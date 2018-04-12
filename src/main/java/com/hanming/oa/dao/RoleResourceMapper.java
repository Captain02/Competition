package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.RoleResource;

public interface RoleResourceMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(RoleResource record);

    int insertSelective(RoleResource record);

    RoleResource selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(RoleResource record);

    int updateByPrimaryKey(RoleResource record);

	void deleteByRoleId(@Param("id")Integer id, @Param("resourceId")Integer resourceId);

	void addRoleResource(@Param("roleId") int roleId,@Param("resourceId") int resourceId);

	void addResourceListId(@Param("id")Integer id, @Param("collect")List<Integer> collect);

	void deleteAllByRoleId(@Param("id")Integer id);
}
