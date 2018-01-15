package com.hanming.oa.testService;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hanming.oa.dao.UserMapper;
import com.hanming.oa.model.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:/spring/spring-dao.xml", })
public class UserDaoTest {

	@Autowired
	UserMapper userMapper;

	@Test
	public void selectByPrimaryKey() {
		User selectByPrimaryKey = userMapper.selectByPrimaryKey(1);
		System.out.println(selectByPrimaryKey);
	}

	@Test
	public void selectByUsername() {
		User selectByUsername = userMapper.selectByUsername("admin");
		System.out.println(selectByUsername);
	}

	@Test
	public void userList() {
		List<User> list = userMapper.list();
		for (User user : list) {
			System.out.println(user.getDepartment());
		}
	}

	@Test
	public void userCount() {
		int userCount = userMapper.userCount();
		System.out.println(userCount);
	}
	
	@Test
	public void selectLikeUsername() {
		String name = "lisi";
		List<User> list = userMapper.selectLikeUsername(name);
		for (User user : list) {
			System.out.println(user.getName());
			System.out.println(user.getDepartment().getName());
		}
	}
	
	@Test
	public void selectLikeName() {
		String name = "四";
		List<User> list = userMapper.selectLikename(name);
		for (User user : list) {
			System.out.println(user.getName());
		}
	}
	
	@Test
	public void selectByPrimaryKeyWithDeptAndRole() {
		System.out.println(userMapper.selectByPrimaryKeyWithDeptAndRole(2).getDepartment().getName());
	}
	
	@Test
	public void selectAllResource() {
		List<String> list = userMapper.selectAllResource(76);
		for (String string : list) {
			System.out.println("----------------------------"+string);
		}
	}
	
	@Test
	public void selectAllRole() {
		List<String> list = userMapper.selectAllRole(76);
		for (String string : list) {
			System.out.println("----------------------------"+string);
		}
	}
	
	@Test
	public void listNotStaff() {
		List<User> list = userMapper.listNotStaff();
		for (User user : list) {
			System.out.println(user.getRole().getName());
		}
	}
}
