<script setup lang="ts">
import {ref, computed, onMounted} from "vue";
import type {Ref} from "@vue/runtime-core";
import {fetchBlogPosts} from "../utils/rss";
import type {ArticleQueryData, ArticleResData} from "../types/article";
import {listArticle} from "../api/blog/article"
import PageTransition from "../components/PageTransition.vue";
import {list} from "postcss";
import {data} from "autoprefixer";
import {blogTabs} from "@/config/navigation";
import Tabs from "@/components/ui/Tabs.vue";


const activeTab = ref("all");

let posts: ArticleResData[] = [];
let queryData: ArticleQueryData = {
  summary: "",
  category:undefined,
  title: "",
  pageNum: 1,
  pageSize: 6
};
const loading = ref(true);
const error = ref<string | null>(null);
const currentPage = ref(1);
const postsPerPage = 6;
const tmpImageIndex = 1;


// 计算总页数
let totalPages = 0;
//总文章数
let totalArticles = 0;


// 页码数组
const pageNumbers = computed(() => {
  const pages = [];
  for (let i = 1; i <= totalPages; i++) {
    pages.push(i);
  }
  return pages;
});

// 切换页面
function changePage(page: number) {
  currentPage.value = page;
  window.scrollTo({top: 0, behavior: "smooth"});
}

// 上一页
function prevPage() {
  //请求上一页
  if (currentPage.value > 1) {
    changePage(currentPage.value - 1);
  }
  getList();
}

// 下一页
function nextPage() {
  //请求下一页
  if (currentPage.value < totalPages) {
    changePage(currentPage.value + 1);
  }
  getList();
}

// 模拟加载效果
const handleTabChange = async () => {
  await new Promise((resolve) => setTimeout(resolve, 300));
  if(activeTab.value == "all") {
    queryData.category = undefined;
  } else {
    queryData.category = activeTab.value;
  }
  getList();
};

async function getList(){
  try {
    loading.value = true;
    queryData.pageNum = currentPage.value;
    const data: any = await listArticle(queryData);
    //获取总页数
    totalArticles = data.total;
    totalPages = Math.ceil(data.total / postsPerPage);
    posts = data.rows;
    posts = fillImageUrl(posts);
  } catch (e) {
    error.value = e instanceof Error ? e.message : "获取博客文章失败";
  } finally {
    loading.value = false;
  }
}


//填充图片
function fillImageUrl(posts: ArticleResData[]): ArticleResData[] {
  posts.forEach(post => {
    if (!post.cover) {
      post.cover = "https://picsum.photos/seed/${tmpImageIndex + i}/800/400";
    }
  })
  return posts;
}


onMounted(async () => {
  getList();
});

// 格式化日期
function formatDate(date: Date): string {
  return new Intl.DateTimeFormat("zh-CN", {
    year: "numeric",
    month: "long",
    day: "numeric",
  }).format(date);
}
</script>

<template>
  <div class="min-h-screen">
    <div class="container mx-auto px-4 py-12">
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

      <!-- 博客列表 -->
      <div v-else>
        <!-- 文章统计 -->
        <div class="text-center mb-8 text-gray-600 dark:text-gray-400">
          共 {{ totalArticles }} 篇文章
        </div>

        <div class="grid gap-8 md:grid-cols-2 lg:grid-cols-3">
          <PageTransition
            v-for="post in posts"
            :key="post.link"
            name="fade"
            class="h-full"
          >
            <article
              class="bg-white dark:bg-gray-800 rounded-xl shadow-sm overflow-hidden"
            >
              <!-- 文章封面 -->
              <img
                v-if="post.cover"
                :src="post.cover"
                :alt="post.title"
                class="w-full h-48 object-cover"
              />
              <div class="p-6 flex-1">
                <div class="flex items-center mb-4 space-x-2">
                  <span
                    class="px-3 py-1 text-sm rounded-full bg-blue-50 dark:bg-blue-900/50 text-blue-500 dark:text-blue-300"
                  >
                    {{ post.category }}
                  </span>
                  <time
                    :datetime="post.createTime"
                    class="text-sm text-tertiary"
                  >
                    {{ post.createTime }}
                  </time>
                </div>
                <h2
                  class="text-xl font-bold mb-3 hover:text-primary transition-colors line-clamp-2"
                >
                  <a
                    :href="post.url"
                    target="_blank"
                    rel="noopener noreferrer"
                  >
                    {{ post.title }}
                  </a>
                </h2>
                <p
                  class="text-secondary line-clamp-3 mb-4 text-sm leading-relaxed"
                  v-html="post.summary"
                ></p>
              </div>
              <div class="px-6 py-4 bg-secondary border-t border-light">
                <a
                  :href="post.url"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="inline-flex items-center text-primary hover:text-primary-dark transition-colors group"
                >
                  阅读全文
                  <svg
                    class="w-4 h-4 ml-1 transform transition-transform group-hover:translate-x-1"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M13 7l5 5m0 0l-5 5m5-5H6"
                    />
                  </svg>
                </a>
              </div>
            </article>
          </PageTransition>
        </div>

        <!-- 分页控件优化 -->
        <div
          v-if="totalPages > 1"
          class="flex justify-center items-center space-x-3 mt-12"
        >
          <button
            @click="prevPage"
            :disabled="currentPage === 1"
            class="px-4 py-2 rounded-lg border-2 border-gray-300 dark:border-gray-600 disabled:opacity-50 disabled:cursor-not-allowed hover:border-primary hover:text-primary transition-all focus:outline-none focus:ring-2 focus:ring-primary/50"
          >
            <span class="flex items-center">
              <svg
                class="w-4 h-4 mr-1"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M15 19l-7-7 7-7"
                />
              </svg>
              上一页
            </span>
          </button>
          <div class="flex space-x-2">
            <button
              v-for="page in pageNumbers"
              :key="page"
              @click="changePage(page)"
              :class="[
                'w-10 h-10 rounded-lg flex items-center justify-center transition-all focus:outline-none focus:ring-2 focus:ring-primary/50',
                currentPage === page
                  ? 'bg-primary text-white'
                  : 'border-2 border-gray-300 dark:border-gray-600 hover:border-primary hover:text-primary',
              ]"
            >
              {{ page }}
            </button>
          </div>
          <button
            @click="nextPage"
            :disabled="currentPage === totalPages"
            class="px-4 py-2 rounded-lg border-2 border-gray-300 dark:border-gray-600 disabled:opacity-50 disabled:cursor-not-allowed hover:border-primary hover:text-primary transition-all focus:outline-none focus:ring-2 focus:ring-primary/50"
          >
            <span class="flex items-center">
              下一页
              <svg
                class="w-4 h-4 ml-1"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M9 5l7 7-7 7"
                />
              </svg>
            </span>
          </button>
        </div>
      </div>

      <!-- 空状态 -->
      <div
        v-if="!loading && !error && posts.length === 0"
        class="text-center py-20"
      >
        <svg
          class="w-20 h-20 mx-auto text-gray-400 mb-4"
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
          />
        </svg>
        <p class="text-gray-500 dark:text-gray-400 text-lg">暂无博客文章</p>
      </div>
    </div>
  </div>
</template>

<style scoped>
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
