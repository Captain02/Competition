package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.FriendHistoryTalk;
import com.hanming.oa.model.Message;

public interface FriendHistoryTalkMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(FriendHistoryTalk record);

    int insertSelective(FriendHistoryTalk record);

    FriendHistoryTalk selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(FriendHistoryTalk record);

    int updateByPrimaryKeyWithBLOBs(FriendHistoryTalk record);

    int updateByPrimaryKey(FriendHistoryTalk record);

	List<Message> list(@Param("fromUserId")Integer fromUserId, @Param("friendId")Integer friendId);

	void deleByMyIdAndFriendId(@Param("fromUserId")Integer fromUserId, @Param("friendId")Integer friendId);
	
}