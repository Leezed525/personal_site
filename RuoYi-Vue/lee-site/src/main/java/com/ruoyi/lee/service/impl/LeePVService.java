package com.ruoyi.lee.service.impl;


import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.lee.domain.LeePageView;
import com.ruoyi.lee.domain.LeeUniqueView;
import com.ruoyi.lee.mapper.LeePageViewMapper;
import com.ruoyi.lee.service.ILeePVService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Service
public class LeePVService implements ILeePVService {


    @Autowired
    private RedisCache redisCache;

    @Autowired(required = false)
    private LeePageViewMapper pageViewMapper;


    @Override
    public void view() {
        // 获取当前日期
        LocalDate date = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String yearMonth = date.format(formatter);
        String key = CacheConstants.PV_PREFIX_KEY + yearMonth;
        //redis string + 1
        redisCache.incrString(key);
    }

    @Override
    public List<LeePageView> recordView() {
        List<LeePageView> leePageViews = listPreviousViewRecords();
        if (!CollectionUtils.isEmpty(leePageViews)) {
            pageViewMapper.insertBatchSomeColumn(leePageViews);
        }
        return leePageViews;

    }

    private List<LeePageView> listPreviousViewRecords() {
        List<LeePageView> records = new ArrayList<>();
        LocalDate previousDay = LocalDate.now().minusDays(1);
        String previousDayStr = previousDay.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        String key = CacheConstants.PV_PREFIX_KEY + previousDayStr;
        do {
            Integer countAsInteger = redisCache.getCacheObject(key);
            Long count = (countAsInteger != null) ? countAsInteger.longValue() : 0;
            LeePageView leePageView = new LeePageView();
            leePageView.setViewDate(DateUtils.toDate(previousDay));
            leePageView.setViewCount(count);
            records.add(leePageView);
            previousDay = previousDay.minusDays(1);
            previousDayStr = previousDay.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            key = CacheConstants.PV_PREFIX_KEY + previousDayStr;
        } while (redisCache.hasKey(key));
        return records;
    }


}
