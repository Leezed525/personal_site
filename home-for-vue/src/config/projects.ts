export interface Project {
  id: number;
  title: string;
  description: string;
  tags: string[];
  image: string;
  link?: string;
  status: "completed" | "developing" | "planning";
}

export const projects: Project[] = [
  {
    id: 2,
    title: "Handsome's Blog",
    description:
      "心若有所向往，何惧道阻且长。记录技术分享和生活感悟的个人博客。",
    tags: ["技术分享", "Blog", "Markdown"],
    image: "https://picsum.photos/800/600?random=3",
    link: "https://www.mmm.sd",
    status: "completed",
  },
  {
    id: 3,
    title: "Status",
    description: "服务状态监控页面，实时监控各项服务的运行状态。",
    tags: ["监控", "服务状态", "实时数据"],
    image: "https://picsum.photos/800/600?random=4",
    link: "https://status.mmm.sd",
    status: "completed",
  },
  {
    id: 4,
    title: "Umami Analytics",
    description:
      "开源、隐私友好的网站访问统计分析工具，提供详细的访问数据和洞察。",
    tags: ["数据分析", "统计", "开源"],
    image: "https://picsum.photos/800/600?random=5",
    link: "https://umami.tvtvz.cn",
    status: "completed",
  },
  {
    id: 5,
    title: "AList",
    description: "支持多种存储的文件列表程序，提供统一的文件管理和访问接口。",
    tags: ["文件管理", "存储", "云服务"],
    image: "https://picsum.photos/800/600?random=6",
    link: "https://alist.mmm.sd",
    status: "completed",
  },
];
