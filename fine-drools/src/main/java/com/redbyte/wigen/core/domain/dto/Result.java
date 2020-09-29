package com.redbyte.wigen.core.domain.dto;

import lombok.Data;

/**
 * <p>
 *
 * </p>
 *
 * @author wangwq
 */
@Data
public class Result {
    private String code;
    private String info;

    public Result() {

    }

    public Result(String code, String info) {
        this.code = code;
        this.info = info;
    }

    public Result setResult(String code, String info) {
        this.setCode(code);
        this.setInfo(info);
        return this;
    }
}
