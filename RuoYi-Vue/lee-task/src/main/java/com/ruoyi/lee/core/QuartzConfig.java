package com.ruoyi.lee.core;

import org.quartz.Scheduler;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;

@Configuration
public class QuartzConfig {

    @Bean
    public AutowireCapableBeanJobFactory jobFactory(AutowireCapableBeanFactory beanFactory) {
        return new AutowireCapableBeanJobFactory(beanFactory);
    }

    @Bean
    public SchedulerFactoryBean schedulerFactoryBean(AutowireCapableBeanJobFactory jobFactory) {
        SchedulerFactoryBean schedulerFactory = new SchedulerFactoryBean();
        schedulerFactory.setJobFactory(jobFactory);
        return schedulerFactory;
    }

    @Bean
    public Scheduler scheduler(SchedulerFactoryBean schedulerFactoryBean) {
        return schedulerFactoryBean.getScheduler();
    }
}
