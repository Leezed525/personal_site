<script setup lang="ts">
import {onMounted, ref} from "vue";
import emailjs from "@emailjs/browser";
import {emailConfig} from "@/config/email";
import {fetchBlogPosts} from "@/utils/rss";
import PageTransition from "@/components/PageTransition.vue";
import {listArticle} from "@/api/blog/article";
import {ArticleQueryData, ArticleResData} from "@/types/article";
import {ElMessage} from "element-plus";
import {addComment} from "@/api/contact/comment";


import {useAuthStore} from '@/store/auth'

const auth = useAuthStore()

const showLeaveMessage = ref(false)   //  控制留言弹窗
const messageText = ref('')           //  留言内容

const loading = ref(true);
const error = ref<string | null>(null);

let posts: ArticleResData[] = [];
let queryData: ArticleQueryData = {
  summary: "",
  title: "",
  pageNum: 1,
  pageSize: 6
};
const currentPage = ref(1);
const postsPerPage = 6;
const tmpImageIndex = 1;

// 计算总页数
let totalPages = 0;
//总文章数
let totalArticles = 0;

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

const handleLeaveMessage = () => {
  if (!auth.isLoggedIn) {
    // 没登录
    ElMessage.warning('请先登录后再留言')
    return
  }
  // 已登录 → 打开弹窗
  messageText.value = ''
  showLeaveMessage.value = true
}

const submitLeaveMessage = async () => {
  if (!messageText.value.trim()) return

  //组装数据
  const data = {
    content: messageText.value,
    authorId: auth.user.id,
  }

  addComment(data).then(() => {
    ElMessage.success('留言发表成功')
    showLeaveMessage.value = false
  }).catch((e: any) => {
    ElMessage.error(e?.response?.data?.msg || '发表失败')
  })


  // try {
  //   await request.post('/api/message', {content: messageText.value})
  //   ElMessage.success('留言发表成功')
  //   showLeaveMessage.value = false
  // } catch (e: any) {
  //   ElMessage.error(e?.response?.data?.msg || '发表失败')
  // }
};

// 获取博客文章
async function getList() {
  try {
    loading.value = true;
    queryData.pageNum = currentPage.value;
    const data: any = await listArticle(queryData);
    //获取总页数
    totalArticles = data.total;
    totalPages = Math.ceil(data.total / postsPerPage);
    posts = data.rows;
    console.log(posts);
  } catch (e) {
    error.value = e instanceof Error ? e.message : "获取博客文章失败";
  } finally {
    loading.value = false;
  }
}

onMounted(async () => {
  getList();
});
</script>

<template>
  <div class="container mx-auto px-4 py-8 md:py-12">
    <!--    <div class="max-w-2xl mx-auto">-->
    +
    <div class="max-w-5xl mx-auto">
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
          @click="handleLeaveMessage"
          class="inline-flex items-center px-5 py-2 md:px-6 md:py-2.5 text-sm md:text-base font-medium rounded-full text-white bg-gradient-to-r from-blue-500 to-purple-500 hover:from-blue-600 hover:to-purple-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-all duration-300 ease-in-out transform hover:scale-105 shadow-sm"
        >
          <span class="mr-2">留言</span>
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
              <div class="p-6 flex-1">
                <div class="flex items-center mb-4 space-x-2">
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

  <!-- 留言弹窗 -->
  <transition
    enter-active-class="duration-200 ease-out"
    enter-from-class="opacity-0 scale-95"
    enter-to-class="opacity-100 scale-100"
  >
    <div
      v-if="showLeaveMessage"
      class="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-sm"
      @click.self="showLeaveMessage = false"
    >
      <div
        class="w-full max-w-lg bg-white dark:bg-gray-800 rounded-xl shadow-2xl p-6 space-y-4"
      >
        <h3 class="text-xl font-bold text-center">发表留言</h3>

        <textarea
          v-model="messageText"
          rows="4"
          placeholder="说点什么..."
          class="w-full border px-3 py-2 rounded-lg resize-none focus:ring-2 focus:ring-blue-500"
        ></textarea>

        <div class="flex justify-end space-x-3">
          <button
            @click="showLeaveMessage = false"
            class="px-4 py-2 rounded-lg bg-gray-200 dark:bg-gray-700 hover:bg-gray-300 dark:hover:bg-gray-600"
          >
            取消
          </button>
          <button
            @click="submitLeaveMessage"
            :disabled="!messageText.trim()"
            class="px-4 py-2 rounded-lg bg-blue-500 text-white hover:bg-blue-600 disabled:bg-gray-400"
          >
            发表
          </button>
        </div>
      </div>
    </div>
  </transition>
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
