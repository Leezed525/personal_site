package com.ruoyi.web.controller.front;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.lee.service.ILeePVService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/pv")
public class PVController {

    @Autowired
    private ILeePVService leePVService;

    @RequestMapping("/view")
    public AjaxResult view() {
        leePVService.view();
        return AjaxResult.success();
    }
}
