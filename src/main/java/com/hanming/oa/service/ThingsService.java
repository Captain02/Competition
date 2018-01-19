package com.hanming.oa.service;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.hanming.oa.dao.ThingsMapper;
import com.hanming.oa.dao.UserThingsMapper;
import com.hanming.oa.model.Things;
import com.hanming.oa.model.ThingsAndExaminationTime;
import com.hanming.oa.model.UserThings;
import com.hanming.oa.model.UserThingsByThingsId;

@Service
public class ThingsService {

	@Autowired
	ThingsMapper thingsMapper;
	@Autowired
	RuntimeService runtimeService;
	@Autowired
	TaskService taskService;
	@Autowired
	UserThingsMapper userThingsMapper;

	public List<Things> listLikeStateType(String state, String name) {
		List<Things> list = thingsMapper.listLikeStateType(state, name);
		return list;
	}

	public int addThings(String persons, MultipartFile file, Things things, HttpServletRequest request,
			String processDefinitionKey) {
		Map<String, Object> variables = new HashMap<String, Object>();
		variables.put("Ass1", SecurityUtils.getSubject().getSession().getAttribute("username"));
		if (!("".equals(persons))) {
			if (persons.contains("-")) {
				String[] personsStr = persons.split("-");
				for (int i = 0; i < personsStr.length; i++) {
					variables.put("Ass" + (i + 2), personsStr[i]);
				}
			}
		}

		// 添加相关数据
		things.setState("审核中");
		if (file != null || file.getOriginalFilename() != null || !("".equals(file.getOriginalFilename()))) {
			String path = request.getSession().getServletContext().getRealPath("upload");
			things.setEnclosure(new Date().toString().replace(":", "-") + file.getOriginalFilename());
			things.setFilename(file.getOriginalFilename());
			File dir = new File(path, new Date().toString().replace(":", "-") + file.getOriginalFilename());
			if (!dir.exists()) {
				dir.mkdirs();
			}

			try {
				file.transferTo(dir);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		UserThings userThings = new UserThings();
		userThings.setUserid((Integer) SecurityUtils.getSubject().getSession().getAttribute("id"));
		insertThings(things);
		userThings.setThingsid(things.getId());
		insertUserThings(userThings);
		// 设置启动流程变量
		variables.put("thingsId", things.getId());

		if (processDefinitionKey.equals("请选择一个审批流程")) {
			return 0;
		} else {
			// 启动流程
			ProcessInstance pi = runtimeService.startProcessInstanceByKey(processDefinitionKey, variables);
			// 根据流程实例Id查询任务
			Task task = taskService.createTaskQuery().processInstanceId(pi.getProcessInstanceId()).singleResult();
			// 完成 学生填写请假单任务
			taskService.complete(task.getId());
			// 修改状态
			things.setProcessinstanceid(pi.getProcessInstanceId());
			updateThings(things);
			return 1;
		}
	}

	private void updateThings(Things things) {
		thingsMapper.updateByPrimaryKeySelective(things);
	}

	private void insertUserThings(UserThings userThings) {
		userThingsMapper.updateByPrimaryKeySelective(userThings);
	}

	private void insertThings(Things things) {
		thingsMapper.insertSelective(things);
	}

	public UserThingsByThingsId selectUserThingsByThingsId(Integer thingsId) {
		UserThingsByThingsId userThingsByThingsId = thingsMapper.selectUserThingsByThingsId(thingsId);
		return userThingsByThingsId;
	}

	public Things selectThingsByProcessInstanceIdLikeStateName(String processInstanceId, String state, String name) {
		Things things = thingsMapper.selectThingsByProcessInstanceIdLikeStateName(processInstanceId, state, name);

		return things;
	}

	public List<Things> selectListThingsByProcessInstanceId(List<String> listProcessinstanceid) {
		List<Things> list = thingsMapper.selectListThingsByProcessInstanceId(listProcessinstanceid);
		return list;
	}

	public List<Things> selectCreatByMeLikeStateName(Integer userId, String state, String name) {
		List<Things> list = thingsMapper.selectCreatByMeLikeStateName(userId, state, name);
		return list;
	}

	public List<ThingsAndExaminationTime> selectExaminationByMeLikeStateName(String username, String state,
			String name) {
		List<ThingsAndExaminationTime> thingsAndExaminationTime = thingsMapper
				.selectExaminationByMeLikeStateName(username, state, name);
		return thingsAndExaminationTime;
	}

	public List<ThingsAndExaminationTime> selectCompleteByMeLikeStateName(String username, String state, String name) {
		List<ThingsAndExaminationTime> list = thingsMapper.selectCompleteByMeLikeStateName(username, state, name);
		return list;
	}


}
