package com.hanming.oa.dao;

import com.hanming.oa.model.FriendHistoryTalk;

public interface FriendHistoryTalkMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(FriendHistoryTalk record);

    int insertSelective(FriendHistoryTalk record);

    FriendHistoryTalk selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(FriendHistoryTalk record);

    int updateByPrimaryKeyWithBLOBs(FriendHistoryTalk record);

    int updateByPrimaryKey(FriendHistoryTalk record);
}