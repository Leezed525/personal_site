package com.ruoyi.lee.domain;

import com.ruoyi.common.xss.Xss;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

@Data
public class RegisterUserDTO {

    @Xss(message = "用户昵称不能包含脚本字符")
    @NotNull
    @Length(min = 4, max = 30, message = "用户名长度必须介于 1 和 30 之间")
    private String userName;

    @Xss(message = "用户昵称不能包含脚本字符")
    @NotNull
    @Length(min = 4, max = 30, message = "用户昵称长度必须介于 1 和 30 之间")
    private String nickname;

    @Xss(message = "密码不能包含脚本字符")
    @NotNull
    @Length(min = 4, max = 30, message = "密码长度必须介于 6 和 30 之间")
    private String password;

    @Xss
    @NotNull
    @Length(max = 30, message = "邮箱长度不能超过30")
    private String email;

    @Xss
    @NotNull
    @Length(min = 6, max = 6, message = "邮箱验证码长度必须为6位")
    private String emailCode;
}
