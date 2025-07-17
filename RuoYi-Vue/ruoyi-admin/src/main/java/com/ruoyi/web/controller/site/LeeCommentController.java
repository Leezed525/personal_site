package com.ruoyi.web.controller.site;

import java.util.List;
import java.util.Arrays;
import javax.servlet.http.HttpServletResponse;
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
import com.ruoyi.lee.domain.LeeComment;
import com.ruoyi.lee.service.ILeeCommentService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 留言板Controller
 * 
 * @author ruoyi
 * @date 2025-07-17
 */
@RestController
@RequestMapping("/LeeSite/comment")
public class LeeCommentController extends BaseController
{
    @Autowired
    private ILeeCommentService leeCommentService;

    /**
     * 查询留言板列表
     */
    @PreAuthorize("@ss.hasPermi('project:comment:list')")
    @GetMapping("/list")
    public TableDataInfo list(LeeComment leeComment)
    {
        startPage();
        List<LeeComment> list = leeCommentService.selectLeeCommentList(leeComment);
        return getDataTable(list);
    }

    /**
     * 导出留言板列表
     */
    @PreAuthorize("@ss.hasPermi('project:comment:export')")
    @Log(title = "留言板", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, LeeComment leeComment)
    {
        List<LeeComment> list = leeCommentService.selectLeeCommentList(leeComment);
        ExcelUtil<LeeComment> util = new ExcelUtil<LeeComment>(LeeComment.class);
        util.exportExcel(response, list, "留言板数据");
    }

    /**
     * 获取留言板详细信息
     */
    @PreAuthorize("@ss.hasPermi('project:comment:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(leeCommentService.getById(id));
    }

    /**
     * 新增留言板
     */
    @PreAuthorize("@ss.hasPermi('project:comment:add')")
    @Log(title = "留言板", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody LeeComment leeComment)
    {
        return toAjax(leeCommentService.saveOrUpdate(leeComment));
    }

    /**
     * 修改留言板
     */
    @PreAuthorize("@ss.hasPermi('project:comment:edit')")
    @Log(title = "留言板", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody LeeComment leeComment)
    {
        return toAjax(leeCommentService.saveOrUpdate(leeComment));
    }

    /**
     * 删除留言板
     */
    @PreAuthorize("@ss.hasPermi('project:comment:remove')")
    @Log(title = "留言板", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(leeCommentService.removeByIds(Arrays.asList(ids)));
    }
}
