// Shape of props.json written by the Python pipeline (studio/renderer_remotion.py).

export type Word = {
  text: string;
  start: number; // seconds from the start of the scene
  end: number;
};

export type SceneData = {
  image: string; // path relative to the episode folder (served as the public dir)
  audio: string;
  durationInFrames: number;
  words: Word[];
  overlay: string; // "45:00" ticks down like a real timer; anything else pops in as a label
};

export type EpisodeProps = {
  fps: number;
  width: number;
  height: number;
  zoom: number;
  transitionFrames: number;
  showCaptions: boolean;
  music: string | null;
  musicVolume: number;
  scenes: SceneData[];
};
