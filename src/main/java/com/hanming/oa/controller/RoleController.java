package com.hanming.oa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.Resource;
import com.hanming.oa.model.Role;
import com.hanming.oa.service.ResourceService;
import com.hanming.oa.service.RoleResourceService;
import com.hanming.oa.service.RoleService;

@Controller
@RequestMapping("/admin/role")
public class RoleController {
	@Autowired
	RoleService roleService;
	@Autowired
	RoleResourceService roleResourceService;
	@Autowired
	ResourceService resourceService;

	// 跳转到列表
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model,
			@RequestParam(value = "name", defaultValue = "") String name) {
		PageInfo<Role> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<Role> list = null;
		if ("".equals(name)) {
			list = roleService.list();
		} else {
			list = roleService.listLikeName(name);
		}
		pageInfo = new PageInfo<>(list, 5);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("name", name);
		return "role/role";
	}

	// 跳转添加页面
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addPage(Model model) {
		model.addAttribute("role", new Role());
		return "role/add";
	}

	// 职称添加功能
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Msg add(@Valid Role role, BindingResult result) {
		if (result.hasErrors()) {
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}
		roleService.insertSelective(role);
		return Msg.success();
	}

	// 跳转职称编辑页面
	@RequestMapping(value = "/update/{id}/{pn}", method = RequestMethod.GET)
	public String update(Model model, @PathVariable("id") Integer id, @PathVariable("pn") Integer pn, Role role) {
		model.addAttribute("pn", pn);
		model.addAttribute("role", roleService.selectByPrimaryKey(id));
		return "role/add";
	}

	// 职称编辑功能
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public Msg update(@Valid Role role, BindingResult result) {
		if (result.hasErrors()) {
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}
		roleService.updateByPrimaryKeySelective(role);
		return Msg.success();
	}

	// 职称的删除
	@ResponseBody
	@RequestMapping(value = "/dele/{id}", method = RequestMethod.DELETE)
	public Msg dele(@PathVariable("id") Integer id) {
		if (roleService.dele(id) == 1) {
			return Msg.success();
		} else {
			return Msg.fail();
		}
	}

	// 职称所拥有的权限
	@RequestMapping(value = "/roleHasResourceList/{id}/{pn}", method = RequestMethod.GET)
	public String roleHasRersource(@PathVariable("id") Integer id, @PathVariable("pn") Integer pn, Model model) {
		model.addAttribute("pn", pn);
		List<Resource> list = roleService.selectRoleHasResource(id);
		List<Resource> system = resourceService.listByColumn("系统管理");
		List<Resource> organization = resourceService.listByColumn("组织管理");
		List<Resource> schedule = resourceService.listByColumn("日程管理");
		List<Resource> project = resourceService.listByColumn("项目管理");
		List<Resource> workAttendence = resourceService.listByColumn("考勤管理");
		List<Resource> examination = resourceService.listByColumn("审批管理");
		List<Resource> knowlege = resourceService.listByColumn("知识管理");
		List<Resource> image = resourceService.listByColumn("相册管理");
		List<Resource> processDefinition = resourceService.listByColumn("流程管理");
		System.out.println("++++++++++++++++++++++++++++++++"+schedule);
		model.addAttribute("roleHasResourceList", list);
		model.addAttribute("system", system);
		model.addAttribute("resources", organization);
		model.addAttribute("schedule", schedule);
		model.addAttribute("project", project);
		model.addAttribute("workAttendence", workAttendence);
		model.addAttribute("examination", examination);
		model.addAttribute("knowlege", knowlege);
		model.addAttribute("image", image);
		model.addAttribute("processDefinition", processDefinition);
		model.addAttribute("roleId", id);
		return "role/roleHasResource";
	}

	// 修改角色权限
	@ResponseBody
	@RequestMapping(value = "/updateResource", method = RequestMethod.GET)
	public Msg updateResource(@RequestParam(value = "roleId") String roleId,
			@RequestParam(value = "resourceId") String resourceId, @RequestParam(value = "check") String check) {
		if (check != null) {
			if (Integer.parseInt(check) == 0) {
				roleResourceService.deleteByRoleId(Integer.parseInt(roleId));
			}
			if (Integer.parseInt(check) == 1) {
				roleResourceService.addRoleResource(Integer.parseInt(roleId), Integer.parseInt(resourceId));
			}
			return Msg.success();
		}
		return Msg.fail();
	}

}
