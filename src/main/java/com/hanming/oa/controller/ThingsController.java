package com.hanming.oa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.Things;
import com.hanming.oa.model.User;
import com.hanming.oa.model.UserReimbursementByReimbursementId;
import com.hanming.oa.model.UserThingsByThingsId;
import com.hanming.oa.service.DeployService;
import com.hanming.oa.service.ThingsService;
import com.hanming.oa.service.UserService;

@Controller
@RequestMapping("/admin/things")
public class ThingsController {
	private static final Logger logger = LoggerFactory.getLogger(ThingsController.class);

	@Autowired
	ThingsService thingsService;
	@Autowired
	UserService userService;
	@Autowired
	TaskService taskService;
	@Autowired
	RepositoryService repositoryService;
	@Autowired
	RuntimeService runtimeService;
	@Autowired
	DeployService deployService;

	// 查询物品申请
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "state", defaultValue = "状态") String state,
			@RequestParam(value = "name", defaultValue = "") String name, Model model) {
		PageInfo<Things> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<Things> list = null;
		list = thingsService.listLikeStateType(state, name);
		pageInfo = new PageInfo<Things>(list, 5);

		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("state", state);
		model.addAttribute("purpose", name);
		logger.info(SecurityUtils.getSubject().getSession().getAttribute("username") + "=====查询物品申请");

		return "things/things";
	}

	// 跳转到添加物品申请页面
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addPage(Model model) {
		List<User> list = userService.listNotStaff();
		List<String> ProcessKey = deployService.selectProcessKey();
		model.addAttribute("processKey", ProcessKey);
		model.addAttribute("user", list);
		return "things/addThing";
	}

	// 我要申请物品
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Msg add(MultipartFile file, @RequestParam("persons") String persons, Things things,
			HttpServletRequest request) {
		thingsService.addThings(persons, file, things, request);

		logger.info(SecurityUtils.getSubject().getSession().getAttribute("username") + "=====执行添加我要申请物品");
		return Msg.success();
	}

	// 查询当前流程图
	@RequestMapping(value = "/showCurrentView/{processinstanceid}", method = RequestMethod.GET)
	public ModelAndView showCurrentView(@PathVariable("processinstanceid") String processInstanceId) {
		// 视图
		ModelAndView mav = new ModelAndView();

		Task task = taskService.createTaskQuery() // 创建任务查询
				.processInstanceId(processInstanceId)// 根据流程实例Id查询当前任务
				.singleResult();
		// 获取流程定义id
		String processDefinitionId = task.getProcessDefinitionId();
		ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery() // 创建流程定义查询
				// 根据流程定义id查询
				.processDefinitionId(processDefinitionId).singleResult();
		// 部署id
		mav.addObject("deploymentId", processDefinition.getDeploymentId());
		mav.addObject("diagramResourceName", processDefinition.getDiagramResourceName()); // 图片资源文件名称

		ProcessDefinitionEntity processDefinitionEntity = (ProcessDefinitionEntity) repositoryService
				.getProcessDefinition(processDefinitionId);

		// 根据流程实例id获取流程实例
		ProcessInstance pi = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId)
				.singleResult();

		// 根据活动id获取活动实例
		ActivityImpl activityImpl = processDefinitionEntity.findActivity(pi.getActivityId());
		// 整理好View视图返回到显示页面
		mav.addObject("x", activityImpl.getX()); // x坐标
		mav.addObject("y", activityImpl.getY()); // y坐标
		mav.addObject("width", activityImpl.getWidth()); // 宽度
		mav.addObject("height", activityImpl.getHeight()); // 高度
		mav.setViewName("holiday/currentView");
		logger.info(SecurityUtils.getSubject().getSession().getAttribute("username") + "=====执行显示当前流程图");
		return mav;
	}

	// 查看物品单
	@RequestMapping(value = "/thingsNote/{thingsId}", method = RequestMethod.GET)
	public String holidayNote(@PathVariable("thingsId") Integer thingsId, Model model) {
		UserThingsByThingsId userThingsByThingsId = thingsService.selectUserThingsByThingsId(thingsId);

		Task task = taskService.createTaskQuery() // 创建任务查询
				.processInstanceId(userThingsByThingsId.getProcessinstanceid())// 根据流程实例Id查询当前任务
				.singleResult();

		if (task != null) {
			model.addAttribute("approver", task.getAssignee());
		}
		model.addAttribute("userThingsByThingsId", userThingsByThingsId);
		logger.info(SecurityUtils.getSubject().getSession().getAttribute("username") + "=====执行查看报销单");
		return "things/thingsNote";
	}

}
