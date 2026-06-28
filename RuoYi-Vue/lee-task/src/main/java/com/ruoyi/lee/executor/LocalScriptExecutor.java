package com.ruoyi.lee.executor;

import com.ruoyi.lee.enums.ExecutorType;
import com.ruoyi.lee.executor.config.LocalScriptExecutorConfig;

public class LocalScriptExecutor extends AbstractTaskExecutor<LocalScriptExecutorConfig> {

    @Override
    public ExecutorType type() {
        return ExecutorType.LOCAL_SCRIPT;
    }

    @Override
    public Class<LocalScriptExecutorConfig> configType() {
        return LocalScriptExecutorConfig.class;
    }

    @Override
    protected void validateConfig(LocalScriptExecutorConfig executorConfig) {
        if (executorConfig.getScriptType() == null) {
            throw new IllegalArgumentException("Missing required config: script_type");
        }
        requiredString(executorConfig.getScriptPath(), "script_path");
    }

    @Override
    protected String doExecute(LocalScriptExecutorConfig executorConfig) {
        return "Local script executor prepared, scriptType=" + executorConfig.getScriptType() +
                ", scriptPath=" + executorConfig.getScriptPath();
    }
}
