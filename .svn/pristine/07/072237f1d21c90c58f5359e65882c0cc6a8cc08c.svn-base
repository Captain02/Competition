package com.hanming.oa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.RoleResourceMapper;
import com.hanming.oa.model.RoleResource;

@Service
public class RoleResourceService {

	@Autowired
	RoleResourceMapper roleResourceMapper;
	
	public int deleteByPrimaryKey(Integer id) {
		int i = roleResourceMapper.deleteByPrimaryKey(id);
		return i;
	}

	public int insert(RoleResource record) {
		int i = roleResourceMapper.insert(record);
		return i;
	}

	public int insertSelective(RoleResource record) {
		int i = roleResourceMapper.insertSelective(record);
		return i;
	}

	public RoleResource selectByPrimaryKey(Integer id) {
		RoleResource resource = roleResourceMapper.selectByPrimaryKey(id);
		return resource;
	}

	public int updateByPrimaryKeySelective(RoleResource record) {
		int i = roleResourceMapper.updateByPrimaryKeySelective(record);
		return i;
	}

	public int updateByPrimaryKey(RoleResource record) {
		int i = roleResourceMapper.updateByPrimaryKey(record);
		return i;
	}

	public void deleteByRoleId(int parseInt) {
		roleResourceMapper.deleteByRoleId(parseInt);
	}

	public void addRoleResource(Integer roleId, Integer resourceId) {
		roleResourceMapper.addRoleResource(roleId,resourceId);
	}

}
