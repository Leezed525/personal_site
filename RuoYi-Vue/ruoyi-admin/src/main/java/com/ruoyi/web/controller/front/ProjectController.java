package com.ruoyi.web.controller.front;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.lee.domain.LeeProject;
import com.ruoyi.lee.service.ILeeProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@RestController
@RequestMapping("/front/project")
public class ProjectController extends BaseController {

    @Autowired
    private ILeeProjectService projectService;

    @GetMapping("/list")
    public AjaxResult list(LeeProject leeProject) {
        List<LeeProject> list = projectService.selectLeeProjectList(leeProject);
        return AjaxResult.success(list);
    }
    
}
