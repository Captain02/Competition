package com.hanming.oa.controller;

import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.ProcessDefinition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/admin/processDefinition")
public class ProcessDefinitionController {

	@Autowired
	private RepositoryService repositoryService;

	// 流程定义列表
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "name", defaultValue = "") String name, Model model) {

		PageInfo<ProcessDefinition> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<ProcessDefinition> list = null;
		if ("".equals(name)) {
			list = repositoryService.createProcessDefinitionQuery()// 创建流程查询实例
					.orderByDeploymentId().desc()// 按照时间进行降序
					.list();
		} else {
			list = repositoryService.createProcessDefinitionQuery()// 创建流程查询实例
					.orderByDeploymentId().desc().processDefinitionNameLike("%" + name + "%")// 根据Name模糊查询
					.list();
		}

		pageInfo = new PageInfo<ProcessDefinition>(list, 5);

		model.addAttribute("name", name);
		model.addAttribute("pageInfo", pageInfo);

		return "processDefinition/deployDefition";
	}

	// 显示图片
	@RequestMapping("/showView/{deploymentId}/{diagramResourceName}")
	public String showView(@PathVariable("deploymentId") String deploymentId,
			@PathVariable("diagramResourceName") String diagramResourceName, HttpServletResponse response)
			throws Exception {
		InputStream inputStream = repositoryService.getResourceAsStream(deploymentId, diagramResourceName+".png");
		OutputStream out = response.getOutputStream();
		for (int b = -1; (b = inputStream.read()) != -1;) {
			out.write(b);
		}
		out.close();
		inputStream.close();
		return null;
	}
}
