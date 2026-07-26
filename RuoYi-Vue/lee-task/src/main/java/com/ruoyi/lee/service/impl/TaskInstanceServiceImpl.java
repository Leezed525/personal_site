package com.ruoyi.lee.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.lee.domain.dataobject.TaskInstanceDO;
import com.ruoyi.lee.mapper.TaskInstanceMapper;
import com.ruoyi.lee.service.ITaskInstanceService;
import java.util.List;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

/**
 * 任务实例 Service 实现。
 */
@Service
public class TaskInstanceServiceImpl extends ServiceImpl<TaskInstanceMapper, TaskInstanceDO>
    implements ITaskInstanceService {

    @Override
    public List<TaskInstanceDO> selectTaskInstanceList(TaskInstanceDO taskInstance) {
        LambdaQueryWrapper<TaskInstanceDO> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(StringUtils.isNotBlank(taskInstance.getDefinitionId()), TaskInstanceDO::getDefinitionId,
            taskInstance.getDefinitionId());
        queryWrapper.eq(StringUtils.isNotBlank(taskInstance.getTriggerType()), TaskInstanceDO::getTriggerType,
            taskInstance.getTriggerType());
        queryWrapper.eq(StringUtils.isNotBlank(taskInstance.getStatus()), TaskInstanceDO::getStatus,
            taskInstance.getStatus());
        queryWrapper.eq(StringUtils.isNotBlank(taskInstance.getTriggeredBy()), TaskInstanceDO::getTriggeredBy,
            taskInstance.getTriggeredBy());
        queryWrapper.orderByDesc(TaskInstanceDO::getCreateTime);
        return baseMapper.selectList(queryWrapper);
    }
}

