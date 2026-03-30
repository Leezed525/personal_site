package com.ruoyi.lee.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum TaskStepManner {

    EMAIL(1, "邮件"),
    NETWORK(2, "网络请求"),
    COMMAND(3, "命令行"),
    DATABASE(4, "数据库操作")
    ;


    private final int code;
    private final String description;

}
