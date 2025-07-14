package com.ruoyi.lee.domain;


import com.ruoyi.common.core.domain.LeeBaseEntity;
import lombok.Data;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ruoyi.common.annotation.Excel;
import lombok.experimental.Accessors;

/**
 * 站点博客列对象 lee_article
 *
 * @author ruoyi
 * @date 2025-07-13
 */

@Data
@TableName("lee_article")
@Accessors(chain = true)
public class LeeArticle extends LeeBaseEntity
{
    private static final long serialVersionUID = 1L;

    /** id */
    private Long id;

    /** 博客标题 */
    @Excel(name = "博客标题")
    private String title;

    /** 博客url */
    @Excel(name = "博客url")
    private String url;

    /** 博客封面url */
    @Excel(name = "博客封面url")
    private String cover;

    /** 博客摘要 */
    @Excel(name = "博客摘要")
    private String summary;

    /** 博客分类 */
    @Excel(name = "博客分类")
    private String category;

    /** 状态 */
    @Excel(name = "状态")
    private Long status;

}
