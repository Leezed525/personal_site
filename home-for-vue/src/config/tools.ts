import JsonFormatterView from "@/views/tools/JsonFormatterView.vue";
import TimestampView from "@/views/tools/TimestampView.vue";

export interface Tool {
  id: number;
  title: string;
  description: string;
  tags: string[];
  image: string;
  component: any;
  status: "completed" | "developing" | "planning";
}

export const tools: Tool[] = [
  {
    id: 1,
    title: "JSON 格式化工具",
    description: "在线 JSON 格式化工具，支持压缩、美化、验证和转换等功能",
    tags: ["JSON", "格式化", "在线工具"],
    image: "https://picsum.photos/800/600?random=1",
    component: JsonFormatterView,
    status: "completed",
  },
  {
    id: 2,
    title: "时间戳转换器",
    description: "时间戳与日期格式互转工具，支持多种格式和时区设置",
    tags: ["时间戳", "日期转换", "时区"],
    image: "https://picsum.photos/800/600?random=2",
    component: TimestampView,
    status: "completed",
  },
];
