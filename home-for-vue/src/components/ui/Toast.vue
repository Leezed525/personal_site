<script setup lang="ts">
import { ref, onMounted, onUnmounted } from "vue";

const isVisible = ref(false);
const message = ref("");
const type = ref<"success" | "error" | "info">("info");
let timeoutId: number;

const show = (
  text: string,
  messageType: "success" | "error" | "info" = "info",
) => {
  clearTimeout(timeoutId);
  message.value = text;
  type.value = messageType;
  isVisible.value = true;
  timeoutId = window.setTimeout(() => {
    isVisible.value = false;
  }, 3000);
};

// 创建全局方法
const toast = {
  show,
  success: (text: string) => show(text, "success"),
  error: (text: string) => show(text, "error"),
  info: (text: string) => show(text, "info"),
};

// 挂载到全局
window.$toast = toast;

onUnmounted(() => {
  clearTimeout(timeoutId);
});
</script>

<template>
  <Teleport to="body">
    <transition
      enter-active-class="transition duration-300 ease-out"
      enter-from-class="transform translate-y-2 opacity-0"
      enter-to-class="transform translate-y-0 opacity-100"
      leave-active-class="transition duration-200 ease-in"
      leave-from-class="transform translate-y-0 opacity-100"
      leave-to-class="transform translate-y-2 opacity-0"
    >
      <div
        v-show="isVisible"
        class="fixed bottom-4 right-4 z-50 px-4 py-2 rounded-lg shadow-lg"
        :class="{
          'bg-green-500 text-white': type === 'success',
          'bg-red-500 text-white': type === 'error',
          'bg-blue-500 text-white': type === 'info',
        }"
      >
        {{ message }}
      </div>
    </transition>
  </Teleport>
</template>
