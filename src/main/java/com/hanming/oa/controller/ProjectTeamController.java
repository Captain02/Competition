package com.hanming.oa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.model.UserByProjectId;
import com.hanming.oa.service.ProjectTeamService;

@Controller
@RequestMapping("/admin/projectTeam")
public class ProjectTeamController {

	@Autowired
	ProjectTeamService projectTeamService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "0") Integer pn,
			@RequestParam(value = "userName", defaultValue = "姓名") String userName,
			HttpServletRequest request,Model model) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		
		PageInfo<UserByProjectId> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<UserByProjectId> list = projectTeamService.list(projectId,userName);
		pageInfo = new PageInfo<>(list);
		
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("userName", userName);
		
		return "projectTeam/team";
	}
}
