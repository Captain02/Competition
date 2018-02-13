package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.Friends;
import com.hanming.oa.model.User;

public interface FriendsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Friends record);

    int insertSelective(Friends record);

    Friends selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Friends record);

    int updateByPrimaryKey(Friends record);

	List<User> listByUserId(Integer userId);

	Integer countByFreindIdAndMyId(@Param("friendId")Integer friendId, @Param("userId")Integer userId);

	void deleByMyIdAndFriendId(@Param("fromUserId")Integer fromUserId, @Param("friendId")Integer friendId);
}