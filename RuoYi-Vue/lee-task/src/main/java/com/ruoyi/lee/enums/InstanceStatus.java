package com.ruoyi.lee.enums;

/**
 * 任务实例执行状态枚举。
 */
public enum InstanceStatus {

    /** 待处理 */
    PENDING,

    /** 前置处理中 */
    PRE_PROCESSING,

    /** 执行中 */
    EXECUTING,

    /** 后置处理中 */
    POST_PROCESSING,

    /** 成功 */
    SUCCESS,

    /** 失败 */
    FAILED,

    /** 超时 */
    TIMEOUT,

    /** 已取消 */
    CANCELLED
}

