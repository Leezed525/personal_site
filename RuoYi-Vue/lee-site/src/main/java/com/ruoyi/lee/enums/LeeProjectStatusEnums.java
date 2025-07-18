package com.ruoyi.lee.enums;


/**
 * 项目状态枚举类
 */
public enum LeeProjectStatusEnums {

    /**
     * 计划状态
     */
    PLANNING(0),
    /**
     * 开发中状态
     */
    DEVELOPING(1),
    /**
     * 已完成状态
     */
    COMPLETED(2),
    ;


    private final long status;

    LeeProjectStatusEnums(int status) {
        this.status = status;
    }

    public long getStatus() {
        return status;
    }
}
