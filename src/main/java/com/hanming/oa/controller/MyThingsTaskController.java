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
import com.hanming.oa.model.Things;
import com.hanming.oa.model.ThingsAndExaminationTime;
import com.hanming.oa.model.User;
import com.hanming.oa.model.UserThingsByThingsId;
import com.hanming.oa.service.MyThingsTaskService;
import com.hanming.oa.service.ThingsService;
import com.hanming.oa.service.UserService;

@Controller
@RequestMapping("/admin/myThingsTask")
public class MyThingsTaskController {
	private static final Logger logger = LoggerFactory.getLogger(MyThingsTaskController.class);

	@Autowired
	TaskService taskService;
	@Autowired
	UserService userService;
	@Autowired
	ThingsService thingsService;
	@Autowired
	HistoryService historyService;
	@Autowired
	MyThingsTaskService myThingsTaskService;

	@RequestMapping(value = "/myThingsTask", method = RequestMethod.GET)
	public String myThingsTask(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "state", defaultValue = "状态") String state,
			@RequestParam(value = "name", defaultValue = "") String name,
			@RequestParam(value = "herfPage", defaultValue = "0") String herfPage, Model model) {

		String username = (String) SecurityUtils.getSubject().getSession().getAttribute("username");
		List<Things> list = new ArrayList<>();
		List<String> listProcessinstanceid = new ArrayList<>();

		// 查询指派给我的报销
		if (Integer.parseInt(herfPage) == 0) {
			List<Task> Tasks = taskService.createTaskQuery().taskAssignee(username).list();
			for (Task task : Tasks) {
				Things things = thingsService.selectThingsByProcessInstanceIdLikeStateName(task.getProcessInstanceId(),
						state, name);
				if (things != null) {
					listProcessinstanceid.add(things.getProcessinstanceid());
				}
			}
			if (listProcessinstanceid.size() > 0) {
				PageInfo<Things> pageInfo = null;
				PageHelper.startPage(pn, 12);
				list = thingsService.selectListThingsByProcessInstanceId(listProcessinstanceid);
				pageInfo = new PageInfo<Things>(list, 5);

				model.addAttribute("pageInfo", pageInfo);
			}
			logger.info(username + "=====查询指派给我的报销");
		}

		// 查询由我创建的报销
		if (Integer.parseInt(herfPage) == 1) {
			Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
			PageInfo<Things> pageInfo = null;
			PageHelper.startPage(pn, 12);
			list = thingsService.selectCreatByMeLikeStateName(userId, state, name);
			pageInfo = new PageInfo<Things>(list, 5);

			model.addAttribute("pageInfo", pageInfo);
			logger.info(username + "=====查询由我创建的报销");
		}

		// 查询由我解决的报销
		if (Integer.parseInt(herfPage) == 2) {
			PageInfo<ThingsAndExaminationTime> pageInfo2 = null;
			PageHelper.startPage(pn, 12);
			List<ThingsAndExaminationTime> thingsAndExaminationTime = thingsService
					.selectExaminationByMeLikeStateName(username, state, name);
			pageInfo2 = new PageInfo<ThingsAndExaminationTime>(thingsAndExaminationTime, 5);

			model.addAttribute("pageInfo", pageInfo2);
			logger.info(username + "=====查询由我解决的报销");
		}

		// 查询由我完成的报销
		if (Integer.parseInt(herfPage) == 3) {
			PageInfo<ThingsAndExaminationTime> pageInfo2 = null;
			PageHelper.startPage(pn, 12);
			List<ThingsAndExaminationTime> thingsAndExaminationTime = thingsService
					.selectCompleteByMeLikeStateName(username, state, name);
			pageInfo2 = new PageInfo<ThingsAndExaminationTime>(thingsAndExaminationTime, 5);

			model.addAttribute("pageInfo", pageInfo2);
			logger.info(username + "=====查询由我完成的报销");
		}

		List<User> userlist = userService.list();
		model.addAttribute("userlist", userlist);

		model.addAttribute("state", state);
		model.addAttribute("name", name);
		model.addAttribute("herfPage", herfPage);

		return "myThingsTask/myThingsTask";
	}

	// 指派任务
	@ResponseBody
	@RequestMapping(value = "/assignTask", method = RequestMethod.POST)
	public Msg assignTask(@RequestParam("assignThingProcessinstanceid") String assignThingProcessinstanceid,
			@RequestParam("assignUsername") String assignUsername) {
		Task task = taskService.createTaskQuery() // 创建任务查询
				.processInstanceId(assignThingProcessinstanceid)// 根据流程实例Id查询当前任务
				.singleResult();
		task.setAssignee(assignUsername);
		taskService.saveTask(task);

		logger.info(SecurityUtils.getSubject().getSession().getAttribute("username") + "=====指派物品申请任务");
		return Msg.success();
	}

	// 转发到批注页面
	@RequestMapping(value = "/examinationPage/{thingsId}/{pn}", method = RequestMethod.GET)
	public String examinationPage(@PathVariable("pn") Integer pn, @PathVariable("thingsId") Integer thingsId,
			Model model) {
		UserThingsByThingsId userThingsByThingsId = thingsService.selectUserThingsByThingsId(thingsId);

		// 根据流程实例ID查询任务对象
		Task task = taskService.createTaskQuery() // 创建任务查询
				.processInstanceId(userThingsByThingsId.getProcessinstanceid())// 根据流程实例Id查询当前任务
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
				"".equals(userThingsByThingsId.getFilename()) ? "没有附件" : userThingsByThingsId.getFilename());
		model.addAttribute("comment", commentList);
		model.addAttribute("userThingsByThingsId", userThingsByThingsId);

		model.addAttribute("pn", pn);
		logger.info(SecurityUtils.getSubject().getSession().getAttribute("username") + "=====跳转审批假条页面");

		return "myThingsTask/thingsExamination";
	}

	// 是否同意物品
	@ResponseBody
	@RequestMapping(value = "/agreeExamination", method = RequestMethod.POST)
	public Msg agreeExamination(UserThingsByThingsId userThingsByThingsId,
			@RequestParam("nowComment") String nowComment, @RequestParam("id") String thingsId,
			@RequestParam("state") String state) {
		String username = (String) SecurityUtils.getSubject().getSession().getAttribute("username");
		int i = myThingsTaskService.agreeExamination(username, userThingsByThingsId, nowComment, thingsId,
				Integer.parseInt(state));
		if (i == 1) {
			if (Integer.parseInt(state) == 1) {
				logger.info(username + "=====跳转不同意物品审批");
				return Msg.success().add("state", state);
			} else if (Integer.parseInt(state) == 0) {
				logger.info(username + "=====跳转同意物品审批");
				return Msg.success().add("state", state);
			} else {
				logger.info(username + "=====向下一个人递送物品审批");
				return Msg.success().add("state", state);
			}
		} else {
			return Msg.fail().add("NoNextNode", "NoNextNode");
		}
	}

}
