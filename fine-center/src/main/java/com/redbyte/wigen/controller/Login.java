package com.redbyte.wigen.controller;

import com.redbyte.wigen.common.JWTConstant;
import com.redbyte.wigen.config.security.JWTUtil;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

/**
 * @author wangwq
 */
@RestController
public class Login {

    @RequestMapping("/login")
    public String login(HttpServletResponse response) {

        String userName = "wigen";
        String token = JWTUtil.createToken(userName);

        response.addCookie(new Cookie(JWTConstant.TOKEN, token));
        response.addCookie(new Cookie(JWTConstant.USER_NAME, userName));
        return "login success";
    }
}
