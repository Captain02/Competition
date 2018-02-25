package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.ProjectTeam;
import com.hanming.oa.model.UserByProjectId;

public interface ProjectTeamMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ProjectTeam record);

    int insertSelective(ProjectTeam record);

    ProjectTeam selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ProjectTeam record);

    int updateByPrimaryKey(ProjectTeam record);

	List<UserByProjectId> listByProjectId(@Param("projectId")Integer projectId,@Param("userName")String userName);
}