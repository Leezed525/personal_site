import {createApp} from "vue";
import App from "./App.vue";
import router from "./router";
import "./assets/styles/main.css";
import {initFontLoading} from "./utils/font";


// elementPlus
import ElementPlus from 'element-plus';
import 'element-plus/dist/index.css';

//pina
import {createPinia} from 'pinia';


const app = createApp(App);
app.use(router);
app.use(ElementPlus);
app.use(createPinia());
app.mount("#app");

// 初始化字体加载
initFontLoading().then(() => {
  console.log("Font initialization complete");
});
