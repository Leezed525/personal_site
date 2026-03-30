package com.ruoyi.lee.domain;

import lombok.Data;
import org.quartz.JobDataMap;

@Data
public class TaskDefinition {
    private String taskId;                    // 业务ID（对应Quartz JobKey）
    private String taskName;
    private TaskType type;          // 任务类型
    private TaskManner manner;    // 任务方式
//    private SchedulingPolicy scheduling;     // 调度策略
//    private TaskPayload payload;             // 任务负载（参数）
//    private RetryPolicy retryPolicy;         // 重试策略（当scheduling为可重试时）

    // 转换为Quartz的JobDataMap
    public JobDataMap toJobDataMap() {
        JobDataMap map = new JobDataMap();
        map.put("TASK_DEFINITION", this);
//        map.put("INTENT", intent.name());
//        map.put("MECHANISM", mechanism.getType());
        map.put("RETRY_COUNT", 0);
        return map;
    }
}
