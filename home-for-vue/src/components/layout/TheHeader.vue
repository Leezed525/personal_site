<script setup lang="ts">
import {ref, onMounted, onUnmounted} from "vue";
import {useRoute} from "vue-router";
import {siteConfig} from "@/config/site";
import ThemeToggle from "@/components/ThemeToggle.vue";
import LoginModal from "@/components/layout/LoginModal.vue";

/* 登录态 */
const isLoggedIn = ref(false);
const currentUser = ref('');

/* 弹窗控制 */
const showLoginModal = ref(false);
const modalType = ref<'login' | 'register'>('login');   // login or register

/* 打开/关闭弹窗 */
const openLogin = () => {
  modalType.value = 'login';
  showLoginModal.value = true;
};

const openRegister = () => {
  modalType.value = 'register';
  showLoginModal.value = true;
};

const closeLoginModal = () => {
  showLoginModal.value = false;
};

/* 模拟登录、退出 */
const handleLogin = (form: { username: string; password: string; captcha: string }) => {
  // TODO: 真实接口校验
  currentUser.value = form.username;
  isLoggedIn.value = true;
  closeLoginModal();
};

const logout = () => {
  isLoggedIn.value = false;
  currentUser.value = '';
};


const route = useRoute();
const isMenuOpen = ref(false);

const closeMenu = () => {
  isMenuOpen.value = false;
};

const handleKeydown = (e: KeyboardEvent) => {
  if (e.key === "Escape") {
    closeMenu();
  }
};

const handleClickOutside = (event: MouseEvent) => {
  const target = event.target as HTMLElement;
  if (!target.closest(".mobile-menu") && !target.closest(".menu-button")) {
    closeMenu();
  }
};

// 在组件挂载时添加事件监听
onMounted(() => {
  window.addEventListener("click", handleClickOutside);
  window.addEventListener("keydown", handleKeydown);
});

// 在组件卸载时移除事件监听，防止内存泄漏
onUnmounted(() => {
  window.removeEventListener("click", handleClickOutside);
  window.removeEventListener("keydown", handleKeydown);
});

const navItems = [
  {name: "首页", path: "/"},
  {
    name: "项目",
    path: "/projects",
    children: [
      {name: "实用工具", path: "/projects#tools"},
      {name: "个人导航", path: "/projects#bookmarks"},
      {name: "个人站点", path: "/projects#sites"},
    ],
  },
  {name: "技能", path: "/skills"},
  {name: "新博客", path: "/newblog"},
  {name: "博客", path: "/blog"},
  {name: "联系", path: "/contact"},
];

const toggleMenu = () => {
  isMenuOpen.value = !isMenuOpen.value;
};

const showUserMenu = ref(false);
</script>

