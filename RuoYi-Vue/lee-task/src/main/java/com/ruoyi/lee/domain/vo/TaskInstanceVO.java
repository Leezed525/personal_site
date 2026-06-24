package com.ruoyi.lee.domain.vo;

import java.time.LocalDateTime;

import com.ruoyi.lee.domain.TaskDefinition;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

/**
 * 任务实例视图对象。
 */
@Data
@NoArgsConstructor
@Accessors(chain = true)
public class TaskInstanceVO {

    private String id;

    private TaskDefinitionVO definitionId;

    private String triggerType;

    private String status;

    private String executorResult;

    private String preOpResult;

    private String postOpResult;

    private String exceptionInfo;

    private Integer retryCount;

    private LocalDateTime startTime;

    private LocalDateTime endTime;

    private Long durationMs;

    private String triggeredBy;

    private String logFilePath;

    private LocalDateTime createTime;
}

