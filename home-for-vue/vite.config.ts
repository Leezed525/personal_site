import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import path from "path";
import viteCompression from "vite-plugin-compression";
import { ViteImageOptimizer } from "vite-plugin-image-optimizer";
import { fontConfig } from "./src/config/font";

export default defineConfig({
  base: "/",
  build: {
    outDir: "dist",
    assetsDir: "assets",
    minify: "terser",
    sourcemap: false,
    chunkSizeWarningLimit: 1500,
    terserOptions: {
      compress: {
        drop_console: true,
        drop_debugger: true,
        pure_funcs: ["console.log"],
      },
      format: {
        comments: /@license/i,
      },
    },
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ["vue", "vue-router"],
        },
        chunkFileNames: "assets/js/[name]-[hash].js",
        entryFileNames: "assets/js/[name]-[hash].js",
        assetFileNames: "assets/[ext]/[name]-[hash].[ext]",
      },
    },
    cssCodeSplit: true,
    cssMinify: true,
  },
  plugins: [
    vue(),
    viteCompression({
      verbose: true,
      disable: false,
      threshold: 10240,
      algorithm: "gzip",
      ext: ".gz",
    }),
    ViteImageOptimizer({
      test: /\.(jpe?g|png|gif|svg)$/i,
      exclude: undefined,
      include: undefined,
      includePublic: true,
      logStats: true,
      ansiColors: true,
      svg: {
        multipass: true,
        plugins: [
          {
            name: "preset-default",
            params: {
              overrides: {
                removeViewBox: false,
                removeEmptyAttrs: false,
              },
            },
          },
        ],
      },
      png: {
        quality: 80,
      },
      jpeg: {
        quality: 80,
      },
      jpg: {
        quality: 80,
      },
      tiff: {
        quality: 80,
      },
      gif: undefined,
      webp: {
        quality: 80,
      },
      avif: {
        quality: 80,
      },
    }),
  ],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "src"),
    },
  },
  server: {
    proxy: {
      "/rss.xml": {
        target: "https://www.mmm.sd",
        changeOrigin: true,
        rewrite: (path) => path + '?t=' + Date.now(),
        headers: {
          Accept: "application/xml, text/xml, */*",
          "User-Agent": "Mozilla/5.0",
          "Cache-Control": "no-cache",
          "Pragma": "no-cache"
        },
      },
      "/LeeSiteApi": {
        // 你的后端 API 实际地址
        target: "http://localhost:8080", // 或者你的后端服务IP:端口
        changeOrigin: true, // 开启跨域
        // 如果后端 API 不包含 /LeeSiteApi 前缀，需要重写路径
        // 例如：前端请求 /LeeSiteApi/users，后端实际处理 /users
        rewrite: (path) => path.replace(/^\/LeeSiteApi/, ''),
      },
    },
  },
  define: {
    __VUE_OPTIONS_API__: true,
    __VUE_PROD_DEVTOOLS__: false,
    "process.env.VITE_FONT_URL": JSON.stringify(fontConfig.url),
    "process.env.VITE_FONT_ENABLED": JSON.stringify(fontConfig.enabled),
    "process.env.VITE_FONT_PRELOAD": JSON.stringify(fontConfig.preload),
  },
});
