<template>
  <div
    class="min-h-screen flex items-center justify-center bg-gray-900 text-white"
  >
    <div class="text-center">
      <h1 class="text-6xl font-bold text-red-500 mb-4">⚠️ 警告</h1>
      <p class="text-xl mb-8">检测到非法操作，已记录您的访问信息。</p>
      <button
        @click="goBack"
        class="px-6 py-2 bg-red-500 hover:bg-red-600 rounded-lg transition-colors"
      >
        返回首页
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted } from "vue";
import { useRouter } from "vue-router";

const router = useRouter();

const goBack = () => {
  router.push("/");
};

// 防止返回
onMounted(() => {
  history.pushState(null, "", document.URL);
  window.addEventListener("popstate", () => {
    history.pushState(null, "", document.URL);
  });
});
</script>
