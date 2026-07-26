package com.ruoyi.lee.service;


public interface IQuartzSchedulerManager {


    /**
     * 将任务注册进quartz
     *
     * @param taskDefinitionId 任务定义Id
     */
    void registerTask(String taskDefinitionId);

    /**
     * 暂停任务
     *
     * @param taskDefinitionId 任务定义Id
     */
    void pauseTask(String taskDefinitionId);

    /**
     * 恢复任务
     *
     * @param taskDefinitionId 任务定义Id
     */
    void resumeTask(String taskDefinitionId);

    /**
     * 删除任务
     *
     * @param taskDefinitionId 任务定义Id
     */
    void deleteTask(String taskDefinitionId);

    /**
     * 重新调度任务
     *
     * @param taskDefinitionId 任务定义Id
     * @param newTime          新的调度时间
     * @throws Exception 异常
     */
    void rescheduleTask(String taskDefinitionId, String newTime) throws Exception;


}
