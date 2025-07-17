package com.ruoyi.lee.domain;


import lombok.Data;
import com.baomidou.mybatisplus.annotation.TableName;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 留言板对象 lee_comment
 *
 * @author ruoyi
 * @date 2025-07-17
 */

@Data
@TableName("lee_comment")
public class LeeComment extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long id;

    /** 上级留言 */
    @Excel(name = "上级留言")
    private Long preId;

    /** 留言内容 */
    @Excel(name = "留言内容")
    private String content;

    /** 状态 */
    @Excel(name = "状态")
    private Long status;

    /** 回复内容 */
    @Excel(name = "回复内容")
    private String reply;

    /** 回复时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "回复时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date replyTime;

    /** 是否根留言 */
    @Excel(name = "是否根留言")
    private String root;

}
