package com.hanming.oa.controller;

import java.util.List;

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
import com.hanming.oa.model.Reimbursement;
import com.hanming.oa.model.User;
import com.hanming.oa.model.UserReimbursementByReimbursementId;
import com.hanming.oa.service.ReimbursementService;
import com.hanming.oa.service.UserService;

@Controller
@RequestMapping(value = "/admin/reimbursement")
public class ReimbursementController {
	private static final Logger logger = LoggerFactory.getLogger(ReimbursementController.class);

	@Autowired
	UserService userService;
	@Autowired
	ReimbursementService reimbursementService;
	@Autowired
	TaskService taskService;
	@Autowired
	RepositoryService repositoryService;
	@Autowired
	RuntimeService runtimeService;

	// 查询列表
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "state", defaultValue = "状态") String state,
			@RequestParam(value = "type", defaultValue = "类型") String type, Model model) {

		PageInfo<Reimbursement> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<Reimbursement> list = null;
		list = reimbursementService.listLikeStateType(state, type);
		pageInfo = new PageInfo<Reimbursement>(list, 5);

		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("state", state);
		model.addAttribute("type", type);
		logger.info(SecurityUtils.getSubject().getSession().getAttribute("username") + "=====执行报销列表");

		return "reimbursement/reimbursement";
	}

	// 跳转添加报销页面
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addPage(Model model) {
		List<User> list = userService.listNotStaff();
		model.addAttribute("user", list);
		return "reimbursement/add";
	}

	// 我要报销
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Msg add(MultipartFile file, @RequestParam("persons") String persons, Reimbursement reimbursement) {
		reimbursementService.addReimbursement(persons, file, reimbursement);

		logger.info(SecurityUtils.getSubject().getSession().getAttribute("username") + "=====执行添加报销");
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

	// 跳转数据分析页面
	@RequestMapping(value = "/dataAnalysisPage", method = RequestMethod.GET)
	public String dataAnalysisPage() {
		return "reimbursement/analysis";
	}

	// 跳转数据分析
	@ResponseBody
	@RequestMapping(value = "/dataAnalysis", method = RequestMethod.GET)
	public List<Object> dataAnalysis(@RequestParam(value = "date", defaultValue = "2017") String date) {
		List<Object> list = reimbursementService.dataAnalysisByMonth(date);
		
		return list;
	}
	
	//查看报销单
	@RequestMapping(value = "/reimbursementNote/{reimbursementId}", method = RequestMethod.GET)
	public String holidayNote(@PathVariable("reimbursementId") Integer reimbursementId, Model model) {
		UserReimbursementByReimbursementId userReimbursementByReimbursementId = reimbursementService.selectReimbursementByReimbursementId(reimbursementId);

		Task task = taskService.createTaskQuery() // 创建任务查询
				.processInstanceId(userReimbursementByReimbursementId.getProcessinstanceid())// 根据流程实例Id查询当前任务
				.singleResult();
		
		if (task!=null) {
			model.addAttribute("approver", task.getAssignee());
		}
		model.addAttribute("userReimbursementByReimbursementId", userReimbursementByReimbursementId);
		logger.info(SecurityUtils.getSubject().getSession().getAttribute("username") + "=====执行查看报销单");
		return "reimbursement/reimbursementNote";
	}
	
}
