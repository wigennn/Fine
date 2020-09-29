package com.redbyte.wigen.common;

import org.slf4j.MDC;
import org.springframework.http.HttpStatus;

import java.util.HashMap;

/**
 * <p>
 *
 * </p>
 *
 * @author wangwq
 */
public class HttpResult extends HashMap<String, Object> {
    private static final long serialVersionUID = -3089064879040346342L;

    private static final String CODE_TAG = "code";
    private static final String MSG_TAG = "msg";
    private static final String DATA_TAG = "data";
    private static final String TRACE_TAG = "traceId";

    public HttpResult() {
        super.put(TRACE_TAG, MDC.get(TRACE_TAG));
    }

    public HttpResult(int code, String msg) {
        super.put(CODE_TAG, code);
        super.put(MSG_TAG, msg);
        super.put(TRACE_TAG, MDC.get(TRACE_TAG));
    }

    public HttpResult(int code, String msg, Object data) {
        super.put(CODE_TAG, code);
        super.put(MSG_TAG, msg);
        super.put(TRACE_TAG, MDC.get(TRACE_TAG));

        if (data != null) {
            super.put(DATA_TAG, data);
        }
    }

    public static HttpResult success(String msg) {
        return new HttpResult(HttpStatus.OK.value(), msg);
    }

    public static HttpResult success(Object data) {
        return new HttpResult(HttpStatus.OK.value(), null, data);
    }

    public static HttpResult error(String msg) {
        return new HttpResult(HttpStatus.INTERNAL_SERVER_ERROR.value(), msg);
    }

}
