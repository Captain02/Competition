package com.hanming.oa.dao;

import com.hanming.oa.model.PersonHead;

public interface PersonHeadMapper {
    int insert(PersonHead record);

    int insertSelective(PersonHead record);
}