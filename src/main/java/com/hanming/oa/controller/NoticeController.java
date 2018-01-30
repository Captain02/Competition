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
import com.hanming.oa.model.Notice;
import com.hanming.oa.model.NoticeDisplay;
import com.hanming.oa.service.NoticeService;

@Controller
@RequestMapping("admin/notice")
public class NoticeController {

	@Autowired
	NoticeService noticeService;

	// 公告列表
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {

		List<NoticeDisplay> Notices = noticeService.list();
		model.addAttribute("Notices", Notices);

		return "notice/notice";
	}

	// 跳转添加页
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addPage() {
		return "notice/add";
	}

	// 添加公告
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Msg add(Notice notice) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		notice.setUserid(userId);
		noticeService.insert(notice);
		return Msg.success();
	}
}
