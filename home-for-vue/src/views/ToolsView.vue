<script setup lang="ts">
import { ref, computed, watch } from "vue";
import PageTransition from "@/components/PageTransition.vue";
import { useRoute } from "vue-router";

const route = useRoute();
const isLoading = ref(false);

interface Tool {
  id: number;
  title: string;
  description: string;
  tags: string[];
  image: string;
  link: string;
  status: "online" | "developing" | "planning";
}

// 模拟加载效果
watch(
  () => route.path,
  async () => {
    isLoading.value = true;
    await new Promise((resolve) => setTimeout(resolve, 300));
    isLoading.value = false;
  },
);

// 点击涟漪效果
const createRipple = (event: MouseEvent) => {
  const button = event.currentTarget as HTMLElement;
  const ripple = document.createElement("span");
  const rect = button.getBoundingClientRect();

  const size = Math.max(rect.width, rect.height);
  const x = event.clientX - rect.left - size / 2;
  const y = event.clientY - rect.top - size / 2;

  ripple.style.width = ripple.style.height = `${size}px`;
  ripple.style.left = `${x}px`;
  ripple.style.top = `${y}px`;
  ripple.classList.add("ripple");

  button.appendChild(ripple);

  setTimeout(() => ripple.remove(), 600);
};

const tools = ref<Tool[]>([
  {
    id: 1,
    title: "JSON 格式化工具",
    description: "在线 JSON 格式化工具，支持压缩、美化、验证和转换等功能",
    tags: ["JSON", "格式化", "在线工具"],
    image: "https://picsum.photos/800/600?random=1",
    link: "/tools/json",
    status: "online",
  },
  {
    id: 2,
    title: "时间戳转换器",
    description: "时间戳与日期格式互转工具，支持多种格式和时区设置",
    tags: ["时间戳", "日期转换", "时区"],
    image: "https://picsum.photos/800/600?random=2",
    link: "/tools/timestamp",
    status: "online",
  },
  {
    id: 3,
    title: "Base64 编解码",
    description: "支持文本、图片、文件的 Base64 编码解码功能",
    tags: ["Base64", "编码解码", "文件处理"],
    image: "https://picsum.photos/800/600?random=3",
    link: "/tools/base64",
    status: "developing",
  },
  {
    id: 4,
    title: "正则表达式测试",
    description: "在线正则表达式测试工具，提供常用正则示例和实时匹配高亮",
    tags: ["正则表达式", "测试工具", "字符串匹配"],
    image: "https://picsum.photos/800/600?random=4",
    link: "/tools/regex",
    status: "planning",
  },
]);

// 过滤标签
const allTags = computed(() => [
  ...new Set(tools.value.flatMap((p) => p.tags)),
]);
const selectedTags = ref<string[]>([]);

const toggleTag = (tag: string) => {
  const index = selectedTags.value.indexOf(tag);
  if (index === -1) {
    selectedTags.value.push(tag);
  } else {
    selectedTags.value.splice(index, 1);
  }
};

const filteredTools = computed(() => {
  if (selectedTags.value.length === 0) return tools.value;
  return tools.value.filter((tool) =>
    selectedTags.value.every((tag) => tool.tags.includes(tag)),
  );
});
</script>

