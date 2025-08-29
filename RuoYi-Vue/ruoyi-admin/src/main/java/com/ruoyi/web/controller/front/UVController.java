package com.ruoyi.web.controller.front;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.ip.IpUtils;
import com.ruoyi.lee.service.ILeeUVService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/front/uv")
public class UVController {
    @Autowired
    private ILeeUVService leeUVService;

    @RequestMapping("/view")
    public AjaxResult view() {
        String ip = IpUtils.getIpAddr();
        leeUVService.view(ip);
        return AjaxResult.success();
    }
}
