package com.redbyte.wigen;

import com.redbyte.wigen.core.domain.dto.Policy;
import com.redbyte.wigen.core.domain.dto.Result;
import lombok.extern.slf4j.Slf4j;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.kie.api.KieServices;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * Unit test for simple DroolsApp.
 */
@Slf4j
@SpringBootTest
public class AppTest {

    private KieContainer kieContainer;
    private Policy policy;

    @Before
    public void init() {
        KieServices kieServices = KieServices.Factory.get();
        kieContainer = kieServices.getKieClasspathContainer();

        policy = new Policy();
        policy.setSex("男");
        policy.setAge(16);
        policy.setUserSingle(true);
        System.out.println("决策请求: " + policy.toString());
    }

    @Test
    public void testDrools() {
        log.info("规则引擎 starting...");
        KieSession kieSession = kieContainer.newKieSession("all-rules"); // kmodule.xml 对应kieSession
        kieSession.insert(policy);
        Result result = new Result();
        kieSession.setGlobal("res", result);
        int count = kieSession.fireAllRules();
        log.info("规则引擎执行结束 end...");
        System.out.println("Fire rules: " + count);
        System.out.println("决策结果(Drools): " + result);

        kieSession.dispose();
    }
}
