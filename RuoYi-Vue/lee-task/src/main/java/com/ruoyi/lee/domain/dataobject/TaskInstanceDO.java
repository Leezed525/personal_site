package com.ruoyi.lee.domain.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.time.LocalDateTime;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

/**
 * 任务实例数据对象。
 */
@Data
@NoArgsConstructor
@Accessors(chain = true)
@TableName("lee_task_instance")
public class TaskInstanceDO {

    @TableId(value = "id", type = IdType.INPUT)
    private String id;

    private String definitionId;

    /** SCHEDULED / MANUAL / API */
    private String triggerType;

    /** PENDING / PRE_PROCESSING / EXECUTING / POST_PROCESSING / SUCCESS / FAILED / TIMEOUT / CANCELLED */
    private String status;

    /** JSON text */
    private String executorResult;

    /** JSON text */
    private String preOpResult;

    /** JSON text */
    private String postOpResult;

    /** JSON text */
    private String exceptionInfo;

    private Integer retryCount;

    private LocalDateTime startTime;

    private LocalDateTime endTime;

    private Long durationMs;

    private String triggeredBy;

    private String logFilePath;

    private LocalDateTime createTime;
}

