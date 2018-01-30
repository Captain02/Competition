package com.hanming.oa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hanming.oa.model.NoticeDisplay;
import com.hanming.oa.service.NoticeService;

@Controller
@RequestMapping("admin/notice")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	

	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String list(Model model) {
		
		
		List<NoticeDisplay> Notices = noticeService.list();
		model.addAttribute("Notices", Notices);
		
		return "notice/notice";
	}
}
