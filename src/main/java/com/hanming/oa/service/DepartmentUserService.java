package com.hanming.oa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.DepartmentUserMapper;
import com.hanming.oa.model.DepartmentUser;

@Service
public class DepartmentUserService {

	@Autowired
	DepartmentUserMapper departmentUserMapper;
	
	public int deleteByPrimaryKey(Integer id) {
		int i = departmentUserMapper.deleteByPrimaryKey(id);
		return i;
	}

	public int insert(DepartmentUser record) {
		int i = departmentUserMapper.insert(record);
		return i;
	}

	public int insertSelective(DepartmentUser record) {
		int i = departmentUserMapper.insertSelective(record);
		return i;
	}

	public DepartmentUser selectByPrimaryKey(Integer id) {
		DepartmentUser departmentUser = departmentUserMapper.selectByPrimaryKey(id);
		return departmentUser;
	}

	public int updateByPrimaryKeySelective(DepartmentUser record) {
		int updateByPrimaryKeySelective = departmentUserMapper.updateByPrimaryKeySelective(record);
		return updateByPrimaryKeySelective;
	}

	public int updateByPrimaryKey(DepartmentUser record) {
		int i = departmentUserMapper.updateByPrimaryKey(record);
		return i;
	}

	public void updateByUserId(DepartmentUser departmentUser) {
		departmentUserMapper.updateByUserId(departmentUser);
	}

	public void deleteByUserId(Integer id) {
		departmentUserMapper.deleteByUserId(id);
	}

}
