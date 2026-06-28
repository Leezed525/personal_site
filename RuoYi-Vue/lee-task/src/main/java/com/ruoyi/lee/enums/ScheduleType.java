package com.ruoyi.lee.enums;

/**
 * 调度方式。
 */
public enum ScheduleType {

    /** Cron 表达式调度。 */
    CRON,

    /** 固定速率调度。 */
    FIXED_RATE,

    /** 固定延迟调度。 */
    FIXED_DELAY,

    /** 不调度（通常用于一次性任务）。 */
    NONE
}

