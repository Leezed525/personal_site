<script setup lang="ts">
import { ref, computed } from "vue";
import ToolLayout from "@/components/layout/ToolLayout.vue";

const input = ref("");
const output = ref("");
const indentSize = ref(2);
const error = ref("");

const formatJson = () => {
  error.value = "";
  if (!input.value.trim()) {
    output.value = "";
    return;
  }

  try {
    const parsed = JSON.parse(input.value);
    output.value = JSON.stringify(parsed, null, indentSize.value);
  } catch (e) {
    error.value = e instanceof Error ? e.message : "无效的 JSON 格式";
  }
};

const compressJson = () => {
  error.value = "";
  if (!input.value.trim()) {
    output.value = "";
    return;
  }

  try {
    const parsed = JSON.parse(input.value);
    output.value = JSON.stringify(parsed);
  } catch (e) {
    error.value = e instanceof Error ? e.message : "无效的 JSON 格式";
  }
};

const copyToClipboard = async () => {
  try {
    await navigator.clipboard.writeText(output.value);
    alert("已复制到剪贴板");
  } catch (e) {
    alert("复制失败，请手动复制");
  }
};

const clearAll = () => {
  input.value = "";
  output.value = "";
  error.value = "";
};

const hasContent = computed(() => input.value.trim().length > 0);
</script>

<template>
  <ToolLayout
    title="JSON 格式化工具"
    description="在线 JSON 格式化工具，支持压缩、美化、验证和转换等功能"
  >
    <div class="grid md:grid-cols-2 gap-6">
      <!-- 输入区域 -->
      <div class="space-y-4">
        <div class="flex items-center justify-between">
          <h2 class="text-lg font-semibold">输入 JSON</h2>
          <button
            v-if="hasContent"
            @click="clearAll"
            class="text-sm text-gray-500 hover:text-primary transition-colors"
          >
            清空
          </button>
        </div>
        <textarea
          v-model="input"
          class="w-full h-[400px] p-4 font-mono text-sm rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 focus:ring-2 focus:ring-primary focus:border-transparent transition-colors resize-none"
          placeholder="在此输入 JSON 字符串..."
          spellcheck="false"
        ></textarea>
      </div>

      <!-- 输出区域 -->
      <div class="space-y-4">
        <div class="flex items-center justify-between">
          <h2 class="text-lg font-semibold">格式化结果</h2>
          <div class="flex items-center gap-2">
            <select
              v-model="indentSize"
              class="px-2 py-1 rounded border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800"
            >
              <option :value="2">缩进 2 空格</option>
              <option :value="4">缩进 4 空格</option>
            </select>
            <button
              v-if="output"
              @click="copyToClipboard"
              class="text-sm text-primary hover:text-primary/80 transition-colors"
            >
              复制
            </button>
          </div>
        </div>
        <pre
          class="w-full h-[400px] p-4 font-mono text-sm rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 overflow-auto"
          :class="{ 'border-red-500': error }"
        ><code>{{ error || output }}</code></pre>
      </div>

      <!-- 操作按钮 -->
      <div class="md:col-span-2 flex justify-center gap-4">
        <button @click="formatJson" class="btn-primary" :disabled="!hasContent">
          格式化
        </button>
        <button
          @click="compressJson"
          class="btn-secondary"
          :disabled="!hasContent"
        >
          压缩
        </button>
      </div>
    </div>
  </ToolLayout>
</template>
