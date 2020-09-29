package com.redbyte.wigen.controller;

import com.redbyte.wigen.common.HttpResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *
 * </p>
 *
 * @author wangwq
 */
@Slf4j
@RestController
public class WelcomeController {

    @RequestMapping("/welcome")
    public HttpResult welcome() {
        log.info("welcome test");
        return HttpResult.success("welcome");
    }
}
