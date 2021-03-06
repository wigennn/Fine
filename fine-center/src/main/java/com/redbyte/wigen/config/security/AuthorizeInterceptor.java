package com.redbyte.wigen.config.security;

import com.redbyte.wigen.common.JWTConstant;
import org.slf4j.MDC;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;

/**
 * <p>
 * 认证拦截器
 * </p>
 *
 * @author wangwq
 */
public class AuthorizeInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request,HttpServletResponse response,
                             Object handler) throws Exception {

        Cookie[] cookies = request.getCookies();

        if (cookies == null) {
            unlogin(request, response);
            return false;
        }

        String token = null;
        String userName = null;
        for (Cookie cookie : cookies) {
            if (JWTConstant.TOKEN.equals(cookie.getName())) {
                token = cookie.getValue();
            }
            if (JWTConstant.USER_NAME.equals(cookie.getName())) {
                userName = cookie.getValue();
            }
        }

        if (StringUtils.isEmpty(token)) {
            unlogin(request, response);
            return false;
        }

        // 验证token正确性
        boolean bool = JWTUtil.verifyToken(userName, token, response);
        if (!bool) {
            unlogin(request, response);
            return false;
        }

        return true;
    }

    private void unlogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() + "/unlogin");
    }

}
