package com.hanming.oa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.model.BugDetailed;
import com.hanming.oa.model.BugDisplay;
import com.hanming.oa.service.BugService;

@Controller
@RequestMapping("admin/bug")
public class BugController {

	@Autowired
	BugService bugService;

	//遍历
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "0") Integer pn,
			@RequestParam(value = "state", defaultValue = "状态") String state,
			@RequestParam(value = "name", defaultValue = "名称") String name,
			@RequestParam(value = "hrefPage", defaultValue = "0") Integer hrefPage,
			HttpServletRequest request,Model model) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		
		PageInfo<BugDisplay> pageInfo = null;
		PageHelper.startPage(pn,8);
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		List<BugDisplay> list = bugService.list(state,name,hrefPage,projectId,userId);
		pageInfo = new PageInfo<>(list);
		
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("state", state);
		model.addAttribute("name", name);
		model.addAttribute("hrefPage", hrefPage);

		return "projectBug/bug";
	}
	
	@RequestMapping(value="/detailed",method=RequestMethod.GET)
	public String detailed(@RequestParam("bugId")Integer id,Model model) {
		BugDetailed bugDetailed = bugService.detailedById(id);
		model.addAttribute("bugDetailed", bugDetailed);
		return "projectBug/bugDetails";
	}
}
