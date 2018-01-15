package com.hanming.oa.dao;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.RoleResource;

public interface RoleResourceMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(RoleResource record);

    int insertSelective(RoleResource record);

    RoleResource selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(RoleResource record);

    int updateByPrimaryKey(RoleResource record);

	void deleteByRoleId(Integer id);

	void addRoleResource(@Param("roleId") int roleId,@Param("resourceId") int resourceId);
}
