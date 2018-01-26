package com.hanming.oa.dao;

import java.util.List;

import com.hanming.oa.model.BBSLabel;

public interface BBSLabelMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BBSLabel record);

    int insertSelective(BBSLabel record);

    BBSLabel selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BBSLabel record);

    int updateByPrimaryKey(BBSLabel record);

	List<BBSLabel> list();
}