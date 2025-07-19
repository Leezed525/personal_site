<script setup lang="ts">
import {ref, computed, onMounted} from "vue";
import PageTransition from "@/components/PageTransition.vue";
import Tabs from "@/components/ui/Tabs.vue";
import BookmarksView from "@/views/tools/BookmarksView.vue";
import {listProject} from "@/api/project/project";
import {projects} from "@/config/projects";
import {tools} from "@/config/tools";
import {tabs} from "@/config/navigation";

const activeTab = ref("projects");
const activeToolId = ref<number | null>(null);

// 加载状态
const isLoading = ref(false);

const projectsList = ref(projects);
const toolsList = ref(tools);

// --------------------------项目部分逻辑代码----------------------------

const PROJECT_STATUS = {
  0: {label: '规划中', color: 'gray', linkable: false},
  1: {label: '开发中', color: 'yellow', linkable: true},
  2: {label: '已完成', color: 'green', linkable: true},
}

// 颜色 → Tailwind 类名
const STATUS_CLASSES: Record<string, string> = {
  green: 'bg-green-100/80 text-green-800 dark:bg-green-900/80 dark:text-green-100',
  yellow: 'bg-yellow-100/80 text-yellow-800 dark:bg-yellow-900/80 dark:text-yellow-100',
  gray:   'bg-gray-100/80 text-gray-800 dark:bg-gray-900/80 dark:text-gray-100',
}


const getProject = () => {
  listProject({}).then((res) => {
    projectsList.value = res.data;
    console.log(res);
    isLoading.value = false;
  }).catch();

}

const activeTool = computed(() =>
  toolsList.value.find((tool) => tool.id === activeToolId.value),
);

const showToolList = () => {
  activeToolId.value = null;
};


// 模拟加载效果
const handleTabChange = async () => {
  isLoading.value = true;
  await new Promise((resolve) => setTimeout(resolve, 300));
  isLoading.value = false;
};

// 页面切换动画延迟
const getTransitionDelay = (index: number) => `${index * 100}ms`;

// -------------------------onMounted--------------------------------
onMounted(() => {
  isLoading.value = true;
  // 初始化项目列表
  getProject();
});
</script>

