package com.hanming.oa.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.DateTool;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.DetailedRembursement;
import com.hanming.oa.model.Reimbursement;
import com.hanming.oa.model.ReimbursementCollect;
import com.hanming.oa.model.User;
import com.hanming.oa.model.UserReimbursementByReimbursementId;
import com.hanming.oa.service.DeployService;
import com.hanming.oa.service.ReimbursementService;
import com.hanming.oa.service.UpDownFileService;
import com.hanming.oa.service.UserService;

@Controller
@RequestMapping(value = "/admin/reimbursement")
public class ReimbursementController {

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
	@Autowired
	DeployService deployService;
	@Autowired
	UpDownFileService upDownFileService;

	// 查询列表
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "state", defaultValue = "状态") String state,
			@RequestParam(value = "type", defaultValue = "类型") String type,
			@RequestParam(value = "approved", defaultValue = "全部") String approved, Model model) {
		if (approved.equals("已审批")) {
			PageInfo<Reimbursement> pageInfo = null;
			PageHelper.startPage(pn, 8);
			List<Reimbursement> list = null;
			list = reimbursementService.listLikeTypeAndApproved(state, type);
			pageInfo = new PageInfo<Reimbursement>(list, 5);
			model.addAttribute("pageInfo", pageInfo);
		} else {
			PageInfo<Reimbursement> pageInfo = null;
			PageHelper.startPage(pn, 8);
			List<Reimbursement> list = null;
			list = reimbursementService.listLikeStateType(state, type);
			pageInfo = new PageInfo<Reimbursement>(list, 5);
			model.addAttribute("pageInfo", pageInfo);
		}

		model.addAttribute("approved", approved);
		model.addAttribute("state", state);
		model.addAttribute("type", type);

		return "reimbursement/reimbursement";
	}

	// 跳转添加报销页面
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addPage(Model model) {
		List<User> list = userService.listNotStaff();
		List<String> ProcessKey = deployService.selectProcessKey();
		model.addAttribute("processKey", ProcessKey);
		model.addAttribute("user", list);
		return "reimbursement/add";
	}

	// 我要报销
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Msg add(MultipartFile file, @RequestParam("persons") String persons,@Valid Reimbursement reimbursement,BindingResult result,
			HttpServletRequest request, String processDefinitionKey) {
		int i = reimbursementService.addReimbursement(persons, file, reimbursement, request, processDefinitionKey);


		if (i == 1) {
			return Msg.success();
		} else {
			return Msg.fail();
		}
	}

	// 查询当前流程图
	@RequestMapping(value = "/showCurrentView/{processinstanceid}", method = RequestMethod.GET)
	public ModelAndView showCurrentView(@PathVariable("processinstanceid") String processInstanceId) {
		// 视图
		ModelAndView mav = new ModelAndView();

		Task task = taskService.createTaskQuery() // 创建任务查询
				.processInstanceId(processInstanceId)// 根据流程实例Id查询当前任务
				.singleResult();
		
		if (task == null) {
			mav.setViewName("NoView");
			return mav;
		}
		
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
		return mav;
	}

	// 跳转数据分析页面
	@RequestMapping(value = "/dataAnalysisPage", method = RequestMethod.GET)
	public String dataAnalysisPage(Model model) {
		List<Reimbursement> list = reimbursementService.listLikeStateType("状态", "类型");
			Set<String> collect = list.stream()
			.map(Reimbursement::getDate)
			.map((x) -> x.substring(0, 4))
			.collect(Collectors.toSet());
		model.addAttribute("years", collect);
		return "reimbursement/analysis";
	}

	// 跳转数据分析
	@ResponseBody
	@RequestMapping(value = "/dataAnalysis", method = RequestMethod.GET)
	public List<Object> dataAnalysis(@RequestParam(value = "date", defaultValue = "undefined") String date) {
		if ("undefined".equals(date)) {
			date = DateTool.dateToString(new Date()).substring(0, 4);
		}
		List<Object> list = reimbursementService.dataAnalysisByMonth(date);

		return list;
	}

	// 查看报销单
	@RequestMapping(value = "/reimbursementNote/{reimbursementId}", method = RequestMethod.GET)
	public String holidayNote(@PathVariable("reimbursementId") Integer reimbursementId, Model model) {
		UserReimbursementByReimbursementId userReimbursementByReimbursementId = reimbursementService
				.selectReimbursementByReimbursementId(reimbursementId);

		Task task = taskService.createTaskQuery() // 创建任务查询
				.processInstanceId(userReimbursementByReimbursementId.getProcessinstanceid())// 根据流程实例Id查询当前任务
				.singleResult();

		if (task != null) {
			model.addAttribute("approver", task.getAssignee());
		}
		model.addAttribute("userReimbursementByReimbursementId", userReimbursementByReimbursementId);
		return "reimbursement/reimbursementNote";
	}

	// 文件下载
	@RequestMapping(value = "/down/{id}", method = RequestMethod.GET)
	public void down(@PathVariable("id") Integer id, HttpServletResponse response, HttpServletRequest request) {

		UserReimbursementByReimbursementId reimbursementByReimbursementId = reimbursementService
				.selectReimbursementByReimbursementId(id);

		try {
			upDownFileService.down(response, request, reimbursementByReimbursementId, "ExaminationFile");
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	// 获得流程定义的KEY对应的人数
	@ResponseBody
	@RequestMapping(value = "/selectProcessKeyName", method = RequestMethod.GET)
	public Msg numberByKey(@RequestParam("selectProcessKeyName") String key) {
		Integer num = deployService.selectNumByProcessDefinitionKey(key);

		return Msg.success().add("num", num);
	}

	// 删除任务
	@ResponseBody
	@RequestMapping(value = "/dele/{ids}", method = RequestMethod.GET)
	public Msg deleteTask(@PathVariable("ids") String ids) {

		reimbursementService.deleteHolidayTaskByProcessInstanceId(ids);

		return Msg.success();
	}
	
	//跳转数据汇总
	@RequestMapping(value="/dataCollectPage",method=RequestMethod.GET)
	public String dateAggregationPage(@RequestParam(value="pn",defaultValue="1")Integer pn,@RequestParam(value="userName",required = false)String username,
			@RequestParam(value="date",required = false)String date,Model model) {
		PageInfo<ReimbursementCollect> pageInfo = null;
		PageHelper.startPage(pn, 8);
		List<ReimbursementCollect> list =  reimbursementService.dataCollectPage(username,date);
		pageInfo = new PageInfo<>(list,5);
		Set<String> collectDate = list.stream().map(ReimbursementCollect::getDate).collect(Collectors.toSet());
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("userName", username);
		model.addAttribute("date", date);
		model.addAttribute("collectDate", collectDate);
		return "reimbursement/dataAggregation";
	}
	
	@ResponseBody
	@RequestMapping(value="/detailedRembursement",method=RequestMethod.GET)
	public void detailedRembursement(@RequestParam("username")String username,@RequestParam("date")String data) {
		List<DetailedRembursement> detailedRembursement = new ArrayList<>();
		detailedRembursement = reimbursementService.selectByUsernameAndDate(username,data);
	}

}
