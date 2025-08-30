package com.ruoyi.lee.service.impl;


import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.lee.domain.LeeUniqueView;
import com.ruoyi.lee.mapper.LeeUniqueViewMapper;
import com.ruoyi.lee.service.ILeeUVService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.core.Local;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class LeeUVService implements ILeeUVService {

    @Autowired
    private RedisCache redisCache;

    @Autowired(required = false)
    private LeeUniqueViewMapper uniqueViewMapper;


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

    @Override
    @Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
    public List<LeeUniqueView> recordView() {
        List<LeeUniqueView> leeUniqueViews = listPreviousViewRecords();
        if (!CollectionUtils.isEmpty(leeUniqueViews)) {
            uniqueViewMapper.insertBatchSomeColumn(leeUniqueViews);
        }
        return leeUniqueViews;
    }

    private List<LeeUniqueView> listPreviousViewRecords() {
        List<LeeUniqueView> records = new ArrayList<>();
        LocalDate previousDay = LocalDate.now().minusDays(1);
        String previousDayStr = previousDay.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        String key = CacheConstants.UV_PREFIX_KEY + previousDayStr;
        do {
            Long countAsLong = redisCache.getHyperLogSize(key);
            Long count = countAsLong != null ? countAsLong : 0;
            LeeUniqueView leeUniqueView = new LeeUniqueView();
            leeUniqueView.setViewDate(DateUtils.toDate(previousDay));
            leeUniqueView.setViewCount(count);
            records.add(leeUniqueView);
            previousDay = previousDay.minusDays(1);
            previousDayStr = previousDay.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            key = CacheConstants.UV_PREFIX_KEY + previousDayStr;
        } while (redisCache.hasKey(key));
        return records;
    }
}
