package com.hanming.oa.testService;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hanming.oa.dao.RoleResourceMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:/spring/spring-dao.xml" })
public class RoleResourceDaoTest {

	@Autowired
	RoleResourceMapper roleResourceMapper;
	
	@Test
	public void addRoleResource() {
		roleResourceMapper.addRoleResource(4, 2);
	}
	
}
