package com.ruoyi.web.controller.front;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.lee.domain.LeeComment;
import com.ruoyi.lee.enums.LeeArticleRootEnum;
import com.ruoyi.lee.enums.LeeCommentStatusEnums;
import com.ruoyi.lee.service.ILeeCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/front/comment")
public class CommentController extends BaseController {

    @Autowired
    private ILeeCommentService commentService;

    /**
     * 查询留言板列表
     */
    @GetMapping("/list")
    public TableDataInfo list(LeeComment leeComment) {
        startPage();
        List<LeeComment> list = commentService.selectFrontLeeCommentList(leeComment);
        return getDataTable(list);
    }


    @GetMapping("/listChildComment")
    public AjaxResult listChildComment(LeeComment leeComment) {
        List<LeeComment> list = commentService.listChildComment(leeComment);
        return AjaxResult.success(list);
    }

    /**
     * 新增留言板
     */
    @Log(title = "留言板", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    public AjaxResult add(@Validated @RequestBody LeeComment leeComment) {
        // 设置状态为审核中
        leeComment.setStatus(LeeCommentStatusEnums.IN_REVIEW.getStatus()); // 假设1表示审核中状态
        if (leeComment.getPreId() == null) {
            leeComment.setRoot(LeeArticleRootEnum.ROOT.getRoot()); // 设置根留言
        } else {
            leeComment.setRoot(LeeArticleRootEnum.NOT_ROOT.getRoot()); // 设置非根留言
        }
        return toAjax(commentService.saveOrUpdate(leeComment));
    }


}
