package com.hanming.oa.dao;

import java.util.List;

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
}