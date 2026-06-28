package com.ruoyi.lee.executor;

import com.ruoyi.lee.enums.ExecutorType;
import com.ruoyi.lee.executor.config.ExecutorConfig;
import com.ruoyi.lee.executor.config.HttpRequestExecutorConfig;
import com.ruoyi.lee.executor.config.LocalScriptExecutorConfig;
import java.util.Collections;
import java.util.EnumMap;
import java.util.Map;
import java.util.Objects;

/**
 * 任务执行器工厂：根据执行器类型返回可执行的策略实例。
 */
public final class TaskExecutorFactory {

    private static final Map<ExecutorType, BaseExecutor> EXECUTOR_MAP = new EnumMap<>(ExecutorType.class);

    static {
        register(ExecutorType.HTTP_REQUEST, new HTTPRequestExecutor());
        register(ExecutorType.LOCAL_SCRIPT, new LocalScriptExecutor());
    }

    private TaskExecutorFactory() {
        // utility class
    }

    public static BaseExecutor get(ExecutorType executorType) {
        if (executorType == null) {
            throw new IllegalArgumentException("executorType can not be null");
        }

        BaseExecutor executor = EXECUTOR_MAP.get(executorType);
        if (executor == null) {
            throw new IllegalArgumentException("Unsupported executor type: " + executorType);
        }
        return executor;
    }

    public static BaseExecutor get(String executorType) {
        if (executorType == null || executorType.trim().isEmpty()) {
            throw new IllegalArgumentException("executorType can not be blank");
        }
        return get(ExecutorType.valueOf(executorType.trim().toUpperCase()));
    }

    public static ExecutorConfig buildConfig(ExecutorType executorType, Map<String, Object> rawConfig) {
        Map<String, Object> safeConfig = rawConfig == null ? Collections.emptyMap() : rawConfig;
        if (executorType == null) {
            throw new IllegalArgumentException("executorType can not be null");
        }

        switch (executorType) {
            case HTTP_REQUEST:
                return HttpRequestExecutorConfig.fromMap(safeConfig);
            case LOCAL_SCRIPT:
                return LocalScriptExecutorConfig.fromMap(safeConfig);
            default:
                throw new IllegalArgumentException("Unsupported executor type: " + executorType);
        }
    }


    // todo 这个方法需要挪出去，工厂只负责获取
    public static String execute(ExecutorType executorType, Map<String, Object> rawConfig) throws Exception {
        BaseExecutor executor = get(executorType);
        ExecutorConfig executorConfig = buildConfig(executorType, rawConfig);
        return executor.execute(executorConfig);
    }

    /**
     * 兼容旧调用方命名。
     */
    @Deprecated
    public static BaseExecutor create(ExecutorType executorType) {
        return get(executorType);
    }

    /**
     * 兼容旧调用方命名。
     */
    @Deprecated
    public static BaseExecutor create(String executorType) {
        return get(executorType);
    }

    public static void register(ExecutorType executorType, BaseExecutor executor) {
        Objects.requireNonNull(executorType, "executorType can not be null");
        Objects.requireNonNull(executor, "executor can not be null");
        if (executor.type() != executorType) {
            throw new IllegalArgumentException("executor type mismatch: expected " + executorType + ", actual " + executor.type());
        }
        EXECUTOR_MAP.put(executorType, executor);
    }
}
