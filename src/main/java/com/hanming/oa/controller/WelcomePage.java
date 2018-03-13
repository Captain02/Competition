package com.hanming.oa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin/welcome")
public class WelcomePage {

	@RequestMapping(value="/weclomeApproval",method=RequestMethod.GET)
	public String approva() {
		
		return "weclomeApproval";
	}
	
	@RequestMapping(value="/organization",method=RequestMethod.GET)
	public String organization() {
		
		return "weclomeOrganization";
	}
}
