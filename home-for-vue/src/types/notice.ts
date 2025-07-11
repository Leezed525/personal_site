export interface NoticeButton {
  text: string;
  type?: string;
  action: "close" | "navigate" | "link" | "custom";
  to?: string;
  href?: string;
  handler?: () => void;
  showAfter?: number | "refresh" | null;
}

export interface NoticeConfig {
  id: string;
  title: string;
  content: string;
  width?: string;
  maskClosable?: boolean;
  showClose?: boolean;
  buttons: NoticeButton[];
}
