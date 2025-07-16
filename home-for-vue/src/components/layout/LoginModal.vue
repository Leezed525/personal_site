<script setup lang="ts">
import {ref, onMounted, computed, watch, nextTick} from 'vue';
import {getCaptcha} from "../../api/captcha";
import {LoginReqBody} from "../../types/login";
import {login, getEmailCode} from "../../api/login";
import {useAuthStore} from "../../store/auth";
import {ElMessage} from "element-plus";


/* ------------------用户状态 --------------------- */
const auth = useAuthStore();

/* ---------------- props & emit ---------------- */
const emit = defineEmits<{
  close: [];
  success: [];
}>();
const type = defineModel<'login' | 'register'>('type', {required: true});

/* ---------------- 表单数据 ---------------- */
const loginForm = ref({username: '', password: '', captchaCode: ''});
const registerForm = ref({
  username: '',
  password: '',
  nickname: '',
  email: '',
  emailCode: '',
  captchaCode: '',
});

/* 当前正在使用的表单（计算属性） */
const activeForm = computed(() => (type.value === 'login' ? loginForm : registerForm));

/* ---------------- 图形验证码 ---------------- */
// 获取图形验证码
const captchaUrl = ref('/api/captcha.ts?' + Date.now());

interface Captcha {
  image: string;   // base64 或 url
  id: string;
  expiredAt: number;
}


const fetchCaptcha = async () => {
  try {
    const res: any = await getCaptcha();
    captcha.value = "data:image/gif;base64," + res.img;
    uuid.value = res.uuid;
  } catch (e) {
    console.error('获取验证码失败', e);
  }
};
const uuid = ref<string | null>();
const captcha = ref<Captcha | null>(null);
const refreshCaptcha = () => fetchCaptcha();

/* 切 tab 时刷新验证码 */
watch(type, fetchCaptcha);   // 登录↔注册切换时也重新拉取

/* ---------------- 邮箱验证码相关 ---------------- */
const emailReg = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
/* 实时邮箱格式错误提示 */
const emailError = ref('')
watch(
  () => registerForm.value.email,
  (val) => {
    if (!val) {
      emailError.value = ''
    } else if (!emailReg.test(val)) {
      emailError.value = '请输入正确的邮箱格式'
    } else {
      emailError.value = ''
    }
  },
  {immediate: true}
)

/* 发送按钮是否可用：邮箱格式正确 + 图形验证码非空 */
const canSendEmailCode = computed(
  () => type.value === 'register' && emailReg.test(registerForm.value.email) && activeForm.value.captchaCode.trim() !== ''
)

/* 真正调接口 + 冷却倒计时 */
const emailCoolDown = ref(0)
const sendEmailCode = async () => {
  if (!canSendEmailCode.value) return


  getEmailCode(activeForm.value.captchaCode, uuid.value, registerForm.value.email)
    .then((res) => {
      console.log(res);
      ElMessage.success('验证码已发送，请查收邮箱')
      // 冷却 60 秒
      emailCoolDown.value = 60
      const timer = setInterval(() => {
        emailCoolDown.value--
        if (emailCoolDown.value <= 0) clearInterval(timer)
      }, 1000)
    })
    .catch((e: any) => {
      console.log(e);
      ElMessage.error(e?.response?.data?.msg || '发送失败')
      refreshCaptcha()          // ✅ 图形验证码错误时刷新
    });


  try {
    ElMessage.success('验证码已发送，请查收邮箱')

    // 冷却 60 秒
    emailCoolDown.value = 60
    const timer = setInterval(() => {
      emailCoolDown.value--
      if (emailCoolDown.value <= 0) clearInterval(timer)
    }, 1000)
  } catch (e: any) {
    ElMessage.error(e?.response?.data?.msg || '发送失败')
    refreshCaptcha()          // ✅ 图形验证码错误时刷新
  }
};


/* 注册提交 */
const handleRegister = async () => {
  loading.value = true
  try {
    await fetch('/api/register', {               // ✅ 替换成你的 request.post(...)
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({
        username: registerForm.value.username,
        password: registerForm.value.password,
        nickname: registerForm.value.nickname,
        email: registerForm.value.email,
        emailCode: registerForm.value.emailCode,
        captcha: registerForm.value.captchaCode,
        uuid: uuid.value
      })
    })
    ElMessage.success('注册成功！')
    // 注册完成自动切到登录页
    type.value = 'login'
    refreshCaptcha()
    closeLoading()
  } catch (e: any) {
    ElMessage.error(e?.response?.data?.msg || '注册失败')
    refreshCaptcha()
    closeLoading()
  }
}


/* ---------------- 提交 ---------------- */
const loading = ref(false);

const closeLoading = () => {
  setTimeout(() => {
    loading.value = false;
    emit('close');
  }, 600);
}

const submit = () => {
  loading.value = true;
  if (type.value === "login") {
    const {username, password, captchaCode} = activeForm.value;
    auth.login(username, password, captchaCode, uuid.value).then(() => {
      //登录成功
      emit('success')
      closeLoading();
    }).catch(() => closeLoading());
  } else {

  }

};

onMounted(fetchCaptcha);

