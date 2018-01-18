package com.hanming.oa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin/myThingsTask")
public class MyThingsTaskController {
	
	@RequestMapping(value="/myThingsTask",method=RequestMethod.GET)
	public String myThingsTask(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "state", defaultValue = "状态") String state,
			@RequestParam(value = "type", defaultValue = "类型") String type,
			@RequestParam(value = "herfPage", defaultValue = "0") String herfPage, Model model){
		
		
		return "myThingsTask/myThingsTask";
	}

}
