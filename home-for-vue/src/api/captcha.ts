import axios from '../utils/request'


// 文章获取
export const getCaptcha = () => {
  // 返回的数据格式可以和服务端约定
  return axios.get<any[]>('/captchaImage');
}

