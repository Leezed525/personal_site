package com.ruoyi.lee.enums;

public enum LeeArticleRootEnum {
    ROOT("1", "根留言"),
    NOT_ROOT("0", "非根留言");

    private final String root;
    private final String description;

    LeeArticleRootEnum(String root, String description) {
        this.root = root;
        this.description = description;
    }

    public String getRoot() {
        return root;
    }

    public String getDescription() {
        return description;
    }
}
