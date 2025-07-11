<script setup lang="ts">
import { ref, watch } from "vue";
import Fireworks from "@/components/effects/Fireworks.vue";
import { noticeConfig } from "@/config/notice";

interface Props {
  show: boolean;
  title?: string;
  width?: string;
  maskClosable?: boolean;
  showClose?: boolean;
  showFireworks?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  show: false,
  title: "",
  width: "400px",
  maskClosable: true,
  showClose: true,
  showFireworks: false,
});

const emit = defineEmits<{
  (e: "update:show", value: boolean): void;
}>();

const modalRef = ref<HTMLElement | null>(null);
const showFireworks = ref(false);

// 处理点击遮罩层关闭
const handleMaskClick = (e: MouseEvent) => {
  if (props.maskClosable && e.target === modalRef.value) {
    emit("update:show", false);
  }
};

// 处理ESC键关闭
const handleKeydown = (e: KeyboardEvent) => {
  if (e.key === "Escape" && props.show) {
    emit("update:show", false);
  }
};

// 监听键盘事件
watch(
  () => props.show,
  (val: boolean) => {
    if (val) {
      document.addEventListener("keydown", handleKeydown);
    } else {
      document.removeEventListener("keydown", handleKeydown);
    }
  },
);

// 监听显示状态
watch(
  () => props.show,
  (newVal: boolean) => {
    if (newVal && props.showFireworks && noticeConfig.showFireworks) {
      showFireworks.value = true;
      setTimeout(() => {
        showFireworks.value = false;
      }, 3000);
    }
  },
);
</script>

<template>
  <Teleport to="body">
    <Transition name="modal">
      <div v-if="show" class="fixed inset-0 z-[90]">
        <Fireworks v-if="showFireworks" />
        <div
          ref="modalRef"
          class="fixed inset-0 z-[90] flex items-center justify-center bg-black/50 backdrop-blur-sm"
          @click="handleMaskClick"
        >
          <div
            class="bg-white dark:bg-gray-800 rounded-lg shadow-xl transform transition-all"
            :style="{ width }"
          >
            <!-- 标题栏 -->
            <div
              v-if="title || showClose"
              class="flex items-center justify-between px-6 py-4 border-b dark:border-gray-700"
            >
              <h3 class="text-lg font-medium text-gray-900 dark:text-gray-100">
                {{ title }}
              </h3>
              <button
                v-if="showClose"
                class="text-gray-400 hover:text-gray-500 dark:hover:text-gray-300 transition-colors"
                @click="emit('update:show', false)"
              >
                <span class="sr-only">关闭</span>
                <svg
                  class="h-6 w-6"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M6 18L18 6M6 6l12 12"
                  />
                </svg>
              </button>
            </div>

            <!-- 内容区 -->
            <div class="px-6 py-4">
              <slot></slot>
            </div>

            <!-- 按钮区 -->
            <div
              v-if="$slots.footer"
              class="px-6 py-4 bg-gray-50 dark:bg-gray-700/50 rounded-b-lg"
            >
              <slot name="footer"></slot>
            </div>
          </div>
        </div>
      </div>
    </Transition>
  </Teleport>
</template>

<style scoped>
.modal-enter-active,
.modal-leave-active {
  transition: all 0.3s ease;
}

.modal-enter-from {
  opacity: 0;
  transform: scale(0.9);
}

.modal-leave-to {
  opacity: 0;
  transform: scale(1.1);
}
</style>
