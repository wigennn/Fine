package com.redbyte.wigen.controller;

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
        Cookie cookie = new Cookie("token", token);
        response.addCookie(cookie);
        return "login success";
    }
}
