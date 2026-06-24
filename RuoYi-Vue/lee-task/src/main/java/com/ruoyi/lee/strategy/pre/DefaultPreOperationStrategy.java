package com.ruoyi.lee.strategy.pre;

public class DefaultPreOperationStrategy implements PreOperationStrategy {


    private static final String strategyName = "default";

    static {
        PreOperationStrategy.strategyMap.put(strategyName, new DefaultPreOperationStrategy());
    }


    @Override
    public void handle() {
        // 默认前置处理逻辑
        System.out.println("执行默认前置处理逻辑");
    }

    @Override
    public String getName() {
        return strategyName;
    }
}
