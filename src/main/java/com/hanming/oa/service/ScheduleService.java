package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.ScheduleMapper;
import com.hanming.oa.model.Event;
import com.hanming.oa.model.Schedule;

@Service
public class ScheduleService {
	
	@Autowired
	ScheduleMapper scheduleMapper;

	public void insert(Schedule schedule) {
		scheduleMapper.insertSelective(schedule);
	}

	public List<Event> list(Integer userId) {
		List<Event> lists = scheduleMapper.list(userId);
		return lists;
	}

	public void update(Schedule schedule) {
		scheduleMapper.updateByPrimaryKeySelective(schedule);
	}

	public void dele(Schedule schedule) {
		scheduleMapper.deleteByPrimaryKey(schedule.getId());
	}

}
