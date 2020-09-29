package com.redbyte.wigen.common.exception;

/**
 * <p>
 * 自定义系统异常
 * </p>
 *
 * @author wangwq
 */
public class FineException extends Exception {
    private static final long serialVersionUID = 7700476302100397045L;

    public FineException() {
        super();
    }

    public FineException(String msg) {
        super(msg);
    }

    public FineException(String msg, Throwable cause) {
        super(msg, cause);
    }

    public FineException(Throwable cause) {
        super(cause);
    }
}
