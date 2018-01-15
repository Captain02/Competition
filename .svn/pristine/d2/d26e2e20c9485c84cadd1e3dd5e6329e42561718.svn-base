package com.hanming.oa.testService;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hanming.oa.dao.ResourceMapper;
import com.hanming.oa.model.Resource;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:/spring/spring-dao.xml" })
public class ResourceDaoTest {

	@Autowired
	ResourceMapper resourceMapper;
	
	@Test
	public void list() {
		List<Resource> list = resourceMapper.list();
		for (Resource resource : list) {
			System.out.println(resource.getId());
			System.out.println(resource.getName());
			System.out.println(resource.getColumn());
			System.out.println(resource.getPermission());
			System.out.println(resource.getUrl());
		}
	}
	
	@Test
	public void selectRoleByResourceId() {
		int i = resourceMapper.selectRoleByResourceId(1);
		System.out.println(i);
	}
}
