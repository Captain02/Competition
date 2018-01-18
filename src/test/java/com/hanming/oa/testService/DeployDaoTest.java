package com.hanming.oa.testService;

import org.activiti.engine.impl.persistence.deploy.Deployer;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hanming.oa.dao.DeployeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:/spring/spring-dao.xml" })
public class DeployDaoTest {

	@Autowired
	DeployeMapper deployeMapper;
	
	@Test
	public void updataPersonNumberByDeployId() {
		deployeMapper.updataPersonNumberByDeployId("helloword:2:77504", 2);
	}
}
