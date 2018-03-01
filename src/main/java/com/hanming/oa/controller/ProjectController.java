package com.hanming.oa.controller;

import java.util.Date;
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

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.DateTool;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.Project;
import com.hanming.oa.model.ProjectDetailed;
import com.hanming.oa.model.ProjectDisplay;
import com.hanming.oa.model.ProjectHistoryDisplay;
import com.hanming.oa.model.User;
import com.hanming.oa.model.UserByProjectId;
import com.hanming.oa.service.ProjectHistoryService;
import com.hanming.oa.service.ProjectService;
import com.hanming.oa.service.ProjectTeamService;
import com.hanming.oa.service.UserService;
import com.hanming.oa.service.WhiteListServer;

@Controller
@RequestMapping("/admin/project")
public class ProjectController {

	@Autowired
	ProjectService projectService;
	@Autowired
	ProjectTeamService projectTeamService;
	@Autowired
	UserService userService;
	@Autowired
	WhiteListServer WhiteListServer;
	@Autowired
	ProjectHistoryService projectHistoryService;

	// 遍历
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "0") Integer pn,
			@RequestParam(value = "state", defaultValue = "项目状态") String state,
			@RequestParam(value = "projectName", defaultValue = "项目名称") String projectName, Model model) {

		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		
		PageInfo<ProjectDisplay> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<ProjectDisplay> list = projectService.list(state, projectName,userId);
		pageInfo = new PageInfo<>(list,5);

		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("state", state);
		model.addAttribute("projectName", projectName);

		return "projectManagement/project";
	}

	// 修改状态
	@ResponseBody
	@RequestMapping(value = "/changeState", method = RequestMethod.POST)
	public Msg changState(@RequestParam("state") String state, @RequestParam("projectId") Integer projectId) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		projectService.updateStateByProjectId(state, projectId,userId);
		return Msg.success();
	}

	// 跳转添加页
	@RequestMapping(value = "/addPage", method = RequestMethod.GET)
	public String addPage(Model model) {

		return "projectManagement/add";
	}

	// 添加项目
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Msg add(Model model, @RequestParam("projectName") String projectName,
			@RequestParam("projectAlias") String projectAliasName,
			@RequestParam("projectStartDate") String projectStartDate,
			@RequestParam("projectEndDate") String projectEndDate, @RequestParam("projectDesc") String projectDesc) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");

		Project project = new Project();
		project.setProjectName(projectName);
		project.setProjectAliasName(projectAliasName);
		project.setStartDate(projectStartDate);
		project.setEndDate(projectEndDate);
		project.setDescs(projectDesc);
		project.setCreateDate(DateTool.dateToString(new Date()));
		project.setCreatePeople(userId);
		project.setState("进行");
		project.setReleaseControl("公开（所有人）");

		projectService.insert(project,userId);

		return Msg.success();
	}

	// 跳转编辑页
	@RequestMapping(value = "/editor", method = RequestMethod.GET)
	public String update(@RequestParam("projectId") Integer projectId, Model model) {
		ProjectDetailed projectDetailed = projectService.projectDetailed(projectId);
		List<User> list = userService.list();
		List<UserByProjectId> team = projectTeamService.list(projectId,"姓名");
		List<User> MyWhite = WhiteListServer.listByProjectId(projectId);
		model.addAttribute("white", list);
		model.addAttribute("MyWhite", MyWhite);
		model.addAttribute("team", team);
		model.addAttribute("projectDetailed", projectDetailed);
		return "projectManagement/editor";
	}

	// 修改
	@ResponseBody
	@RequestMapping(value = "/editor", method = RequestMethod.POST)
	public Msg update(Project project, @RequestParam(value = "whiteNameId", required = false) String whiteNameId,
			@RequestParam(value = "descs", required = false) String descs) {
		project.setDescs(descs);
		projectService.update(project,whiteNameId);
		return Msg.success();
	}

	// 跳转详情页
	@RequestMapping(value = "/projectDetails", method = RequestMethod.GET)
	public String detailed(@RequestParam("projectId") Integer projectId, Model model,HttpServletRequest request) {
		request.getSession().setAttribute("projectId", projectId);
		
		List<ProjectHistoryDisplay> list = projectHistoryService.listByTypeAndTypeId(projectId, "项目");
		model.addAttribute("projectHistory", list);
		
		ProjectDetailed projectDetailed = projectService.projectDetailed(projectId);
		model.addAttribute("projectDetailed", projectDetailed);
		model.addAttribute("subDays",
				(DateTool.substractTime(projectDetailed.getEndDate(), DateTool.dateToYearMonthDay(new Date()))) / 60
						/ 12);
		

		return "projectManagement/projectDetails";
	}
}