<template>
  <header
    class="fixed w-full top-0 z-50 bg-white/80 dark:bg-gray-900/80 backdrop-blur-sm"
  >
    <nav class="container mx-auto px-4 py-3 md:py-4">
      <div class="flex items-center justify-between">
        <router-link to="/" class="logo-link group relative overflow-hidden">
          <span
            class="text-xl md:text-2xl font-bold bg-gradient-to-r from-blue-500 via-purple-500 to-pink-500 bg-clip-text text-transparent bg-[length:200%_auto] hover:animate-gradient"
          >
            {{ siteConfig.name }}
          </span>
        </router-link>

        <!-- 桌面端导航 -->
        <div class="hidden md:flex items-center space-x-6">
          <router-link
            v-for="item in navItems"
            :key="item.path"
            :to="item.path"
            class="nav-link"
            :class="{ 'text-primary': route.path === item.path }"
          >
            {{ item.name }}
          </router-link>
          <ThemeToggle/>

          <!-- 桌面端登录状态 -->
          <div v-if="!isLoggedIn" class="nav-link cursor-pointer" @click="openLogin">
            登录
          </div>
          <!-- 桌面端登录状态 -->
          <div v-else class="relative">
            <!-- 用户名触发区 -->
            <span
              class="nav-link cursor-default select-none"
              @mouseenter="showUserMenu = true"
            >
              Hi, {{ currentUser }}
            </span>

            <!-- 下拉菜单 -->
            <transition
              enter-active-class="duration-150 ease-out"
              enter-from-class="opacity-0 scale-95"
              enter-to-class="opacity-100 scale-100"
              leave-active-class="duration-100 ease-in"
              leave-from-class="opacity-100 scale-100"
              leave-to-class="opacity-0 scale-95"
            >
              <div
                v-show="showUserMenu"
                class="absolute right-0 top-full mt-2 w-36 origin-top-right bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg shadow-xl z-20"
                @mouseenter="showUserMenu = true"
                @mouseleave="showUserMenu = false"
              >
                <button
                  class="block w-full text-left px-3 py-2 text-sm text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-700 first:rounded-t-lg last:rounded-b-lg"
                >
                  修改密码
                </button>
                <button
                  class="block w-full text-left px-3 py-2 text-sm
               text-gray-700 dark:text-gray-200
               hover:bg-gray-100 dark:hover:bg-gray-700
               first:rounded-t-lg last:rounded-b-lg"
                  @click="logout"
                >
                  退出登录
                </button>
              </div>
            </transition>
          </div>
        </div>

        <!-- 移动端菜单按钮 -->
        <div class="md:hidden flex items-center space-x-2">
          <ThemeToggle/>
          <button
            class="menu-button p-1.5 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-colors"
            @click.stop="toggleMenu"
            aria-label="Toggle menu"
          >
            <svg
              class="w-6 h-6"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                v-if="!isMenuOpen"
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M4 6h16M4 12h16M4 18h16"
              />
              <path
                v-else
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M6 18L18 6M6 6l12 12"
              />
            </svg>
          </button>
        </div>
      </div>

      <!-- 移动端导航菜单 -->
      <transition
        enter-active-class="transition duration-200 ease-out"
        enter-from-class="opacity-0 -translate-y-2"
        enter-to-class="opacity-100 translate-y-0"
        leave-active-class="transition duration-150 ease-in"
        leave-from-class="opacity-100 translate-y-0"
        leave-to-class="opacity-0 -translate-y-2"
      >
        <div v-show="isMenuOpen" class="mobile-menu md:hidden">
          <div class="py-2 space-y-1">
            <router-link
              v-for="item in navItems"
              :key="item.path"
              :to="item.path"
              class="block px-4 py-2 text-base hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
              :class="{
                'bg-primary/10 text-primary': route.path === item.path,
              }"
              @click="closeMenu"
            >
              {{ item.name }}
            </router-link>
            <!-- 移动端登录状态 -->
            <div class="border-t border-gray-200 dark:border-gray-700 my-2"></div>
            <template v-if="!isLoggedIn">
              <button
                class="block w-full text-left px-4 py-2 text-base hover:bg-gray-100 dark:hover:bg-gray-800"
                @click="openLogin"
              >
                登录
              </button>
            </template>
            <template v-else>
              <div class="px-4 py-2 text-base text-gray-600 dark:text-gray-300">
                Hi, {{ currentUser }}
              </div>
              <button
                class="block w-full text-left px-4 py-2 text-sm hover:bg-gray-100 dark:hover:bg-gray-800"
              >
                修改密码
              </button>
              <button
                class="block w-full text-left px-4 py-2 text-sm hover:bg-gray-100 dark:hover:bg-gray-800"
                @click="logout"
              >
                退出登录
              </button>
            </template>
          </div>
        </div>
      </transition>
    </nav>
    <LoginModal
      v-if="showLoginModal"
      v-model:type="modalType"
      @close="closeLoginModal"
      @success="handleLogin"
    />
  </header>
</template>

<style scoped>
.nav-link {
  @apply text-gray-600 dark:text-gray-300 hover:text-primary dark:hover:text-primary transition-colors;
}

.mobile-menu {
  @apply absolute top-full left-0 right-0 bg-white/95 dark:bg-gray-900/95 backdrop-blur-sm
  border-t border-gray-200 dark:border-gray-700 shadow-lg;
}

/* 移动端导航链接悬停效果 */
@media (hover: hover) {
  .mobile-menu .router-link-active {
    @apply bg-primary-10 text-primary;
  }
}

/* Logo 悬停动画 */
.logo-link {
  @apply inline-block py-1;
}

.logo-link:hover span:first-child {
  @apply transform scale-105 transition-transform duration-300;
}

@keyframes gradient {
  0% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
  100% {
    background-position: 0% 50%;
  }
}

.hover\:animate-gradient:hover {
  animation: gradient 3s linear infinite;
}
</style>
