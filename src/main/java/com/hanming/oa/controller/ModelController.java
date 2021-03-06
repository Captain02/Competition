package com.hanming.oa.controller;

import java.util.List;
import java.util.Locale;

import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.service.DeployService;

@Controller
@RequestMapping("admin/model")
public class ModelController {
	
	@Autowired
	DeployService deployService;
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
	
	//部署模型
	@RequestMapping(value="/deployModel",method=RequestMethod.POST)
	public String deployModel(@RequestParam(value="modelId")String modelId,@RequestParam("people")Integer people) {
	    try {
	        org.activiti.engine.repository.Model modelData = repositoryService.getModel(modelId);
	        ObjectNode modelNode = (ObjectNode) new ObjectMapper().readTree(repositoryService.getModelEditorSource(modelData.getId()));
	        byte[] bpmnBytes = null;
	        BpmnModel model = new BpmnJsonConverter().convertToBpmnModel(modelNode);
	        bpmnBytes = new BpmnXMLConverter().convertToXML(model);
	        String processName = modelData.getName() + ".bpmn20.xml";
	        Deployment deployment = repositoryService.createDeployment().name(modelData.getName()).addString(processName, new String(bpmnBytes,"utf-8")).deploy();
	       
	        deployService.updataPersonNumberByDeployId(deployment.getId(), people);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return "redirect:/admin/model/list";
	}
	
	//删除
	@ResponseBody
	@RequestMapping(value="/deleModel",method=RequestMethod.POST)
	public Msg deleModel(@RequestParam(value="modelId")String modelId) {
		repositoryService.deleteModel(modelId);
		return Msg.success();
	}
}
