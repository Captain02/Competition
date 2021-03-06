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
import com.hanming.oa.model.Holiday;
import com.hanming.oa.model.HolidayAndExaminationTime;
import com.hanming.oa.model.User;
import com.hanming.oa.model.UserHolidayByHolidayId;
import com.hanming.oa.service.HolidayService;
import com.hanming.oa.service.MyHolidayTaskService;
import com.hanming.oa.service.UserService;

@Controller
@RequestMapping("/admin/myHolidayTask")
public class MyHolidayTaskController {

	@Autowired
	TaskService taskService;
	@Autowired
	HolidayService holidayService;
	@Autowired
	HistoryService historyService;
	@Autowired
	MyHolidayTaskService myHolidayTaskService;
	@Autowired
	UserService userService;

	// 查询指派给我的假期审批
	@RequestMapping(value = "/myHolidayTask", method = RequestMethod.GET)
	public String list(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "state", defaultValue = "状态") String state,
			@RequestParam(value = "type", defaultValue = "类型") String type,
			@RequestParam(value = "herfPage", defaultValue = "0") String herfPage, Model model) {
		String username = (String) SecurityUtils.getSubject().getSession().getAttribute("username");
		List<Holiday> list = new ArrayList<>();
		List<String> listProcessinstanceid = new ArrayList<>();

		// 查询指派给我的假期任务
		if (Integer.parseInt(herfPage) == 0) {
			List<Task> Tasks = taskService.createTaskQuery().taskAssignee(username).list();
			for (Task task : Tasks) {
				Holiday holiday = holidayService
						.selectHolidayByProcessInstanceIdLikeStateType(task.getProcessInstanceId(), state, type);
				if (holiday != null) {
					listProcessinstanceid.add(holiday.getProcessinstanceid());
				}
			}
			if (listProcessinstanceid.size() > 0) {
				PageInfo<Holiday> pageInfo = null;
				PageHelper.startPage(pn, 12);
				list = holidayService.selectListHolidayByProcessInstanceId(listProcessinstanceid);
				pageInfo = new PageInfo<Holiday>(list, 5);

				model.addAttribute("pageInfo", pageInfo);
			}
		}

		// 查询由我创建的假期任务
		if (Integer.parseInt(herfPage) == 1) {
			Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
			PageInfo<Holiday> pageInfo = null;
			PageHelper.startPage(pn, 12);
			list = holidayService.selectCreatByMeLikeStateType(userId, state, type);
			pageInfo = new PageInfo<Holiday>(list, 5);
			model.addAttribute("pageInfo", pageInfo);
		}

		// 查询由我解决的假期任务
		if (Integer.parseInt(herfPage) == 2) {
			PageInfo<HolidayAndExaminationTime> pageInfo2 = null;
			PageHelper.startPage(pn, 12);
			List<HolidayAndExaminationTime> holidayAndExaminationTimelist = holidayService
					.selectExaminationByMeLikeStateType(username, state, type);
			pageInfo2 = new PageInfo<HolidayAndExaminationTime>(holidayAndExaminationTimelist, 5);

			model.addAttribute("pageInfo", pageInfo2);
		}

		// 查询由我完成的假期任务
		if (Integer.parseInt(herfPage) == 3) {

			PageInfo<HolidayAndExaminationTime> pageInfo2 = null;
			PageHelper.startPage(pn, 12);
			List<HolidayAndExaminationTime> holidayAndExaminationTimelist = holidayService
					.selectCompleteByMeLikeStateType(username, state, type);
			pageInfo2 = new PageInfo<HolidayAndExaminationTime>(holidayAndExaminationTimelist, 5);

			model.addAttribute("pageInfo", pageInfo2);
		}

		List<User> userlist = userService.list();
		model.addAttribute("userlist", userlist);

		model.addAttribute("state", state);
		model.addAttribute("type", type);
		model.addAttribute("herfPage", herfPage);

		return "myHolidayTask/myHolidayTask";
	}

	// 转发到批注页面
	@RequestMapping(value = "/examinationPage/{holidayId}/{pn}", method = RequestMethod.GET)
	public String examinationPage(@PathVariable("pn") Integer pn, @PathVariable("holidayId") Integer holidayId,
			Model model) {
		UserHolidayByHolidayId userHolidayByHolidayId = holidayService.selectHolidayByHolidayId(holidayId);

		// 根据流程实例ID查询任务对象
		Task task = taskService.createTaskQuery() // 创建任务查询
				.processInstanceId(userHolidayByHolidayId.getProcessinstanceid())// 根据流程实例Id查询当前任务
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
				"".equals(userHolidayByHolidayId.getFilename()) ? "没有附件" : userHolidayByHolidayId.getFilename());
		model.addAttribute("comment", commentList);
		model.addAttribute("userHolidayByHolidayId", userHolidayByHolidayId);

		model.addAttribute("pn", pn);

		return "myHolidayTask/holidayExamination";
	}

	// 是否同意请假
	@ResponseBody
	@RequestMapping(value = "/agreeExamination", method = RequestMethod.POST)
	public Msg agreeExamination(UserHolidayByHolidayId userHolidayByHolidayId,
			@RequestParam("nowComment") String nowComment, @RequestParam("id") String holidayId,
			@RequestParam("state") String state) {
		String username = (String) SecurityUtils.getSubject().getSession().getAttribute("username");
		int i = myHolidayTaskService.agreeExamination(username, userHolidayByHolidayId, nowComment, holidayId,
				Integer.parseInt(state));

		if (i == 1) {
			if (Integer.parseInt(state) == 1) {
				return Msg.success().add("state", state);
			} else if (Integer.parseInt(state) == 0) {
				return Msg.success().add("state", state);
			} else {
				return Msg.success().add("state", state);
			}
		}else {
			return Msg.fail().add("NoNextNode", "NoNextNode");
		}
	}

	// 指派任务
	@ResponseBody
	@RequestMapping(value = "/assignTask", method = RequestMethod.POST)
	public Msg assignTask(@RequestParam("assignHolidayProcessinstanceid") String assignHolidayProcessinstanceid,
			@RequestParam("assignUsername") String assignUsername) {
		System.out.println(assignHolidayProcessinstanceid);
		System.out.println(assignUsername);
		Task task = taskService.createTaskQuery() // 创建任务查询
				.processInstanceId(assignHolidayProcessinstanceid)// 根据流程实例Id查询当前任务
				.singleResult();
		task.setAssignee(assignUsername);
		taskService.saveTask(task);

		return Msg.success();
	}
}
