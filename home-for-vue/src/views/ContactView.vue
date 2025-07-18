<script setup lang="ts">
import {onMounted, ref} from "vue";
import emailjs from "@emailjs/browser";
import {emailConfig} from "@/config/email";
import {fetchBlogPosts} from "@/utils/rss";
import PageTransition from "@/components/PageTransition.vue";
import {ArticleQueryData, ArticleResData} from "@/types/article";
import {ElMessage} from "element-plus";
import {addComment, listComment, listChildComment} from "@/api/contact/comment";


import {useAuthStore} from '@/store/auth'

const auth = useAuthStore()

const showLeaveMessage = ref(false)   //  控制留言弹窗
const messageText = ref('')           //  留言内容

const loading = ref(true);
const error = ref<string | null>(null);

/* 新增：弹窗控制 */
const replyModal = ref<{
  open: boolean;
}>({open: false});

/* 新增：回复输入框 */
const replyText = ref('');

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

/* 新增：当前留言详情 + 子回复 */
const currentDetail = ref<{
  id: string | number;
  createBy: string;
  createTime: string;
  content: string;
  replies: ArticleResData[];
} | null>(null)

/* 新增：弹窗 loading */
const replyDetailLoading = ref(false)


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
    ElMessage.success('留言发表成功(审核通过后展示)')
    showLeaveMessage.value = false
  }).catch((e: any) => {
    ElMessage.error(e?.response?.data?.msg || '发表失败')
  })
};


// ✅ 替换原来的 openReplyModal
const openReplyModal = async (post: ArticleResData) => {
  replyDetailLoading.value = true
  replyModal.value = {open: true, comment: null} // 先显示空壳

  try {
    // 1. 拉子回复
    const repliesRes = await listChildComment(post);

    // 2. 拼成完整数据
    currentDetail.value = {
      ...post,
      replies: repliesRes.data
    }
  } catch (e) {
    ElMessage.error('加载留言详情失败')
  } finally {
    replyDetailLoading.value = false
  }
}

const closeReplyModal = () => {
  replyModal.value.open = false
  currentDetail.value = null
}

const submitReply = async (preid) => {
  if (!replyText.value.trim()) return;
  console.log(preid);
  console.log(replyText.value);
  const data = {
    preId: preid,
    content: replyText.value,
    authorId: auth.user.id, // 使用当前登录用户的 ID
  }

  addComment(data).then(() => {
    ElMessage.success('留言发表成功(审核通过后展示)')
    replyText.value = '';
  }).catch((e: any) => {
    ElMessage.error(e?.response?.data?.msg || '发表失败')
  })
};

/* 示例：刷新回复列表（按后端接口实现） */
const refreshReplies = async () => {
  /* 如后端支持 /api/comment/{id}/replies */
  // const { data } = await getReplies(replyModal.value.comment!.id);
  // replyModal.value.comment.replies = data;
};

// 获取博客文章
async function getList() {
  try {
    loading.value = true;
    queryData.pageNum = currentPage.value;
    const data: any = await listComment(queryData);
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

      <!-- 留言列表 -->
      <div v-else>
        <div class="grid gap-8 md:grid-cols-2 lg:grid-cols-3">
          <PageTransition
            v-for="post in posts"
            :key="post.id"
            name="fade"
            class="h-full"
          >
            <article
              class="bg-white dark:bg-gray-800 rounded-2xl shadow-md hover:shadow-xl  transition-all duration-300 flex flex-col overflow-hidden">
              <!-- 顶部信息 -->
              <div class="p-5">
                <time :datetime="post.createTime" class="text-xs text-gray-400 dark:text-gray-500">
                  {{ post.createTime }}
                </time>

                <h3 class="mt-2 text-lg font-semibold text-gray-900 dark:text-white  line-clamp-2">
                  {{ post.createBy }}
                </h3>

                <p class="mt-2 text-sm text-gray-600 dark:text-gray-300 leading-relaxed" v-html="post.content"></p>
              </div>

              <!-- 底部按钮区 -->
              <div class="mt-auto px-5 py-3 bg-gray-50 dark:bg-gray-800/50 flex items-center justify-end">
                <button @click="openReplyModal(post)"
                        class="text-xs font-medium px-3 py-1.5 rounded-full  text-white bg-blue-500  hover:bg-blue-600 transition-all duration-200 hover:scale-105">
                  查看/回复
                </button>
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

    <!-- 回复弹窗 -->
    <transition
      enter-active-class="duration-200 ease-out"
      enter-from-class="opacity-0 scale-95"
      enter-to-class="opacity-100 scale-100"
    >
      <div
        v-if="replyModal.open"
        class="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-sm"
        @click.self="closeReplyModal"
      >
        <div
          class="w-full max-w-2xl max-h-[90vh] bg-white dark:bg-gray-800 rounded-xl shadow-2xl p-6 space-y-4 overflow-y-auto"
        >
          <h3 class="text-xl font-bold">留言详情</h3>

          <!-- ✅ 骨架屏 -->
          <div v-if="replyDetailLoading" class="flex justify-center py-10">
            <div class="animate-spin rounded-full h-8 w-8 border-2 border-blue-500 border-t-transparent"></div>
          </div>

          <!-- ✅ 详情渲染 -->
          <template v-if="!replyDetailLoading && currentDetail">
            <!-- 原留言 -->
            <div class="border-b pb-4">
              <p class="text-sm text-tertiary">{{ currentDetail.createTime }}</p>
              <p class="text-lg font-semibold mt-1">{{ currentDetail.createBy }}</p>
              <p class="mt-2" v-html="currentDetail.content"></p>
            </div>

            <!-- 回复列表 -->
            <div>
              <h4 class="font-semibold mb-2">回复</h4>
              <!-- 有回复 -->
              <div v-if="currentDetail?.replies?.length">
                <div
                  v-for="r in currentDetail.replies"
                  :key="r.id"
                  class="mb-2 border-l-2 pl-3"
                >
                  <p class="text-sm text-tertiary">{{ r.createBy }} · {{ r.createTime }}</p>
                  <p>{{ r.content }}</p>
                </div>
              </div>
              <!-- ✅ 暂无回复 -->
              <p v-else class="text-sm text-gray-400 dark:text-gray-500">
                暂无回复
              </p>
            </div>
          </template>

          <!-- 回复输入框区域 -->
          <div>
            <!-- 未登录：灰色占位提示 -->
            <div v-if="!auth.isLoggedIn"
                 class="w-full border border-gray-300 dark:border-gray-600 rounded-lg bg-gray-100 dark:bg-gray-700 text-center py-4 text-sm text-gray-500 cursor-pointer"
                 @click="needLogin"
            >
              请先登录后再回复
            </div>

            <!-- 已登录：正常输入框 -->
            <textarea v-else
                      v-model="replyText" rows="3" placeholder="写一条回复..."
                      class="w-full border px-3 py-2 rounded-lg resize-none focus:ring-2 focus:ring-blue-500"
            ></textarea>
          </div>

          <!-- 回复按钮：未登录时隐藏 -->
          <button
            v-if="auth.isLoggedIn"
            @click="submitReply(currentDetail.id)"
            :disabled="!replyText.trim()"
            class="px-4 py-2 rounded bg-blue-500 text-white hover:bg-blue-600 disabled:bg-gray-400"
          >
            回复
          </button>

          <!-- 关闭按钮 -->
          <button
            @click="closeReplyModal"
            class="absolute top-3 right-3 text-gray-400 hover:text-gray-600"
          >
            &times;
          </button>
        </div>
      </div>
    </transition>
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