<template>
  <div class="container mx-auto px-4 py-12">
    <template v-if="!route.params.tool">
      <PageTransition name="bounce">
        <div class="max-w-4xl mx-auto text-center mb-12">
          <h1 class="text-4xl font-bold mb-4">工具箱</h1>
          <p class="text-lg text-gray-600 dark:text-gray-400">
            一些实用的在线工具集合
          </p>
        </div>
      </PageTransition>

      <div class="max-w-6xl mx-auto">
        <!-- 加载状态 -->
        <div v-if="isLoading" class="flex items-center justify-center py-12">
          <div
            class="loader dark:border-t-gray-700 dark:border-r-gray-700 dark:border-l-gray-700"
          ></div>
        </div>

        <!-- 标签过滤器 -->
        <div v-show="!isLoading" class="mb-8">
          <div class="flex flex-wrap gap-2">
            <button
              v-for="tag in allTags"
              :key="tag"
              class="px-3 py-1 rounded-full text-sm transition-all duration-300 relative overflow-hidden"
              :class="[
                selectedTags.includes(tag)
                  ? 'bg-primary text-white scale-105 shadow-md dark:shadow-primary/20 dark:hover:glow-sm'
                  : 'bg-gray-100 dark:bg-gray-800/80 hover:bg-gray-200 dark:hover:bg-gray-700/90 hover:scale-102 hover:shadow-sm dark:hover:shadow-gray-900/50 dark:hover:border-primary/30',
              ]"
              @click="toggleTag(tag)"
              @mousedown="createRipple"
            >
              {{ tag }}
            </button>
          </div>
        </div>

        <!-- 工具列表 -->
        <TransitionGroup
          v-show="!isLoading"
          name="list"
          tag="div"
          class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 xl:gap-8"
        >
          <article
            v-for="tool in filteredTools"
            :key="tool.id"
            class="group bg-white dark:bg-gray-800/90 rounded-xl shadow-lg overflow-hidden hover:shadow-xl dark:hover:shadow-primary/5 transition-all duration-300 hover:-translate-y-2 relative dark:border dark:border-gray-700/50 dark:hover:glow-lg dark:hover:border-primary/30"
          >
            <!-- 工具卡片悬停效果 -->
            <div
              class="absolute inset-0 bg-primary/5 dark:bg-primary/10 opacity-0 group-hover:opacity-100 transition-all duration-300 dark:group-hover:backdrop-blur-sm"
            ></div>
            <div class="relative h-48 overflow-hidden">
              <img
                :src="tool.image"
                :alt="tool.title"
                class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-110"
              />
              <div
                class="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center"
              >
                <router-link
                  v-if="tool.status === 'online'"
                  :to="tool.link"
                  class="px-6 py-2 bg-white/20 hover:bg-white/30 rounded-full transition-colors text-white"
                >
                  立即使用
                </router-link>
                <span
                  v-else
                  class="px-6 py-2 bg-white/20 rounded-full text-white"
                >
                  {{ tool.status === "developing" ? "开发中" : "规划中" }}
                </span>
              </div>
            </div>
            <div class="p-6">
              <h3 class="text-xl font-semibold mb-2">{{ tool.title }}</h3>
              <p class="text-gray-600 dark:text-gray-400 mb-4">
                {{ tool.description }}
              </p>
              <div class="flex flex-wrap gap-2">
                <span
                  v-for="tag in tool.tags"
                  :key="tag"
                  class="px-3 py-1 bg-primary-10 text-primary rounded-full text-sm"
                >
                  {{ tag }}
                </span>
              </div>
            </div>
          </article>
        </TransitionGroup>
      </div>
    </template>

    <!-- 工具详情页 -->
    <router-view v-else v-slot="{ Component }">
      <transition name="fade" mode="out-in">
        <component :is="Component"></component>
      </transition>
    </router-view>
  </div>
</template>

<style scoped>
/* 列表动画 */
.list-move,
.list-enter-active,
.list-leave-active {
  transition: all 0.6s cubic-bezier(0.4, 0, 0.2, 1);
}

.list-enter-from,
.list-leave-to {
  opacity: 0;
  transform: scale(0.95) translateY(30px);
}

.list-leave-active {
  position: absolute;
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

/* 涟漪效果 */
.ripple {
  position: absolute;
  border-radius: 50%;
  background-color: rgba(255, 255, 255, 0.4);
  @apply dark:bg-white/20;
  transform: scale(0);
  animation: ripple 0.6s linear;
}

@keyframes ripple {
  to {
    transform: scale(4);
    opacity: 0;
  }
}

/* 暗色模式特效 */
@media (prefers-color-scheme: dark) {
  .dark\:hover\:glow-sm:hover {
    box-shadow: 0 0 10px var(--color-primary);
  }

  .dark\:hover\:glow-lg:hover {
    box-shadow: 0 0 20px var(--color-primary);
  }
}

.hover\:scale-102:hover {
  transform: scale(1.02);
}

/* 路由过渡动画 */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
