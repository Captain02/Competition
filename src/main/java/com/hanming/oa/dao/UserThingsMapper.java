package com.hanming.oa.dao;

import com.hanming.oa.model.UserThings;

public interface UserThingsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserThings record);

    int insertSelective(UserThings record);

    UserThings selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserThings record);

    int updateByPrimaryKey(UserThings record);
}