package com.hanming.oa.controller;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.DemandDisplay;
import com.hanming.oa.model.Dusty;
import com.hanming.oa.model.DustyDetailed;
import com.hanming.oa.model.DustyDisplay;
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

	// 遍历
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "0") Integer pn,
			@RequestParam(value = "type", defaultValue = "任务类型") String type,
			@RequestParam(value = "state", defaultValue = "任务状态") String state,
			@RequestParam(value = "dustyName", defaultValue = "任务名称") String dustyName,
			@RequestParam(value = "herfPage", defaultValue = "0") Integer herfPage, Model model,
			HttpServletRequest request) {

		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");

		PageInfo<DustyDisplay> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<DustyDisplay> list = dustyService.list(type, state, dustyName, herfPage, projectId, userId);
		pageInfo = new PageInfo<>(list);

		List<UserByProjectId> users = projectTeamService.list(projectId, "姓名");

		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("users", users);
		model.addAttribute("type", type);
		model.addAttribute("state", state);
		model.addAttribute("dustyName", dustyName);
		return "projectDusty/dusty";
	}

	// 跳转添加页
	@RequestMapping(value = "/addPage", method = RequestMethod.GET)
	public String addPage(Model model, HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		List<UserByProjectId> team = projectTeamService.list(projectId, "姓名");
		List<DemandDisplay> demands = demandService.list("需求状态", "需求名称", projectId);
		model.addAttribute("team", team);
		model.addAttribute("demands", demands);
		model.addAttribute("dustyDetailed", new DustyDetailed());
		return "projectDusty/add";
	}

	// 添加
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Msg add(Dusty dusty, @RequestParam("ccid") String ccid, MultipartFile file, HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		dusty.setCreatPeople(userId);
		dusty.setProjectId(projectId);
		dusty.setState("进行中");
		
		Set<Integer> idInt =null;
		String[] ids = ccid.split("-");
		List<String> idStr = Arrays.asList(ids);
		if (!("".equals(idStr.get(0))) && idStr!=null) {
			idInt = idStr.stream().map((x) -> Integer.parseInt(x)).collect(Collectors.toSet());
		}else {
			idInt = new HashSet<>();
		}
		idInt.add(dusty.getAssignor());

		dustyService.insert(dusty,file,idInt,1,request);
		return Msg.success();
	}

	// 跳转详情
	@RequestMapping(value = "/detailed", method = RequestMethod.GET)
	public String detailed(@RequestParam("id") Integer id, Model model) {
		DustyDetailed dustyDetailed = dustyService.detailedById(id);
		model.addAttribute("dustyDetailed", dustyDetailed);
		return "projectDusty/dustyDetails";
	}

	// 修改状态
	@ResponseBody
	@RequestMapping(value = "/changeState", method = RequestMethod.POST)
	public Msg changeState(@RequestParam("state") String state, @RequestParam("id") Integer id) {
		Dusty dusty = new Dusty();
		dusty.setState(state);
		dusty.setId(id);
		dustyService.update(dusty);
		return Msg.success();
	}

	// 删除
	@ResponseBody
	@RequestMapping(value = "/dele", method = RequestMethod.POST)
	public Msg dele(@RequestParam("id") Integer id) {
		dustyService.deleteById(id);
		return Msg.success();
	}
	
	//修改指派人
	@ResponseBody
	@RequestMapping(value = "/assignTask", method = RequestMethod.POST)
	public Msg dele(@RequestParam("dustyId") Integer dustyId,@RequestParam("assignor") Integer assignor) {
		Dusty dusty = new Dusty();
		dusty.setId(dustyId);
		dusty.setAssignor(assignor);
		dustyService.update(dusty);
		return Msg.success();
	}
	
	//跳转编辑
	@RequestMapping(value="/editor",method=RequestMethod.GET)
	public String editor(@RequestParam("id") Integer id, Model model,HttpServletRequest request) {
		DustyDetailed dustyDetailed = dustyService.detailedById(id);
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		List<UserByProjectId> team = projectTeamService.list(projectId, "姓名");
		List<DemandDisplay> demands = demandService.list("需求状态", "需求名称", projectId);
		model.addAttribute("dustyDetailed", dustyDetailed);
		model.addAttribute("team", team);
		model.addAttribute("demands", demands);
		return "projectDusty/editor";
	}
	
	// 添加
	@ResponseBody
	@RequestMapping(value = "/editor", method = RequestMethod.POST)
	public Msg editor(Dusty dusty, @RequestParam("ccid") String ccid, MultipartFile file, HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		dusty.setCreatPeople(userId);
		dusty.setProjectId(projectId);

		dustyService.insert(dusty,file,null,0,request);
		return Msg.success();
	}
	
	//跳转批量添加
	@RequestMapping(value = "/addBatch", method = RequestMethod.GET)
	public String addBatchPage(Model model,HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		List<UserByProjectId> team = projectTeamService.list(projectId, "姓名");
		List<DemandDisplay> demands = demandService.list("需求状态", "需求名称", projectId);
		
		List<Integer> counts = Arrays.asList(1,2,3,4,5,6,7,8,9,0);
		
		model.addAttribute("team", team);
		model.addAttribute("counts", counts);
		model.addAttribute("demands", demands);
		
		return "projectDusty/addBatch";
	}
	
	//批量添加
	@ResponseBody
	@RequestMapping(value = "/addBatch", method = RequestMethod.POST)
	public Msg addBatch(@RequestBody List<Dusty> dustys,HttpServletRequest request) {
		
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		
		List<Dusty> dusties = dustys.stream()
			.filter((x) -> {
				if ((x.getTaskName()!=null)&&(x.getTaskName()!="")) {
					x.setProjectId(projectId);
					x.setState("未开始");
					x.setCreatPeople(userId);
					return true;
				}else {
					return false;
				}
			})
			.collect(Collectors.toList());
		
		dustyService.addBatch(dusties);
		
		return Msg.success();
	}
	
	//克隆
	@RequestMapping(value = "/clone", method = RequestMethod.GET)
	public String clone(@RequestParam("id") Integer id, Model model,HttpServletRequest request) {
		DustyDetailed dustyDetailed = dustyService.detailedById(id);
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		List<UserByProjectId> team = projectTeamService.list(projectId, "姓名");
		List<DemandDisplay> demands = demandService.list("需求状态", "需求名称", projectId);
		model.addAttribute("dustyDetailed", dustyDetailed);
		model.addAttribute("team", team);
		model.addAttribute("demands", demands);
		return "projectDusty/add";
	}
}