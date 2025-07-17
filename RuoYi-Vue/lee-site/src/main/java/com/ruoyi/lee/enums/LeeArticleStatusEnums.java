package com.ruoyi.lee.enums;


public enum LeeArticleStatusEnums {

    HIDE(0L),
    PUBLISHED(1L),
    DELETED(-1L);

    private final Long status;


    LeeArticleStatusEnums(Long status) {
        this.status = status;
    }

    public Long getStatus() {
        return status;
    }
}


