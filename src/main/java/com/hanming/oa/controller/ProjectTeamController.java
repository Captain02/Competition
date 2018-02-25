package com.hanming.oa.controller;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.User;
import com.hanming.oa.model.UserByProjectId;
import com.hanming.oa.service.ProjectTeamService;
import com.hanming.oa.service.UserService;
import com.sun.xml.internal.ws.policy.privateutil.PolicyUtils.Collections;

@Controller
@RequestMapping("/admin/projectTeam")
public class ProjectTeamController {

	@Autowired
	ProjectTeamService projectTeamService;
	@Autowired
	UserService userService;

	// 遍历
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "0") Integer pn,
			@RequestParam(value = "userName", defaultValue = "姓名") String userName, HttpServletRequest request,
			Model model) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");

		PageInfo<UserByProjectId> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<UserByProjectId> list = projectTeamService.list(projectId, userName);
		pageInfo = new PageInfo<>(list);

		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("userName", userName);

		return "projectTeam/team";
	}

	// 跳转添加页
	@RequestMapping(value = "/addPage", method = RequestMethod.GET)
	public String addPage(Model model) {
		List<User> list = userService.list();
		model.addAttribute("users", list);
		return "projectTeam/add";
	}

	// 添加成员
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Msg add(@RequestParam(value = "ids", defaultValue = "") String ids,HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		if (ids == "") {
			return Msg.fail();
		} else {
			if (ids.contains("-")) {
				String[] strIds = ids.split("-");
				List<String> idsStrList = Arrays.asList(strIds);
				if (idsStrList.get(0) != "") {
					List<Integer> idsIntList = idsStrList.stream()
							.map((x) -> Integer.parseInt(x))
							.collect(Collectors.toList());
					projectTeamService.inserList(projectId,idsIntList);
					return Msg.success();
				}
			}
		}
		return Msg.fail();
	}
}
