package com.hanming.oa.controller;

import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.model.SystemMessageDisplay;
import com.hanming.oa.service.SystemMessageService;

@Controller
@RequestMapping("/admin/systemMessage")
public class SystemMessageController {
	
	@Autowired
	SystemMessageService systemMessageService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "state", defaultValue = "状态") String state,
			@RequestParam(value = "type", defaultValue = "类型") String type,
			@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			Model modle) {
		
		if ("知识".equals(state)) {
			state = "knowledge";
		}else if ("相册".equals(state)) {
			state = "myImage";
		}
		
		Integer myId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		PageInfo<SystemMessageDisplay> pageInfo = null;
		PageHelper.startPage(pn, 20);
		List<SystemMessageDisplay> list = systemMessageService.list(type,state,myId);
		pageInfo = new PageInfo<>(list, 5);
		
		modle.addAttribute("pageInfo", pageInfo);

		return "personPage/systemMessage";
	}
}
