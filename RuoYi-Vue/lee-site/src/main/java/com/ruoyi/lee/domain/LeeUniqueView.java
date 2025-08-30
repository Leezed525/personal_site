package com.ruoyi.lee.domain;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Date;

@Data
@TableName("lee_unique_view")
@Accessors(chain = true)
public class LeeUniqueView {
    /*
     * id
     */
    private Long id;
    /*
     * 访问日期
     */
    private Date viewDate;
    /*
     * 访问数量
     */
    private Long viewCount;
}
