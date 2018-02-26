package com.hanming.oa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.model.DemandDisplay;
import com.hanming.oa.model.DustyDetailed;
import com.hanming.oa.model.DustyDisplay;
import com.hanming.oa.model.User;
import com.hanming.oa.model.UserByProjectId;
import com.hanming.oa.service.DemandService;
import com.hanming.oa.service.DustyService;
import com.hanming.oa.service.ProjectTeamService;
import com.hanming.oa.service.UserService;

@Controller
@RequestMapping("/admin/dusty")
public class DustyController {

	@Autowired
	DemandService demandService;
	@Autowired
	DustyService dustyService;
	@Autowired
	UserService userService;
	@Autowired
	ProjectTeamService projectTeamService;
	
	//遍历
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "0") Integer pn,
			@RequestParam(value = "type", defaultValue = "任务类型") String type,
			@RequestParam(value = "state", defaultValue = "任务状态") String state,
			@RequestParam(value = "dustyName", defaultValue = "任务名称") String dustyName,
			@RequestParam(value = "herfPage", defaultValue = "0")Integer herfPage,
			Model model,HttpServletRequest request) {
		
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		
		PageInfo<DustyDisplay> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<DustyDisplay> list = dustyService.list(type,state,dustyName,herfPage,projectId,userId);
		pageInfo = new PageInfo<>(list);
		
		List<User> users = userService.list();

		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("users", users);
		model.addAttribute("type", type);
		model.addAttribute("state", state);
		model.addAttribute("dustyName", dustyName);
		return "projectDusty/dusty";
	}
	
	//跳转添加页
	@RequestMapping(value="/addPage",method=RequestMethod.GET)
	public String addPage(Model model, HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		List<UserByProjectId> team = projectTeamService.list(projectId,"姓名");
		List<DemandDisplay> demands = demandService.list("需求状态", "需求名称", projectId);
		model.addAttribute("team", team);
		model.addAttribute("demands", demands);
		return "projectDusty/add";
	}
	
	
	//跳转详情
	@RequestMapping(value="/detailed",method=RequestMethod.GET)
	public String detailed(@RequestParam("id")Integer id,Model model) {
		 DustyDetailed dustyDetailed =  dustyService.detailedById(id);
		model.addAttribute("dustyDetailed", dustyDetailed);
		return "projectDusty/dustyDetails";
	}
}
