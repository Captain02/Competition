package com.hanming.oa.dao;

import com.hanming.oa.model.DateStandard;

public interface DateStandardMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(DateStandard record);

    int insertSelective(DateStandard record);

    DateStandard selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(DateStandard record);

    int updateByPrimaryKey(DateStandard record);
}