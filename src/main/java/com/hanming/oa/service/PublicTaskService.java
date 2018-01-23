package com.hanming.oa.service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.activiti.engine.HistoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PublicTaskService {

	@Autowired
	TaskService taskService;
	@Autowired
	HistoryService historyService;

	// 根据流程实例ID删除任务
	public void deleTaskByProcessInstanceId(List<String> idsList) {

		Set<Task> taskList = new HashSet<>();

		for (String string : idsList) {
			List<Task> list = taskService.createTaskQuery().processInstanceId(string).list();
			taskList.addAll(list);
		}

		List<String> list = taskList.stream().map(Task::getId).collect(Collectors.toList());
		System.out.println(list);
		taskService.deleteTasks(list,true);

		for (String string : idsList) {
			historyService.deleteHistoricProcessInstance(string);
		}

	}
}
