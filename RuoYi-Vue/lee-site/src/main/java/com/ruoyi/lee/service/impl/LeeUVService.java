package com.ruoyi.lee.service.impl;


import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.lee.service.ILeeUVService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Service
public class LeeUVService implements ILeeUVService {

    @Autowired
    private RedisCache redisCache;


    @Override
    public void view(String ip) {
        // 获取当前日期
        LocalDate date = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String yearMonth = date.format(formatter);
        String key = CacheConstants.UV_PREFIX_KEY + yearMonth;
        // hyperlog insert
        redisCache.insertHyperLog(key, ip);

    }
}
