package com.ruoyi.lee.executor;

import com.ruoyi.lee.enums.ExecutorType;
import com.ruoyi.lee.executor.config.ExecutorConfig;

public interface BaseExecutor {

    /**
     * 当前执行器支持的类型。
     */
    ExecutorType type();

    /**
     * 当前执行器支持的配置类型。
     */
    Class<? extends ExecutorConfig> configType();

    /**
     * 执行任务。
     */
    String execute(ExecutorConfig executorConfig) throws Exception;
}
