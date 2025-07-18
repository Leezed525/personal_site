package com.ruoyi.lee.domain;


import com.ruoyi.common.core.domain.LeeBaseEntity;
import lombok.Data;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ruoyi.common.annotation.Excel;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

/**
 * 留言板对象 lee_comment
 *
 * @author ruoyi
 * @date 2025-07-17
 */

@Data
@TableName("lee_comment")
public class LeeComment extends LeeBaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long id;

    /** 上级留言 */
    @Excel(name = "上级留言")
    private Long preId;

    /**
     * 留言内容
     */
    @Excel(name = "留言内容")
    @NotNull(message = "留言内容不能为空")
    @Length(min = 1, max = 2000, message = "留言内容长度必须在1到2000之间")
    private String content;

    /** 状态 */
    @Excel(name = "状态")
    private Long status;

    /** 是否根留言 */
    @Excel(name = "是否根留言")
    private String root;

    @Excel(name = "作者id")
    @NotNull(message = "作者id不能为空")
    private Long authorId;


}
