package com.ruoyi.lee.strategy.post;

import java.util.HashMap;
import java.util.Map;

public interface PostOperationStrategy {
    Map<String, PostOperationStrategy> strategyMap = new HashMap<>();

    /**
     * 后置处理
     */
    void handle();

    /**
     * 获取策略名称
     *
     * @return 策略名称
     */
    String getName();
}
