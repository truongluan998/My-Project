import { AbsoluteFill, Audio, Img, interpolate, spring, staticFile, useCurrentFrame, useVideoConfig } from "remotion";
import { loadFont as loadBangers } from "@remotion/google-fonts/Bangers";
import { loadFont as loadInter } from "@remotion/google-fonts/Inter";
import type { SceneData, Word } from "./types";

const { fontFamily: displayFont } = loadBangers();
const { fontFamily: captionFont } = loadInter("normal", { weights: ["800"], subsets: ["latin", "latin-ext", "vietnamese"] });

const YELLOW = "#f5c828";
const outline = (px: number) => ({ WebkitTextStroke: `${px}px black`, paintOrder: "stroke fill" as const });

export const Scene: React.FC<{ scene: SceneData; index: number; zoom: number; showCaptions: boolean }> = ({
  scene, index, zoom, showCaptions,
}) => (
  <AbsoluteFill>
    <KenBurns src={staticFile(scene.image)} move={index % 4} zoom={zoom} />
    <Audio src={staticFile(scene.audio)} />
    {scene.overlay.trim() ? <Overlay text={scene.overlay.trim()} /> : null}
    {showCaptions ? <Captions words={scene.words} /> : null}
  </AbsoluteFill>
);

// Slow zoom/pan, cycled per scene. Unlike ffmpeg's zoompan this is sub-pixel smooth.
const KenBurns: React.FC<{ src: string; move: number; zoom: number }> = ({ src, move, zoom }) => {
  const frame = useCurrentFrame();
  const { durationInFrames, width } = useVideoConfig();
  const p = frame / durationInFrames;
  const pan = ((zoom - 1) * width) / 2;
  const [scale, x] = [
    [interpolate(p, [0, 1], [1, zoom]), 0],
    [interpolate(p, [0, 1], [zoom, 1]), 0],
    [zoom, interpolate(p, [0, 1], [pan, -pan])],
    [zoom, interpolate(p, [0, 1], [-pan, pan])],
  ][move];
  return (
    <AbsoluteFill style={{ overflow: "hidden" }}>
      <Img src={src} style={{ width: "100%", height: "100%", objectFit: "cover", transform: `translateX(${x}px) scale(${scale})` }} />
    </AbsoluteFill>
  );
};

// "45:00" becomes a live timer ticking down one second per second; other text just pops in.
const Overlay: React.FC<{ text: string }> = ({ text }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const pop = spring({ frame, fps, config: { damping: 9, stiffness: 160 } });
  const timer = text.match(/^(\d{1,2}):(\d{2})$/);
  let label = text;
  let pulse = 1;
  if (timer) {
    const left = Math.max(0, Number(timer[1]) * 60 + Number(timer[2]) - Math.floor(frame / fps));
    label = `${String(Math.floor(left / 60)).padStart(2, "0")}:${String(left % 60).padStart(2, "0")}`;
    pulse = 1 + 0.06 * Math.max(0, 1 - (frame % fps) / (fps * 0.25)); // small beat on every tick
  }
  return (
    <AbsoluteFill style={{ alignItems: "center", paddingTop: 50 }}>
      <div
        style={{
          fontFamily: displayFont, fontSize: 150, letterSpacing: 4, color: YELLOW, ...outline(14),
          transform: `scale(${pop * pulse}) rotate(${interpolate(pop, [0, 1], [-8, 0])}deg)`,
        }}
      >
        {label}
      </div>
    </AbsoluteFill>
  );
};

// Short caption pages; the word being spoken is highlighted.
const MAX_WORDS = 6;

const paginate = (words: Word[]) => {
  const pages: Word[][] = [];
  let page: Word[] = [];
  for (const w of words) {
    page.push(w);
    if (page.length >= MAX_WORDS || /[.!?,;:]$/.test(w.text)) {
      pages.push(page);
      page = [];
    }
  }
  if (page.length) pages.push(page);
  return pages;
};

const Captions: React.FC<{ words: Word[] }> = ({ words }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const t = frame / fps;
  const pages = paginate(words);
  const page = [...pages].reverse().find((p) => p[0].start <= t);
  if (!page || t > page[page.length - 1].end + 0.6) return null;
  const sinceStart = Math.round((t - page[0].start) * fps);
  const enter = spring({ frame: sinceStart, fps, config: { damping: 14, stiffness: 200 } });
  return (
    <AbsoluteFill style={{ justifyContent: "flex-end", alignItems: "center", paddingBottom: 90 }}>
      <div
        style={{
          fontFamily: captionFont, fontWeight: 800, fontSize: 66, color: "white", textAlign: "center",
          maxWidth: "80%", lineHeight: 1.25, ...outline(12),
          transform: `translateY(${interpolate(enter, [0, 1], [30, 0])}px)`, opacity: enter,
        }}
      >
        {page.map((w, i) => {
          const active = w.start <= t && t < w.end;
          return (
            <span
              key={i}
              style={{
                display: "inline-block", margin: "0 10px", color: active ? YELLOW : "white",
                transform: `scale(${active ? 1.12 : 1})`,
              }}
            >
              {w.text}
            </span>
          );
        })}
      </div>
    </AbsoluteFill>
  );
};
