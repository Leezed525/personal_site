package com.ruoyi.web.controller.front;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.framework.web.service.EmailService;
import com.ruoyi.lee.domain.EmailCodeDTO;
import com.ruoyi.system.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/front/email")
public class EmailController extends BaseController {


    @Autowired
    private EmailService emailService;

    @Autowired
    private ISysUserService userService;


    /**
     * 2. 校验图形验证码 + 发送邮件
     */
    @PostMapping("/code")
    public AjaxResult send(@RequestBody EmailCodeDTO emailCodeDTO, HttpServletRequest request) {
        String email = emailCodeDTO.getEmail();
        String imgCode = emailCodeDTO.getImgCode();
        String uuid = emailCodeDTO.getUuid();
        //判断邮箱是否已经存在
        SysUser user = new SysUser();
        user.setEmail(email);
        if (!userService.checkEmailUnique(user)) {
            return AjaxResult.error("邮箱已存在");
        }
        return emailService.sendEmailCode(email, imgCode, uuid);

    }
}
