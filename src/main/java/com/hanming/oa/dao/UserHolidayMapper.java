package com.hanming.oa.dao;

import com.hanming.oa.model.UserHoliday;

public interface UserHolidayMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserHoliday record);

    int insertSelective(UserHoliday record);

    UserHoliday selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserHoliday record);

    int updateByPrimaryKey(UserHoliday record);
}