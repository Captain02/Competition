package com.hanming.oa.service;

import java.util.HashMap;
import java.util.Map;

import org.activiti.engine.TaskService;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.model.Holiday;
import com.hanming.oa.model.Things;
import com.hanming.oa.model.UserThingsByThingsId;

@Service
public class MyThingsTaskService {

	@Autowired
	TaskService taskService;
	@Autowired
	HolidayService holidayService;
	@Autowired
	DeployService deployService;
	@Autowired
	ThingsService thingsService;

	public int agreeExamination(String username, UserThingsByThingsId userThingsByThingsId, String nowComment,
			String thingsId, int state) {
		Map<String, Object> variables = new HashMap<String, Object>();

		// 根据流程实例ID查询任务对象
		Task task = taskService.createTaskQuery() // 创建任务查询
				.processInstanceId(userThingsByThingsId.getProcessinstanceid())// 根据流程实例Id查询当前任务
				.singleResult();

		// 修改假条
		Things things = new Things();
		things.setId(userThingsByThingsId.getId());
		if (state == 0) {
			things.setState("已通过");
			variables.put("msg", "已通过");
			variables.put("completePeople", username);
			thingsService.updateThings(things);
		} else if (state == 1) {
			things.setState("已通过");
			variables.put("msg", "未通过");
			variables.put("completePeople", username);
			thingsService.updateThings(things);
		} else {
			
			//判断是否有下一审批人
			int i = deployService.getNextTaskNodeByProcessInstanceId(userThingsByThingsId.getProcessinstanceid());
			if (i==0) {
				return 0;
			}
			
			variables.put("msg", "审核中");
			variables.put("completePeople", username);
		}

		// 设置用户id
		Authentication.setAuthenticatedUserId(username);
		// 添加批注信息
		taskService.addComment(task.getId(), userThingsByThingsId.getProcessinstanceid(), nowComment);
		// 完成任务
		taskService.complete(task.getId(), variables);
		return 1;

	}

}
