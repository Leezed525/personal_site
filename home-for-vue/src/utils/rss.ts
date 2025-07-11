import type { BlogPost } from "../types/blog";
import { rssConfig } from "@/config/rss";

// 使用 RSS2JSON API 转换 RSS 为 JSON
export const fetchBlogPosts = async (): Promise<BlogPost[]> => {
  try {
    if (!rssConfig.url) {
      throw new Error("RSS URL is not defined");
    }

    // 使用 RSS2JSON 服务
    const apiUrl = `https://api.rss2json.com/v1/api.json?rss_url=${encodeURIComponent(rssConfig.url)}`;
    const response = await fetch(apiUrl, {
      headers: {
        "Cache-Control": "no-cache",
        "Pragma": "no-cache"
      }
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const data = await response.json();

    if (data.status !== "ok") {
      throw new Error("Failed to fetch RSS feed");
    }

    return data.items.map(
      (item: any): BlogPost => ({
        title: item.title,
        link: item.link,
        date: new Date(item.pubDate),
        description: item.content || item.description,
        category: item.category || "默认分类",
      }),
    );
  } catch (error) {
    console.error("获取博客文章失败:", error);
    return [];
  }
};
