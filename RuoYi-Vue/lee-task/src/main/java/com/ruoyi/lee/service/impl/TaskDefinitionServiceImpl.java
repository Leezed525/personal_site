package com.ruoyi.lee.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.lee.domain.dataobject.TaskDefinitionDO;
import com.ruoyi.lee.mapper.TaskDefinitionMapper;
import com.ruoyi.lee.service.ITaskDefinitionService;
import java.util.List;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

/**
 * 任务定义 Service 实现。
 */
@Service
public class TaskDefinitionServiceImpl extends ServiceImpl<TaskDefinitionMapper, TaskDefinitionDO>
    implements ITaskDefinitionService {

    @Override
    public List<TaskDefinitionDO> selectTaskDefinitionList(TaskDefinitionDO taskDefinition) {
        LambdaQueryWrapper<TaskDefinitionDO> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.like(StringUtils.isNotBlank(taskDefinition.getName()), TaskDefinitionDO::getName,
            taskDefinition.getName());
        queryWrapper.eq(StringUtils.isNotBlank(taskDefinition.getTaskType()), TaskDefinitionDO::getTaskType,
            taskDefinition.getTaskType());
        queryWrapper.eq(StringUtils.isNotBlank(taskDefinition.getScheduleType()), TaskDefinitionDO::getScheduleType,
            taskDefinition.getScheduleType());
        queryWrapper.eq(StringUtils.isNotBlank(taskDefinition.getExecutorType()), TaskDefinitionDO::getExecutorType,
            taskDefinition.getExecutorType());
        queryWrapper.eq(StringUtils.isNotBlank(taskDefinition.getStatus()), TaskDefinitionDO::getStatus,
            taskDefinition.getStatus());
        queryWrapper.orderByDesc(TaskDefinitionDO::getCreateTime);
        return baseMapper.selectList(queryWrapper);
    }
}

