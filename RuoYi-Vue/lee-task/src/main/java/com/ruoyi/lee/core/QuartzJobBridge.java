package com.ruoyi.lee.core;

import com.ruoyi.lee.domain.dataobject.TaskDefinitionDO;
import com.ruoyi.lee.service.ITaskDefinitionService;
import com.ruoyi.lee.service.ITaskInstanceService;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.springframework.beans.factory.annotation.Autowired;

public class QuartzJobBridge implements Job {


    @Autowired
    private ITaskDefinitionService taskDefinitionService;
    @Autowired
    private ITaskInstanceService taskInstanceService;


    @Override
    public void execute(JobExecutionContext ctx) {
        String definitionId = ctx.getMergedJobDataMap().getString("definitionId");
        TaskDefinitionDO def = taskDefinitionService.getById(definitionId);
    }
}
