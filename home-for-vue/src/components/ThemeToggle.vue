<script setup lang="ts">
import { ref, onMounted } from "vue";

const isDark = ref(false);

const toggleTheme = () => {
  isDark.value = !isDark.value;
  document.documentElement.classList.toggle("dark", isDark.value);
  localStorage.setItem("theme", isDark.value ? "dark" : "light");
};

onMounted(() => {
  // 检查系统主题偏好
  const prefersDark = window.matchMedia("(prefers-color-scheme: dark)").matches;
  // 获取保存的主题设置
  const savedTheme = localStorage.getItem("theme");

  // 如果有保存的主题设置就使用，否则跟随系统
  isDark.value = savedTheme === "dark" || (!savedTheme && prefersDark);
  document.documentElement.classList.toggle("dark", isDark.value);

  // 监听系统主题变化
  window
    .matchMedia("(prefers-color-scheme: dark)")
    .addEventListener("change", (e) => {
      if (!localStorage.getItem("theme")) {
        isDark.value = e.matches;
        document.documentElement.classList.toggle("dark", isDark.value);
      }
    });
});
</script>

<template>
  <button
    @click="toggleTheme"
    class="relative w-10 h-10 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors duration-200"
    aria-label="切换主题"
  >
    <div class="absolute inset-0 flex items-center justify-center">
      <transition name="theme-toggle" mode="out-in">
        <!-- 暗色主题图标 -->
        <svg
          v-if="isDark"
          key="dark"
          class="w-5 h-5 text-yellow-500"
          fill="currentColor"
          viewBox="0 0 20 20"
        >
          <path
            d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z"
          />
        </svg>
        <!-- 亮色主题图标 -->
        <svg
          v-else
          key="light"
          class="w-5 h-5 text-gray-500"
          fill="currentColor"
          viewBox="0 0 20 20"
        >
          <path
            d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"
          />
        </svg>
      </transition>
    </div>
  </button>
</template>

<style scoped>
.theme-toggle-enter-active,
.theme-toggle-leave-active {
  transition: all 0.3s ease;
}

.theme-toggle-enter-from,
.theme-toggle-leave-to {
  opacity: 0;
  transform: rotate(30deg) scale(0.8);
}
</style>
