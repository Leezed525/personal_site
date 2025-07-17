package com.ruoyi.lee.service.impl;

import java.util.List;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ruoyi.common.utils.DateUtils;
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
public class LeeCommentServiceImpl extends ServiceImpl<LeeCommentMapper,LeeComment> implements ILeeCommentService
{
    /**
     * 查询留言板列表
     *
     * @param leeComment 留言板
     * @return 留言板
     */
    @Override
    public List<LeeComment> selectLeeCommentList(LeeComment leeComment)
    {
        QueryWrapper<LeeComment> queryWrapper = new QueryWrapper<>();
        return baseMapper.selectList(queryWrapper);
    }

}
