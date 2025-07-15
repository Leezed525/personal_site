export interface ArticleResData {
  id: number;
  title: string;
  link: string;
  date: Date;
  description: string;
  category?: string;
  image?: string;
}



export interface ArticleQueryData {
  title: string;
  link: string;
  description: string;
  category?: string;
  image?: string;
  pageNum: number;
  pageSize: number;
}
