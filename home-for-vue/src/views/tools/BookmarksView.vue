<script setup lang="ts">
import { ref, computed } from "vue";

interface Bookmark {
  title: string;
  description: string;
  url: string;
  icon?: string;
  tags: string[];
}

interface BookmarkCategory {
  name: string;
  bookmarks: Bookmark[];
}

const categories = ref<BookmarkCategory[]>([
  {
    name: "常用工具",
    bookmarks: [
      {
        title: "ChatGPT",
        description: "OpenAI 开发的人工智能聊天机器人",
        url: "https://chat.openai.com",
        icon: "🤖",
        tags: ["AI", "聊天"],
      },
      {
        title: "GitHub",
        description: "全球最大的代码托管平台",
        url: "https://github.com",
        icon: "📦",
        tags: ["开发", "代码"],
      },
    ],
  },
  {
    name: "学习资源",
    bookmarks: [
      {
        title: "MDN",
        description: "Mozilla 的开发者文档",
        url: "https://developer.mozilla.org",
        icon: "📚",
        tags: ["文档", "开发"],
      },
      {
        title: "Vue.js",
        description: "渐进式 JavaScript 框架",
        url: "https://vuejs.org",
        icon: "💚",
        tags: ["框架", "开发"],
      },
    ],
  },
  {
    name: "设计资源",
    bookmarks: [
      {
        title: "Tailwind CSS",
        description: "实用优先的 CSS 框架",
        url: "https://tailwindcss.com",
        icon: "🎨",
        tags: ["CSS", "设计"],
      },
      {
        title: "Heroicons",
        description: "精美的 SVG 图标库",
        url: "https://heroicons.com",
        icon: "⭐",
        tags: ["图标", "设计"],
      },
    ],
  },
]);

const searchQuery = ref("");
const selectedTags = ref<string[]>([]);

// 获所有标签
const allTags = [
  ...new Set(
    categories.value.flatMap((category) =>
      category.bookmarks.flatMap((bookmark) => bookmark.tags),
    ),
  ),
];

// 切换标签选择
const toggleTag = (tag: string) => {
  const index = selectedTags.value.indexOf(tag);
  if (index === -1) {
    selectedTags.value.push(tag);
  } else {
    selectedTags.value.splice(index, 1);
  }
};

// 过滤书签
const filteredCategories = computed(() => {
  return categories.value
    .map((category) => ({
      ...category,
      bookmarks: category.bookmarks.filter((bookmark) => {
        const matchesSearch = searchQuery.value
          ? bookmark.title
              .toLowerCase()
              .includes(searchQuery.value.toLowerCase()) ||
            bookmark.description
              .toLowerCase()
              .includes(searchQuery.value.toLowerCase())
          : true;

        const matchesTags = selectedTags.value.length
          ? selectedTags.value.every((tag) => bookmark.tags.includes(tag))
          : true;

        return matchesSearch && matchesTags;
      }),
    }))
    .filter((category) => category.bookmarks.length > 0);
});
</script>

<template>
  <div>
    <!-- 导航内容 -->
    <div class="grid gap-8">
      <!-- 搜索和过滤 -->
      <div class="mb-8 space-y-4">
        <input
          v-model="searchQuery"
          type="text"
          placeholder="搜索网站..."
          class="w-full px-4 py-2 rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 focus:ring-2 focus:ring-primary focus:border-transparent transition-colors"
        />

        <div class="flex flex-wrap gap-2">
          <button
            v-for="tag in allTags"
            :key="tag"
            class="px-3 py-1 rounded-full text-sm transition-all duration-300"
            :class="[
              selectedTags.includes(tag)
                ? 'bg-primary text-white scale-105'
                : 'bg-gray-100 dark:bg-gray-800 hover:bg-gray-200 dark:hover:bg-gray-700 hover:scale-105',
            ]"
            @click="toggleTag(tag)"
          >
            {{ tag }}
          </button>
        </div>
      </div>

      <!-- 书签列表 -->
      <div class="space-y-8">
        <div
          v-for="category in filteredCategories"
          :key="category.name"
          class="space-y-4"
        >
          <h2 class="text-xl font-bold">{{ category.name }}</h2>
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <a
              v-for="bookmark in category.bookmarks"
              :key="bookmark.url"
              :href="bookmark.url"
              target="_blank"
              rel="noopener noreferrer"
              class="group p-4 bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700 hover:border-primary dark:hover:border-primary transition-all duration-300 hover:-translate-y-1 hover:shadow-lg"
            >
              <div class="flex items-start space-x-3">
                <span class="text-2xl">{{ bookmark.icon }}</span>
                <div class="flex-1">
                  <h3
                    class="font-semibold group-hover:text-primary transition-colors"
                  >
                    {{ bookmark.title }}
                  </h3>
                  <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">
                    {{ bookmark.description }}
                  </p>
                  <div class="flex flex-wrap gap-2 mt-2">
                    <span
                      v-for="tag in bookmark.tags"
                      :key="tag"
                      class="px-2 py-0.5 text-xs bg-primary-10 text-primary rounded-full"
                    >
                      {{ tag }}
                    </span>
                  </div>
                </div>
              </div>
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
