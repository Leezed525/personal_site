package com.ruoyi.lee.executor.config;

import com.ruoyi.lee.enums.ScriptType;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import lombok.Data;

@Data
public class LocalScriptExecutorConfig implements ExecutorConfig {

    private ScriptType scriptType;

    private String scriptPath;

    private List<String> scriptArgs = Collections.emptyList();

    private String workDir;

    private Map<String, String> environmentVars = Collections.emptyMap();

    private Boolean captureStdout = Boolean.TRUE;

    private Boolean captureStderr = Boolean.TRUE;

    private List<Integer> exitCodeSuccess = List.of(0);

    public static LocalScriptExecutorConfig fromMap(Map<String, Object> rawConfig) {
        Map<String, Object> safeConfig = rawConfig == null ? Collections.emptyMap() : rawConfig;
        LocalScriptExecutorConfig config = new LocalScriptExecutorConfig();

        Object scriptTypeValue = safeConfig.get("script_type");
        if (scriptTypeValue != null) {
            config.setScriptType(ScriptType.valueOf(scriptTypeValue.toString().trim().toUpperCase()));
        }

        Object scriptPathValue = safeConfig.get("script_path");
        if (scriptPathValue != null) {
            config.setScriptPath(scriptPathValue.toString().trim());
        }

        Object workDirValue = safeConfig.get("working_dir");
        if (workDirValue != null) {
            config.setWorkDir(workDirValue.toString().trim());
        }

        Object captureStdoutValue = safeConfig.get("capture_stdout");
        if (captureStdoutValue != null) {
            config.setCaptureStdout(Boolean.parseBoolean(captureStdoutValue.toString()));
        }

        Object captureStderrValue = safeConfig.get("capture_stderr");
        if (captureStderrValue != null) {
            config.setCaptureStderr(Boolean.parseBoolean(captureStderrValue.toString()));
        }

        return config;
    }
}

