import axios from '../../utils/request'

export const addComment = (data: any) => {
  return axios.post('/front/comment/add', data);
}


// 文章获取
export const listComment = (params: any) => {
  return axios.get<any[]>('/front/comment/list', params);
}

export const listChildComment = (params: any) => {
  return axios.get<any[]>('/front/comment/listChildComment', params);
}

