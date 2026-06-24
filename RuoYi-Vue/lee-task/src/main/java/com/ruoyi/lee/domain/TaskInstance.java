package com.ruoyi.lee.domain;

import com.ruoyi.lee.enums.InstanceStatus;
import com.ruoyi.lee.enums.TriggerType;
import java.time.LocalDateTime;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

/**
 * 任务实例领域对象。
 */
@Data
@NoArgsConstructor
@Accessors(chain = true)
public class TaskInstance {

    private String id;

    /** 所属任务定义 ID */
    private String definitionId;

    /** SCHEDULED / MANUAL / API */
    private TriggerType triggerType;

    /** PENDING / PRE_PROCESSING / EXECUTING / POST_PROCESSING / SUCCESS / FAILED / TIMEOUT / CANCELLED */
    private InstanceStatus status;

    /** 执行结果摘要（JSON） */
    private String executorResult;

    /** 前置操作执行结果 */
    private String preOpResult;

    /** 后置处理执行结果 */
    private String postOpResult;

    /** 异常堆栈/错误详情 */
    private String exceptionInfo;

    /** 当前已重试次数 */
    private Integer retryCount;

    /** 开始执行时间 */
    private LocalDateTime startTime;

    /** 结束时间 */
    private LocalDateTime endTime;

    /** 执行耗时（毫秒） */
    private Long durationMs;

    /** 触发者标识 */
    private String triggeredBy;

    /** 日志文件路径 */
    private String logFilePath;

    /** 记录创建时间 */
    private LocalDateTime createTime;
}

