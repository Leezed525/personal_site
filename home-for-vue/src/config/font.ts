interface FontConfig {
  enabled: boolean;
  name: string;
  url: string;
  preload?: boolean;
  display?: "auto" | "block" | "swap" | "fallback" | "optional";
  weights?: string;
}

export const fontConfig: FontConfig = {
  enabled: true,
  name: "LXWK",
  url: "https://cdn.jsdmirror.com/gh/acanyo/mmm.sd@master/assets/font/lxwk.woff2",
  preload: true,
  display: "swap",
  weights: "100 900",
};
