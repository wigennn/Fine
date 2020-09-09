package com.redbyte.wigen.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * <p>
 *
 * </p>
 *
 * @author wangwq
 */
@Data
@Configuration
@EnableConfigurationProperties(AppProperties.class)
@ConfigurationProperties(prefix = "app")
public class AppProperties {

    private String id;

    private String secret;
}
