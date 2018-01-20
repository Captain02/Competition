package com.hanming.oa.service;

import java.util.HashMap;
import java.util.Map;

import org.activiti.engine.TaskService;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.model.Reimbursement;
import com.hanming.oa.model.UserReimbursementByReimbursementId;

@Service
public class MyReimbursementTaskService {
	
	@Autowired
	TaskService taskService;
	@Autowired
	ReimbursementService reimbursementService;
	@Autowired
	DeployService deployService;
	
	

	public int agreeExamination(String username, UserReimbursementByReimbursementId userReimbursementByReimbursementId,
			String nowComment, String reimbursementId, Integer state) {
		
		Map<String, Object> variables = new HashMap<String, Object>();

		// 根据流程实例ID查询任务对象
		Task task = taskService.createTaskQuery() // 创建任务查询
				.processInstanceId(userReimbursementByReimbursementId.getProcessinstanceid())// 根据流程实例Id查询当前任务
				.singleResult();

		// 修改假条
		Reimbursement reimbursement = new Reimbursement();
		if (state==0) {
			reimbursement.setTest("已通过");
			variables.put("msg", "已通过");
			variables.put("completePeople", username);
		}else if (state==1) {
			reimbursement.setTest("未通过");
			variables.put("msg", "未通过");
			variables.put("completePeople", username);
		}else {
			
			//判断是否有下一审批人
			int i = deployService.getNextTaskNodeByProcessInstanceId(userReimbursementByReimbursementId.getProcessinstanceid());
			if (i==0) {
				return 0;
			}
			
			variables.put("msg", "审核中");
			variables.put("completePeople", username);
		}
//		reimbursement.setTest("审核通过");
		reimbursement.setId(userReimbursementByReimbursementId.getId());
		reimbursementService.updateReimbursement(reimbursement);

//		// 设置流程变量
//		variables.put("getHolidaydays", userReimbursementByReimbursementId.getHolidaydays());
		// 设置用户id
		Authentication.setAuthenticatedUserId(username);
		// 添加批注信息
		taskService.addComment(task.getId(), userReimbursementByReimbursementId.getProcessinstanceid(), nowComment);
		// 完成任务
		taskService.complete(task.getId(), variables);
		return 1;
	}
	


}
