import axios from '../../utils/request'

export const addComment = (data: any) => {
  return axios.post('/front/comment/add', data);
}


// 文章获取
export const listArticle = (params: any) => {
  return axios.get<any[]>('/front/article/list', params);
}

