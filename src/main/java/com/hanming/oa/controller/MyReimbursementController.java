package com.hanming.oa.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.activiti.engine.HistoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.task.Comment;
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

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.Reimbursement;
import com.hanming.oa.model.ReimbursementAndExaminationTime;
import com.hanming.oa.model.User;
import com.hanming.oa.model.UserReimbursementByReimbursementId;
import com.hanming.oa.service.MyReimbursementTaskService;
import com.hanming.oa.service.ReimbursementService;
import com.hanming.oa.service.UserService;

@Controller
@RequestMapping("/admin/myReimbursementTask")
public class MyReimbursementController {
	private static final Logger logger = LoggerFactory.getLogger(MyReimbursementController.class);

	@Autowired
	TaskService taskService;
	@Autowired
	ReimbursementService reimbursementService;
	@Autowired
	HistoryService historyService;
	@Autowired
	MyReimbursementTaskService myReimbursementTaskService;
	@Autowired
	UserService userService;

	@RequestMapping(value = "/myReimbursementTask", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "state", defaultValue = "状态") String state,
			@RequestParam(value = "type", defaultValue = "类型") String type,
			@RequestParam(value = "herfPage", defaultValue = "0") String herfPage, Model model) {

		String username = (String) SecurityUtils.getSubject().getSession().getAttribute("username");
		List<Reimbursement> list = new ArrayList<>();
		List<String> listProcessinstanceid = new ArrayList<>();

		// 查询指派给我的报销
		if (Integer.parseInt(herfPage) == 0) {
			List<Task> Tasks = taskService.createTaskQuery().taskAssignee(username).list();
			for (Task task : Tasks) {
				Reimbursement reimbursement = reimbursementService
						.selectReimbursementByProcessInstanceIdLikeStateType(task.getProcessInstanceId(), state, type);
				if (reimbursement != null) {
					listProcessinstanceid.add(reimbursement.getProcessinstanceid());
				}
			}
			if (listProcessinstanceid.size() > 0) {
				PageInfo<Reimbursement> pageInfo = null;
				PageHelper.startPage(pn, 12);
				list = reimbursementService.selectListReimbursementByProcessInstanceId(listProcessinstanceid);
				pageInfo = new PageInfo<Reimbursement>(list, 5);

				model.addAttribute("pageInfo", pageInfo);
			}
			logger.info(username + "=====查询指派给我的报销");
		}

		// 查询由我创建的报销
		if (Integer.parseInt(herfPage) == 1) {
			Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
			PageInfo<Reimbursement> pageInfo = null;
			PageHelper.startPage(pn, 12);
			list = reimbursementService.selectCreatByMeLikeStateType(userId, state, type);
			pageInfo = new PageInfo<Reimbursement>(list, 5);

			model.addAttribute("pageInfo", pageInfo);
			logger.info(username + "=====查询由我创建的报销");
		}

		// 查询由我解决的报销
		if (Integer.parseInt(herfPage) == 2) {
			PageInfo<ReimbursementAndExaminationTime> pageInfo2 = null;
			PageHelper.startPage(pn, 12);
			List<ReimbursementAndExaminationTime> reimbursementAndExaminationTimelist = reimbursementService
					.selectExaminationByMeLikeStateType(username, state, type);
			pageInfo2 = new PageInfo<ReimbursementAndExaminationTime>(reimbursementAndExaminationTimelist, 5);

			model.addAttribute("pageInfo", pageInfo2);
			logger.info(username + "=====查询由我解决的报销");
		}

		// 查询由我完成的报销
		if (Integer.parseInt(herfPage) == 3) {
			PageInfo<ReimbursementAndExaminationTime> pageInfo2 = null;
			PageHelper.startPage(pn, 12);
			List<ReimbursementAndExaminationTime> reimbursementExaminationTimelist = reimbursementService
					.selectCompleteByMeLikeStateType(username, state, type);
			pageInfo2 = new PageInfo<ReimbursementAndExaminationTime>(reimbursementExaminationTimelist, 5);

			model.addAttribute("pageInfo", pageInfo2);
			logger.info(username + "=====查询由我完成的报销");
		}

		List<User> userlist = userService.list();
		model.addAttribute("userlist", userlist);

		model.addAttribute("state", state);
		model.addAttribute("type", type);
		model.addAttribute("herfPage", herfPage);

		return "myReimbursement/myReimbursementTask";
	}

	// 转发到批注页面
	@RequestMapping(value = "/examinationPage/{reimbursementId}/{pn}", method = RequestMethod.GET)
	public String examinationPage(@PathVariable("pn") Integer pn,
			@PathVariable("reimbursementId") Integer reimbursementId, Model model) {
		UserReimbursementByReimbursementId userReimbursementByReimbursementId = reimbursementService
				.selectReimbursementByReimbursementId(reimbursementId);

		// 根据流程实例ID查询任务对象
		Task task = taskService.createTaskQuery() // 创建任务查询
				.processInstanceId(userReimbursementByReimbursementId.getProcessinstanceid())// 根据流程实例Id查询当前任务
				.singleResult();

		// 根据任务ID查询历史任务流程
		HistoricTaskInstance hti = historyService.createHistoricTaskInstanceQuery().taskId(task.getId()).singleResult();

		// 封装审批记录
		List<Comment> commentList = null;
		if (hti != null) {
			commentList = taskService.getProcessInstanceComments(hti.getProcessInstanceId());
			// 集合元素反转
			Collections.reverse(commentList);
		}

		model.addAttribute("enclosureName",
				"".equals(userReimbursementByReimbursementId.getEnclosure().substring(14)) ? "没有附件"
						: userReimbursementByReimbursementId.getEnclosure().substring(14));
		model.addAttribute("comment", commentList);
		model.addAttribute("userReimbursementByReimbursementId", userReimbursementByReimbursementId);

		model.addAttribute("pn", pn);
		logger.info(SecurityUtils.getSubject().getSession().getAttribute("username") + "=====跳转审批假条页面");

		return "myReimbursement/reimbursementExamination";
	}

	// 指派任务
	@ResponseBody
	@RequestMapping(value = "/assignTask", method = RequestMethod.POST)
	public Msg assignTask(@RequestParam("assignProcessinstanceid") String assignProcessinstanceid,
			@RequestParam("assignUsername") String assignUsername) {
		System.out.println("+++++++++++++++++"+assignProcessinstanceid);
		System.out.println("++++++"+assignUsername);
		Task task = taskService.createTaskQuery() // 创建任务查询
				.processInstanceId(assignProcessinstanceid)// 根据流程实例Id查询当前任务
				.singleResult();
		task.setAssignee(assignUsername);
		taskService.saveTask(task);

		logger.info(SecurityUtils.getSubject().getSession().getAttribute("username") + "=====指派请假任务");
		return Msg.success();
	}

}
