package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.WorkAttendance;
import com.hanming.oa.model.WorkAttendenceByMonthStatistics;
import com.hanming.oa.model.WorkAttendenceDisplay;

public interface WorkAttendanceMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(WorkAttendance record);

	int insertSelective(WorkAttendance record);

	WorkAttendance selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(WorkAttendance record);

	int updateByPrimaryKey(WorkAttendance record);

	List<WorkAttendenceDisplay> list(@Param("date") String date, @Param("isByMyId") Integer isByMyId,
			@Param("userName") String userName);

	Integer selectNormalByMonthStatistics(@Param("date")String date, @Param("userId")Integer userId);

	Integer selectLateByMonthStatistics(@Param("date")String date, @Param("userId")Integer userId);

	Integer selectLeaveByMonthStatistics(@Param("date")String date, @Param("userId")Integer userId);

	Integer selectOverTimeByMonthStatistics(@Param("date")String date, @Param("userId")Integer userId);

	Long selectpunishmentTime(@Param("date")String date, @Param("userId")Integer userId);

	Integer selectCountByDate(@Param("nowDate") String nowDate, @Param("userId") Integer userId);

	List<WorkAttendance> selectByPrimaryKeys(List<Integer> idsInt);

	void deleByIds(List<Integer> idsInt);

	Integer selectCountNumByMonthStatistics(@Param("date")String date, @Param("userId")Integer userId);

	WorkAttendance selectByUserIdAndDate(@Param("userId")Integer userId, @Param("nowDate")String date);

	List<String> selectDateList(@Param("isByMyId")Integer isByMyId, @Param("userName")String userName);

	Long selectsumOverTime(@Param("date")String date, @Param("userId")Integer userId);

}