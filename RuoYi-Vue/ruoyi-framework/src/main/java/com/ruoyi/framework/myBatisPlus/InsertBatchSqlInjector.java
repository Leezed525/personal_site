package com.ruoyi.framework.myBatisPlus;

import com.baomidou.mybatisplus.core.injector.AbstractMethod;
import com.baomidou.mybatisplus.core.injector.DefaultSqlInjector;
import com.baomidou.mybatisplus.extension.injector.methods.InsertBatchSomeColumn;

import java.util.List;

//为mybatis plus 配置批量插入
public class InsertBatchSqlInjector extends DefaultSqlInjector {
    public List<AbstractMethod> getMethodList(Class<?> mapperClass) {
        List<AbstractMethod> methodList = super.getMethodList(mapperClass);
        methodList.add(new InsertBatchSomeColumn());//添加InsertBatch方法
        return methodList;
    }

}
