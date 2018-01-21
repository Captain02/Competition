package com.hanming.oa.controller;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hanming.oa.model.User;
import com.hanming.oa.service.UserService;

@Controller
@RequestMapping("/admin/personPage")
public class PersonPageController {
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {
		String username = (String) SecurityUtils.getSubject().getSession().getAttribute("username");
		User user = userService.selectByUsername(username);
		
		model.addAttribute("user", user);
		return "personPage/personPage";
	}
	
	@RequestMapping(value="/personPage",method=RequestMethod.GET)
	public String personHead() {
		
		return "personPage/personHead";
	}
}
