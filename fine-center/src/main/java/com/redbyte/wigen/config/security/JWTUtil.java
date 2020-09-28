package com.redbyte.wigen.config.security;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.redbyte.wigen.common.JWTConstant;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

/**
 * @author wangwq
 */
@Slf4j
public class JWTUtil {

    private static final Algorithm algorithm = Algorithm.HMAC256(JWTConstant.SECRET);

    public static String createToken(String userName) {
        Algorithm algorithm = Algorithm.HMAC256(JWTConstant.SECRET);
        String token = JWT.create()
                .withIssuer(userName)
                .withExpiresAt(new Date(System.currentTimeMillis() + JWTConstant.EXPIRE_TIME))
                .sign(algorithm);
        return token;
    }

    private static String refreshToken(String userName) {
        return createToken(userName);
    }

    public static boolean verifyToken(String userName, String token, HttpServletResponse response) {
        try {
            JWTVerifier verifier = JWT.require(algorithm).withIssuer(userName).build();
            verifier.verify(token);
            updateHttpResp(userName, refreshToken(userName), response);
            return true;
        } catch (JWTVerificationException e) {
            log.error("验证token失败, 登陆userName:{}, token:{}", userName, token);
            e.printStackTrace();
            return false;
        }
    }

    public static void updateHttpResp(String userName, String token, HttpServletResponse response) {
        response.addCookie(new Cookie(JWTConstant.TOKEN, token));
        response.addCookie(new Cookie(JWTConstant.USER_NAME, userName));
    }
}
