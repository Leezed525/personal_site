export const initFontLoading = async () => {
  try {
    // 等待字体加载
    await document.fonts.load('1em "LXWK"');

    // 检查字体是否加载成功
    const isLoaded = document.fonts.check('1em "LXWK"');
    console.log("Font loaded:", isLoaded);

    if (!isLoaded) {
      // 如果字体加载失败，使用系统字体
      document.documentElement.style.fontFamily =
        '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif';
    }
  } catch (error) {
    console.error("Font loading error:", error);
    // 出错时使用系统字体
    document.documentElement.style.fontFamily =
      '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif';
  }
};
