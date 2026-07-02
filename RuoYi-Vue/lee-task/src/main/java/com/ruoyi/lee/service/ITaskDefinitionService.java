package com.ruoyi.lee.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.lee.domain.dataobject.TaskDefinitionDO;
import java.util.List;

/**
 * 任务定义 Service 接口。
 */
public interface ITaskDefinitionService extends IService<TaskDefinitionDO> {

    /**
     * 查询任务定义列表。
     *
     * @param taskDefinition 查询条件
     * @return 任务定义集合
     */
    List<TaskDefinitionDO> selectTaskDefinitionList(TaskDefinitionDO taskDefinition);
}

