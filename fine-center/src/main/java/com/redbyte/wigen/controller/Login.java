package com.redbyte.wigen.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author wangwq
 */
@RestController
public class Login {

    @RequestMapping("/login")
    public String login() {
        return "login";
    }
}
