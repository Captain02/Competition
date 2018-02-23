package com.hanming.oa.dao;

import java.util.List;

import com.hanming.oa.model.ProjectTeam;
import com.hanming.oa.model.User;

public interface ProjectTeamMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ProjectTeam record);

    int insertSelective(ProjectTeam record);

    ProjectTeam selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ProjectTeam record);

    int updateByPrimaryKey(ProjectTeam record);

	List<User> listByProjectId(Integer projectId);
}