package com.hanming.oa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.model.ProjectDisplay;
import com.hanming.oa.service.ProjectService;

@Controller
@RequestMapping("/admin/project")
public class ProjectController {

	@Autowired
	ProjectService projectService;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "0") Integer pn,
			@RequestParam(value = "state", defaultValue = "项目状态") String state,
			@RequestParam(value = "projectName", defaultValue = "项目名称") String projectName,
			Model model) {

		PageInfo<ProjectDisplay> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<ProjectDisplay> list = projectService.list(state,projectName);
		pageInfo = new PageInfo<>(list);
		
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("state", state);
		model.addAttribute("projectName", projectName);
		
		return "projectManagement/project";
	}

}
