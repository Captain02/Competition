package com.hanming.oa.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipInputStream;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.service.DeployService;

@Controller
@RequestMapping(value = "/admin/deploy")
public class DeployController {
	private static final Logger logger = LoggerFactory.getLogger(DeployController.class);

	@Autowired
	RepositoryService repositoryService;
	@Autowired
	RuntimeService runtimeService;
	@Autowired
	DeployService deployService;

	// 流程部署列表
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "name", defaultValue = "") String name, Model model) {

		PageInfo<Deployment> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<Deployment> list = null;
		if ("".equals(name)) {
			list = repositoryService.createDeploymentQuery()// 创建流程查询实例
					.orderByDeploymenTime().desc()// 按照时间进行降序
					.list();
		} else {
			list = repositoryService.createDeploymentQuery()// 创建流程查询实例
					.orderByDeploymenTime().desc().deploymentNameLike("%" + name + "%")// 根据Name模糊查询
					.list();
		}

		pageInfo = new PageInfo<Deployment>(list, 5);

		model.addAttribute("name", name);
		model.addAttribute("pageInfo", pageInfo);
		logger.info(SecurityUtils.getSubject().getSession().getAttribute("username") + "=====执行部署管理");

		return "deploy/deployProcess";
	}

	// 跳转添加页
	@RequestMapping(value = "/addeploy", method = RequestMethod.GET)
	public String addeploy() {
		return "deploy/addeploy";
	}

	// 添上传流程部署ZIP文件
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String add(MultipartFile file) throws IOException {
		repositoryService.createDeployment()// 创建部署
				.name(file.getOriginalFilename())// 需要部署流程名称
				.addZipInputStream(new ZipInputStream(file.getInputStream()))// 添加zip输入流
				.deploy();// 开始部署
		return "deploy/add";
	}

	// 员工单个和批量删除
	@ResponseBody
	@RequestMapping(value = "/dele/{ids}", method = RequestMethod.DELETE)
	public Msg dele(@PathVariable("ids") String ids) {
		
		System.out.println("+++++++++++++++++++++++++++++++"+ids);
		deployService.deleDeploy(ids);
		
		return Msg.success();
	}
	

}
