<script setup lang="ts">
import PageTransition from "@/components/PageTransition.vue";

defineProps<{
  title: string;
  description?: string;
}>();
</script>

<template>
  <div class="container mx-auto px-4 py-12">
    <PageTransition name="bounce">
      <div class="max-w-4xl mx-auto text-center mb-12">
        <h1 class="text-4xl font-bold mb-4">{{ title }}</h1>
        <p v-if="description" class="text-gray-600 dark:text-gray-300">
          {{ description }}
        </p>
      </div>
    </PageTransition>

    <PageTransition name="fade">
      <div class="max-w-6xl mx-auto">
        <slot></slot>
      </div>
    </PageTransition>
  </div>
</template>
