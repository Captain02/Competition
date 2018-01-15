package com.hanming.oa.testService;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hanming.oa.dao.DepartmentMapper;
import com.hanming.oa.model.Department;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:/spring/spring-dao.xml" })
public class DepartmentDaoTest {

	@Autowired
	DepartmentMapper departmentMapper;
	
	@Test
	public void list() {
		List<Department> list = departmentMapper.list();
		for (Department department : list) {
			System.out.println(department.getName());
		}
	}
	
	@Test
	public void listLikeName() {
		List<Department> list = departmentMapper.listLikeName("业");
		for (Department department : list) {
			System.out.println(department.getId());
			System.out.println(department.getName());
			System.out.println(department.getDescription());
			System.out.println(department.getAddress());
		}
	}
	
	@Test 
	public void selectUserBydepartmentId() {
		int id = departmentMapper.selectUserBydepartmentId(261);
		System.out.println("===============================>"+id);
	}
}
