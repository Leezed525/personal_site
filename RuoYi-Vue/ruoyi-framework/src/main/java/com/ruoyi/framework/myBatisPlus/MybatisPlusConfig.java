package com.ruoyi.framework.myBatisPlus;

import com.baomidou.mybatisplus.core.config.GlobalConfig;
import com.baomidou.mybatisplus.core.injector.ISqlInjector;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

@Configuration
public class MybatisPlusConfig {

    @Bean
    public InsertBatchSqlInjector easySqlInjector() {
        return new InsertBatchSqlInjector();
    }

    @Bean
    public GlobalConfig globalConfig(@Qualifier("easySqlInjector") ISqlInjector easySqlInjector) {
        GlobalConfig globalConfig = new GlobalConfig();
        globalConfig.setSqlInjector(easySqlInjector);
        return globalConfig;
    }
}
