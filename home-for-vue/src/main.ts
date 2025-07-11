import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import "./assets/styles/main.css";
import { initFontLoading } from "./utils/font";

const app = createApp(App);
app.use(router);
app.mount("#app");

// 初始化字体加载
initFontLoading().then(() => {
  console.log("Font initialization complete");
});