<template>
  <div class="container mx-auto px-4 py-8 md:py-12">
    <h1
      class="text-2xl md:text-3xl font-bold text-center mb-6 md:mb-8 bg-gradient-to-r from-blue-500 via-purple-500 to-pink-500 bg-clip-text text-transparent animate-gradient"
    >
      工具集
    </h1>

    <div class="max-w-6xl mx-auto">
      <!-- 标签页切换 -->
      <div class="mb-6 md:mb-8">
        <Tabs
          v-model="activeTab"
          :tabs="tabs"
          class="justify-center max-w-md mx-auto bg-white/50 dark:bg-gray-800/50 backdrop-blur-sm rounded-full p-1.5 md:p-2 shadow-sm flex items-center gap-1.5 md:gap-2 text-sm md:text-base"
          @update:modelValue="handleTabChange"
        />
      </div>

      <!-- 加载状态 -->
      <div
        v-if="isLoading"
        class="flex items-center justify-center py-8 md:py-12"
      >
        <div
          class="loader dark:border-t-gray-700 dark:border-r-gray-700 dark:border-l-gray-700 w-10 h-10 md:w-12 md:h-12"
        ></div>
      </div>

      <template v-else>
        <!-- 项目列表 -->
        <TransitionGroup
          v-show="activeTab === 'projects'"
          name="list"
          tag="div"
          class="grid grid-cols-1 md:grid-cols-2 gap-8 px-4"
        >
          <article
            v-for="(project, index) in projectsList"
            :key="project.id"
            :style="{ transitionDelay: getTransitionDelay(index) }"
            class="group bg-white dark:bg-gray-800/90 rounded-xl shadow-lg overflow-hidden hover:shadow-xl dark:hover:shadow-primary/5 transition-all duration-300 hover:-translate-y-2 relative dark:border dark:border-gray-700/50 dark:hover:glow-lg dark:hover:border-primary/30 flex flex-col animate-fade-in"
          >
            <!-- 项目卡片悬停效果 -->
            <div
              class="absolute inset-0 bg-primary/5 dark:bg-primary/10 opacity-0 group-hover:opacity-100 transition-all duration-300 dark:group-hover:backdrop-blur-sm"
            ></div>
            <div class="relative h-56 overflow-hidden">
              <img
                :src="project.image"
                :alt="project.title"
                class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-110"
              />
              <div
                class="absolute inset-0 bg-gradient-to-t from-black/70 via-black/50 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center"
              >
                <a
                  v-if="project.link && PROJECT_STATUS[project.status]?.linkable"
                  :href="project.link"
                  target="_blank"
                  class="px-8 py-3 bg-white/20 hover:bg-white/30 rounded-full transition-all duration-300 text-white font-medium hover:scale-105 hover:shadow-lg backdrop-blur-sm"
                >
                  访问项目
                </a>
                <span v-if="!PROJECT_STATUS[project.status]?.linkable">
                  {{ PROJECT_STATUS[project.status]?.label }}
                </span>
              </div>
            </div>
            <div class="p-6 flex-1 flex flex-col">
              <div class="flex items-center justify-between mb-2">
                <h3 class="text-xl font-semibold dark:text-gray-100">
                  {{ project.title }}
                </h3>
                <span
                  class="text-sm px-2 py-1 rounded"
                  :class="STATUS_CLASSES[PROJECT_STATUS[project.status]?.color]"
                >
                    {{ PROJECT_STATUS[project.status]?.label }}
                </span>
              </div>
              <p class="text-gray-600 dark:text-gray-400 mb-4 flex-1">
                {{ project.description }}
              </p>
              <div class="flex flex-wrap gap-2">
                <span
                  v-for="tag in project.tags"
                  :key="tag"
                  class="px-3 py-1 bg-primary-10 dark:bg-primary/10 text-primary dark:text-primary-light rounded-full text-sm font-medium hover:scale-105 transition-transform cursor-default"
                >
                  {{ tag }}
                </span>
              </div>
            </div>
          </article>
        </TransitionGroup>

        <!-- 工具列表 -->
        <TransitionGroup
          v-show="activeTab === 'tools' && !activeToolId"
          name="list"
          tag="div"
          class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3 md:gap-4"
        >
          <article
            v-for="(tool, index) in toolsList"
            :key="tool.id"
            :style="{ transitionDelay: getTransitionDelay(index) }"
            class="group bg-white dark:bg-gray-800 rounded-lg shadow-sm hover:shadow-md transition-all duration-300 border border-gray-100 dark:border-gray-700/50"
          >
            <div class="relative h-40 md:h-48 overflow-hidden rounded-t-lg">
              <img
                :src="tool.image"
                :alt="tool.title"
                class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105"
              />
              <div
                class="absolute inset-0 bg-gradient-to-t from-black/60 via-black/30 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center"
              >
                <button
                  v-if="tool.status === 'completed'"
                  @click="activeToolId = tool.id"
                  class="px-6 py-2 md:px-8 md:py-3 bg-white/20 hover:bg-white/30 rounded-full transition-all duration-300 text-white text-sm md:text-base font-medium hover:scale-105 hover:shadow-lg backdrop-blur-sm"
                >
                  立即使用
                </button>
                <span
                  v-else
                  class="px-6 py-2 md:px-8 md:py-3 bg-white/20 rounded-full text-white backdrop-blur-sm text-sm md:text-base font-medium"
                >
                  {{ tool.status === "developing" ? "开发中" : "规划中" }}
                </span>
              </div>
            </div>

            <div class="p-4 md:p-5">
              <div class="flex items-center justify-between mb-2">
                <h3
                  class="text-base md:text-lg font-medium text-gray-800 dark:text-gray-200"
                >
                  {{ tool.title }}
                </h3>
                <span
                  class="text-xs md:text-sm px-2 py-1 rounded"
                  :class="{
                    'bg-green-100/80 text-green-800 dark:bg-green-900/80 dark:text-green-100':
                      tool.status === 'completed',
                    'bg-yellow-100/80 text-yellow-800 dark:bg-yellow-900/80 dark:text-yellow-100':
                      tool.status === 'developing',
                    'bg-gray-100/80 text-gray-800 dark:bg-gray-900/80 dark:text-gray-100':
                      tool.status === 'planning',
                  }"
                >
                  {{
                    tool.status === "completed"
                      ? "已完成"
                      : tool.status === "developing"
                        ? "开发中"
                        : "规划中"
                  }}
                </span>
              </div>
              <p
                class="text-sm text-gray-600 dark:text-gray-400 mb-3 line-clamp-2"
              >
                {{ tool.description }}
              </p>
              <div class="flex flex-wrap gap-1.5">
                <span
                  v-for="tag in tool.tags"
                  :key="tag"
                  class="px-2 py-1 text-xs rounded-full bg-gray-50 dark:bg-gray-800/50 text-gray-700 dark:text-gray-300 shadow-sm hover:shadow hover:scale-105 hover:bg-primary hover:text-white dark:hover:bg-primary transition-all duration-300 cursor-default border border-gray-100 dark:border-gray-700/50"
                >
                  {{ tag }}
                </span>
              </div>
            </div>
          </article>
        </TransitionGroup>

        <!-- 网址导航 -->
        <div
          v-show="activeTab === 'bookmarks'"
          class="bg-white dark:bg-gray-800 rounded-lg shadow-sm p-4 md:p-6 animate-fade-in border border-gray-100 dark:border-gray-700"
        >
          <BookmarksView/>
        </div>

        <!-- 工具详情页 -->
        <div
          v-if="activeTab === 'tools' && activeToolId"
          class="relative bg-white dark:bg-gray-800 rounded-lg shadow-sm p-4 md:p-6 animate-fade-in border border-gray-100 dark:border-gray-700"
        >
          <!-- 返回按钮 -->
          <div class="absolute left-0 transform -translate-y-full mb-2">
            <button
              @click="showToolList"
              class="flex items-center gap-2 px-3 py-1.5 md:px-4 md:py-2 text-sm md:text-base text-gray-600 dark:text-gray-400 hover:text-blue-500 dark:hover:text-blue-400 bg-white dark:bg-gray-800 rounded-lg shadow-sm hover:shadow-md transition-all duration-300 hover:-translate-x-2"
            >
              <span class="text-lg md:text-xl leading-none">←</span>
              <span>返回工具列表</span>
            </button>
          </div>

          <component
            v-if="activeTool?.component"
            :is="activeTool.component"
            class="animate-slide-up"
          ></component>
        </div>
      </template>
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
</style>
