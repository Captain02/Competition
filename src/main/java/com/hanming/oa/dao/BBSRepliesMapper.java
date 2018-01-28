package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.BBSReplies;

public interface BBSRepliesMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BBSReplies record);

    int insertSelective(BBSReplies record);

    BBSReplies selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BBSReplies record);

    int updateByPrimaryKey(BBSReplies record);

	void deleteByTopicId(@Param("topicId")Integer topicId);

	void deleteByTopicIdList(List<Integer> topicIds);
}