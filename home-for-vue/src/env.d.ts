/// <reference types="vite/client" />

declare global {
  interface ImportMetaEnv {
    readonly VITE_APP_TITLE: string;
    readonly VITE_APP_DESCRIPTION: string;
    readonly VITE_APP_KEYWORDS: string;
    readonly VITE_APP_AUTHOR: string;
    readonly VITE_APP_URL: string;
    readonly VITE_APP_LOGO: string;
    readonly VITE_APP_GITHUB: string;
    readonly VITE_APP_TWITTER: string;
    readonly VITE_APP_TWITTER_URL: string;
    readonly VITE_APP_THEME_COLOR: string;
    readonly VITE_EMAILJS_SERVICE_ID: string;
    readonly VITE_EMAILJS_TEMPLATE_ID: string;
    readonly VITE_EMAILJS_PUBLIC_KEY: string;
    readonly VITE_SITE_URL: string;
    readonly DEV: boolean;
    readonly PROD: boolean;
    readonly MODE: string;
  }

  interface ImportMeta {
    readonly env: ImportMetaEnv;
    readonly hot?: {
      readonly data: any;
      accept(): void;
      accept(cb: (mod: any) => void): void;
      accept(dep: string, cb: (mod: any) => void): void;
      accept(deps: string[], cb: (mods: any[]) => void): void;
      prune(cb: () => void): void;
      dispose(cb: (data: any) => void): void;
      decline(): void;
      invalidate(): void;
      on(event: string, cb: (...args: any[]) => void): void;
    };
    readonly glob: (glob: string) => Record<string, () => Promise<any>>;
  }
}

// Vue 组件类型声明
declare module "*.vue" {
  import type { DefineComponent } from "vue";
  const component: DefineComponent<{}, {}, any>;
  export default component;
}

// Vue 宏命令类型声明
declare module "vue" {
  import type { DefineComponent, Ref } from "vue";

  // 生命周期钩子
  export declare const onMounted: (cb: () => void) => void;
  export declare const onBeforeMount: (cb: () => void) => void;
  export declare const onBeforeUnmount: (cb: () => void) => void;
  export declare const onUnmounted: (cb: () => void) => void;
  export declare const onActivated: (cb: () => void) => void;
  export declare const onDeactivated: (cb: () => void) => void;
  export declare const onBeforeUpdate: (cb: () => void) => void;
  export declare const onUpdated: (cb: () => void) => void;
  export declare const onErrorCaptured: (cb: (err: unknown) => void) => void;

  // 组合式 API
  export declare const createApp: any;
  export declare const ref: <T>(value: T) => Ref<T>;
  export declare const computed: <T>(getter: () => T) => Ref<T>;
  export declare const watch: typeof import("vue").watch;
  export declare const watchEffect: (effect: () => void) => void;
  export declare const reactive: <T extends object>(target: T) => T;
  export declare const readonly: <T extends object>(target: T) => Readonly<T>;

  // 组件相关
  export declare const defineProps: {
    <T extends Record<string, any>>(): Readonly<T>;
    <T extends Record<string, any>>(props: T): Readonly<T>;
  };

  export declare const defineEmits: {
    <T extends Record<string, any>>(): T;
    <T extends Record<string, any>>(emits: T): T;
  };

  export declare const defineExpose: (exposed?: Record<string, any>) => void;
  export declare const withDefaults: <
    Props,
    Defaults extends { [K in keyof Props]?: Props[K] },
  >(
    props: Props,
    defaults: Defaults,
  ) => {
    [K in keyof Props]: K extends keyof Defaults ? Defaults[K] : Props[K];
  };
}

// 第三方模块声明
declare module "vite" {
  import type { UserConfig, Plugin } from "vite";

  export interface ViteConfig extends UserConfig {
    plugins?: Plugin[];
  }

  export const defineConfig: <T extends ViteConfig>(config: T) => T;
}

declare module "vue-router" {
  import type { Component } from "vue";

  export interface RouteMeta {
    title?: string;
    description?: string;
    keywords?: string;
    transition?: string;
    requiresAuth?: boolean;
    [key: string]: any;
  }

  export interface RouteRecordRaw {
    path: string;
    name?: string;
    component?: Component | (() => Promise<Component>);
    components?: { [key: string]: Component };
    redirect?: string | { name: string };
    meta?: RouteMeta;
    children?: RouteRecordRaw[];
  }

  export interface Router {
    push(to: string | { name: string; params?: any }): Promise<void>;
  }

  export interface Route {
    meta: RouteMeta;
    params: Record<string, string>;
    query: Record<string, string>;
    hash: string;
    path: string;
    fullPath: string;
    matched: RouteRecordRaw[];
  }

  // 添加 RouterLink 组件类型
  export interface RouterLinkProps {
    to: string | { name: string; params?: Record<string, any> };
    replace?: boolean;
    activeClass?: string;
    exactActiveClass?: string;
    custom?: boolean;
    ariaCurrentValue?: string;
  }

  export const RouterLink: Component<RouterLinkProps>;
  export const RouterView: Component;
  export const createRouter: any;
  export const createWebHistory: any;
  export const useRoute: () => Route;
  export const useRouter: () => Router;
}

declare module "@emailjs/browser" {
  const emailjs: any;
  export default emailjs;
}

declare module "vite-plugin-compression";
declare module "vite-plugin-image-optimizer";
