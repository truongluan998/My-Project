import { useMemo } from "react";
import { AbsoluteFill, Audio, staticFile, useCurrentFrame, useVideoConfig } from "remotion";
import { fade } from "@remotion/transitions/fade";
import { linearTiming, TransitionSeries } from "@remotion/transitions";
import { Scene } from "./Scene";
import type { EpisodeProps } from "./types";

export const totalFrames = (p: EpisodeProps) =>
  p.scenes.reduce((sum, s) => sum + s.durationInFrames, 0) - p.transitionFrames * Math.max(0, p.scenes.length - 1);

// Frame at which each scene starts, accounting for the overlap of every fade transition.
const sceneStarts = (p: EpisodeProps) => {
  const starts: number[] = [];
  let t = 0;
  for (const s of p.scenes) {
    starts.push(t);
    t += s.durationInFrames - p.transitionFrames;
  }
  return starts;
};

export const Episode: React.FC<EpisodeProps> = (props) => {
  const { scenes, transitionFrames, music, musicVolume } = props;
  const { fps, durationInFrames } = useVideoConfig();

  // Per-frame "is someone speaking" map, so music ducks under the narration.
  const speaking = useMemo(() => {
    const map = new Uint8Array(durationInFrames + 1);
    const pad = Math.round(0.25 * fps);
    sceneStarts(props).forEach((start, i) => {
      for (const w of scenes[i].words) {
        const a = Math.max(0, start + Math.floor(w.start * fps) - pad);
        const b = Math.min(durationInFrames, start + Math.ceil(w.end * fps) + pad);
        map.fill(1, a, b);
      }
    });
    return map;
  }, [props, scenes, fps, durationInFrames]);

  return (
    <AbsoluteFill style={{ backgroundColor: "#f6f1e6" }}>
      <TransitionSeries>
        {scenes.flatMap((scene, i) => [
          ...(i > 0
            ? [<TransitionSeries.Transition key={`t${i}`} presentation={fade()} timing={linearTiming({ durationInFrames: transitionFrames })} />]
            : []),
          <TransitionSeries.Sequence key={`s${i}`} durationInFrames={scene.durationInFrames}>
            <Scene scene={scene} index={i} zoom={props.zoom} showCaptions={props.showCaptions} />
          </TransitionSeries.Sequence>,
        ])}
      </TransitionSeries>
      {music ? (
        <Audio loop src={staticFile(music)} volume={(f) => (speaking[f] ? musicVolume * 0.35 : musicVolume)} />
      ) : null}
      <ProgressBar />
    </AbsoluteFill>
  );
};

const ProgressBar: React.FC = () => {
  const frame = useCurrentFrame();
  const { durationInFrames, width } = useVideoConfig();
  return (
    <div
      style={{
        position: "absolute", left: 0, bottom: 0, height: 10,
        width: (width * frame) / durationInFrames, backgroundColor: "#f5c828",
      }}
    />
  );
};
