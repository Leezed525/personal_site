package com.ruoyi.common.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

public interface MyBaseMapper<T> extends BaseMapper<T> {
    Integer insertBatchSomeColumn(java.util.List<T> entityList);
}
