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
import com.hanming.oa.model.Department;
import com.hanming.oa.service.DepartmentService;

@Controller
@RequestMapping("/admin/department")
public class DepartmentController {
	@Autowired
	DepartmentService departmentService;

	// 部门遍历
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "name", defaultValue = "") String name, Model model) {
		PageInfo<Department> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<Department> list = null;
		if ("".equals(name)) {
			list = departmentService.list();
		} else {
			list = departmentService.listLikeName(name);
		}
		
		pageInfo = new PageInfo<Department>(list, 5);

		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("name", name);
		return "department/department";
	}

	// 跳转部门添加页
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addPage(Model model) {
		model.addAttribute("department", new Department());
		return "department/add";
	}

	// 部门添加
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Msg add(@Valid Department department, BindingResult result) {
		if (result.hasErrors()) {
			// 校验失败
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}
		departmentService.insertSelective(department);
		return Msg.success();
	}

	// 部门修改跳转页面
	@RequestMapping(value = "/update/{id}/{pn}", method = RequestMethod.GET)
	public String updatePage(@PathVariable("id") Integer id, @PathVariable("pn") Integer pn, Department department,
			Model model) {
		model.addAttribute("pn", pn);
		model.addAttribute("department", departmentService.selectByPrimaryKey(id));
		return "department/add";
	}

	// 部门的修改
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public Msg update(@Valid Department department, BindingResult result) {
		if (result.hasErrors()) {
			// 校验失败
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}
		departmentService.updateByPrimaryKeySelective(department);
		return Msg.success();
	}

	// 部门删除
	@ResponseBody
	@RequestMapping(value = "/dele/{id}", method = RequestMethod.DELETE)
	public Msg dele(@PathVariable("id") Integer id) {
		int count = departmentService.selectUserBydepartmentId(id);
		if (count != 0) {
			return Msg.fail();
		} else {
			departmentService.deleteByPrimaryKey(id);
			return Msg.success();
		}
	}
}
