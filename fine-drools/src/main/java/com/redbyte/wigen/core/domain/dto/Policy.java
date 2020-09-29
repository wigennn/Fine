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
public class Policy {
    private String sex;            // 性别；男、女
    private Integer age;           // 年龄
    private Boolean userSingle;    // 单身；是/否
}
