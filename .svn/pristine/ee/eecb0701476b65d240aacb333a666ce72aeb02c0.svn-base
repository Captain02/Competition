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

	
	@Transactional
	public int agreeExamination(String username, UserHolidayByHolidayId userHolidayByHolidayId, String nowComment, String holidayId,Integer state) {
		Map<String, Object> variables = new HashMap<String, Object>();

		// 根据流程实例ID查询任务对象
		Task task = taskService.createTaskQuery() // 创建任务查询
				.processInstanceId(userHolidayByHolidayId.getProcessinstanceid())// 根据流程实例Id查询当前任务
				.singleResult();

		// 修改假条
		Holiday holiday = new Holiday();
		if (state==0) {
			holiday.setTest("审核通过");
			variables.put("msg", "通过");
			variables.put("completePeople", username);
		}else if (state==1) {
			holiday.setTest("审核不通过");
			variables.put("completePeople", username);
		}else {
			holiday.setTest("审核中");
			variables.put("msg", "审核中");
		}
		holiday.setTest("审核通过");
		holiday.setId(userHolidayByHolidayId.getId());
		holidayService.updateHoliday(holiday);

		// 设置流程变量
		variables.put("getHolidaydays", userHolidayByHolidayId.getHolidaydays());
		// 设置用户id
		Authentication.setAuthenticatedUserId(userHolidayByHolidayId.getName());
		// 添加批注信息
		taskService.addComment(task.getId(), userHolidayByHolidayId.getProcessinstanceid(), nowComment);
		// 完成任务
		taskService.complete(task.getId(), variables);
		return 1;
	}


}
