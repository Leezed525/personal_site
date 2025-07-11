<script setup lang="ts">
import { ref } from "vue";
import emailjs from "@emailjs/browser";
import { emailConfig } from "@/config/email";

interface FormData {
  name: string;
  email: string;
  subject: string;
  message: string;
}

const formData = ref<FormData>({
  name: "",
  email: "",
  subject: "",
  message: "",
});

const isSubmitting = ref(false);
const submitStatus = ref<"success" | "error" | null>(null);

const validateEmail = (email: string) => {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
};

const handleSubmit = async () => {
  submitStatus.value = null;

  if (!formData.value.name.trim()) {
    alert("请输入您的姓名");
    return;
  }
  if (!formData.value.email.trim() || !validateEmail(formData.value.email)) {
    alert("请输入有效的邮箱地址");
    return;
  }
  if (!formData.value.message.trim()) {
    alert("请输入留言内容");
    return;
  }

  try {
    isSubmitting.value = true;

    const result = await emailjs.send(
      emailConfig.serviceId,
      emailConfig.templateId,
      {
        from_name: formData.value.name,
        from_email: formData.value.email,
        subject: formData.value.subject,
        message: formData.value.message,
        reply_to: formData.value.email,
      },
      emailConfig.publicKey,
    );

    submitStatus.value = "success";
    formData.value = {
      name: "",
      email: "",
      subject: "",
      message: "",
    };
  } catch (error: any) {
    submitStatus.value = "error";
    alert(`发送失败: ${error.text || error.message || "请稍后重试"}`);
  } finally {
    isSubmitting.value = false;
  }
};

// 添加跳转函数
const goToGuestbook = () => {
  window.open(import.meta.env.VITE_GUESTBOOK_URL, "_blank");
};
</script>

