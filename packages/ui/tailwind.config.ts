import type { Config } from "tailwindcss";
import sharedConfig from "@nozna/tailwind-config";

const config: Pick<Config, "prefix" | "presets" | "content" | "plugins"> = {
  content: ["/src/**/*.{ts,tsx}"],
  presets: [sharedConfig],
};

export default config;
