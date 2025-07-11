<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from "vue";
import ToolLayout from "@/components/layout/ToolLayout.vue";

interface TimeFormat {
  label: string;
  format: string;
}

const timestamp = ref("");
const dateString = ref("");
const selectedFormat = ref("YYYY-MM-DD HH:mm:ss");

const timeFormats: TimeFormat[] = [
  { label: "年-月-日 时:分:秒", format: "YYYY-MM-DD HH:mm:ss" },
  { label: "年-月-日", format: "YYYY-MM-DD" },
  { label: "年/月/日 时:分:秒", format: "YYYY/MM/DD HH:mm:ss" },
  { label: "年月日时分秒", format: "YYYYMMDDHHmmss" },
];

// 自动更新当前时间戳
let timer: number;
onMounted(() => {
  timer = window.setInterval(() => {
    currentTimestamp.value = Math.floor(Date.now() / 1000);
  }, 1000);
});

onUnmounted(() => {
  clearInterval(timer);
});

// 复制到剪贴板
const copyToClipboard = async (text: string) => {
  try {
    await navigator.clipboard.writeText(text);
    window.$toast.success("已复制到剪贴板");
  } catch (e) {
    window.$toast.error("复制失败，请手动复制");
  }
};

// 时间戳转日期
const timestampToDate = () => {
  if (!timestamp.value) return;

  try {
    const ts =
      timestamp.value.length === 10
        ? Number(timestamp.value) * 1000
        : Number(timestamp.value);

    const date = new Date(ts);
    if (isNaN(date.getTime())) {
      throw new Error("无效的时间戳");
    }

    dateString.value = formatDate(date, selectedFormat.value);
    window.$toast.success("转换成功");
  } catch (e) {
    window.$toast.error("请输入有效的时间戳");
  }
};

// 日期转时间戳
const dateToTimestamp = () => {
  if (!dateString.value) return;

  try {
    const date = new Date(dateString.value);
    if (isNaN(date.getTime())) {
      throw new Error("无效的日期");
    }

    timestamp.value = String(Math.floor(date.getTime() / 1000));
    window.$toast.success("转换成功");
  } catch (e) {
    window.$toast.error("请输入有效的日期");
  }
};

// 获取当前时间
const setCurrentTime = () => {
  const now = new Date();
  timestamp.value = String(Math.floor(now.getTime() / 1000));
  dateString.value = formatDate(now, selectedFormat.value);
  window.$toast.success("已使用当前时间");
};

// 格式化日期
const formatDate = (date: Date, format: string) => {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  const hours = String(date.getHours()).padStart(2, "0");
  const minutes = String(date.getMinutes()).padStart(2, "0");
  const seconds = String(date.getSeconds()).padStart(2, "0");

  return format
    .replace("YYYY", String(year))
    .replace("MM", month)
    .replace("DD", day)
    .replace("HH", hours)
    .replace("mm", minutes)
    .replace("ss", seconds);
};

// 计算属性
const currentTimestamp = ref<number>(Math.floor(Date.now() / 1000));

const updateTimestamp = () => {
  currentTimestamp.value = Math.floor(Date.now() / 1000);
};
</script>

<template>
  <ToolLayout title="时间戳转换" description="Unix 时间戳与日期格式互转工具">
    <div class="max-w-4xl mx-auto space-y-8">
      <!-- 当前时间信息 -->
      <div class="text-center space-y-2">
        <p class="text-gray-600 dark:text-gray-400">
          当前时间戳：
          <span class="font-mono text-primary">{{ currentTimestamp }}</span>
        </p>
        <button
          @click="setCurrentTime"
          class="text-sm text-primary hover:text-primary/80 transition-colors"
        >
          使用当前时间
        </button>
      </div>

      <!-- 转换工具 -->
      <div class="grid md:grid-cols-2 gap-8">
        <!-- 时间戳转日期 -->
        <div class="space-y-4">
          <div class="flex items-center justify-between">
            <h2 class="text-lg font-semibold">时间戳转日期</h2>
            <button
              v-if="timestamp"
              @click="() => copyToClipboard(dateString)"
              class="text-sm text-primary hover:text-primary/80 transition-colors"
            >
              复制结果
            </button>
          </div>
          <div class="space-y-4">
            <input
              v-model="timestamp"
              type="text"
              placeholder="请输入时间戳..."
              class="w-full px-4 py-2 font-mono rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 focus:ring-2 focus:ring-primary focus:border-transparent transition-colors"
            />
            <select
              v-model="selectedFormat"
              class="w-full px-4 py-2 rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 focus:ring-2 focus:ring-primary focus:border-transparent transition-colors"
            >
              <option
                v-for="format in timeFormats"
                :key="format.format"
                :value="format.format"
              >
                {{ format.label }}
              </option>
            </select>
            <button
              @click="timestampToDate"
              class="w-full btn-primary"
              :disabled="!timestamp"
            >
              转换为日期
            </button>
          </div>
        </div>

        <!-- 日期转时间戳 -->
        <div class="space-y-4">
          <div class="flex items-center justify-between">
            <h2 class="text-lg font-semibold">日期转时间戳</h2>
            <button
              v-if="dateString"
              @click="() => copyToClipboard(timestamp)"
              class="text-sm text-primary hover:text-primary/80 transition-colors"
            >
              复制结果
            </button>
          </div>
          <div class="space-y-4">
            <input
              v-model="dateString"
              type="datetime-local"
              class="w-full px-4 py-2 rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 focus:ring-2 focus:ring-primary focus:border-transparent transition-colors"
            />
            <button
              @click="dateToTimestamp"
              class="w-full btn-primary"
              :disabled="!dateString"
            >
              转换为时间戳
            </button>
          </div>
        </div>
      </div>

      <!-- 结果展示 -->
      <div
        v-if="timestamp || dateString"
        class="p-6 bg-gray-50 dark:bg-gray-800 rounded-lg space-y-4"
      >
        <div v-if="timestamp" class="space-y-2">
          <h3 class="font-semibold">时间戳：</h3>
          <p class="font-mono">{{ timestamp }}</p>
        </div>
        <div v-if="dateString" class="space-y-2">
          <h3 class="font-semibold">日期时间：</h3>
          <p class="font-mono">{{ dateString }}</p>
        </div>
      </div>
    </div>
  </ToolLayout>
</template>
