package com.redbyte.wigen;

import com.redbyte.wigen.core.domain.dto.Policy;
import com.redbyte.wigen.core.domain.dto.Result;
import org.kie.api.KieServices;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;

/**
 * <p>
 *
 * </p>
 *
 * @author wangwq
 */
public class DroolsTest {


    public static void main(String[] args) {
        KieServices kieServices = KieServices.Factory.get();
        KieContainer kieContainer = kieServices.getKieClasspathContainer();

        Policy policy = new Policy();
        policy.setSex("男");
        policy.setAge(16);
        policy.setUserSingle(false);
        System.out.println("决策请求: "+policy.toString());

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
