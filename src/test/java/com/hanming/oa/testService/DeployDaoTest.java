package com.hanming.oa.testService;

import java.util.List;

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
	
	@Test
	public void selectProcessKey() {
		List<String> list = deployeMapper.selectProcessKey();
		System.out.println(list);
		
	}
	
	@Test
	public void selectNumByProcessDefinitionKey() {
		Integer integer = deployeMapper.selectNumByProcessDefinitionKey("helloword");
		System.out.println(integer);
	}
}
