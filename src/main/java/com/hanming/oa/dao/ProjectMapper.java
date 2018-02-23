package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.Project;
import com.hanming.oa.model.ProjectDisplay;

public interface ProjectMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Project record);

    int insertSelective(Project record);

    Project selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Project record);

    int updateByPrimaryKey(Project record);

	List<ProjectDisplay> list(@Param("state")String state, @Param("projectName")String projectName);

	void updateStateByProjectId(@Param("state")String state, @Param("projectId")Integer projectId);
}