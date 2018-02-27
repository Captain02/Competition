package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.BugDetailed;
import com.hanming.oa.model.BugDisplay;
import com.hanming.oa.model.ProjectBug;

public interface ProjectBugMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(ProjectBug record);

	int insertSelective(ProjectBug record);

	ProjectBug selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(ProjectBug record);

	int updateByPrimaryKey(ProjectBug record);

	List<BugDisplay> list(@Param("state") String state, @Param("name") String name, @Param("hrefPage") Integer hrefPage,
			@Param("projectId") Integer projectId,@Param("userId") Integer userId);

	BugDetailed detailedById(Integer id);
}