package com.redbyte.wigen;

import com.redbyte.wigen.core.domain.dto.Policy;
import com.redbyte.wigen.core.domain.dto.Result;
import org.junit.Before;
import org.junit.Test;
import org.kie.api.KieServices;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;

/**
 * Unit test for simple DroolsApp.
 */
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
        policy.setUserSingle(false);
        System.out.println("决策请求: " + policy.toString());
    }

    @Test
    public void testDrools() {
        KieSession kieSession = kieContainer.newKieSession("all-rules"); // kmodule.xml 对应kieSession
        kieSession.insert(policy);
        Result result = new Result();
        kieSession.setGlobal("res", result);
        int count = kieSession.fireAllRules();

        System.out.println("Fire rules: " + count);
        System.out.println("决策结果(Drools): " + result);

        kieSession.dispose();

    }
}
