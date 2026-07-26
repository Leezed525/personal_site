package com.ruoyi.lee.core;

import org.quartz.spi.TriggerFiredBundle;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.scheduling.quartz.SpringBeanJobFactory;

public class AutowireCapableBeanJobFactory extends SpringBeanJobFactory {
    private final AutowireCapableBeanFactory beanJobFactory;

    public AutowireCapableBeanJobFactory(AutowireCapableBeanFactory beanJobFactory) {
        this.beanJobFactory = beanJobFactory;
    }

    @Override
    protected Object createJobInstance(TriggerFiredBundle bundle) throws Exception {
        Object job = super.createJobInstance(bundle);
        beanJobFactory.autowireBean(job);
        return job;
    }
}
