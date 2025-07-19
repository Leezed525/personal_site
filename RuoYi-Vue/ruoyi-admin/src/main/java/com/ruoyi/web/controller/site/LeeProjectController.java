package com.ruoyi.web.controller.site;

import java.util.List;
import java.util.Arrays;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.lee.enums.LeeProjectStatusEnums;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.lee.domain.LeeProject;
import com.ruoyi.lee.service.ILeeProjectService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 项目Controller
 *
 * @author ruoyi
 * @date 2025-07-18
 */
@RestController
@RequestMapping("/LeeSite/project")
public class LeeProjectController extends BaseController {
    @Autowired
    private ILeeProjectService leeProjectService;

    private final static int DEFAULT_ORDER_NUM = 20;

    /**
     * 查询项目列表
     */
    @PreAuthorize("@ss.hasPermi('LeeSite:project:list')")
    @GetMapping("/list")
    public TableDataInfo list(LeeProject leeProject) {
        startPage();
        List<LeeProject> list = leeProjectService.selectLeeProjectList(leeProject);
        return getDataTable(list);
    }

    /**
     * 导出项目列表
     */
    @PreAuthorize("@ss.hasPermi('LeeSite:project:export')")
    @Log(title = "项目", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, LeeProject leeProject) {
        List<LeeProject> list = leeProjectService.selectLeeProjectList(leeProject);
        ExcelUtil<LeeProject> util = new ExcelUtil<LeeProject>(LeeProject.class);
        util.exportExcel(response, list, "项目数据");
    }

    /**
     * 获取项目详细信息
     */
    @PreAuthorize("@ss.hasPermi('LeeSite:project:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return success(leeProjectService.getById(id));
    }

    /**
     * 新增项目
     */
    @PreAuthorize("@ss.hasPermi('LeeSite:project:add')")
    @Log(title = "项目", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody LeeProject leeProject) {
        if (leeProject.getOrderNum() == null) {
            leeProject.setOrderNum(DEFAULT_ORDER_NUM);
        }
        return toAjax(leeProjectService.saveOrUpdate(leeProject));
    }

    /**
     * 修改项目
     */
    @PreAuthorize("@ss.hasPermi('LeeSite:project:edit')")
    @Log(title = "项目", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody LeeProject leeProject) {
        return toAjax(leeProjectService.saveOrUpdate(leeProject));
    }

    /**
     * 删除项目
     */
    @PreAuthorize("@ss.hasPermi('LeeSite:project:remove')")
    @Log(title = "项目", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(leeProjectService.removeByIds(Arrays.asList(ids)));
    }
}
