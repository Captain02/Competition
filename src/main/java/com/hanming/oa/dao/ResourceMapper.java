package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.Resource;

public interface ResourceMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(Resource record);

	int insertSelective(Resource record);

	Resource selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(Resource record);

	int updateByPrimaryKey(Resource record);

	List<Resource> list();

	List<Resource> listLikeName(@Param("name") String name);

	int selectRoleByResourceId(Integer id);

	List<Resource> listByColumn(@Param("columnStr")String columnStr);

}