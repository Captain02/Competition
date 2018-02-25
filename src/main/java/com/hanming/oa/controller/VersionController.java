package com.hanming.oa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.Versions;
import com.hanming.oa.service.VersionServer;

@Controller
@RequestMapping("/admin/version")
public class VersionController {

	@Autowired
	VersionServer versionServer;

	//遍历
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "0") Integer pn,
			@RequestParam(value = "versionName", defaultValue = "版本名称") String versionName,HttpServletRequest request,Model model) {
		
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		
		PageInfo<Versions> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<Versions> list = versionServer.list(versionName,projectId);
		pageInfo = new PageInfo<>(list,5);

		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("versionName", versionName);
		
		return "projectVersion/version";
	}
	
	//详情页面
	@RequestMapping(value="/detailed",method=RequestMethod.GET)
	public String detailed(@RequestParam(value="id")Integer id,Model model) {
		Versions version = versionServer.detailedById(id);
		model.addAttribute("version", version);
		return "projectVersion/versionDetails";
	}
	
	//跳转编辑
	@RequestMapping(value="/editor",method=RequestMethod.GET)
	public String editor(@RequestParam(value="id")Integer id,Model model) {
		Versions version = versionServer.detailedById(id);
		model.addAttribute("version", version);
		return "projectVersion/editor";
	}
	
	//编辑
	@ResponseBody
	@RequestMapping(value="/editor",method=RequestMethod.POST)
	public Msg editor(Versions versions, MultipartFile file, HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		versionServer.insert(versions, file, request, projectId, 0);
		return Msg.success();
	}
	
	//添加页面
	@RequestMapping(value="/addPage",method=RequestMethod.GET)
	public String addPage() {
		return "projectVersion/add";
	}
	
	//添加
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Msg add(Versions versions, MultipartFile file, HttpServletRequest request) {
		Integer projectId = (Integer) request.getSession().getAttribute("projectId");
		versionServer.insert(versions, file, request, projectId, 1);
		return Msg.success();
	}
	
	//删除版本
	@ResponseBody
	@RequestMapping(value = "/dele", method = RequestMethod.POST)
	public Msg dele(@RequestParam("id")Integer id) {
		versionServer.delete(id);
		return Msg.success();
	}
}



