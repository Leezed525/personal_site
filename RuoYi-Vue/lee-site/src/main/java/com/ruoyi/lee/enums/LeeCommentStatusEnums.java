package com.ruoyi.lee.enums;

public enum LeeCommentStatusEnums {
    //审核中
    IN_REVIEW(0L),

    //公开
    PUBLISHED(1L),

    //审核失败
    AUDIT_FAILED(2L),
    ;

    private final Long status;

    LeeCommentStatusEnums(Long status) {
        this.status = status;
    }

    public Long getStatus() {
        return status;
    }

}
