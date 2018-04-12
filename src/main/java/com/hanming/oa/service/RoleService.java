package com.hanming.oa.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hanming.oa.dao.ResourceMapper;
import com.hanming.oa.dao.RoleMapper;
import com.hanming.oa.dao.RoleResourceMapper;
import com.hanming.oa.model.Resource;
import com.hanming.oa.model.Role;
import com.hanming.oa.model.RoleIdAndName;
import com.hanming.oa.model.User;

@Service
public class RoleService {
	@Autowired
	RoleMapper roleMapper;
	@Autowired
	RoleResourceMapper roleResourceMapper;
	@Autowired
	ResourceMapper resourceMapper;

	public int deleteByPrimaryKey(Integer id) {
		int i = roleMapper.deleteByPrimaryKey(id);
		return i;
	}

	public int insert(Role record) {
		int insert = roleMapper.insert(record);
		return insert;
	}

	@Transactional
	public int insertSelective(Role record) {
		int insertSelective = roleMapper.insertSelective(record);
		List<Resource> column = resourceMapper.listByColumn("默认权限");
		List<Integer> collect = column.stream()
				.map(Resource::getId)
				.collect(Collectors.toList());
		roleResourceMapper.addResourceListId(record.getId(),collect);
		return insertSelective;
	}

	public Role selectByPrimaryKey(Integer id) {
		Role role = roleMapper.selectByPrimaryKey(id);
		return role;
	}

	public int updateByPrimaryKeySelective(Role record) {
		int i = roleMapper.updateByPrimaryKeySelective(record);
		return i;
	}

	public int updateByPrimaryKey(Role record) {
		int i = roleMapper.updateByPrimaryKey(record);
		return i;
	}

	public List<Role> list() {
		List<Role> list = roleMapper.list();
		return list;
	}

	public List<Role> listLikeName(String name) {
		List<Role> list = roleMapper.listLikeName(name);
		return list;
	}

	public List<User> selectUserByRoleId(Integer id) {
		List<User> list = roleMapper.selectUserByRoleId(id);
		return list;
	}

	public List<User> selectUserByRoleIdLikeName(RoleIdAndName rin) {
		List<User> list = roleMapper.selectUserByRoleIdLikeName(rin);
		return list;
	}

	public int selectUserCountByRoleId(Integer id) {
		int i = roleMapper.selectUserCountByRoleId(id);
		return i;
	}

	// 职称的删除
	@Transactional
	public int dele(Integer id) {
		int count = roleMapper.selectUserCountByRoleId(id);
		if (count != 0) {
			return 0;
		} else {
			roleMapper.deleteByPrimaryKey(id);
			roleResourceMapper.deleteAllByRoleId(id);
			return 1;
		}
	}

	// 角色所用拥有的权限
	public List<Resource> selectRoleHasResource(Integer id) {
		List<Resource> list = roleMapper.RoleHasResource(id);
		return list;
	}

}
