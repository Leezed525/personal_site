package com.ruoyi.lee.strategy.post;

public class DefaultPostOperationStrategy implements PostOperationStrategy {

    private static final String strategyName = "default";

    static {
        PostOperationStrategy.strategyMap.put(strategyName, new DefaultPostOperationStrategy());
    }

    @Override
    public void handle() {
        // 默认后置处理逻辑
        System.out.println("执行默认后置处理逻辑");
    }

    @Override
    public String getName() {
        return strategyName;
    }
}
