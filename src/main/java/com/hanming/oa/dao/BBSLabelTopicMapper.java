package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.BBSLabelTopic;

public interface BBSLabelTopicMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BBSLabelTopic record);

    int insertSelective(BBSLabelTopic record);

    BBSLabelTopic selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BBSLabelTopic record);

    int updateByPrimaryKey(BBSLabelTopic record);

	void insertLabelTopics(@Param("list")List<BBSLabelTopic> bbsLabelTopics);


}