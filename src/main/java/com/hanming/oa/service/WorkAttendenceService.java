package com.hanming.oa.service;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hanming.oa.Tool.DateTool;
import com.hanming.oa.dao.WorkAttendanceMapper;
import com.hanming.oa.dao.WorkAttendencePunishmentMapper;
import com.hanming.oa.model.WorkAttendance;
import com.hanming.oa.model.WorkAttendenceByMonthStatistics;
import com.hanming.oa.model.WorkAttendenceDisplay;
import com.hanming.oa.model.WorkAttendencePunishment;

@Service
public class WorkAttendenceService {

	@Autowired
	WorkAttendanceMapper workAttendanceMapper;
	@Autowired
	WorkAttendencePunishmentMapper workAttendencePunishmentMapper;

	public List<WorkAttendenceDisplay> list(String date, Integer isByMyId, String userName) {
		List<WorkAttendenceDisplay> list = workAttendanceMapper.list(date, isByMyId, userName);
		return list;
	}

	public WorkAttendenceByMonthStatistics getWorkAttendenceByMonthStatistics(String date) {
		Integer normalByMonthStatistics = workAttendanceMapper.selectNormalByMonthStatistics(date);
		Integer lateByMonthStatistics = workAttendanceMapper.selectLateByMonthStatistics(date);
		Integer leaveByMonthStatistics = workAttendanceMapper.selectLeaveByMonthStatistics(date);
		Integer overTimeByMonthStatistics = workAttendanceMapper.selectOverTimeByMonthStatistics(date);
		Integer CountNumByMonthStatistics = workAttendencePunishmentMapper.selectCountNumByMonthStatistics(date);
		Integer CountDaysByMonthStatistics = workAttendanceMapper.selectCountNumByMonthStatistics(date);
		Long punishmentTime = workAttendanceMapper.selectpunishmentTime(date);
		Long sumOverTime = workAttendanceMapper.selectsumOverTime(date);

		WorkAttendenceByMonthStatistics workAttendenceByMonthStatistics = new WorkAttendenceByMonthStatistics();
		workAttendenceByMonthStatistics.setNormal(normalByMonthStatistics);
		workAttendenceByMonthStatistics.setLate(lateByMonthStatistics);
		workAttendenceByMonthStatistics.setLeave(leaveByMonthStatistics);
		workAttendenceByMonthStatistics.setOverTime(overTimeByMonthStatistics);
		workAttendenceByMonthStatistics.setCountNum(CountNumByMonthStatistics);
		workAttendenceByMonthStatistics.setCountDays(CountDaysByMonthStatistics);
		workAttendenceByMonthStatistics.setAbsenteeism(DateTool.calculation(punishmentTime));
		workAttendenceByMonthStatistics.setSumOverTime(DateTool.calculation(sumOverTime));
		return workAttendenceByMonthStatistics;
	}

	public Integer selectCountByDate(String nowDate, Integer userId) {
		Integer nowDateStr = workAttendanceMapper.selectCountByDate(nowDate, userId);
		return nowDateStr;
	}

	public void insert(WorkAttendance workAttendance) {
		workAttendanceMapper.insertSelective(workAttendance);
	}

	@Transactional
	public int addAttendence(WorkAttendance workAttendance, WorkAttendencePunishment WorkAttendencePunishment) {
		Integer countByDate = workAttendanceMapper.selectCountByDate(workAttendance.getDate(),
				workAttendance.getUserid());
		Integer attendenceNum = -1;
		if (countByDate > 0) {
			attendenceNum = workAttendencePunishmentMapper.selectByWorkAttendanceId(workAttendance.getId());
			if (attendenceNum >= 2) {
				return 0;
			}
			workAttendanceMapper.updateByPrimaryKeySelective(workAttendance);
		} else {
			workAttendanceMapper.insertSelective(workAttendance);
		}
		WorkAttendencePunishment.setWorkattendenceid(workAttendance.getId());

		if (attendenceNum >= 2) {
			return 0;
		}
		workAttendencePunishmentMapper.insert(WorkAttendencePunishment);
		return 1;
	}

	@Transactional
	public void deleByids(String ids) {
		List<Integer> idsInt = null;
			String[] split = ids.split("-");
			List<String> idsStr = Arrays.asList(split);
			

			idsInt = idsStr.stream()
							.map((x) -> Integer.parseInt(x))
							.collect(Collectors.toList());
		workAttendanceMapper.deleByIds(idsInt);
		workAttendencePunishmentMapper.deleteByWorkAttendanceIds(idsInt);
	}

	public WorkAttendance selectByUserIdAndDate(Integer userId, String date) {
		WorkAttendance selectByUserIdAndDate = workAttendanceMapper.selectByUserIdAndDate(userId, date);
		return selectByUserIdAndDate;
	}

	public List<String> selectDateList(Integer isByMyId, String userName) {
		List<String> dateList = workAttendanceMapper.selectDateList(isByMyId,userName);
		return dateList;
	}

}
