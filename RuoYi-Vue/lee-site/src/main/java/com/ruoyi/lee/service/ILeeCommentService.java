package com.ruoyi.lee.service;

import java.util.List;

import com.ruoyi.lee.domain.LeeComment;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * 留言板Service接口
 *
 * @author ruoyi
 * @date 2025-07-17
 */
public interface ILeeCommentService extends IService<LeeComment> {
    /**
     * 查询留言板列表
     *
     * @param leeComment 留言板
     * @return 留言板集合
     */
    public List<LeeComment> selectLeeCommentList(LeeComment leeComment);

    List<LeeComment> selectFrontLeeCommentList(LeeComment leeComment);

    List<LeeComment> listFrontChildComment(LeeComment leeComment);

    int removeCommentByIds(List<Long> list);

    List<LeeComment> listChildComment(LeeComment leeComment);
}
