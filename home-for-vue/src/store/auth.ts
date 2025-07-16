// src/stores/auth.ts
import {defineStore} from 'pinia'
import {ref, computed} from 'vue'
import request from '../utils/request'   // 你封装的 axios 实例
import {login, getInfo} from "../api/login"

export const useAuthStore = defineStore(
  'auth',
  () => {
    /* ---------- 状态 ---------- */
    const token = ref<string>(localStorage.getItem('token') || '')
    const user = ref<Record<string, any> | null>(null)

    /* ---------- Getter ---------- */
    const isLoggedIn = computed(() => !!token.value)

    /* ---------- Action ---------- */

    // 1️⃣ 保存 token 并写入 localStorage
    const setToken = (t: string) => {
      token.value = t
      localStorage.setItem('token', t)
    }

    // 2️⃣ 根据 token 拉取用户信息
    const fetchUser = async () => {
      if (!token.value) return
      try {
        const data:any = await getInfo();
        console.log(data);
        //获取关键信息 用户名，昵称
        const userInfo:any = {
          email: data.user.email,
          username: data.user.userName,
          nickname: data.user.nickName,
        }
        user.value = userInfo
        console.log(user.value);
      } catch (e) {
        // token 失效、被顶下线等
        logout()
      }
    }

    // 3️⃣ 登录成功后调用
    const loginUser = async (username: string, password: string, captcha: string, uuid: string) => {
      const res: any = await login(username, password, captcha, uuid);
      setToken(res.token)
      await fetchUser()          // 马上拿用户信息
    }

    // 4️⃣ 退出
    const logout = () => {
      token.value = ''
      user.value = null
      localStorage.removeItem('token')
      // 可跳转到 /login
    }

    /* ---------- 初始化 ---------- */
    // 刷新页面时若本地有 token，自动拉一次用户信息
    if (token.value) fetchUser()

    return {
      token,
      user,
      isLoggedIn,
      login: loginUser,
      logout,
      fetchUser,
    }
  },
  {
    // 可选：持久化插件，pinia-plugin-persistedstate
    // persist: true
  }
)
