package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.BBSCollection;
import com.hanming.oa.model.MyCollectionDisplay;

public interface BBSCollectionMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(BBSCollection record);

	int insertSelective(BBSCollection record);

	BBSCollection selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(BBSCollection record);

	int updateByPrimaryKey(BBSCollection record);

	Integer selectCountCollectionByUserAndTopic(@Param("userId") Integer userId, @Param("topicId") Integer topicId);

	void deleCollectionByUserIdAndTopicId(@Param("userId") Integer userId, @Param("topicId") Integer topicId);

	void deleteByTopicId(@Param("topicId") Integer topicId);

	Integer countNumByTopic(@Param("topicId") Integer topicId);

	void deleByTopicIdList(List<Integer> bbsTopicIds);

	List<MyCollectionDisplay> listByMyId(@Param("name")String name, @Param("type")String type, @Param("userId")Integer userId);
}