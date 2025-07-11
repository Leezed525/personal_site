<script setup lang="ts">
import { ref, onMounted } from "vue";

const props = defineProps<{
  src: string;
  alt: string;
  width?: string | number;
  height?: string | number;
}>();

const isLoaded = ref(false);
const observer = ref<IntersectionObserver | null>(null);
const imgRef = ref<HTMLImageElement | null>(null);

onMounted(() => {
  observer.value = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting && imgRef.value) {
        imgRef.value.src = props.src;
        isLoaded.value = true;
        observer.value?.disconnect();
      }
    });
  });

  if (imgRef.value) {
    observer.value.observe(imgRef.value);
  }
});
</script>

<template>
  <div class="relative overflow-hidden">
    <img
      ref="imgRef"
      :alt="alt"
      :width="width"
      :height="height"
      class="transition-opacity duration-300"
      :class="{ 'opacity-0': !isLoaded, 'opacity-100': isLoaded }"
      loading="lazy"
    />
    <div
      v-if="!isLoaded"
      class="absolute inset-0 bg-gray-200 dark:bg-gray-700 animate-pulse"
    ></div>
  </div>
</template>
