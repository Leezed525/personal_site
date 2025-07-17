package com.ruoyi.web.controller.front;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.framework.web.service.EmailService;
import com.ruoyi.lee.domain.DTO.RegisterUserDTO;
import com.ruoyi.system.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/front/user")
public class UserController extends BaseController {

    @Autowired
    private ISysUserService userService;

    @Autowired
    private EmailService emailService;

    private static final String CREATE_BY_REGISTER = "register_user";

    private static final long REGISTER_USER_DEPT_ID = 200L;

    private static final Long REGISTER_USER_ROLE_ID = 100L;

    /**
     * 新增用户
     */
    @Log(title = "用户管理", businessType = BusinessType.INSERT)
    @PostMapping("/register")
    public AjaxResult add(@Validated @RequestBody RegisterUserDTO registerUserDTO) {
        // 校验邮箱验证码
        emailService.validEmailCode(registerUserDTO.getEmail(), registerUserDTO.getEmailCode());
        SysUser user = new SysUser();
        user.setUserName(registerUserDTO.getUsername());
        user.setNickName(registerUserDTO.getNickname());
        user.setEmail(registerUserDTO.getEmail());
        user.setPassword(registerUserDTO.getPassword());
        user.setRoleId(REGISTER_USER_ROLE_ID);
        user.setDeptId(REGISTER_USER_DEPT_ID);
        if (!userService.checkUserNameUnique(user)) {
            return error("新增用户'" + user.getUserName() + "'失败，登录账号已存在");
        } else if (StringUtils.isNotEmpty(user.getEmail()) && !userService.checkEmailUnique(user)) {
            return error("新增用户'" + user.getUserName() + "'失败，邮箱账号已存在");
        }
        user.setCreateBy(CREATE_BY_REGISTER);
        user.setPassword(SecurityUtils.encryptPassword(user.getPassword()));
        return toAjax(userService.insertUser(user));
    }


}
