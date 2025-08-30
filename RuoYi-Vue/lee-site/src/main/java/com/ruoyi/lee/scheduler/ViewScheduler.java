package com.ruoyi.lee.scheduler;

import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SimpleRedisLockUtils;
import com.ruoyi.lee.domain.LeePageView;
import com.ruoyi.lee.domain.LeeUniqueView;
import com.ruoyi.lee.service.ILeePVService;
import com.ruoyi.lee.service.ILeeUVService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.util.Date;
import java.util.List;

@Component
public class ViewScheduler {

    @Autowired
    private ILeeUVService leeUVService;

    @Autowired
    private ILeePVService leePVService;

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private SimpleRedisLockUtils redisLockUtils;

    @Scheduled(cron = "0 0 2 * * ?")
    public void recordView() {
        executeRecordView();
    }

    public void executeRecordView() {
        //加锁，为了后续的分布式集群
        if (redisLockUtils.tryLock(SimpleRedisLockUtils.RECORD_VIEW_LOCK, String.valueOf(System.currentTimeMillis()))) {
            try {
                List<LeePageView> leePageViews = leePVService.recordView();
                List<LeeUniqueView> leeUniqueViews = leeUVService.recordView();
                deletePreviousPageView(leePageViews);
                deletePreviousUniqueView(leeUniqueViews);
            } finally {
                redisLockUtils.unlock(SimpleRedisLockUtils.RECORD_VIEW_LOCK);
            }
        }
        // 这里可以添加定时任务的逻辑
        System.out.println("定时任务执行: 记录访问量");
    }


    private void deletePreviousPageView(List<LeePageView> leePageViews) {
        if (CollectionUtils.isEmpty(leePageViews)) {
            return;
        }
        for (LeePageView leePageView : leePageViews) {
            Date viewDate = leePageView.getViewDate();
            String date = DateUtils.dateTime(viewDate);
            String key = CacheConstants.PV_PREFIX_KEY + date;
            redisCache.deleteObject(key);
        }
    }

    private void deletePreviousUniqueView(List<LeeUniqueView> leeUniqueViews) {
        if (CollectionUtils.isEmpty(leeUniqueViews)) {
            return;
        }
        for (LeeUniqueView leeUniqueView : leeUniqueViews) {
            Date viewDate = leeUniqueView.getViewDate();
            String date = DateUtils.dateTime(viewDate);
            String key = CacheConstants.UV_PREFIX_KEY + date;
            redisCache.deleteObject(key);
        }
    }
}
