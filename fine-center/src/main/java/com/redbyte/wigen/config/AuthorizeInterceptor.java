package com.redbyte.wigen.config;

import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * <p>
 * 认证拦截器
 * </p>
 *
 * @author wangwq
 */
public class AuthorizeInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        Cookie[] cookies = request.getCookies();

        String token = "";
        for (Cookie cookie : cookies) {
            if ("token".equals(cookie.getName())) {
                token = cookie.getValue();
            }
        }

        if (StringUtils.isEmpty(token)) {
            unlogin(request, response);
            return false;
        }

        // 验证token正确性

        return true;
    }

    private void unlogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() + "/login");
    }

}
