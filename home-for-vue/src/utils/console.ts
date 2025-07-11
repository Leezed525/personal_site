interface ConsoleInfo {
  text: string;
  version: string | undefined;
  link: string;
  style?: string;
}

export const printConsoleInfo = (info: ConsoleInfo) => {
  // 标题样式
  const titleStyle = [
    "background: linear-gradient(45deg, #2193b0, #6dd5ed)",
    "color: white",
    "padding: 12px 20px",
    "border-radius: 4px 0 0 4px",
    "font-weight: bold",
    "font-size: 13px",
    "text-shadow: 0 1px 1px rgba(0,0,0,0.2)",
    "box-shadow: inset 0 -3px 0 rgba(0,0,0,0.1)",
  ].join(";");

  // 版本样式
  const versionStyle = [
    "background: linear-gradient(45deg, #6dd5ed, #2193b0)",
    "color: white",
    "padding: 12px 20px",
    "font-weight: bold",
    "font-size: 13px",
    "text-shadow: 0 1px 1px rgba(0,0,0,0.2)",
    "box-shadow: inset 0 -3px 0 rgba(0,0,0,0.1)",
  ].join(";");

  // 链接样式
  const linkStyle = [
    "background: linear-gradient(45deg, #2193b0, #6dd5ed)",
    "color: white",
    "padding: 12px 20px",
    "border-radius: 0 4px 4px 0",
    "font-weight: bold",
    "font-size: 13px",
    "text-shadow: 0 1px 1px rgba(0,0,0,0.2)",
    "box-shadow: inset 0 -3px 0 rgba(0,0,0,0.1)",
  ].join(";");

  // 主信息
  console.log(
    `%c ${info.text} %c ${info.version || ""} %c ${info.link} `,
    titleStyle,
    versionStyle,
    linkStyle,
  );

  // 欢迎信息
  const welcomeStyle = [
    "color: #2193b0",
    "font-size: 14px",
    "font-weight: bold",
    "padding: 12px 20px",
    "margin: 20px 0",
    "border: 2px solid #2193b0",
    "border-radius: 4px",
    "background: rgba(33,147,176,0.1)",
    "text-shadow: 0 1px 1px rgba(255,255,255,0.8)",
  ].join(";");

  console.log("%c欢迎访问我的个人主页！", welcomeStyle);

  // 装饰线
  const lineStyle = [
    "font-size: 1px",
    "padding: 0",
    "margin: 4px 0",
    "line-height: 1px",
    "background: linear-gradient(to right, #2193b0, #6dd5ed)",
  ].join(";");

  console.log("%c ", `${lineStyle}; padding: 2px 125px;`);
};
