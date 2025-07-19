<script setup lang="ts">
import {ref} from 'vue'
import {ElMessage} from 'element-plus'
import {resetPwd} from "../../api/login";
import {useAuthStore} from "../../store/auth";

const auth = useAuthStore()

const emit = defineEmits<{
  close: []
  success: [newPwd: string]
}>()

const pwd1 = ref('')
const pwd2 = ref('')

const loading = ref(false)

const submit = () => {
  if (!pwd1.value || !pwd2.value) {
    ElMessage.warning('请输入新密码')
    return
  }
  if (pwd1.value !== pwd2.value) {
    ElMessage.error('两次密码不一致')
    return
  }
  loading.value = true
  // 这里换成真实接口 await changePwdApi(pwd1.value)
  const data = {
    userId: auth.user.id,
    userName: auth.user.username,
    password: pwd1.value,
  };
  resetPwd(data).then(res => {
    ElMessage.success('密码修改成功')
    loading.value = false
    emit('success', pwd1.value)
  }).catch();
}
</script>

<template>
  <Teleport to="body">
    <div
      class="fixed inset-0 z-[999] flex items-center justify-center bg-black/40 backdrop-blur-sm"
      @click.self="$emit('close')"
    >
      <div
        class="w-full max-w-sm bg-white dark:bg-gray-800 rounded-xl shadow-2xl p-6 space-y-4"
      >
        <h3 class="text-xl font-bold text-center">修改密码</h3>

        <input
          v-model="pwd1"
          type="password"
          placeholder="新密码"
          class="w-full border px-3 py-2 rounded-lg"
        />
        <input
          v-model="pwd2"
          type="password"
          placeholder="确认密码"
          class="w-full border px-3 py-2 rounded-lg"
        />

        <button
          @click="submit"
          :disabled="loading"
          class="w-full py-2 rounded bg-blue-500 text-white hover:bg-blue-600 disabled:bg-gray-400"
        >
          {{ loading ? '处理中...' : '确认修改' }}
        </button>

        <button
          @click="$emit('close')"
          class="w-full py-1 text-sm text-gray-500 hover:text-gray-800"
        >
          取消
        </button>
      </div>
    </div>
  </Teleport>
</template>
