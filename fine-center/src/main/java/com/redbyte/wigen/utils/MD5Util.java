package com.redbyte.wigen.utils;

import org.springframework.util.DigestUtils;

/**
 * @author wangwq
 */
public class MD5Util {

    public static String encrypt(String str) throws Exception {
        return DigestUtils.md5DigestAsHex(str.getBytes("utf-8"));
    }
}
