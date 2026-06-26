package com.ruoyi.lee.executor;

import com.ruoyi.lee.enums.ScriptType;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
public class LocalScriptExecutor implements BaseExecutor {

    // 运行脚本类型
    private ScriptType scriptType;

    // 脚本路径
    private String scriptPath;

    // 脚本参数
    private List<String> scriptArgs;

    // 工作路径
    private String workDir;

    // 环境变量
    private Map<String, String> environmentVars;

    // 是否捕获标准输出
    private Boolean captureStdout = Boolean.TRUE;

    // 是否捕获标准错误输出
    private Boolean captureStderr = Boolean.TRUE;

    // 判定成功过的退出码
    private List<String> exitCodeSuccess;

    @Override
    public String execute() throws Exception {
        return "Success";
    }

}
