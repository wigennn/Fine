package com.redbyte.wigen.common;

/**
 * @author wangwq
 */
public interface JWTConstant {

    String TOKEN = "access_token";

    String SECRET = "a672078a4f9d4d189b7f6ff3542c0584";

    Integer EXPIRE_TIME = 1000 * 60 * 30; // 过期时间设置30分钟

    String USER_NAME = "user_name";
}
