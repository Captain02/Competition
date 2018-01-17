package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.Things;
import com.hanming.oa.model.UserThings;

public interface UserThingsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserThings record);

    int insertSelective(UserThings record);

    UserThings selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserThings record);

    int updateByPrimaryKey(UserThings record);
    
    List<Things> listLikeStateType(@Param("state") String state, @Param("name") String name);
}