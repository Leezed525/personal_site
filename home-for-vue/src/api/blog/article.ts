import axios from '../../utils/request'
import {ArticleQueryData,ArticleResData} from '../../types/article'


// 文章获取
export const listArticle = (params: ArticleQueryData) => {
  // 返回的数据格式可以和服务端约定
  console.log('请求文章列表', params);
  return axios.get<ArticleResData[]>('/front/article/list', params);
}

