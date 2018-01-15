package com.hanming.oa.dao;

import java.util.List;

import com.hanming.oa.model.Department;

public interface DepartmentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Department record);

    int insertSelective(Department record);

    Department selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Department record);

    int updateByPrimaryKey(Department record);

	List<Department> list();
	
	List<Department> listLikeName(String name);

	int selectUserBydepartmentId(Integer id);

}