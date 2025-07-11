<script setup lang="ts">
interface Project {
  title: string;
  image: string;
  description?: string;
  tags?: string[];
  link?: string;
}

defineProps<{
  project: Project;
}>();
</script>

<template>
  <div class="bg-white dark:bg-gray-800 rounded-xl shadow-lg overflow-hidden">
    <img
      :src="project.image"
      :alt="project.title"
      class="w-full h-48 object-cover"
    />
    <div class="p-6">
      <h3 class="text-xl font-semibold mb-2">{{ project.title }}</h3>
      <p
        v-if="project.description"
        class="text-gray-600 dark:text-gray-300 mb-4"
      >
        {{ project.description }}
      </p>
      <div v-if="project.tags" class="flex flex-wrap gap-2 mb-4">
        <span
          v-for="tag in project.tags"
          :key="tag"
          class="px-2 py-1 text-sm bg-gray-100 dark:bg-gray-700 rounded"
        >
          {{ tag }}
        </span>
      </div>
      <a
        v-if="project.link"
        :href="project.link"
        target="_blank"
        rel="noopener noreferrer"
        class="text-primary hover:underline"
      >
        查看详情
      </a>
    </div>
  </div>
</template>

<style scoped>
.project-card {
  transition: transform 0.3s ease;
}

.project-card:hover {
  transform: translateY(-4px);
}
</style>
