package com.hanming.oa.dao;

import com.hanming.oa.model.ProjectTeam;

public interface ProjectTeamMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ProjectTeam record);

    int insertSelective(ProjectTeam record);

    ProjectTeam selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ProjectTeam record);

    int updateByPrimaryKey(ProjectTeam record);
}