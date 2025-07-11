<template>
  <Transition name="fade">
    <div
      v-if="isOpen"
      class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm"
    >
      <div
        class="bg-white dark:bg-gray-800 rounded-lg shadow-xl max-w-md w-full p-6 space-y-6"
      >
        <div class="text-center">
          <span class="text-5xl block mb-4">⚠️</span>
          <h3 class="text-2xl font-bold mb-4">友情提示</h3>
          <div class="space-y-3 text-gray-600 dark:text-gray-300">
            <p>为了确保最佳的浏览体验，我们暂时禁用了以下功能：</p>
            <ul class="text-left list-disc list-inside space-y-2">
              <li>开发者工具 (F12)</li>
              <li>查看源代码 (Ctrl/Cmd + U)</li>
              <li>检查元素 (Ctrl/Cmd + Shift + C)</li>
            </ul>
            <p class="mt-4 text-sm">
              如果您是开发者需要调试，请访问我们的
              <a
                href="https://github.com/your-repo"
                target="_blank"
                class="text-primary hover:underline"
              >
                GitHub 仓库
              </a>
            </p>
          </div>
        </div>
        <div class="flex justify-center space-x-4">
          <button
            @click="close"
            class="px-6 py-2.5 bg-primary text-white rounded-lg hover:bg-primary-dark transition-all duration-300 transform hover:scale-105 focus:outline-none focus:ring-2 focus:ring-primary focus:ring-offset-2 dark:focus:ring-offset-gray-800"
          >
            我知道了
          </button>
        </div>
      </div>
    </div>
  </Transition>
</template>

<script setup lang="ts">
import { ref } from "vue";

const isOpen = ref(false);

const open = () => {
  isOpen.value = true;
  document.addEventListener("keydown", handleEscape);
};

const close = () => {
  isOpen.value = false;
  document.removeEventListener("keydown", handleEscape);
};

const handleEscape = (e: KeyboardEvent) => {
  if (e.key === "Escape") {
    close();
  }
};

defineExpose({
  open,
  close,
});
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: all 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
  transform: scale(0.95);
}

.fade-enter-to,
.fade-leave-from {
  opacity: 1;
  transform: scale(1);
}
</style>
