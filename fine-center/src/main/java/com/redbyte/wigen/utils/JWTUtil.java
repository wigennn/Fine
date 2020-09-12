package com.redbyte.wigen.utils;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.redbyte.wigen.common.JWTConstant;

import java.util.Date;

/**
 * @author wangwq
 */
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

    public String refreshToken(String userName) {
        return createToken(userName);
    }

    public static boolean verifyToken(String userName, String token) {
        try {
            JWTVerifier verifier = JWT.require(algorithm).withIssuer(userName).build();
            verifier.verify(token);
            return true;
        } catch (JWTVerificationException e) {
            e.printStackTrace();
            return false;
        }
    }
}
