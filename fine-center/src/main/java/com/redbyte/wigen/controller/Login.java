package com.redbyte.wigen.controller;

import com.redbyte.wigen.common.JWTConstant;
import com.redbyte.wigen.utils.JWTUtil;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author wangwq
 */
@RestController
public class Login {

    @RequestMapping("/login")
    public String login(HttpServletRequest request, HttpServletResponse response) {

        String token = JWTUtil.createToken("wigen");
        Cookie cookie = new Cookie(JWTConstant.TOKEN, token);
        Cookie cookie1 = new Cookie(JWTConstant.USER_NAME, "wigen");

        response.addCookie(cookie);
        response.addCookie(cookie1);
        return "login success";
    }
}
