package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.DepartmentMapper;
import com.hanming.oa.model.Department;

@Service
public class DepartmentService {

	@Autowired
	DepartmentMapper departmentmapper;
	
	public int deleteByPrimaryKey(Integer id) {
		int i = departmentmapper.deleteByPrimaryKey(id);
		return i;
	}

	public int insert(Department record) {
		int i = departmentmapper.insert(record);
		return i;
	}

	public int insertSelective(Department record) {
		int i = departmentmapper.insertSelective(record);
		return i;
	}

	public Department selectByPrimaryKey(Integer id) {
		Department department = departmentmapper.selectByPrimaryKey(id);
		return department;
	}

	public int updateByPrimaryKeySelective(Department record) {
		int updateByPrimaryKeySelective = departmentmapper.updateByPrimaryKeySelective(record);
		return updateByPrimaryKeySelective;
	}

	public int updateByPrimaryKey(Department record) {
		int updateByPrimaryKey = departmentmapper.updateByPrimaryKey(record);
		return updateByPrimaryKey;
	}

	public List<Department> list() {
		List<Department> list = departmentmapper.list();
		return list;
	}

	public List<Department> listLikeName(String name) {
		List<Department> list = departmentmapper.listLikeName(name);
		return list;
	}

	public int selectUserBydepartmentId(Integer id) {
		int i = departmentmapper.selectUserBydepartmentId(id);
		return i;
	}

}
