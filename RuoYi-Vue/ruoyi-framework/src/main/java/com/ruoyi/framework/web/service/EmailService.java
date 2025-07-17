package com.ruoyi.framework.web.service;

import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.exception.user.CaptchaException;
import com.ruoyi.common.exception.user.CaptchaExpireException;
import com.ruoyi.common.exception.user.EmailCodeException;
import com.ruoyi.common.utils.EmailUtils;
import com.ruoyi.common.utils.MessageUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.ip.IpUtils;
//import com.ruoyi.framework.manager.AsyncManager;
//import com.ruoyi.framework.manager.factory.AsyncFactory;
//import org.aspectj.weaver.loadtime.Aj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;

@Component
public class EmailService {

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private JavaMailSender mailSender;

    private final static int EMAIL_CODE_INTERVAL = 45;//后端校验邮箱验证码的间隔比前端少一点，避免出错，本质上后端防的就是滥用接口的情况

    private final static int EMAIL_CODE_EXPIRE = 10; //单词邮箱验证码时间为10分钟

    @Value("${spring.mail.username}")
    private String emailFrom; // 发件人邮箱地址

//    @Value("${spring.mail.password}")
//    private String emailPassword;


    public AjaxResult sendEmailCode(String email, String imgCode, String uuid) {
        //第一步校验图形验证码是否正确
        validateCaptcha(imgCode, uuid);
        //发验证码前置校验
        long interval = emailSendPreCheck();
        if (interval > 0) {
            return AjaxResult.success().put("lastTime", interval);
        }
        //第二步校验邮箱格式
        if (!EmailUtils.isEmail(email)) {
            return AjaxResult.error("邮箱格式错误");
        }
        //检查是不是在10分钟内
        String code;
        String emailKey = CacheConstants.EMAIL_CODE_KEY + email;
        if (redisCache.hasKey(emailKey)) {
            //重新将这个key的expire时间设置为10分钟
            redisCache.expire(emailKey, EMAIL_CODE_EXPIRE, TimeUnit.MINUTES);
            code = redisCache.getCacheObject(emailKey);
        } else {
            //从来没有生成过验证码的情况下生成随机六位数验证码
            code = EmailUtils.generateCode();
            redisCache.setCacheObject(emailKey, code, EMAIL_CODE_EXPIRE, TimeUnit.MINUTES);
        }
        //发送邮件
        sendEmail(email, getEmailCodeTitle(), getEmailCodeTemplate(code));
        return AjaxResult.success();
    }

    public void validEmailCode(String email, String emailCode) {
        //校验验证码
        String emailKey = CacheConstants.EMAIL_CODE_KEY + email;
        String code = redisCache.getCacheObject(emailKey);
        System.out.println(emailKey+ code);
        if (code == null) {
            throw new EmailCodeException();
        }
        redisCache.deleteObject(emailKey);
        if (!emailCode.equalsIgnoreCase(code)) {
            throw new EmailCodeException();
        }
    }


    private String getEmailCodeTitle() {
        return "Lee小站验证码";
    }

    private String getEmailCodeTemplate(String code) {
        return "尊敬的用户，您好！\n\n" +
                "您的验证码是：" + code + "\n\n" +
                "请在10分钟内完成验证，感谢您的使用！\n\n" +
                "如果您没有进行此操作，请忽略此邮件。\n\n";
    }

    public void sendEmail(String to, String subject, String text) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to);                // 收件人邮箱
        message.setSubject(subject);      // 邮件主题
        message.setText(text);            // 邮件内容
        message.setFrom(emailFrom); // 发件人邮箱
        mailSender.send(message);         // 发送邮件
    }

    /**
     * 校验验证码
     *
     * @param code 验证码
     * @param uuid 唯一标识
     */
    private void validateCaptcha(String code, String uuid) {
        String verifyKey = CacheConstants.CAPTCHA_CODE_KEY + StringUtils.nvl(uuid, "");
        String captcha = redisCache.getCacheObject(verifyKey);
        if (captcha == null) {
            throw new CaptchaExpireException();
        }
        redisCache.deleteObject(verifyKey);
        if (!code.equalsIgnoreCase(captcha)) {
            throw new CaptchaException();
        }
    }


    /**
     * 检查邮箱验证码发送时间间隔，同时设置邮箱发送时间间隔
     *
     * @return 剩余时间
     */
    private long emailSendPreCheck() {
        //获取ip
        final String ip = IpUtils.getIpAddr();
        //检查redis中这个ip的key在不在
        String emailKey = CacheConstants.EMAIL_CODE_INTERVAL_KEY + ip;
        //如果有这个key,说明在间隔时间内请求了二维码
        if (redisCache.hasKey(emailKey)) {
            //计算剩余时间
            long expire = redisCache.getExpire(emailKey);
            return 20L + expire;//额外增加一点冗余时间
        } else {
            //设置key
            redisCache.setCacheObject(emailKey, "1", EMAIL_CODE_INTERVAL, TimeUnit.SECONDS);
        }
        return 0;
    }

}
