package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hanming.oa.Tool.Encryption;
import com.hanming.oa.dao.DepartmentMapper;
import com.hanming.oa.dao.DepartmentUserMapper;
import com.hanming.oa.dao.RoleMapper;
import com.hanming.oa.dao.UserMapper;
import com.hanming.oa.dao.UserRoleMapper;
import com.hanming.oa.model.DepartmentUser;
import com.hanming.oa.model.Role;
import com.hanming.oa.model.User;
import com.hanming.oa.model.UserRole;

@Service
public class UserService {

	@Autowired
	RoleMapper roleMapper;
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	RoleMapper rolemapper;
	@Autowired
	UserMapper userMapper;
	@Autowired
	DepartmentUserMapper departmentUserMapper;
	@Autowired
	UserRoleMapper userRoleMapper;

	public int deleteByPrimaryKey(Integer id) {
		int i = userMapper.deleteByPrimaryKey(id);
		return i;
	}

	public int insert(User record) {
		int i = userMapper.insert(record);
		return i;
	}

	public int insertSelective(User record) {
		int i = userMapper.insertSelective(record);
		return i;
	}

	public User selectByPrimaryKey(Integer id) {
		User user = userMapper.selectByPrimaryKey(id);
		return user;
	}

	public int updateByPrimaryKeySelective(User record) {
		int i = userMapper.updateByPrimaryKeySelective(record);
		return i;
	}

	public int updateByPrimaryKey(User record) {
		int i = userMapper.updateByPrimaryKey(record);
		return i;
	}

	public User selectByUsername(String username) {
		User user = userMapper.selectByUsername(username);
		return user;
	}

	public List<User> list() {
		List<User> list = userMapper.list();
		return list;
	}

	public int userCount() {
		int i = userMapper.userCount();
		return i;
	}

	public List<User> selectLikeUsername(String name) {
		List<User> list = userMapper.selectLikeUsername(name);
		return list;
	}

	public List<User> selectLikename(String name) {
		List<User> likename = userMapper.selectLikename(name);
		return likename;
	}

	public User selectByPrimaryKeyWithDeptAndRole(Integer id) {
		User user = userMapper.selectByPrimaryKeyWithDeptAndRole(id);
		return user;
	}

	// 保存用户功能
	@Transactional
	public Integer add(String departmentId, String roleId, User user) {
		// 采用md5盐值加密
		user.setPassword(Encryption.md5(user.getPassword(), user.getUsername()));

		// 设置角色和部门
		user.setDepartment(departmentMapper.selectByPrimaryKey(Integer.parseInt(departmentId)));
		user.setRole(rolemapper.selectByPrimaryKey(Integer.parseInt(roleId)));

		// 执行用户保存
		userMapper.insertSelective(user);
		System.out.println(user.getId());

		// 执行用户部门关联保存
		DepartmentUser departmentUser = new DepartmentUser(Integer.parseInt(departmentId), user.getId());
		departmentUserMapper.insertSelective(departmentUser);

		// 执行用户角色关联保存
		UserRole userRole = new UserRole(user.getId(), Integer.parseInt(roleId));
		userRoleMapper.insertSelective(userRole);

		return 1;
	}

	// 修改
	@Transactional
	public Integer Update(String departmentId, String roleId, User user) {
		userMapper.updateByPrimaryKeySelective(user);
		UserRole userrole = new UserRole(user.getId(), Integer.parseInt(roleId));
		DepartmentUser departmentUser = new DepartmentUser(Integer.parseInt(departmentId), user.getId());
		userRoleMapper.updateByUserId(userrole);
		departmentUserMapper.updateByUserId(departmentUser);
		return 1;
	}

	// 人员删除
	@Transactional
	public Integer dele(String userId) {
		// 删除人员
		userMapper.deleteByPrimaryKey(Integer.parseInt(userId));

		// 删除人员关联的角色
		userRoleMapper.deleteByUserId(Integer.parseInt(userId));

		// 删除人员关联的部门
		departmentUserMapper.deleteByUserId(Integer.parseInt(userId));

		return 1;
	}

	public List<String> selectAllResource(Integer userId) {
		List<String> resourcelist =	userMapper.selectAllResource(userId);
		return resourcelist;
	}

	public List<String> selectAllRole(Integer userId) {
		List<String> roleList =	userMapper.selectAllRole(userId);
		return roleList;
	}

	public Role selectRoleByUserId(Integer id) {
		Role role = userMapper.selectRoleByUserId(id);
		return role;
	}

	public List<User> listNotStaff() {
		List<User> list = userMapper.listNotStaff();
		return list;
	}


}
