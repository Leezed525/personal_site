package com.ruoyi.framework.myBatisPlus;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;
import com.ruoyi.common.utils.SecurityUtils;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.Date;

@Component
public class CustomMetaObjectHandler implements MetaObjectHandler {

    private static final String CREATE_BY = "createBy";
    private static final String UPDATE_BY = "updateBy";
    private static final String CREATE_TIME = "createTime";
    private static final String UPDATE_TIME = "updateTime";

    @Override
    public void insertFill(MetaObject metaObject) {
        //填充创建人
        this.setFieldValByName(CREATE_BY, SecurityUtils.getUsername(), metaObject);
        //填充创建时间
        this.setFieldValByName(CREATE_TIME, formatDate(metaObject.getSetterType(CREATE_TIME)), metaObject);
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        //填充更新人
        this.setFieldValByName(UPDATE_BY, SecurityUtils.getUsername(), metaObject);
        //填充更新时间
        this.setFieldValByName(UPDATE_TIME, formatDate(metaObject.getSetterType(UPDATE_TIME)), metaObject);
    }

    /**
     * 处理特殊日期
     *
     * @param setterType 参数类型
     * @return 日期类型
     */
    private Object formatDate(Class<?> setterType) {
        if (Date.class.equals(setterType)) {
            return new Date();
        } else if (LocalDateTime.class.equals(setterType)) {
            return LocalDateTime.now();
        } else if (Long.class.equals(setterType)) {
            return System.currentTimeMillis();
        }
        return null;
    }

}
