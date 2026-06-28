package com.ruoyi.lee.domain.vo;

import java.time.LocalDateTime;
import java.util.List;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@Accessors(chain = true)
public class TaskDefinitionVO {

    private String id;

    private String name;

    private String description;

    private String taskType;

    private String scheduleType;

    private String cronExpression;

    private String executorType;

    private String executorConfig;

    private String status;

    private String preOpConfig;

    private String postOpConfig;

    private String exceptionHandlerConfig;

    private String loggerConfig;

    private String retryPolicy;

    private Integer timeoutSeconds;

    private String concurrencyMode;

    private Integer priority;

    private List<String> tags;

    private String createBy;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    private String updateBy;

    private String remark;
}

