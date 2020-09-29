package com.redbyte.wigen.controller;

import com.redbyte.wigen.common.HttpResult;
import com.redbyte.wigen.config.security.JWTUtil;
import com.redbyte.wigen.core.dao.UserMapper;
import com.redbyte.wigen.core.domain.dto.LoginUser;
import com.redbyte.wigen.core.domain.entity.User;
import com.redbyte.wigen.utils.MD5Util;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;

/**
 * @author wangwq
 */
@Slf4j
@RestController
public class LoginController {

    @Autowired
    private UserMapper userMapper;

    @RequestMapping("/login")
    public HttpResult login(@RequestBody LoginUser loginUser, HttpServletResponse response) throws Exception {

        String userName = loginUser.getUserName();
        loginUser.setPassword(MD5Util.encrypt(loginUser.getPassword()));
        int count = userMapper.verifyUser(loginUser);
        if (count > 0) {
            String token = JWTUtil.createToken(userName);
            JWTUtil.updateHttpResp(userName, token, response);
        } else {
            log.info("loginUser:{}", loginUser.toString());
            return HttpResult.success("登陆名用户密码错误");
        }
        return HttpResult.success("login success");
    }

    @RequestMapping("/register")
    public HttpResult register(@RequestBody User user) throws Exception {

        // 校验用户名是否存在
        int count = userMapper.isDuplicateUserName(user.getUserName());
        if (count > 0) {
            return HttpResult.success("用户名已存在");
        }

        // 注册
        String pwd = user.getPassword();
        user.setPassword(MD5Util.encrypt(pwd));
        userMapper.registerUser(user);
        return HttpResult.success("注册成功");
    }

    @RequestMapping("/unlogin")
    public HttpResult unlogin() {
        return HttpResult.success("unlogin");
    }
}
