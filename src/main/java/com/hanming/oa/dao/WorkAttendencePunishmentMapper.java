package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.WorkAttendencePunishment;

public interface WorkAttendencePunishmentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(WorkAttendencePunishment record);

    int insertSelective(WorkAttendencePunishment record);

    WorkAttendencePunishment selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(WorkAttendencePunishment record);

    int updateByPrimaryKey(WorkAttendencePunishment record);

	void deleteByWorkAttendanceIds(List<Integer> idsInt);

	Integer selectByWorkAttendanceId(Integer id);

	Integer selectCountNumByMonthStatistics(@Param("date")String date, @Param("userId")Integer userId);
}