package com.hanming.oa.controller;

import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.model.Things;
import com.hanming.oa.service.ThingsService;

@Controller
@RequestMapping("/admin/things")
public class ThingsTaskController {
	private static final Logger logger = LoggerFactory.getLogger(ThingsTaskController.class);
	
	
	@Autowired
	ThingsService thingsService;
	
	//查询物品申请
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "state", defaultValue = "状态") String state,
			@RequestParam(value = "name", defaultValue = "") String name, Model model) {
		
		PageInfo<Things> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<Things> list = null;
		list = thingsService.listLikeStateType(state, name);
		pageInfo = new PageInfo<Things>(list, 5);

		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("state", state);
		model.addAttribute("purpose", name);
		logger.info(SecurityUtils.getSubject().getSession().getAttribute("username") + "=====查询物品申请");
		
		return "things/things";
	}
	
}
