package com.hanming.oa.testService;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hanming.oa.dao.RoleMapper;
import com.hanming.oa.model.Resource;
import com.hanming.oa.model.Role;
import com.hanming.oa.model.RoleIdAndName;
import com.hanming.oa.model.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:/spring/spring-dao.xml" })
public class RoleDaoTest {

	@Autowired
	RoleMapper roleMapper;

	@Test
	public void list() {
		List<Role> list = roleMapper.list();
		for (Role role : list) {
			System.out.println(role.getName());
		}

	}

	@Test
	public void listLikeName() {
		List<Role> list = roleMapper.listLikeName("总");
		for (Role role : list) {
			System.out.println("----------------->" + role.getName());
		}
	}
	
	@Test
	public void selectUserByRoleId() {
		List<User> list = roleMapper.selectUserByRoleId(2);
		for (User user : list) {
			System.out.println(user.getName());
		}
	}
	
	@Test
	public void selectUserByRoleIdLikeName() {
		RoleIdAndName rin = new RoleIdAndName();
		rin.setId(1);
		rin.setName("s");
		List<User> list = roleMapper.selectUserByRoleIdLikeName(rin);
		for (User user : list) {
			System.out.println(user.getName());
		}
	}
	
	@Test
	public void selectUserCountByRoleId() {
		int i = roleMapper.selectUserCountByRoleId(1);
		System.out.println(i);
	}
	
	@Test
	public void roleHasResource() {
		List<Resource> list = roleMapper.RoleHasResource(1);
		for (Resource resource : list) {
			System.out.println(resource.getColumn());
		}
		
	}
}
