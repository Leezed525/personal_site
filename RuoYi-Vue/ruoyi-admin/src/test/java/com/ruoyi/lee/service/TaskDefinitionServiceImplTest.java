package com.ruoyi.lee.service;

import com.ruoyi.RuoYiApplication;
import com.ruoyi.common.utils.uuid.UUID;
import com.ruoyi.lee.domain.dataobject.TaskDefinitionDO;
import com.ruoyi.lee.mapper.TaskDefinitionMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest(classes = RuoYiApplication.class)
@ActiveProfiles("local")
public class TaskDefinitionServiceImplTest {


    @Autowired
    private TaskDefinitionMapper taskDefinitionMapper;


    @Test
    public void testInsertTaskDefinition() {
        TaskDefinitionDO taskDefinitionDO = new TaskDefinitionDO();

        taskDefinitionDO.setId(UUID.fastUUID().toString());
        taskDefinitionDO.setName("test");

        taskDefinitionDO.setTaskType("REUSEABLE");

        taskDefinitionDO.setExecutorType("LocalScript");
        taskDefinitionDO.setExecutorConfig("{}");
        taskDefinitionDO.setStatus("ENABLED");


        taskDefinitionMapper.insert(taskDefinitionDO);
    }


}