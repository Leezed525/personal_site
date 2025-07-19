package com.ruoyi.lee.domain;


import com.ruoyi.common.core.domain.LeeBaseEntity;
import lombok.Data;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ruoyi.common.annotation.Excel;

/**
 * 项目对象 lee_project
 *
 * @author ruoyi
 * @date 2025-07-18
 */

@Data
@TableName("lee_project")
public class LeeProject extends LeeBaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long id;

    /** 项目名称 */
    @Excel(name = "项目名称")
    private String title;

    /** 项目描述 */
    @Excel(name = "项目描述")
    private String description;

    /** 状态 */
    @Excel(name = "状态")
    private Long status;

    /** 项目链接 */
    @Excel(name = "项目链接")
    private String link;

    /** 项目图片 */
    @Excel(name = "项目图片")
    private String image;

    /** 项目排序 */
    @Excel(name = "项目排序")
    private Integer orderNum;
}
