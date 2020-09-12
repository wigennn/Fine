package com.redbyte.wigen.common;

/**
 * @author wangwq
 */
public interface JWTConstant {

    String TOKEN = "access_token";

    String SECRET = "secret";

    Integer EXPIRE_TIME = 1000 * 60 * 30; // 过期时间设置30分钟

    String USER_NAME = "user_name";
}
