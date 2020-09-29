package com.redbyte.wigen.config;

import org.slf4j.MDC;
import org.springframework.core.task.TaskDecorator;

import java.util.Map;

/**
 * <p>
 *
 * </p>
 *
 * @author wangwq
 */
public class MdcDecorator implements TaskDecorator {

    @Override
    public Runnable decorate(Runnable runnable) {
        Map<String, String> mdcContextMap = MDC.getCopyOfContextMap();
        return () -> {
            try {
                MDC.setContextMap(mdcContextMap);
                runnable.run();
            } finally {
                MDC.clear();
            }
        };
    }
}
