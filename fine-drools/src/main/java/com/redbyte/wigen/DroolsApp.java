package com.redbyte.wigen;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Hello world!
 */
@MapperScan("com.redbyte.wigen.core.dao")
@SpringBootApplication
public class DroolsApp {
    public static void main(String[] args) {
        SpringApplication.run(DroolsApp.class, args);
    }
}
