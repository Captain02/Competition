package com.hanming.oa.testService;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hanming.oa.dao.FriendsMapper;
import com.hanming.oa.model.Department;
import com.hanming.oa.model.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:/spring/spring-dao.xml"})
public class FriendsDaoTest {

	@Autowired
	FriendsMapper friendsMapper;
	
	@Test
	public void list() {
		List<User> list = friendsMapper.listByUserId(140);
		list.stream()
			.map(User::getDepartment)
			.map(Department::getName)
			.forEach(System.out::println);
		
	} 
}
