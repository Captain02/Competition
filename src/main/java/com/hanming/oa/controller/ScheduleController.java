package com.hanming.oa.controller;

import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.Event;
import com.hanming.oa.model.Schedule;
import com.hanming.oa.service.ScheduleService;

@Controller
@RequestMapping("/admin/schedule")
public class ScheduleController {

	@Autowired
	ScheduleService scheduleService;
	
	//遍历
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String list() {
		
		return "schedule/schedule";
	}
	
	//保存
	@ResponseBody
	@RequestMapping(value="/save",method=RequestMethod.POST)
	public Msg save(Schedule schedule) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		schedule.setUserID(userId);
		scheduleService.insert(schedule);
		return Msg.success();
	}
	
	//遍历
	@ResponseBody
	@RequestMapping(value="/scheduleds",method=RequestMethod.GET)
	public Msg scheduleds() {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		List<Event> events = scheduleService.list(userId);
		return Msg.success().add("schedules", events);
	}
	
}
