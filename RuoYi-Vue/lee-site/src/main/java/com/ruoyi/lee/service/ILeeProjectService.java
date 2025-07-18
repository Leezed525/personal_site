package com.ruoyi.lee.service;

import java.util.List;
import com.ruoyi.lee.domain.LeeProject;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * 项目Service接口
 *
 * @author ruoyi
 * @date 2025-07-18
 */
public interface ILeeProjectService extends IService<LeeProject> {
    /**
     * 查询项目列表
     *
     * @param leeProject 项目
     * @return 项目集合
     */
    public List<LeeProject> selectLeeProjectList(LeeProject leeProject);
}
