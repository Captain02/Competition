package com.hanming.oa.dao;

import java.util.List;

import com.hanming.oa.model.Resource;
import com.hanming.oa.model.Role;
import com.hanming.oa.model.RoleIdAndName;
import com.hanming.oa.model.User;

public interface RoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);

	List<Role> list();

	List<Role> listLikeName(String name);

	List<User> selectUserByRoleId(Integer id);

	List<User> selectUserByRoleIdLikeName(RoleIdAndName rin);

	int selectUserCountByRoleId(Integer id);

	List<Resource> RoleHasResource(Integer id);
}