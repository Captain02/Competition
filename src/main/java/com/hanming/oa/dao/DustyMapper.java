package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.Dusty;
import com.hanming.oa.model.DustyDetailed;
import com.hanming.oa.model.DustyDisplay;

public interface DustyMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(Dusty record);

	int insertSelective(Dusty record);

	Dusty selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(Dusty record);

	int updateByPrimaryKey(Dusty record);

	List<DustyDisplay> list(@Param("type") String type, @Param("state") String state,
			@Param("dustyName") String dustyName, @Param("herfPage") Integer herfPage,
			@Param("projectId") Integer projectId, @Param("userId") Integer userId);

	DustyDetailed detailedById(Integer id);

}