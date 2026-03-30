package com.ruoyi.lee.domain;


import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum TaskType {

    DISPOSABLE(1, "一次性任务"),
    REPEATED(2, "重复性任务");


    private final int code;
    private final String description;
}