<template>
  <div class="container mx-auto px-4 py-8 md:py-12">
    <div class="max-w-2xl mx-auto">
      <h1
        class="text-2xl md:text-3xl font-bold text-center mb-4 md:mb-8 bg-gradient-to-r from-blue-500 via-purple-500 to-pink-500 bg-clip-text text-transparent animate-gradient"
      >
        联系我
      </h1>
      <p
        class="text-sm md:text-base text-gray-600 dark:text-gray-300 text-center mb-6"
      >
        有任何问题或建议？请随时与我联系。
      </p>

      <!-- 留言板入口 -->
      <div class="text-center mb-8 md:mb-12">
        <p
          class="text-sm md:text-base text-gray-600 dark:text-gray-300 mb-3 md:mb-4"
        >
          您也可以在留言板上留下您的想法
        </p>
        <button
          @click="goToGuestbook"
          class="inline-flex items-center px-5 py-2 md:px-6 md:py-2.5 text-sm md:text-base font-medium rounded-full text-white bg-gradient-to-r from-blue-500 to-purple-500 hover:from-blue-600 hover:to-purple-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-all duration-300 ease-in-out transform hover:scale-105 shadow-sm"
        >
          <span class="mr-2">前往留言板</span>
          <svg
            class="w-4 h-4 md:w-5 md:h-5"
            viewBox="0 0 20 20"
            fill="currentColor"
          >
            <path
              fill-rule="evenodd"
              d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z"
              clip-rule="evenodd"
            />
          </svg>
        </button>
      </div>

      <!-- 表单部分 -->
      <form
        @submit.prevent="handleSubmit"
        class="space-y-4 md:space-y-6 bg-white dark:bg-gray-800 rounded-lg md:rounded-xl shadow-sm p-4 md:p-8"
      >
        <!-- 表单字段 -->
        <div class="space-y-4">
          <div>
            <label
              for="name"
              class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1"
            >
              姓名 <span class="text-red-500">*</span>
            </label>
            <input
              id="name"
              v-model="formData.name"
              type="text"
              required
              class="w-full px-3 md:px-4 py-2 text-sm md:text-base rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500 outline-none transition-colors"
              :disabled="isSubmitting"
            />
          </div>

          <div>
            <label
              for="email"
              class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1"
            >
              邮箱 <span class="text-red-500">*</span>
            </label>
            <input
              id="email"
              v-model="formData.email"
              type="email"
              required
              class="w-full px-3 md:px-4 py-2 text-sm md:text-base rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500 outline-none transition-colors"
              :disabled="isSubmitting"
            />
          </div>

          <div>
            <label
              for="subject"
              class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1"
            >
              主题
            </label>
            <input
              id="subject"
              v-model="formData.subject"
              type="text"
              class="w-full px-3 md:px-4 py-2 text-sm md:text-base rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500 outline-none transition-colors"
              :disabled="isSubmitting"
            />
          </div>

          <div>
            <label
              for="message"
              class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1"
            >
              留言 <span class="text-red-500">*</span>
            </label>
            <textarea
              id="message"
              v-model="formData.message"
              rows="5"
              required
              class="w-full px-3 md:px-4 py-2 text-sm md:text-base rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500 outline-none transition-colors resize-none"
              :disabled="isSubmitting"
            ></textarea>
          </div>
        </div>

        <!-- 提交按钮 -->
        <div class="flex justify-center pt-2 md:pt-4">
          <button
            type="submit"
            class="w-full md:w-auto inline-flex items-center justify-center px-6 py-2.5 md:px-8 md:py-3 text-sm md:text-base font-medium rounded-lg md:rounded-full text-white bg-gradient-to-r from-blue-500 to-purple-500 hover:from-blue-600 hover:to-purple-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-all duration-300 ease-in-out transform hover:scale-105 disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none shadow-sm"
            :disabled="isSubmitting"
          >
            <span v-if="isSubmitting" class="flex items-center">
              <svg
                class="animate-spin -ml-1 mr-2 h-5 w-5"
                fill="none"
                viewBox="0 0 24 24"
              >
                <circle
                  class="opacity-25"
                  cx="12"
                  cy="12"
                  r="10"
                  stroke="currentColor"
                  stroke-width="4"
                ></circle>
                <path
                  class="opacity-75"
                  fill="currentColor"
                  d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                ></path>
              </svg>
              正在发送...
            </span>
            <span v-else class="flex items-center">
              发送消息
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-5 w-5 ml-2"
                viewBox="0 0 20 20"
                fill="currentColor"
              >
                <path
                  d="M10.894 2.553a1 1 0 00-1.788 0l-7 14a1 1 0 001.169 1.409l5-1.429A1 1 0 009 15.571V11a1 1 0 112 0v4.571a1 1 0 00.725.962l5 1.428a1 1 0 001.17-1.408l-7-14z"
                />
              </svg>
            </span>
          </button>
        </div>

        <!-- 提交状态提示 -->
        <transition
          enter-active-class="transition duration-300 ease-out"
          enter-from-class="transform -translate-y-2 opacity-0"
          enter-to-class="transform translate-y-0 opacity-100"
          leave-active-class="transition duration-200 ease-in"
          leave-from-class="transform translate-y-0 opacity-100"
          leave-to-class="transform -translate-y-2 opacity-0"
        >
          <div
            v-if="submitStatus"
            class="text-center py-2 md:py-3 px-4 md:px-6 rounded-lg mt-4 md:mt-6 text-sm md:text-base"
            :class="{
              'bg-green-50 text-green-800 dark:bg-green-900/50 dark:text-green-100':
                submitStatus === 'success',
              'bg-red-50 text-red-800 dark:bg-red-900/50 dark:text-red-100':
                submitStatus === 'error',
            }"
          >
            <div
              class="flex items-center justify-center"
              v-if="submitStatus === 'success'"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-5 w-5 mr-2 text-green-500"
                viewBox="0 0 20 20"
                fill="currentColor"
              >
                <path
                  fill-rule="evenodd"
                  d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                  clip-rule="evenodd"
                />
              </svg>
              <span>消息已发送，感谢您的反馈！我们将尽快与您联系。</span>
            </div>
            <div class="flex items-center justify-center" v-else>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-5 w-5 mr-2 text-red-500"
                viewBox="0 0 20 20"
                fill="currentColor"
              >
                <path
                  fill-rule="evenodd"
                  d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z"
                  clip-rule="evenodd"
                />
              </svg>
              <span>发送失败，请稍后重试。</span>
            </div>
          </div>
        </transition>
      </form>
    </div>
  </div>
</template>

<style scoped>
.animate-gradient {
  background-size: 200% auto;
  animation: gradient 4s linear infinite;
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
</style>
