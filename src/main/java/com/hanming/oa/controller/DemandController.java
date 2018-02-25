package com.hanming.oa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.Demand;
import com.hanming.oa.model.DemandDetailed;
import com.hanming.oa.model.DemandDisplay;
import com.hanming.oa.model.UserByProjectId;
import com.hanming.oa.service.DemandService;
import com.hanming.oa.service.ProjectTeamService;

@Controller
@RequestMapping("/admin/demand")
public class DemandController {

	@Autowired
	DemandService demandService;
	@Autowired
	ProjectTeamService projectTeamService;

	// 列表
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "0") Integer pn,
			@RequestParam(value = "state", defaultValue = "需求状态") String state,
			@RequestParam(value = "projectName", defaultValue = "需求名称") String demandName, Model model,
			HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		PageInfo<DemandDisplay> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<DemandDisplay> list = demandService.list(state, demandName, projectId);
		pageInfo = new PageInfo<>(list);

		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("state", state);
		model.addAttribute("demandName", demandName);

		return "projectDemand/demand";
	}

	// 详细页面
	@RequestMapping(value = "/detailed", method = RequestMethod.GET)
	public String detailed(@RequestParam(value = "demandId") Integer demandId, Model model) {
		DemandDetailed demandDetailed = demandService.detaileById(demandId);
		model.addAttribute("demandDetailed", demandDetailed);
		return "projectDemand/demandDetails";
	}

	// 编辑页
	@RequestMapping(value = "/editorPage", method = RequestMethod.GET)
	public String editorPage(@RequestParam(value = "editor") Integer demandId, Model model, HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		List<UserByProjectId> team = projectTeamService.list(projectId,"姓名");
		DemandDetailed demandDetailed = demandService.detaileById(demandId);
		model.addAttribute("demandDetailed", demandDetailed);
		model.addAttribute("team", team);
		return "projectDemand/editor";
	}
	
	//编辑
	@ResponseBody
	@RequestMapping(value = "/editor", method = RequestMethod.POST)
	public Msg editorPage(Demand demand,MultipartFile file,HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		demandService.insert(demand,file,request,projectId,0);
		return Msg.success();
	}

	// 跳转添加
	@RequestMapping(value = "/addPage", method = RequestMethod.GET)
	public String addPage(Model model, HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		List<UserByProjectId> team = projectTeamService.list(projectId,"姓名");
		model.addAttribute("team", team);
		return "projectDemand/add";
	}

	// 添加
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Msg add(Demand demand,MultipartFile file,HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		demandService.insert(demand,file,request,projectId,1);
		return Msg.success();
	}
}
