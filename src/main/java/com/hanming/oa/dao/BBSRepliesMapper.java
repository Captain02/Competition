package com.hanming.oa.dao;

import com.hanming.oa.model.BBSReplies;

public interface BBSRepliesMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BBSReplies record);

    int insertSelective(BBSReplies record);

    BBSReplies selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BBSReplies record);

    int updateByPrimaryKey(BBSReplies record);
}