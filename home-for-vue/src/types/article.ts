export interface ArticleResData {
  id: number;
  title: string;
  url: string;
  cover: string;
  createTime: Date;
  summary: string;
  category?: string;
  image?: string;
}



export interface ArticleQueryData {
  title: string;
  summary: string;
  category?: string;
  image?: string;
  pageNum: number;
  pageSize: number;
}
