package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.Things;

public interface ThingsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Things record);

    int insertSelective(Things record);

    Things selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Things record);

    int updateByPrimaryKey(Things record);
    
    List<Things> listLikeStateType(@Param("state") String state, @Param("name") String name);
}