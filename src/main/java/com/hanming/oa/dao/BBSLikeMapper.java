package com.hanming.oa.dao;

import com.hanming.oa.model.BBSLike;

public interface BBSLikeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BBSLike record);

    int insertSelective(BBSLike record);

    BBSLike selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BBSLike record);

    int updateByPrimaryKey(BBSLike record);
}