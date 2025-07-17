package com.ruoyi.lee.domain.DTO;

import com.ruoyi.common.xss.Xss;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

@Data
public class RegisterUserDTO {

    @Xss(message = "用户昵称不能包含脚本字符")
    @NotNull(message = "用户名不能为空")
    @Length(min = 4, max = 30, message = "用户名长度必须介于 1 和 30 之间")
    private String username;

    @Xss(message = "用户昵称不能包含脚本字符")
    @NotNull(message = "用户昵称不能为空")
    @Length(min = 1, max = 30, message = "用户昵称长度必须介于 1 和 30 之间")
    private String nickname;

    @Xss(message = "密码不能包含脚本字符")
    @NotNull(message = "密码不能为空")
    @Length(min = 4, max = 30, message = "密码长度必须介于 6 和 30 之间")
    private String password;

    @Xss(message = "邮箱不能包含脚本字符")
    @NotNull(message = "邮箱不能为空")
    @Length(max = 30, message = "邮箱长度不能超过30")
    private String email;

    @Xss(message = "邮箱验证码不能包含脚本字符")
    @NotNull(message = "邮箱验证码不能为空")
    @Length(min = 6, max = 6, message = "邮箱验证码长度必须为6位")
    private String emailCode;

}
