package com.hanming.oa.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.zip.ZipInputStream;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.runtime.ProcessInstance;
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

	//流程部署
	@Transactional
	public void addDeploye(MultipartFile file, Integer num) {
		Deployment deploy;
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

}
