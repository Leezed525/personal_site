package com.ruoyi.lee.executor;

import com.ruoyi.lee.enums.ExecutorType;
import com.ruoyi.lee.executor.config.HttpRequestExecutorConfig;

public class HTTPRequestExecutor extends AbstractTaskExecutor<HttpRequestExecutorConfig> {

    @Override
    public ExecutorType type() {
        return ExecutorType.HTTP_REQUEST;
    }

    @Override
    public Class<HttpRequestExecutorConfig> configType() {
        return HttpRequestExecutorConfig.class;
    }

    @Override
    protected void validateConfig(HttpRequestExecutorConfig executorConfig) {
        if (executorConfig.getHttpMethod() == null) {
            throw new IllegalArgumentException("Missing required config: http_method");
        }
        requiredString(executorConfig.getUrl(), "url");
    }

    @Override
    protected String doExecute(HttpRequestExecutorConfig executorConfig) {
        return "HTTP executor prepared, method=" + executorConfig.getHttpMethod() +
                ", url=" + executorConfig.getUrl();
    }
}
