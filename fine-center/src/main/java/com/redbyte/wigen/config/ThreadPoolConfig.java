package com.redbyte.wigen.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.ThreadPoolExecutor;

/**
 * <p>
 *
 * </p>
 *
 * @author wangwq
 */
@Configuration
public class ThreadPoolConfig {

    @Bean("threadPoolTaskExecutor")
    public ThreadPoolTaskExecutor threadPoolTaskExecutor() {
        ThreadPoolTaskExecutor poolTaskExecutor = new ThreadPoolTaskExecutor();
        poolTaskExecutor.setCorePoolSize(8);
        poolTaskExecutor.setMaxPoolSize(50);
        poolTaskExecutor.setKeepAliveSeconds(60);
        poolTaskExecutor.setQueueCapacity(1000);
        poolTaskExecutor.setTaskDecorator(new MdcDecorator()); // 异步线程使用同样添加MDC
        poolTaskExecutor.setRejectedExecutionHandler(new ThreadPoolExecutor.AbortPolicy());
        return poolTaskExecutor;
    }
}
