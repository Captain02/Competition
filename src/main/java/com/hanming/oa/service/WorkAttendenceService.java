package com.hanming.oa.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
		Integer CountNumByMonthStatistics = workAttendanceMapper.selectCountNumByMonthStatistics(date);
		Long punishmentTime = (workAttendanceMapper.selectpunishmentTime(date) / 60000);

		WorkAttendenceByMonthStatistics workAttendenceByMonthStatistics = new WorkAttendenceByMonthStatistics();
		workAttendenceByMonthStatistics.setNormal(normalByMonthStatistics);
		workAttendenceByMonthStatistics.setLate(lateByMonthStatistics);
		workAttendenceByMonthStatistics.setLeave(leaveByMonthStatistics);
		workAttendenceByMonthStatistics.setOverTime(overTimeByMonthStatistics);
		Long hours = punishmentTime / 60;
		Long minutes = punishmentTime - hours * 60;
		String absenteeism = hours + " 小时 " + minutes + " 分钟";
		workAttendenceByMonthStatistics.setAbsenteeism(absenteeism);
		return workAttendenceByMonthStatistics;
	}

	public Integer selectCountByDate(String nowDate) {
		Integer nowDateStr = workAttendanceMapper.selectCountByDate(nowDate);
		return nowDateStr;
	}

	public void insert(WorkAttendance workAttendance) {
		workAttendanceMapper.insertSelective(workAttendance);
	}

	@Transactional
	public void addAttendence(WorkAttendance workAttendance, WorkAttendencePunishment WorkAttendencePunishment) {
		Integer countByDate = workAttendanceMapper.selectCountByDate(workAttendance.getDate());
		if (countByDate > 0) {
			workAttendanceMapper.updateByPrimaryKeySelective(workAttendance);
		} else {
			workAttendanceMapper.insertSelective(workAttendance);
		}
		workAttendencePunishmentMapper.insert(WorkAttendencePunishment);
	}

	@Transactional
	public void deleByids(String ids) {
		List<Integer> idsInt = null;
		if (ids.contains("-")) {
			String[] split = ids.split("-");
			List<String> idsStr = Arrays.asList(split);

			idsInt = idsStr.stream()
							.map((x) -> Integer.parseInt(x))
							.collect(Collectors.toList());
		}
		workAttendanceMapper.deleByIds(idsInt);
		workAttendencePunishmentMapper.deleteByWorkAttendanceIds(idsInt);
	}

}
