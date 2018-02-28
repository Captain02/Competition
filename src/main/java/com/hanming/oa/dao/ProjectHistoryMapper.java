package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.ProjectHistory;
import com.hanming.oa.model.ProjectHistoryDisplay;

public interface ProjectHistoryMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ProjectHistory record);

    int insertSelective(ProjectHistory record);

    ProjectHistory selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ProjectHistory record);

    int updateByPrimaryKey(ProjectHistory record);

	List<ProjectHistoryDisplay> listByTypeAndTypeId(@Param("id")Integer id, @Param("string")String string);
}