package com.hanming.oa.service;

import java.util.HashMap;
import java.util.Map;

import org.activiti.engine.HistoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hanming.oa.model.Holiday;
import com.hanming.oa.model.UserHolidayByHolidayId;

@Service
public class MyHolidayTaskService {

	@Autowired
	TaskService taskService;
	@Autowired
	HolidayService holidayService;
	@Autowired
	DeployService deployService;

	
	@Transactional
	public int agreeExamination(String username, UserHolidayByHolidayId userHolidayByHolidayId, String nowComment, String holidayId,Integer state) {
		Map<String, Object> variables = new HashMap<String, Object>();

		// 根据流程实例ID查询任务对象
		Task task = taskService.createTaskQuery() // 创建任务查询
				.processInstanceId(userHolidayByHolidayId.getProcessinstanceid())// 根据流程实例Id查询当前任务
				.singleResult();

		// 修改假条
		Holiday holiday = new Holiday();
		holiday.setId(userHolidayByHolidayId.getId());
		if (state==0) {
			holiday.setTest("已通过");
			variables.put("msg", "已通过");
			variables.put("completePeople", username);
			holidayService.updateHoliday(holiday);
		}else if (state==1) {
			holiday.setTest("未通过");
			variables.put("msg", "未通过");
			variables.put("completePeople", username);
			holidayService.updateHoliday(holiday);
		}else {
			
			//判断是否有下一审批人
			int i = deployService.getNextTaskNodeByProcessInstanceId(userHolidayByHolidayId.getProcessinstanceid());
			if (i==0) {
				return 0;
			}
			
			variables.put("msg", "审核中");
			variables.put("completePeople", username);
		}

		// 设置流程变量
		variables.put("getHolidaydays", userHolidayByHolidayId.getHolidaydays());
		// 设置用户id
		Authentication.setAuthenticatedUserId(username);
		// 添加批注信息
		taskService.addComment(task.getId(), userHolidayByHolidayId.getProcessinstanceid(), nowComment);
		// 完成任务
		taskService.complete(task.getId(), variables);
		return 1;
	}


}
