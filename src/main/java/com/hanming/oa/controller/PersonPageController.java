package com.hanming.oa.controller;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.BBSDisplayTopic;
import com.hanming.oa.model.NoticeDisplay;
import com.hanming.oa.model.User;
import com.hanming.oa.service.BBSTopicService;
import com.hanming.oa.service.NoticeService;
import com.hanming.oa.service.UpDownFileService;
import com.hanming.oa.service.UserService;

@Controller
@RequestMapping("/admin/personPage")
public class PersonPageController {

	@Autowired
	UserService userService;
	@Autowired
	UpDownFileService upDownFileService;
	@Autowired
	NoticeService noticeService;
	@Autowired
	BBSTopicService bbsTopicService;

	// 跳转个人主页
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {

		// 个人信息
		String username = (String) SecurityUtils.getSubject().getSession().getAttribute("username");
		User user = userService.selectByUsername(username);

		// 公告信息
		List<NoticeDisplay> Notices = noticeService.list(0);
		Collections.reverse(Notices);
		if (Notices.size() > 2) {
			List<NoticeDisplay> reverseNotices = Notices.subList(0, 2);
			model.addAttribute("Notices", reverseNotices);
		}else {
			model.addAttribute("Notices", Notices);
		}
		
		// 知识
		List<BBSDisplayTopic> topics = bbsTopicService.selectDisplayTopic(0,0);
		Collections.reverse(topics);
		if (topics.size() > 2) {
			List<BBSDisplayTopic> reverseTopics = topics.subList(0, 2);
			model.addAttribute("topics", reverseTopics);
		}else {
			model.addAttribute("topics", topics);
		}
		

		model.addAttribute("user", user);
		return "personPage/personPage";
	}

	// 上传头像页面
	@RequestMapping(value = "/personHeadPage", method = RequestMethod.GET)
	public String personHeadPage() {

		return "personPage/personHead";
	}

	// 上传头像
	@ResponseBody
	@RequestMapping(value = "/upPersonHeadFile", method = RequestMethod.POST)
	public Msg upPersonHeadFile(@RequestParam(value = "imgData") String dataURL,
			@RequestParam(value = "oldImg", defaultValue = "") String oldImg, HttpServletRequest request) {
		// Integer userId = (Integer)
		// SecurityUtils.getSubject().getSession().getAttribute("id");

		upDownFileService.upPersonHead(dataURL, request, "");
		if (!("".equals(oldImg))) {
			upDownFileService.upPersonHead(oldImg, request, "old");
		}

		return Msg.success();
	}

}
