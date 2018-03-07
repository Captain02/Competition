package com.hanming.oa.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hanming.oa.Tool.DateTool;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.Event;
import com.hanming.oa.model.Schedule;
import com.hanming.oa.service.ScheduleService;

@Controller
@RequestMapping("/admin/schedule")
public class ScheduleController {

	@Autowired
	ScheduleService scheduleService;

	// 遍历
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list() {

		return "schedule/schedule";
	}

	// 保存
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Msg save(Schedule schedule) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		schedule.setUserID(userId);
		scheduleService.insert(schedule);
		return Msg.success();
	}

	// 遍历
	@ResponseBody
	@RequestMapping(value = "/scheduleds", method = RequestMethod.GET)
	public Msg scheduleds() {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		List<Event> events = scheduleService.list(userId);
		return Msg.success().add("schedules", events);
	}

	// 改变天数
	@ResponseBody
	@RequestMapping(value = "/updateDay", method = RequestMethod.POST)
	public Msg updateDay(@RequestParam(value = "days", required = false) Integer days,
			@RequestParam(value = "start", required = false) String start,
			@RequestParam(value = "end", required = false) String end,
			@RequestParam(value = "id", required = false) Integer id) {
		System.out.println("++++++++++++++++++++++++++"+start);
		Schedule schedule = new Schedule();
		
		schedule.setStartTime(start);
		schedule.setEndTime(end);
		
		schedule.setId(id);
		scheduleService.update(schedule);
		
		return Msg.success();
	}

}