</script>

<template>
  <Teleport to="body">
    <transition
      enter-active-class="duration-200 ease-out"
      enter-from-class="opacity-0 scale-95"
      enter-to-class="opacity-100 scale-100"
      leave-active-class="duration-150 ease-in"
      leave-from-class="opacity-100 scale-100"
      leave-to-class="opacity-0 scale-95"
    >
      <div
        class="fixed inset-0 z-[999] flex items-center justify-center bg-black/40 backdrop-blur-sm p-4"
        @click.self="$emit('close')"
      >
        <div
          class="relative w-full max-w-md bg-white dark:bg-gray-800 rounded-2xl shadow-2xl p-6 sm:p-8 space-y-6"
        >
          <!-- 关闭按钮 -->
          <button
            class="absolute top-4 right-4 text-gray-400 hover:text-gray-600 dark:hover:text-gray-200"
            @click="$emit('close')"
          >
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                    d="M6 18L18 6M6 6l12 12"/>
            </svg>
          </button>

          <!-- 标题 -->
          <h2 class="text-2xl font-bold text-center text-gray-800 dark:text-gray-100">
            {{ type === 'login' ? '欢迎回来' : '创建账号' }}
          </h2>

          <!-- 登录 / 注册 表单 -->
          <form class="space-y-4" @submit.prevent="submit">
            <!-- 用户名 -->
            <div>
              <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">
                用户名
              </label>
              <input
                v-model.trim="activeForm.username"
                type="text"
                required
                class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg bg-gray-50 dark:bg-gray-700 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition"
                placeholder="请输入用户名"
              />
            </div>

            <!-- 密码 -->
            <div>
              <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">
                密码
              </label>
              <input
                v-model="activeForm.password"
                type="password"
                required
                class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg bg-gray-50 dark:bg-gray-700 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition"
                placeholder="请输入密码"
              />
            </div>

            <!-- 昵称（注册） -->
            <div v-if="type === 'register'">
              <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">
                昵称
              </label>
              <input
                v-model.trim="registerForm.nickname"
                type="text"
                required
                class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg bg-gray-50 dark:bg-gray-700 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition"
                placeholder="给自己起个名字吧"
              />
            </div>

            <!-- 图形验证码 -->
            <div>
              <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">
                图形验证码
              </label>
              <div class="flex items-center space-x-2">
                <input
                  v-model="activeForm.captchaCode"
                  type="text"
                  required
                  class="flex-1 px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg bg-gray-50 dark:bg-gray-700 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition"
                  placeholder="请输入验证码"
                />
                <img
                  :src="captcha"
                  alt="captcha"
                  class="h-10 w-28 rounded object-cover cursor-pointer border border-gray-300 dark:border-gray-600"
                  @click="refreshCaptcha"
                />
              </div>
            </div>

            <!-- 邮箱（注册） -->
            <div v-if="type === 'register'">
              <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">
                邮箱
              </label>
              <div class="flex items-center space-x-2">
                <input
                  v-model.trim="registerForm.email"
                  type="email"
                  required
                  class="flex-1 px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg bg-gray-50 dark:bg-gray-700 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition"
                  placeholder="example@mail.com"
                />
                <button
                  type="button"
                  :disabled="!canSendEmailCode || emailCoolDown > 0"
                  :class="[canSendEmailCode && !emailCoolDown? 'bg-blue-500 hover:bg-blue-600':'bg-gray-300 cursor-not-allowed']"
                  class="shrink-0 px-3 py-2 text-sm rounded-lg text-white transition"
                  @click="sendEmailCode"
                >
                  {{ emailCoolDown ? `${emailCoolDown}s` : '发送验证码' }}
                </button>
              </div>
              <!-- ✅ 新增邮箱格式提示 -->
              <p v-if="emailError" class="text-xs text-red-500 mt-1">{{ emailError }}</p>
            </div>


            <!-- 邮箱验证码（注册） -->
            <div v-if="type === 'register'">
              <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">
                邮箱验证码
              </label>
              <input
                v-model.trim="registerForm.emailCode"
                type="text"
                required
                class="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg bg-gray-50 dark:bg-gray-700 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition"
                placeholder="6位数字"
              />
            </div>


            <!-- 提交按钮 -->
            <button
              type="submit"
              :disabled="loading"
              class="w-full py-2.5 rounded-lg bg-blue-600 hover:bg-blue-700 disabled:bg-blue-400 text-white font-semibold transition"
              @click="handleSubmit"
            >
              {{ loading ? '处理中...' : type === 'login' ? '登录' : '注册' }}
            </button>
          </form>

          <!-- 切换登录 / 注册 -->
          <p class="text-center text-sm text-gray-500 dark:text-gray-400">
            {{ type === 'login' ? '还没有账号？' : '已有账号？' }}
            <span
              class="font-semibold text-blue-600 cursor-pointer hover:underline"
              @click="type = type === 'login' ? 'register' : 'login'"
            >
              {{ type === 'login' ? '立即注册' : '去登录' }}
            </span>
          </p>
        </div>
      </div>
    </transition>
  </Teleport>
</template>
