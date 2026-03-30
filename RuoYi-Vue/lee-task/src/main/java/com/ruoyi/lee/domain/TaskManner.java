package com.ruoyi.lee.domain;


import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum TaskManner {

    LOCAL(1, "本地执行"),
    NETWORK(2, "网络执行"),
    ;


    private final int code;
    private final String description;
}
