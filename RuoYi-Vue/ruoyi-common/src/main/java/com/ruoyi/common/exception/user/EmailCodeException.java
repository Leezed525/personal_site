package com.ruoyi.common.exception.user;

public class EmailCodeException extends UserException {
    private static final long serialVersionUID = 1L;

    public EmailCodeException() {
        super("user.emailCode.error", null);
    }
}
