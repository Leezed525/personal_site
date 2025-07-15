package com.ruoyi.lee.service;

import java.util.List;
import com.ruoyi.lee.domain.LeeArticle;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * 站点博客列Service接口
 *
 * @author ruoyi
 * @date 2025-07-13
 */
public interface ILeeArticleService extends IService<LeeArticle> {
    /**
     * 后台查询站点博客列列表
     *
     * @param leeArticle 站点博客列
     * @return 站点博客列集合
     */
    public List<LeeArticle> selectLeeArticleList(LeeArticle leeArticle);


    /**
     * 前台查询站点博客列列表
     *
     * @param leeArticle 站点博客列
     * @return 站点博客列集合
     */
    public List<LeeArticle> selectFrontLeeArticleList(LeeArticle leeArticle);
}
