package com.hanming.oa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.Schedule;
import com.hanming.oa.service.ScheduleService;

@Controller
@RequestMapping("/admin/schedule")
public class ScheduleController {

	@Autowired
	ScheduleService ScheduleService;
	
	//遍历
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String list() {
		
		return "schedule/schedule";
	}
	
	//保存
	@ResponseBody
	@RequestMapping(value="/save",method=RequestMethod.POST)
	public Msg save(Schedule schedule) {
		System.out.println(schedule);
		return Msg.success();
	}
	
}
