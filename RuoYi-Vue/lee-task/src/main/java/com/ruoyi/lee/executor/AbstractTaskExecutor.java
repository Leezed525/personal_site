package com.ruoyi.lee.executor;

import com.ruoyi.lee.executor.config.ExecutorConfig;

public abstract class AbstractTaskExecutor<C extends ExecutorConfig> implements BaseExecutor {

    @Override
    public String execute(ExecutorConfig executorConfig) throws Exception {
        // 校验config是否合理
        C typedConfig = castConfig(executorConfig);
        validateConfig(typedConfig);

        // 前置操作
        doExecute(typedConfig);
        // 后置操作
        return "success";
    }

    @SuppressWarnings("unchecked")
    private C castConfig(ExecutorConfig executorConfig) {
        if (executorConfig == null) {
            throw new IllegalArgumentException("executorConfig can not be null");
        }
        if (!configType().isInstance(executorConfig)) {
            throw new IllegalArgumentException(
                    "Config type mismatch, expected " + configType().getSimpleName() +
                            ", actual " + executorConfig.getClass().getSimpleName());
        }
        return (C) executorConfig;
    }

    /**
     * 子类可覆盖该方法做参数校验。
     */
    protected void validateConfig(C executorConfig) {
        // default no-op
    }

    /**
     * 子类实现具体执行逻辑。
     */
    protected abstract String doExecute(C executorConfig) throws Exception;

    protected String requiredString(String value, String key) {
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException("Missing required config: " + key);
        }
        return value.trim();
    }
}
