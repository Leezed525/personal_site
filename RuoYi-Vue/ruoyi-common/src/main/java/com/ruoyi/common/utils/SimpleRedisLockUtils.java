package com.ruoyi.common.utils;


import com.ruoyi.common.core.redis.RedisCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class SimpleRedisLockUtils {

    @Autowired
    private RedisCache redisCache;

    public static final String LOCK_PREFIX = "lock:";

    public static final String RECORD_VIEW_LOCK = LOCK_PREFIX + "record_view_lock";


    public boolean tryLock(String key, String value) {
        return redisCache.setCacheObjectIfAbsent(key, value, 10L);
    }

    public boolean tryLock(String key, String value, long expireTime) {
        return redisCache.setCacheObjectIfAbsent(key, value, expireTime);
    }

    public void unlock(String key) {
        redisCache.deleteObject(key);
    }
}
