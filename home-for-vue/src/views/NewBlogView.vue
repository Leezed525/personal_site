<script setup lang="ts">
import {ref, computed} from "vue";
import PageTransition from "@/components/PageTransition.vue";
import Tabs from "@/components/ui/Tabs.vue";
import BookmarksView from "@/views/tools/BookmarksView.vue";
import {projects} from "@/config/projects";
import {tools} from "@/config/tools";
import {blogTabs} from "@/config/navigation";
import {fetchBlogPosts} from "@/utils/rss";

const activeTab = ref("projects");
const activeToolId = ref<number | null>(null);

const projectsList = ref(projects);
const toolsList = ref(tools);

const activeTool = computed(() =>
  toolsList.value.find((tool) => tool.id === activeToolId.value),
);

const showToolList = () => {
  activeToolId.value = null;
};

// 加载状态
const isLoading = ref(false);

// 模拟加载效果
const handleTabChange = async () => {
  isLoading.value = true;
  await new Promise((resolve) => setTimeout(resolve, 300));
  isLoading.value = false;
};



// 页面切换动画延迟
const getTransitionDelay = (index: number) => `${index * 100}ms`;


const error = ref<string | null>(null);

</script>

<template>
  <div class="container mx-auto px-4 py-8 md:py-12">
    <PageTransition>
      <div class="text-center mb-12">
        <h1
          class="text-3xl font-bold text-center mb-8 bg-gradient-to-r from-blue-500 via-purple-500 to-pink-500 bg-clip-text text-transparent animate-gradient"
        >
          博客文章
        </h1>
        <p class="text-gray-600 dark:text-gray-400 text-lg max-w-2xl mx-auto">
          分享技术见解和学习心得，记录编程之路的点点滴滴
        </p>
      </div>
    </PageTransition>

    <div class="max-w-6xl mx-auto">
      <!-- 标签页切换 -->
      <div class="mb-6 md:mb-8">
        <Tabs
          v-model="activeTab"
          :tabs="blogTabs"
          class="justify-center max-w-md mx-auto bg-white/50 dark:bg-gray-800/50 backdrop-blur-sm rounded-full p-1.5 md:p-2 shadow-sm flex items-center gap-1.5 md:gap-2 text-sm md:text-base"
          @update:modelValue="handleTabChange"
        />
      </div>

      <!-- 加载状态 -->
      <div v-if="loading" class="flex justify-center items-center py-20">
        <div
          class="animate-spin rounded-full h-16 w-16 border-4 border-primary border-t-transparent"
        ></div>
      </div>

      <!-- 错误提示 -->
      <div v-else-if="error" class="text-center py-20">
        <p class="text-red-500 text-lg mb-4">{{ error }}</p>
        <button
          @click="fetchBlogPosts"
          class="px-6 py-3 bg-primary text-white rounded-lg hover:bg-primary-dark transition-all transform hover:scale-105"
        >
          重试
        </button>
      </div>
    </div>
  </div>
</template>

<style scoped>
/* 列表动画 */
.list-move,
.list-enter-active,
.list-leave-active {
  transition: all 0.8s cubic-bezier(0.4, 0, 0.2, 1);
}

.list-enter-from,
.list-leave-to {
  opacity: 0;
  transform: scale(0.9) translateY(50px);
}

.list-leave-active {
  position: absolute;
}

/* 渐入动画 */
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* 向上滑入动画 */
@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* 渐变动画 */
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

.animate-gradient {
  background-size: 200% auto;
  animation: gradient 4s linear infinite;
}

.animate-fade-in {
  animation: fadeIn 0.6s ease-out forwards;
}

.animate-slide-up {
  animation: slideUp 0.5s ease-out forwards;
}

/* 加载动画 */
.loader {
  width: 48px;
  height: 48px;
  border: 5px solid;
  border-color: #f3f3f3;
  border-bottom-color: var(--color-primary);
  border-radius: 50%;
  display: inline-block;
  animation: rotation 1s linear infinite;
}

@keyframes rotation {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

/* 暗色模式特效 */
@media (prefers-color-scheme: dark) {
  .dark\:hover\:glow-lg:hover {
    box-shadow: 0 0 30px var(--color-primary);
    transform: translateY(-0.5rem) scale(1.01);
  }
}

/* 背景渐变 */
.container {
  background: linear-gradient(
    135deg,
    var(--color-primary-50/10) 0%,
    transparent 100%
  );
}

/* 卡片悬停效果增强 */
.group:hover {
  transform: translateY(-0.5rem) scale(1.01);
  z-index: 1;
}

/* 标签页切换动画 */
.tab-enter-active,
.tab-leave-active {
  transition: all 0.5s ease-in-out;
}

.tab-enter-from,
.tab-leave-to {
  opacity: 0;
  transform: translateY(20px);
}

/* 加载动画优化 */
.loader {
  box-shadow: 0 0 15px var(--color-primary/30);
}

/* 暗色模式优化 */
@media (prefers-color-scheme: dark) {
  .container {
    background: linear-gradient(
      135deg,
      var(--color-primary-900/10) 0%,
      transparent 100%
    );
  }
}

/* 返回按钮容器样式 */
.transform {
  transform-style: preserve-3d;
  backface-visibility: hidden;
}


.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.bg-primary-10 {
  background-color: rgba(59, 130, 246, 0.1);
}

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
