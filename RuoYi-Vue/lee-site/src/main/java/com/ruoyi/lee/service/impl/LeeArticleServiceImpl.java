package com.ruoyi.lee.service.impl;

import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.lee.enums.LeeArticleStatusEnums;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.lee.mapper.LeeArticleMapper;
import com.ruoyi.lee.domain.LeeArticle;
import com.ruoyi.lee.service.ILeeArticleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 站点博客列Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-07-13
 */
@Service
public class LeeArticleServiceImpl extends ServiceImpl<LeeArticleMapper,LeeArticle> implements ILeeArticleService
{
    /**
     * 查询站点博客列列表
     *
     * @param leeArticle 站点博客列
     * @return 站点博客列
     */
    @Override
    public List<LeeArticle> selectLeeArticleList(LeeArticle leeArticle)
    {
        LambdaQueryWrapper<LeeArticle> queryWrapper = new LambdaQueryWrapper<LeeArticle>();
        return baseMapper.selectList(queryWrapper);
    }

    @Override
    public List<LeeArticle> selectFrontLeeArticleList(LeeArticle leeArticle)
    {
        LambdaQueryWrapper<LeeArticle> queryWrapper = new LambdaQueryWrapper<LeeArticle>();
        //如果leeArticle中的category不为空
        queryWrapper.eq(leeArticle.getCategory() != null, LeeArticle::getCategory, leeArticle.getCategory());
        queryWrapper.eq(LeeArticle::getStatus, LeeArticleStatusEnums.PUBLISHED);
        return baseMapper.selectList(queryWrapper);
    }

}
