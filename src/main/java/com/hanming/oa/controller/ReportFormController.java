package com.hanming.oa.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.BugDisplay;
import com.hanming.oa.model.DemandDisplay;
import com.hanming.oa.model.DustyDisplay;
import com.hanming.oa.model.UserByProjectId;
import com.hanming.oa.reportForm.RoleReprotForm;
import com.hanming.oa.service.BugService;
import com.hanming.oa.service.DemandService;
import com.hanming.oa.service.DustyService;
import com.hanming.oa.service.ProjectTeamService;

@Controller
@RequestMapping("/admin/reportForms")
public class ReportFormController {
	
	@Autowired
	DustyService dustyService;
	@Autowired
	ProjectTeamService projectTeamService;
	@Autowired
	DemandService demandService;
	@Autowired
	BugService bugService;

	// 跳转
	@RequestMapping(value = "/reportForm", method = RequestMethod.GET)
	public String list() {

		return "projectReportForm/reportForm";
	}

	// 获取数据生成视图
	@ResponseBody
	@RequestMapping(value = "/report", method = RequestMethod.GET)
	public Msg report(Model model, HttpServletRequest request, @RequestParam("name") String name) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		List<RoleReprotForm> roleProportion = new ArrayList<>();

		List<String> roleName = new ArrayList<>();

		if ("职称比例".equals(name)) {
			List<UserByProjectId> users = projectTeamService.list(projectId, "姓名");

			Map<String, Long> map = users.stream().map(UserByProjectId::getRoleName)
					.collect(Collectors.groupingBy(p -> p, Collectors.counting()));

			reprortForm(roleProportion, roleName, map);
		}
		if ("需求指派比例".equals(name)) {
			List<DemandDisplay> list = demandService.list("需求状态", "需求名称", projectId);
			Map<String, Long> map = list.stream()
				.map(DemandDisplay::getAssignor)
				.collect(Collectors.groupingBy(p -> p, Collectors.counting()));
			
			reprortForm(roleProportion, roleName, map);
		}
		
		if ("需求创建人比例".equals(name)) {
			List<DemandDisplay> list = demandService.list("需求状态", "需求名称", projectId);
			Map<String, Long> map = list.stream()
				.map(DemandDisplay::getCreatePeopele)
				.collect(Collectors.groupingBy(p -> p, Collectors.counting()));
			
			reprortForm(roleProportion, roleName, map);
		}
		
		if ("需求来源比例".equals(name)) {
			List<DemandDisplay> list = demandService.list("需求状态", "需求名称", projectId);
			Map<String, Long> map = list.stream()
				.map(DemandDisplay::getSource)
				.collect(Collectors.groupingBy(p -> p, Collectors.counting()));
			
			reprortForm(roleProportion, roleName, map);
		}
		
		if ("任务指派比例".equals(name)) {
			List<DustyDisplay> list = dustyService.list("任务类型", "任务状态", "任务名称", 0, projectId, 0);
			Map<String, Long> map = list.stream()
				.map(DustyDisplay::getAssignor)
				.collect(Collectors.groupingBy(p -> p, Collectors.counting()));
			
			reprortForm(roleProportion, roleName, map);
		}
		
		if ("任务创建人比例".equals(name)) {
			List<DustyDisplay> list = dustyService.list("任务类型", "任务状态", "任务名称", 0, projectId, 0);
			Map<String, Long> map = list.stream()
				.map(DustyDisplay::getCreatPeople)
				.collect(Collectors.groupingBy(p -> p, Collectors.counting()));
			
			reprortForm(roleProportion, roleName, map);
		}
		
		if ("任务完成人比例".equals(name)) {
			List<DustyDisplay> list = dustyService.list("任务类型", "任务状态", "任务名称", 0, projectId, 0);
			Map<String, Long> map = list.stream()
					.filter((x) -> x.getCompletName()!=null)
				.map(DustyDisplay::getCompletName)
				.collect(Collectors.groupingBy(p -> p, Collectors.counting()));
			
			reprortForm(roleProportion, roleName, map);
		}
		
		if ("任务类型比例".equals(name)) {
			List<DustyDisplay> list = dustyService.list("任务类型", "任务状态", "任务名称", 0, projectId, 0);
			Map<String, Long> map = list.stream()
				.map(DustyDisplay::getState)
				.collect(Collectors.groupingBy(p -> p, Collectors.counting()));
			
			reprortForm(roleProportion, roleName, map);
		}
		
		if ("Bug指派比例".equals(name)) {
			List<BugDisplay> list = bugService.list("状态", "名称", 0, projectId, 0);
			Map<String, Long> map = list.stream()
				.filter((x) -> x.getAssginor()!=null)
				.map(BugDisplay::getAssginor)
				.collect(Collectors.groupingBy(p -> p, Collectors.counting()));
			
			reprortForm(roleProportion, roleName, map);
		}
		
		if ("Bug创建人比例".equals(name)) {
			List<BugDisplay> list = bugService.list("状态", "名称", 0, projectId, 0);
			Map<String, Long> map = list.stream()
				.map(BugDisplay::getCreatPeople)
				.collect(Collectors.groupingBy(p -> p, Collectors.counting()));
			
			reprortForm(roleProportion, roleName, map);
		}
		
		if ("Bug完成人比例".equals(name)) {
			List<BugDisplay> list = bugService.list("状态", "名称", 0, projectId, 0);
			Map<String, Long> map = list.stream()
					.filter((x) -> x.getCompletpeople()!=null)
				.map(BugDisplay::getCompletpeople)
				.collect(Collectors.groupingBy(p -> p, Collectors.counting()));
			
			reprortForm(roleProportion, roleName, map);
		}
		
		return Msg.success().add("roleProportion", roleProportion).add("roleName", roleName);
	}
	
	

	private void reprortForm(List<RoleReprotForm> roleProportion, List<String> roleName, Map<String, Long> map) {
		Set<Entry<String, Long>> entrySet = map.entrySet();

		for (Entry<String, Long> entry : entrySet) {
			RoleReprotForm rrf = new RoleReprotForm(entry.getValue(), entry.getKey());
			roleProportion.add(rrf);
			roleName.add(entry.getKey());
		}
	}
}
