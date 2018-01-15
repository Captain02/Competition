package com.hanming.oa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.UserRoleMapper;
import com.hanming.oa.model.UserRole;

@Service
public class UserRoleService {

	@Autowired
	UserRoleMapper userRoleMapper;
	
	public int deleteByPrimaryKey(Integer id) {
		int i = userRoleMapper.deleteByPrimaryKey(id);
		return i;
	}

	public int insert(UserRole record) {
		int i = userRoleMapper.insert(record);
		return i;
	}

	public int insertSelective(UserRole record) {
		int i = userRoleMapper.insertSelective(record);
		return i;
	}
	
	public UserRole selectByPrimaryKey(Integer id) {
		UserRole userRole = userRoleMapper.selectByPrimaryKey(id);
		return userRole;
	}

	public int updateByPrimaryKeySelective(UserRole record) {
		int i = userRoleMapper.updateByPrimaryKeySelective(record);
		return i;
	}

	public int updateByPrimaryKey(UserRole record) {
		int i = userRoleMapper.updateByPrimaryKey(record);
		return i;
	}

	public void updateByUserId(UserRole userRole) {
		userRoleMapper.updateByUserId(userRole);
	}

	public void deleteByUserId(Integer id) {
		userRoleMapper.deleteByUserId(id);
	}

}
