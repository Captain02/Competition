package com.hanming.oa.controller;

import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.RoleIdAndName;
import com.hanming.oa.model.User;
import com.hanming.oa.model.UserRole;
import com.hanming.oa.service.RoleService;
import com.hanming.oa.service.UserService;
import com.hanming.oa.service.UserRoleService;

@Controller
@RequestMapping("/admin/member")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Autowired
	RoleService roleService;
	@Autowired
	UserService userService;
	@Autowired
	UserRoleService userRoleService;

	// 组员的列表
	@RequestMapping(value = "list/{id}", method = RequestMethod.GET)
	public String list(@PathVariable("id") Integer id, @RequestParam(value = "pn", defaultValue = "1") Integer pn,
			Model model, @RequestParam(value = "name", defaultValue = "") String name, RoleIdAndName roleIdAndName) {
		PageInfo<User> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<User> list = null;
		if ("".equals(name)) {
			list = roleService.selectUserByRoleId(id);
		} else {
			list = roleService.selectUserByRoleIdLikeName(roleIdAndName);
		}
		pageInfo = new PageInfo<User>(list, 5);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("roleId", id);
		model.addAttribute("name", name);
		logger.info(SecurityUtils.getSubject().getSession().getAttribute("username") + "=====执行查询组员的列表");
		return "member/member";
	}

	// 组员修改跳转页
	@RequestMapping(value = "/update/{id}/{pn}", method = RequestMethod.GET)
	public String updatePage(@PathVariable("id") Integer id, @PathVariable("pn") Integer pn, Model model) {
		model.addAttribute("user", userService.selectByPrimaryKeyWithDeptAndRole(id));
		model.addAttribute("pn", pn);
		model.addAttribute("role", roleService.list());
		logger.info(SecurityUtils.getSubject().getSession().getAttribute("username") + "=====执行组员修改跳转页");
		return "member/editor";
	}

	// 组员修改完成
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public Msg update(@RequestParam("userId") String userId, @RequestParam("roleId") String roleId) {
		UserRole userRole = new UserRole(Integer.parseInt(userId), Integer.parseInt(roleId));
		userRoleService.updateByUserId(userRole);
		logger.info(SecurityUtils.getSubject().getSession().getAttribute("username") + "=====执行组员修改");
		return Msg.success();
	}
}
