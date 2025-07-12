export interface Tab {
  id: string;
  label: string;
  icon: string;
}

export const tabs: Tab[] = [
  {id: "projects", label: "项目展示", icon: "🎨"},
  {id: "tools", label: "在线工具", icon: "🛠"},
  {id: "bookmarks", label: "网址导航", icon: "🔖"},
];

export const blogTabs: Tab[] = [
  {id: "all", label: "全部", icon: "📄"},
  {id: "java", label: "Java", icon: "☕"},
  {id: "pytorch", label: "PyTorch", icon: "🐍"},
  {id: "toyprojects", label: "玩具", icon: "🧸"},
];
