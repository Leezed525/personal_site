<script setup lang="ts">
import { ref } from "vue";

interface Tab {
  id: string;
  label: string;
  icon?: string;
}

const props = defineProps<{
  tabs: Tab[];
  modelValue: string;
}>();

const emit = defineEmits<{
  (e: "update:modelValue", value: string): void;
}>();

const activeTab = ref(props.modelValue);

const switchTab = (tabId: string) => {
  activeTab.value = tabId;
  emit("update:modelValue", tabId);
};
</script>

<template>
  <div class="flex" :class="$attrs.class">
    <button
      v-for="tab in tabs"
      :key="tab.id"
      @click="$emit('update:modelValue', tab.id)"
      class="flex items-center gap-2 px-4 py-2 rounded-full transition-all duration-300 min-w-[120px] justify-center"
      :class="[
        modelValue === tab.id
          ? 'bg-white dark:bg-gray-800 shadow-md text-primary dark:text-primary-light'
          : 'text-gray-600 dark:text-gray-400 hover:text-primary dark:hover:text-primary-light',
      ]"
    >
      <span class="text-lg">{{ tab.icon }}</span>
      <span>{{ tab.label }}</span>
    </button>
  </div>
</template>
