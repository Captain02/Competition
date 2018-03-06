package com.hanming.oa.dao;

import com.hanming.oa.model.Schedule;

public interface ScheduleMapper {
    int deleteByPrimaryKey(String id);

    int insert(Schedule record);

    int insertSelective(Schedule record);

    Schedule selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Schedule record);

    int updateByPrimaryKey(Schedule record);
}