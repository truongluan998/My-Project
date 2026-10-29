import { Composition } from "remotion";
import { Episode, totalFrames } from "./Episode";
import type { EpisodeProps } from "./types";

// Only used when opening Remotion Studio without --props.
const defaultProps: EpisodeProps = {
  fps: 30,
  width: 1920,
  height: 1080,
  zoom: 1.12,
  transitionFrames: 12,
  showCaptions: true,
  music: null,
  musicVolume: 0.18,
  scenes: [],
};

export const RemotionRoot: React.FC = () => (
  <Composition
    id="Episode"
    component={Episode}
    defaultProps={defaultProps}
    durationInFrames={1}
    fps={30}
    width={1920}
    height={1080}
    calculateMetadata={({ props }) => ({
      durationInFrames: Math.max(1, totalFrames(props)),
      fps: props.fps,
      width: props.width,
      height: props.height,
    })}
  />
);
