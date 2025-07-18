package com.ruoyi.lee.service.impl;

import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.lee.enums.LeeCommentStatusEnums;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.lee.mapper.LeeCommentMapper;
import com.ruoyi.lee.domain.LeeComment;
import com.ruoyi.lee.service.ILeeCommentService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 留言板Service业务层处理
 *
 * @author ruoyi
 * @date 2025-07-17
 */
@Service
public class LeeCommentServiceImpl extends ServiceImpl<LeeCommentMapper, LeeComment> implements ILeeCommentService {
    /**
     * 查询留言板列表
     *
     * @param leeComment 留言板
     * @return 留言板
     */
    @Override
    public List<LeeComment> selectLeeCommentList(LeeComment leeComment) {
        QueryWrapper<LeeComment> queryWrapper = new QueryWrapper<>();
        return baseMapper.selectList(queryWrapper);
    }

    @Override
    public List<LeeComment> selectFrontLeeCommentList(LeeComment leeComment) {
        LambdaQueryWrapper<LeeComment> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(LeeComment::getStatus, LeeCommentStatusEnums.PUBLISHED.getStatus()); // 只查询状态为审核通过的留言
        if (leeComment.getPreId() != null) {
            queryWrapper.eq(LeeComment::getPreId, leeComment.getPreId()); // 根据上级留言ID查询
        } else {
            queryWrapper.isNull(LeeComment::getPreId); // 查询根留言
        }
        queryWrapper.orderByDesc(LeeComment::getCreateTime); // 按创建时间降序排列
        List<LeeComment> comments = baseMapper.selectList(queryWrapper);
        //留言的发言人信息在create_by中，不用绑定了，先凑活着用
        return comments;

    }

    /**
     * 查询子留言
     *
     * @param leeComment 父留言
     * @return 子留言列表
     */
    @Override
    public List<LeeComment> listChildComment(LeeComment leeComment) {
        LambdaQueryWrapper<LeeComment> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(LeeComment::getPreId, leeComment.getId()); // 根据父留言ID查询子留言
        queryWrapper.eq(LeeComment::getStatus, LeeCommentStatusEnums.PUBLISHED.getStatus()); // 只查询状态为审核通过的留言
        queryWrapper.orderByDesc(LeeComment::getCreateTime); // 按创建时间降序排列
        List<LeeComment> comments = baseMapper.selectList(queryWrapper);
        return comments;
    }

}
