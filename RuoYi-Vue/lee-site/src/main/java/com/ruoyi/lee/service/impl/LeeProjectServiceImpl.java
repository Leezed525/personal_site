package com.ruoyi.lee.service.impl;

import java.util.List;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.lee.mapper.LeeProjectMapper;
import com.ruoyi.lee.domain.LeeProject;
import com.ruoyi.lee.service.ILeeProjectService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 项目Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-07-18
 */
@Service
public class LeeProjectServiceImpl extends ServiceImpl<LeeProjectMapper,LeeProject> implements ILeeProjectService
{
    /**
     * 查询项目列表
     *
     * @param leeProject 项目
     * @return 项目
     */
    @Override
    public List<LeeProject> selectLeeProjectList(LeeProject leeProject)
    {
        QueryWrapper<LeeProject> queryWrapper = new QueryWrapper<>();
        return baseMapper.selectList(queryWrapper);
    }

}
