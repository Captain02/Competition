package com.hanming.oa.controller;

import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.UserByProjectId;
import com.hanming.oa.service.ProjectTeamService;

@Controller
@RequestMapping("/admin/reportForms")
public class ReportFormController {
	@Autowired
	ProjectTeamService projectTeamService;

	// 跳转
	@RequestMapping(value = "/reportForm", method = RequestMethod.GET)
	public String list() {

		return "projectReportForm/reportForm";
	}

	@ResponseBody
	@RequestMapping(value = "/report", method = RequestMethod.GET)
	public Msg report(Model model,HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		
		List<UserByProjectId> users = projectTeamService.list(projectId, "姓名");
		System.out.println(users);
		
		Map<String, Long> map = users.stream()
			.map(UserByProjectId::getRoleName)
			.collect(Collectors.groupingBy(p -> p,Collectors.counting()));
		
		model.addAttribute("userName", map.keySet());
		model.addAttribute("userByGroupNum", map.values());
		return Msg.success().add("userName", map.keySet()).add("userByGroupNum", map.values());
	}
}
