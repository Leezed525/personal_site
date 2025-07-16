package com.ruoyi.common.utils;


import java.util.Random;
import java.util.regex.Pattern;

/**
 * 简单、严格、零依赖的邮箱格式校验工具类
 */
public final class EmailUtils {

    // 严格的正则，覆盖 99% 场景
    private static final String EMAIL_REGEX =
            "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
    private static final Pattern PATTERN = Pattern.compile(EMAIL_REGEX);

    /**
     * 判断字符串是否为合法邮箱
     *
     * @param str 待校验字符串
     * @return true 表示格式正确
     */
    public static boolean isEmail(String str) {
        return str != null && PATTERN.matcher(str.trim()).matches();
    }

    /**
     * 生成随机六位数字验证码
     *
     * @return 六位数字验证码字符串
     */
    public static String generateCode() {
        Random random = new Random();
        int captcha = 100000 + random.nextInt(900000); // 生成 100000 到 999999 之间的随机数
        return String.valueOf(captcha);
    }

    private EmailUtils() {
    }
}