package com.hanming.oa.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.zip.ZipInputStream;

import org.activiti.engine.HistoryService;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.hanming.oa.dao.DeployeMapper;

@Service
public class DeployService {

	@Autowired
	RepositoryService repositoryService;
	@Autowired
	RuntimeService runtimeService;
	@Autowired
	HistoryService historyService;
	@Autowired
	HolidayService holidayService;
	@Autowired
	ReimbursementService reimbursementService;
	@Autowired
	DeployeMapper deployeMapper;
	@Autowired
	DeployService deployService;
	@Autowired
	TaskService taskService;
	@Autowired
	ProcessEngine processEngine;

	// 删除流程部署
	@Transactional
	public void deleDeploy(String ids) {
		if (ids.contains("-")) {
			String[] idsStr = ids.split("-");
			List<String> strList = Arrays.asList(idsStr);
			List<String> processInstanceIds = getProcessInstanceIdByMultipleDeploymentId(strList);
			if (processInstanceIds.size() > 0) {
				holidayService.deleteHolidayByProcessInstanceId(processInstanceIds);
				reimbursementService.deleteReimbursementServiceByProcessInstanceId(processInstanceIds);
			}
			for (String string : idsStr) {
				repositoryService.deleteDeployment(string, true);
			}
		} else {
			List<String> processInstanceId = getProcessInstanceIdBySingleDeploymentId(ids);
			if (processInstanceId.size() > 0) {
				holidayService.deleteHolidayByProcessInstanceId(processInstanceId);
				reimbursementService.deleteReimbursementServiceByProcessInstanceId(processInstanceId);
			}
			repositoryService.deleteDeployment(ids, true);
		}
	}

	public List<String> getProcessInstanceIdBySingleDeploymentId(String deploymentId) {
		List<String> listProcessInstance = new ArrayList<>();
		List<ProcessInstance> list1 = runtimeService.createProcessInstanceQuery().deploymentId(deploymentId).list();
		List<HistoricProcessInstance> list2 = historyService.createHistoricProcessInstanceQuery()
				.deploymentId(deploymentId).list();
		for (ProcessInstance processInstance : list1) {
			listProcessInstance.add(processInstance.getId());
		}
		for (HistoricProcessInstance historicProcessInstance : list2) {
			listProcessInstance.add(historicProcessInstance.getId());
		}
		return listProcessInstance;
	}

	public List<String> getProcessInstanceIdByMultipleDeploymentId(List<String> str) {
		List<String> listProcessInstance = new ArrayList<>();
		List<ProcessInstance> list1 = runtimeService.createProcessInstanceQuery().deploymentIdIn(str).list();
		List<HistoricProcessInstance> list2 = historyService.createHistoricProcessInstanceQuery().deploymentIdIn(str)
				.list();
		for (ProcessInstance processInstance : list1) {
			listProcessInstance.add(processInstance.getId());
		}
		for (HistoricProcessInstance historicProcessInstance : list2) {
			listProcessInstance.add(historicProcessInstance.getId());
		}
		return listProcessInstance;
	}

	public void updataPersonNumberByDeployId(String id, Integer num) {
		deployeMapper.updataPersonNumberByDeployId(id, num);
	}

	// 流程部署
	@Transactional
	public void addDeploye(MultipartFile file, Integer num) {
		
		Deployment deploy = null;
		try {
			// 开始部署
			deploy = repositoryService.createDeployment()// 创建部署
					.name(file.getOriginalFilename())// 需要部署流程名称
					.addZipInputStream(new ZipInputStream(file.getInputStream()))// 添加zip输入流
					.deploy();
			deployService.updataPersonNumberByDeployId(deploy.getId(), num);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	// 根据当前流程实例获取下一节点
	public int getNextTaskNodeByProcessInstanceId(String processinstanceid) {
		// 1、首先是根据流程ID获取当前任务：
		List<Task> tasks = taskService.createTaskQuery().processInstanceId(processinstanceid).list();
		String nextId = "";
		for (Task task : tasks) {
			RepositoryService rs = processEngine.getRepositoryService();
			// 2、然后根据当前任务获取当前流程的流程定义，然后根据流程定义获得所有的节点：
			ProcessDefinitionEntity def = (ProcessDefinitionEntity) ((RepositoryServiceImpl) rs)
					.getDeployedProcessDefinition(task.getProcessDefinitionId());
			List<ActivityImpl> activitiList = def.getActivities(); // rs是指RepositoryService的实例
			// 3、根据任务获取当前流程执行ID，执行实例以及当前流程节点的ID：
			String excId = task.getExecutionId();
			RuntimeService runtimeService = processEngine.getRuntimeService();
			ExecutionEntity execution = (ExecutionEntity) runtimeService.createExecutionQuery().executionId(excId)
					.singleResult();
			String activitiId = execution.getActivityId();
			// 4、然后循环activitiList
			// 并判断出当前流程所处节点，然后得到当前节点实例，根据节点实例获取所有从当前节点出发的路径，然后根据路径获得下一个节点实例：
			for (ActivityImpl activityImpl : activitiList) {
				String id = activityImpl.getId();
				if (activitiId.equals(id)) {
					// logger.debug("当前任务：" + activityImpl.getProperty("name")); // 输出某个节点的某种属性
					List<PvmTransition> outTransitions = activityImpl.getOutgoingTransitions();// 获取从某个节点出来的所有线路
					for (PvmTransition tr : outTransitions) {
						PvmActivity ac = tr.getDestination(); // 获取线路的终点节点
						// logger.debug("下一步任务任务：" + ac.getProperty("name"));
						nextId = ac.getId();
					}
					break;
				}
			}
		}
		if (nextId.contains("endevent")) {
			return 0;
		} else {
			return 1;
		}

	}

	public List<String> selectProcessKey() {
		List<String> list = deployeMapper.selectProcessKey();
		return list;
	}

	public Integer selectNumByProcessDefinitionKey(String key) {
		Integer num = deployeMapper.selectNumByProcessDefinitionKey(key);
		return num;
	}

}
