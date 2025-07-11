// 禁用开发者工具和快捷键
export const initSecurityMeasures = () => {
  let warningShown = false;
  let warningTimeout: number | null = null;

  // 显示友好提示
  const showWarning = () => {
    if (!warningShown) {
      warningShown = true;
      const warningDialog = document.querySelector<any>("#warning-dialog");
      if (warningDialog) {
        warningDialog.open();
        // 清除之前的定时器
        if (warningTimeout) {
          clearTimeout(warningTimeout);
        }
        // 3秒后自动关闭
        warningTimeout = window.setTimeout(() => {
          warningDialog.close();
          warningShown = false;
          warningTimeout = null;
        }, 3000);
      }
    }
  };

  // 监听右键菜单
  document.addEventListener(
    "contextmenu",
    (e: MouseEvent) => {
      e.preventDefault();
      showWarning();
    },
    true,
  );

  // 监听开发者工具快捷键
  document.addEventListener(
    "keydown",
    (e: KeyboardEvent) => {
      const isMacCmd = e.metaKey && !e.ctrlKey;
      const isWinCtrl = e.ctrlKey && !e.metaKey;

      if (
        e.key === "F12" ||
        ((isMacCmd || isWinCtrl) &&
          e.shiftKey &&
          ["I", "J", "C", "U"].includes(e.key.toUpperCase()))
      ) {
        e.preventDefault();
        showWarning();
      }
    },
    true,
  );

  // 检测开发者工具状态
  const checkDevTools = () => {
    const threshold = 160;
    const widthThreshold = window.outerWidth - window.innerWidth > threshold;
    const heightThreshold = window.outerHeight - window.innerHeight > threshold;

    if (widthThreshold || heightThreshold) {
      showWarning();
    }
  };

  // 每 1000ms 检查一次
  setInterval(checkDevTools, 1000);
};
