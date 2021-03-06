package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.Holiday;
import com.hanming.oa.model.HolidayAndExaminationTime;
import com.hanming.oa.model.UserHolidayByHolidayId;

public interface HolidayMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(Holiday record);

	int insertSelective(Holiday record);

	Holiday selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(Holiday record);

	int updateByPrimaryKey(Holiday record);

	List<Holiday> list();

	UserHolidayByHolidayId selectHolidayByHolidayId(Integer holidayId);

	Holiday selectHolidayByProcessInstanceId(String processInstanceId);

	List<Holiday> listLikeStateType(@Param("state") String state, @Param("type") String type);

	Holiday selectHolidayByProcessInstanceIdLikeStateType(@Param("processInstanceId") String processInstanceId, @Param("state") String state, @Param("type") String type);

	List<Holiday> selectCreatByMeLikeStateType(@Param("userId")Integer userId, @Param("state") String state, @Param("type") String type);

	List<HolidayAndExaminationTime> selectExaminationByMeLikeStateType(@Param("username")String username, @Param("state") String state, @Param("type") String type);

	List<HolidayAndExaminationTime> selectCompleteByMeLikeStateType(@Param("username")String username, @Param("state") String state, @Param("type") String type);

	List<Holiday> selectListHolidayByProcessInstanceId(List<String> listProcessinstanceid);

	void deleteHolidayByProcessInstanceId(List<String> processInstanceId);

	List<Holiday> listLikeTypeAndApproved(@Param("state")String state, @Param("type")String type);

}