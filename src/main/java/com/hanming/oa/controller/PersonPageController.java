package com.hanming.oa.controller;

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
import com.hanming.oa.model.User;
import com.hanming.oa.service.PersonHeadService;
import com.hanming.oa.service.UpDownFileService;
import com.hanming.oa.service.UserService;

@Controller
@RequestMapping("/admin/personPage")
public class PersonPageController {

	@Autowired
	UserService userService;
	@Autowired
	PersonHeadService personHeadService;
	@Autowired
	UpDownFileService upDownFileService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {
		String username = (String) SecurityUtils.getSubject().getSession().getAttribute("username");
		User user = userService.selectByUsername(username);

		model.addAttribute("user", user);
		return "personPage/personPage";
	}

	@RequestMapping(value = "/personHeadPage", method = RequestMethod.GET)
	public String personHeadPage() {

		return "personPage/personHead";
	}

	@ResponseBody
	@RequestMapping(value = "/upPersonHeadFile", method = RequestMethod.POST)
	public Msg upPersonHeadFile(@RequestParam(value = "imgData") String dataURL,
			@RequestParam(value = "oldImg", defaultValue = "") String oldImg, HttpServletRequest request) {
		// PersonHead personHead = new PersonHead();

		upDownFileService.upPersonHead(dataURL, request, "");
		if (!("".equals(oldImg))) {
			upDownFileService.upPersonHead(oldImg, request, "old");
		}

		// personHeadService.insertPersonHead();

		return Msg.success();
	}

}
