package com.redbyte.wigen.controller;

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

        Cookie cookie = new Cookie("token", "yes");
        response.addCookie(cookie);
        return "login";
    }
}
