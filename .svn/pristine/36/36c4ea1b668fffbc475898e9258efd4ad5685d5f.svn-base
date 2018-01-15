package com.hanming.oa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.DepartmentRoleMapper;
import com.hanming.oa.model.DepartmentRole;

@Service
public class DepartmentRoleService {

	@Autowired
	DepartmentRoleMapper departmentRoleMapper;
	
	public int deleteByPrimaryKey(Integer id) {
		int i = departmentRoleMapper.deleteByPrimaryKey(id);
		return i;
	}

	public int insert(DepartmentRole record) {
		int i = departmentRoleMapper.insert(record);
		return i;
	}

	public int insertSelective(DepartmentRole record) {
		int i = departmentRoleMapper.insertSelective(record);
		return i;
	}

	public DepartmentRole selectByPrimaryKey(Integer id) {
		DepartmentRole departmentRole = departmentRoleMapper.selectByPrimaryKey(id);
		return departmentRole;
	}

	public int updateByPrimaryKeySelective(DepartmentRole record) {
		int i = departmentRoleMapper.updateByPrimaryKeySelective(record);
		return i;
	}

	public int updateByPrimaryKey(DepartmentRole record) {
		departmentRoleMapper.updateByPrimaryKey(record);
		return 0;
	}

}
