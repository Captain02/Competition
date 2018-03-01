package com.hanming.oa.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.DateTool;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.BugDetailed;
import com.hanming.oa.model.BugDisplay;
import com.hanming.oa.model.DemandDisplay;
import com.hanming.oa.model.DustyDisplay;
import com.hanming.oa.model.ProjectBug;
import com.hanming.oa.model.ProjectHistory;
import com.hanming.oa.model.ProjectHistoryDisplay;
import com.hanming.oa.model.UserByProjectId;
import com.hanming.oa.service.BugService;
import com.hanming.oa.service.DemandService;
import com.hanming.oa.service.DustyService;
import com.hanming.oa.service.ProjectHistoryService;
import com.hanming.oa.service.ProjectTeamService;
import com.hanming.oa.service.UpDownFileService;

@Controller
@RequestMapping("admin/bug")
public class BugController {

	@Autowired
	BugService bugService;
	@Autowired
	DemandService demandService;
	@Autowired
	ProjectTeamService projectTeamService;
	@Autowired
	DustyService dustyService;
	@Autowired
	ProjectHistoryService projectHistoryService;
	@Autowired
	UpDownFileService upDownFileService;

	// 遍历
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "0") Integer pn,
			@RequestParam(value = "state", defaultValue = "状态") String state,
			@RequestParam(value = "name", defaultValue = "名称") String name,
			@RequestParam(value = "herfPage", defaultValue = "0") Integer hrefPage, HttpServletRequest request,
			Model model) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");

		PageInfo<BugDisplay> pageInfo = null;
		PageHelper.startPage(pn, 8);
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		List<BugDisplay> list = bugService.list(state, name, hrefPage, projectId, userId);
		pageInfo = new PageInfo<>(list);

		List<UserByProjectId> users = projectTeamService.list(projectId, "姓名");

		model.addAttribute("users", users);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("state", state);
		model.addAttribute("name", name);
		model.addAttribute("herfPage", hrefPage);

		return "projectBug/bug";
	}

	// 详情页面
	@RequestMapping(value = "/detailed", method = RequestMethod.GET)
	public String detailed(@RequestParam("bugId") Integer id, Model model) {
		BugDetailed bugDetailed = bugService.detailedById(id);
		List<ProjectHistoryDisplay> list = projectHistoryService.listByTypeAndTypeId(id, "bug");
		model.addAttribute("bugDetailed", bugDetailed);
		model.addAttribute("bugHistory", list);
		return "projectBug/bugDetails";
	}

	// 跳转编辑页面
	@RequestMapping(value = "/editor", method = RequestMethod.GET)
	public String deitor(@RequestParam(value = "bugId") Integer id, Model model, HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");

		List<UserByProjectId> team = projectTeamService.list(projectId, "姓名");

		List<DemandDisplay> DemandDisplay = demandService.list("需求状态", "需求名称", projectId);
		List<DustyDisplay> DustyDisplay = dustyService.list("任务类型", "任务状态", "任务名称", 0, projectId, 0);

		BugDetailed bugDetailed = bugService.detailedById(id);

		model.addAttribute("bugDetailed", bugDetailed);
		model.addAttribute("DemandDisplay", DemandDisplay);
		model.addAttribute("DustyDisplay", DustyDisplay);
		model.addAttribute("team", team);
		return "projectBug/deitor";
	}

	// 编辑
	@ResponseBody
	@RequestMapping(value = "/editor", method = RequestMethod.POST)
	public Msg editor(ProjectBug projectBug, MultipartFile file, HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		projectBug.setState("待解决");

		bugService.insert(projectBug, file, null, 0, request, projectId, userId);
		return Msg.success();
	}

	// 跳转添加页面
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model, HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");

		List<UserByProjectId> team = projectTeamService.list(projectId, "姓名");

		List<DemandDisplay> DemandDisplay = demandService.list("需求状态", "需求名称", projectId);
		List<DustyDisplay> DustyDisplay = dustyService.list("任务类型", "任务状态", "任务名称", 0, projectId, 0);

		model.addAttribute("DemandDisplay", DemandDisplay);
		model.addAttribute("DustyDisplay", DustyDisplay);
		model.addAttribute("team", team);
		return "projectBug/add";
	}

	// 添加
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Msg add(@RequestParam("ccid") String ccid, ProjectBug projectBug, MultipartFile file,
			HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		projectBug.setCreatPeople(userId);
		projectBug.setProjectId(projectId);
		projectBug.setState("待解决");

		Set<Integer> idInt = null;
		String[] ids = ccid.split("-");
		List<String> idStr = Arrays.asList(ids);
		if (!("".equals(idStr.get(0))) && idStr != null) {
			idInt = idStr.stream().map((x) -> Integer.parseInt(x)).collect(Collectors.toSet());
		} else {
			idInt = new HashSet<>();
		}
		idInt.add(projectBug.getAssginor());

		bugService.insert(projectBug, file, idInt, 1, request, projectId, userId);
		return Msg.success();
	}

	// 改变状态
	@ResponseBody
	@RequestMapping(value = "/changeState", method = RequestMethod.POST)
	public Msg changeState(@RequestParam("id") Integer id, @RequestParam("state") String state) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		ProjectBug projectBug = new ProjectBug();
		projectBug.setId(id);
		projectBug.setState(state);
		projectBug.setCompletPeople(userId);
		projectBug.setEndTime(DateTool.dateToString(new Date()));
		bugService.update(projectBug);
		ProjectHistory projectHistory = new ProjectHistory();
		projectHistory.setOperationPeopleId(userId);
		projectHistory.setHistoryType("bug");
		projectHistory.setTypeId(projectBug.getId());
		projectHistory.setOperationType("修改了bug状态为" + state);
		projectHistoryService.insertSelective(projectHistory);
		return Msg.success();
	}

	// 修改指派人
	@ResponseBody
	@RequestMapping(value = "/assignTask", method = RequestMethod.POST)
	public Msg dele(@RequestParam("bugId") Integer bugId, @RequestParam("assignor") Integer assignor) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		ProjectBug projectBug = new ProjectBug();
		projectBug.setId(bugId);
		projectBug.setAssginor(assignor);
		bugService.update(projectBug);
		ProjectHistory projectHistory = new ProjectHistory();
		projectHistory.setOperationPeopleId(userId);
		projectHistory.setHistoryType("bug");
		projectHistory.setTypeId(bugId);
		projectHistory.setOperationType("修改了bug的指派人");
		projectHistoryService.insertSelective(projectHistory);
		return Msg.success();
	}

	// 文件下载
	@RequestMapping(value = "/down/{id}", method = RequestMethod.GET)
	public void down(@PathVariable("id") Integer id, HttpServletResponse response, HttpServletRequest request) {

		ProjectBug projectBug = bugService.select(id);

		try {
			upDownFileService.down(response, request, projectBug, "ProjectBug");
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
