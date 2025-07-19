interface FooterLink {
  text: string;
  to?: string; // 内部路由
  href?: string; // 外部链接
  target?: string;
}

interface FooterConfig {
  links: FooterLink[];
  provider: {
    name: string;
    link: string;
    logo: string;
    text: string;
  };
}

export const footerConfig: FooterConfig = {
  links: [
    {
      text: "联系",
      to: "/contact",
    },

    {
      text: "博客",
      href: "https://blog.csdn.net/Leezed525?spm=1010.2135.3001.5343",
      target: "_blank",
    },
    {
      text: "GitHub",
      href: "https://github.com/Leezed525",
      target: "_blank",
    },
  ],
  provider: {
    name: "雨云",
    link: "https://www.rainyun.com/handsome_",
    logo: "https://app.rainyun.com/img/icons/apple-touch-icon-152x152.png",
    text: "提供 CDN 加速 / 云存储服务",
  },
};
