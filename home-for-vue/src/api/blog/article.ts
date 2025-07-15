import axios from '../../utils/request'
import {ArticleQueryData,ArticleResData} from '../../types/article'


// 文章获取
export const listArticle = (params: ArticleQueryData) => {
  // 返回的数据格式可以和服务端约定
  return axios.get<ArticleResData[]>('/front/article/list', params);
}

