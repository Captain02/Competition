package com.hanming.oa.dao;

import com.hanming.oa.model.RequestAddFriend;

public interface RequestAddFriendMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(RequestAddFriend record);

    int insertSelective(RequestAddFriend record);

    RequestAddFriend selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(RequestAddFriend record);

    int updateByPrimaryKey(RequestAddFriend record);
}