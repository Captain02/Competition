package com.hanming.oa.controller;

import java.util.List;

import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.RepositoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

@Controller
@RequestMapping("admin/model")
public class ModelController {
	
	@Autowired
	RepositoryService repositoryService;

	//列表
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String list(Model model) {
		List<org.activiti.engine.repository.Model> pageInfo = repositoryService.createModelQuery().list();
		model.addAttribute("pageInfo", pageInfo);
		return "deploy/modelManagement";
	}
	
	//跳转添加页
	@RequestMapping(value="/createPage",method=RequestMethod.GET)
	public String addModelPage() {
		
		return "deploy/modelAdd";
	}
	
	//跳转绘制流程
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String createModel(@RequestParam("modelName") String modelName, @RequestParam("modelKey") String modelKey, @RequestParam("modelDescription") String description) {

		try {

			ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();

			RepositoryService repositoryService = processEngine.getRepositoryService();

			ObjectMapper objectMapper = new ObjectMapper();
			ObjectNode editorNode = objectMapper.createObjectNode();
			editorNode.put("id", "canvas");
			editorNode.put("resourceId", "canvas");
			ObjectNode stencilSetNode = objectMapper.createObjectNode();
			stencilSetNode.put("namespace", "http://b3mn.org/stencilset/bpmn2.0#");
			editorNode.put("stencilset", stencilSetNode);
			org.activiti.engine.repository.Model modelData = repositoryService.newModel();

			ObjectNode modelObjectNode = objectMapper.createObjectNode();
			modelObjectNode.put(ModelDataJsonConstants.MODEL_NAME, modelName);
			modelObjectNode.put(ModelDataJsonConstants.MODEL_REVISION, 1);
			modelObjectNode.put(ModelDataJsonConstants.MODEL_DESCRIPTION, description);
			modelData.setMetaInfo(modelObjectNode.toString());
			modelData.setName(modelName);
			modelData.setKey(modelKey);

			repositoryService.saveModel(modelData);
			repositoryService.addModelEditorSource(modelData.getId(), editorNode.toString().getBytes("utf-8"));
			// response.sendRedirect(request.getContextPath() + "/modeler.html?modelId=" +
			// modelData.getId());
			return "redirect:/static/process-editor/modeler.html?modelId=" + modelData.getId();
		} catch (Exception e) {
		}
		return null;
	}
}
