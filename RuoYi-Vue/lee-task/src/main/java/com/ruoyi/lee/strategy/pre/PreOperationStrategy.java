package com.ruoyi.lee.strategy.pre;

import java.util.HashMap;
import java.util.Map;

public interface PreOperationStrategy {

    Map<String, PreOperationStrategy> strategyMap = new HashMap<>();


    /**
     * 前置处理
     */
    void handle();

    /**
     * 获取策略名称
     *
     * @return 策略名称
     */
    String getName();
}
