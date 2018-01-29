package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.BBSLabelTopic;
import com.hanming.oa.model.BBSTopic;

public interface BBSLabelTopicMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BBSLabelTopic record);

    int insertSelective(BBSLabelTopic record);

    BBSLabelTopic selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BBSLabelTopic record);

    int updateByPrimaryKey(BBSLabelTopic record);

	void insertLabelTopics(@Param("list")List<BBSLabelTopic> bbsLabelTopics);

	void deleteByTopicId(@Param("topicId") Integer topicId);

	void deleByTopicIdList(List<Integer> topicIds);

	List<BBSLabelTopic> getTopicListByLabelIds(List<Integer> bbsLabelIds);

	List<BBSLabelTopic> getBBSLabelTopicLabelId(Integer labelId);


}