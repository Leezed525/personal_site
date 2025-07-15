package com.ruoyi.lee.domain;


import lombok.Data;

@Data
public class SiteUserRegisterBody {
    /**
     * 账号
     */
    private String username;

    /**
     * 昵称
     */
    private String nickname;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 密码
     */
    private String Password;

    /**
     * 验证码
     */
    private String code;


}
