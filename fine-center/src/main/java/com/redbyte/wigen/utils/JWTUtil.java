package com.redbyte.wigen.utils;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;

/**
 * @author wangwq
 */
public class JWTUtil {

    private static final String SECRET = "secret";

    private static final Integer EXPIRE_TIME = 1000 * 60 * 30;

    private static final Algorithm algorithm = Algorithm.HMAC256(SECRET);

    public static String createToken(String userName) {
        Algorithm algorithm = Algorithm.HMAC256(SECRET);
        String token = JWT.create()
                .withIssuer(userName)
                .sign(algorithm);
        return token;
    }

    public String refreshToken(String userName, String token) {

        return "";
    }

    public static boolean verifyToken(String userName, String token) {
        try {
            JWTVerifier verifier = JWT.require(algorithm).withIssuer(userName).build();
            DecodedJWT decodedJWT = verifier.verify(token);
            return true;
        } catch (JWTVerificationException e) {
            e.printStackTrace();
            return false;
        }
    }
}
