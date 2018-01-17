package com.hanming.oa.controller;

import java.util.ArrayList;
import java.util.List;

import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.model.Things;
import com.hanming.oa.model.ThingsAndExaminationTime;
import com.hanming.oa.model.User;
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
	
	@RequestMapping(value="/myThingsTask",method=RequestMethod.GET)
	public String myThingsTask(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "state", defaultValue = "状态") String state,
			@RequestParam(value = "name", defaultValue = "") String name,
			@RequestParam(value = "herfPage", defaultValue = "0") String herfPage, Model model){

		String username = (String) SecurityUtils.getSubject().getSession().getAttribute("username");
		List<Things> list = new ArrayList<>();
		List<String> listProcessinstanceid = new ArrayList<>();

		// 查询指派给我的报销
		if (Integer.parseInt(herfPage) == 0) {
			List<Task> Tasks = taskService.createTaskQuery().taskAssignee(username).list();
			for (Task task : Tasks) {
				Things things = thingsService
						.selectThingsByProcessInstanceIdLikeStateName(task.getProcessInstanceId(), state, name);
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

}
