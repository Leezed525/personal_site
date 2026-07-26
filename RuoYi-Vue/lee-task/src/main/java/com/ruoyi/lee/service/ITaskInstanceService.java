package com.ruoyi.lee.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.lee.domain.dataobject.TaskInstanceDO;
import java.util.List;

/**
 * 任务实例 Service 接口。
 */
public interface ITaskInstanceService extends IService<TaskInstanceDO> {

    /**
     * 查询任务实例列表。
     *
     * @param taskInstance 查询条件
     * @return 任务实例集合
     */
    List<TaskInstanceDO> selectTaskInstanceList(TaskInstanceDO taskInstance);
}

