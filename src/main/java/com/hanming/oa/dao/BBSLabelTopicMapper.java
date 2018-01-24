package com.hanming.oa.dao;

import com.hanming.oa.model.BBSLabelTopic;

public interface BBSLabelTopicMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BBSLabelTopic record);

    int insertSelective(BBSLabelTopic record);

    BBSLabelTopic selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BBSLabelTopic record);

    int updateByPrimaryKey(BBSLabelTopic record);
}