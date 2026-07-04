package com.ruoyi.lee.service;

import com.ruoyi.RuoYiApplication;
import com.ruoyi.common.utils.uuid.UUID;
import com.ruoyi.lee.domain.dataobject.TaskInstanceDO;
import com.ruoyi.lee.mapper.TaskInstanceMapper;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest(classes = RuoYiApplication.class)
@ActiveProfiles("local")
public class TaskInstanceServiceImplTest {


    @Autowired
    private TaskInstanceMapper taskInstanceMapper;


    @Test
    public void test() {
        TaskInstanceDO taskInstanceDO = new TaskInstanceDO();

        taskInstanceDO.setId(UUID.fastUUID().toString());

        taskInstanceDO.setDefinitionId("test");
        taskInstanceDO.setTriggerType("SCHEDULE");
        taskInstanceDO.setStatus("RUNNING");

        taskInstanceMapper.insert(taskInstanceDO);

    }

}



