package com.hanming.oa.dao;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.BBSLike;

public interface BBSLikeMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(BBSLike record);

	int insertSelective(BBSLike record);

	BBSLike selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(BBSLike record);

	int updateByPrimaryKey(BBSLike record);

	Integer selectCountLikeByUserIdAndTopicId(@Param("userId") Integer userId, @Param("topicId") Integer topicId);

	Integer deletByUserIdAndTopicId(@Param("userId") Integer userId, @Param("topicId") Integer topicId);

	void deleteByTopicId(@Param("topicId") Integer topicId);

	Integer countByToicpId(@Param("topicId") Integer topicId);
}