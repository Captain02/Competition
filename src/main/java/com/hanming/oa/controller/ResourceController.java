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
import com.hanming.oa.service.ResourceService;

@Controller
@RequestMapping(value = "/admin/resource")
public class ResourceController {
	@Autowired
	ResourceService resourceService;

	// 权限的查询
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "name", defaultValue = "") String name, Model model) {
		PageInfo<Resource> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<Resource> list = null;
		if ("".equals(name)) {
			list = resourceService.list();
		} else {
			list = resourceService.listLikeName(name);
		}
		pageInfo = new PageInfo<>(list);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("name", name);
		return "resource/resource";
	}

	// 权限的修改页面跳转
	@RequestMapping(value = "/update/{id}/{pn}", method = RequestMethod.GET)
	public String updatePage(@PathVariable("id") Integer id, @PathVariable("pn") Integer pn, Resource resource,
			Model model) {
		model.addAttribute("pn", pn);
		model.addAttribute("resource", resourceService.selectByPrimaryKey(id));
		return "resource/editor";
	}

	// 权限的修改
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public Msg update(@Valid Resource resource, BindingResult result) {
		if (result.hasErrors()) {
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}
		resourceService.updateByPrimaryKey(resource);
		return Msg.success();
	}

	// 权限的删除
	@ResponseBody
	@RequestMapping(value = "/dele/{id}", method = RequestMethod.DELETE)
	public Msg dele(@PathVariable("id") Integer id) {
		int i = resourceService.selectRoleByResourceId(id);
		if (i != 0) {
			return Msg.fail();
		}
		resourceService.deleteByPrimaryKey(id);
		return Msg.success();
	}
}
