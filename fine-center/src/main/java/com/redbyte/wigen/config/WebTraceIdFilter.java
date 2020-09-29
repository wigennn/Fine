package com.redbyte.wigen.config;

import org.slf4j.MDC;
import org.springframework.context.annotation.Configuration;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;
import java.util.UUID;

/**
 * <p>
 *
 * </p>
 *
 * @author wangwq
 */
@Configuration
@WebFilter(urlPatterns = "/*")
public class WebTraceIdFilter extends GenericFilter {
    private static final long serialVersionUID = -1237682846155326049L;

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        try {
            MDC.put("traceId", UUID.randomUUID().toString().replaceAll("-", ""));
            filterChain.doFilter(servletRequest, servletResponse);
        } finally {
            MDC.remove("traceId");
        }

    }
}
