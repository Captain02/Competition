package com.hanming.oa.dao;

import com.hanming.oa.model.BBSCollection;

public interface BBSCollectionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BBSCollection record);

    int insertSelective(BBSCollection record);

    BBSCollection selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BBSCollection record);

    int updateByPrimaryKey(BBSCollection record);
}