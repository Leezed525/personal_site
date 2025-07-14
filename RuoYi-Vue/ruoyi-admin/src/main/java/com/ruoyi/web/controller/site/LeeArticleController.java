package com.ruoyi.web.controller.site;

import java.util.Arrays;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.lee.enums.LeeArticleStatusEnums;
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
import com.ruoyi.lee.domain.LeeArticle;
import com.ruoyi.lee.service.ILeeArticleService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 站点博客列Controller
 * 
 * @author ruoyi
 * @date 2025-07-13
 */
@RestController
@RequestMapping("/LeeSite/article")
public class LeeArticleController extends BaseController
{
    @Autowired
    private ILeeArticleService leeArticleService;

    /**
     * 查询站点博客列列表
     */
    @PreAuthorize("@ss.hasPermi('system:article:list')")
    @GetMapping("/list")
    public TableDataInfo list(LeeArticle leeArticle)
    {
        startPage();
        List<LeeArticle> list = leeArticleService.selectLeeArticleList(leeArticle);
        return getDataTable(list);
    }

    /**
     * 导出站点博客列列表
     */
    @PreAuthorize("@ss.hasPermi('system:article:export')")
    @Log(title = "站点博客列", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, LeeArticle leeArticle)
    {
        List<LeeArticle> list = leeArticleService.selectLeeArticleList(leeArticle);
        ExcelUtil<LeeArticle> util = new ExcelUtil<LeeArticle>(LeeArticle.class);
        util.exportExcel(response, list, "站点博客列数据");
    }

    /**
     * 获取站点博客列详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:article:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(leeArticleService.getById(id));
    }

    /**
     * 新增站点博客列
     */
    @PreAuthorize("@ss.hasPermi('system:article:add')")
    @Log(title = "站点博客列", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody LeeArticle leeArticle)
    {
        return toAjax(leeArticleService.saveOrUpdate(leeArticle.setStatus(LeeArticleStatusEnums.HIDE)));
    }

    /**
     * 修改站点博客列
     */
    @PreAuthorize("@ss.hasPermi('system:article:edit')")
    @Log(title = "站点博客列", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody LeeArticle leeArticle)
    {
        return toAjax(leeArticleService.saveOrUpdate(leeArticle));
    }

    /**
     * 删除站点博客列
     */
    @PreAuthorize("@ss.hasPermi('system:article:remove')")
    @Log(title = "站点博客列", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(leeArticleService.removeByIds(Arrays.asList(ids)));
    }
}
