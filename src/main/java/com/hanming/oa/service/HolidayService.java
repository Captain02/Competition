package com.hanming.oa.service;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.hanming.oa.dao.HolidayMapper;
import com.hanming.oa.dao.UserHolidayMapper;
import com.hanming.oa.model.Holiday;
import com.hanming.oa.model.HolidayAndExaminationTime;
import com.hanming.oa.model.UserHoliday;
import com.hanming.oa.model.UserHolidayByHolidayId;

@Service
public class HolidayService {

	@Autowired
	HolidayMapper holidayMapper;
	@Autowired
	UserHolidayMapper userHolidayMapper;
	@Autowired
	RuntimeService runtimeService;
	@Autowired
	TaskService taskService;
	@Autowired
	PublicTaskService publicTaskService;

	public int insertHoliday(Holiday holiday) {
		int i = holidayMapper.insertSelective(holiday);
		return i;
	}

	public void insertUserHoliday(UserHoliday userHoliday) {
		userHolidayMapper.insertSelective(userHoliday);
	}

	public List<Holiday> list() {
		List<Holiday> list = holidayMapper.list();
		return list;
	}

	public void updateHoliday(Holiday holiday) {
		holidayMapper.updateByPrimaryKeySelective(holiday);
	}

	// 我要请假
	@Transactional
	public int addholiday(String persons, MultipartFile file, Holiday holiday, HttpServletRequest request,
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
		holiday.setTest("审核中");
		if (file != null) {
			String path = request.getSession().getServletContext().getRealPath("ExaminationFile");
			String fileName = new Date().toString().replace(":", "-") + file.getOriginalFilename();
			
			holiday.setEnclosure(fileName);
			holiday.setFilename(file.getOriginalFilename());
			File dir = new File(path, fileName);
			if (!dir.exists()) {
				dir.mkdirs();
			}

			// MultipartFile自带的解析方法
			try {
				file.transferTo(dir);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		UserHoliday userHoliday = new UserHoliday();
		userHoliday.setUserid((Integer) SecurityUtils.getSubject().getSession().getAttribute("id"));
		insertHoliday(holiday);
		userHoliday.setHolidayid(holiday.getId());
		insertUserHoliday(userHoliday);
		// 启动流程
		variables.put("holidayId", holiday.getId());
		// 启动流程
		if (processDefinitionKey.equals("请选择一个审批流程")) {
			return 0;
		}else {
			ProcessInstance pi = runtimeService.startProcessInstanceByKey(processDefinitionKey, variables);
			// 根据流程实例Id查询任务
			Task task = taskService.createTaskQuery().processInstanceId(pi.getProcessInstanceId()).singleResult();
			// 完成 学生填写请假单任务
			taskService.complete(task.getId());
			// 修改状态
			holiday.setProcessinstanceid(pi.getProcessInstanceId());
			updateHoliday(holiday);
			return 1;
		}
	}

	public UserHolidayByHolidayId selectHolidayByHolidayId(Integer holidayId) {
		UserHolidayByHolidayId userHolidayByHolidayId = holidayMapper.selectHolidayByHolidayId(holidayId);
		return userHolidayByHolidayId;
	}

	public Holiday selectHolidayByProcessInstanceId(String processInstanceId) {
		Holiday holiday = holidayMapper.selectHolidayByProcessInstanceId(processInstanceId);
		return holiday;
	}

	public List<Holiday> listLikeStateType(String state, String type) {
		List<Holiday> holiday = holidayMapper.listLikeStateType(state, type);
		return holiday;
	}

	public Holiday selectHolidayByProcessInstanceIdLikeStateType(String processInstanceId, String state, String type) {
		Holiday holiday = holidayMapper.selectHolidayByProcessInstanceIdLikeStateType(processInstanceId, state, type);
		return holiday;
	}

	public List<Holiday> selectCreatByMeLikeStateType(Integer userId, String state, String type) {
		List<Holiday> list = holidayMapper.selectCreatByMeLikeStateType(userId, state, type);
		return list;
	}

	public List<HolidayAndExaminationTime> selectExaminationByMeLikeStateType(String username, String state,
			String type) {
		List<HolidayAndExaminationTime> list = holidayMapper.selectExaminationByMeLikeStateType(username, state, type);
		return list;
	}

	public List<HolidayAndExaminationTime> selectCompleteByMeLikeStateType(String username, String state, String type) {
		List<HolidayAndExaminationTime> list = holidayMapper.selectCompleteByMeLikeStateType(username, state, type);

		return list;
	}

	public List<Holiday> selectListHolidayByProcessInstanceId(List<String> listProcessinstanceid) {
		List<Holiday> listHolidayByProcessInstanceId = holidayMapper
				.selectListHolidayByProcessInstanceId(listProcessinstanceid);
		return listHolidayByProcessInstanceId;
	}

	public void deleteHolidayByProcessInstanceId(List<String> processInstanceId) {
		holidayMapper.deleteHolidayByProcessInstanceId(processInstanceId);
	}

	@Transactional
	public void deleteHolidayTaskByProcessInstanceId(String ids) {
		String[] idsStr = ids.split("-");
		List<String> idsList = Arrays.asList(idsStr);
		List<Holiday> holidays = holidayMapper.selectListHolidayByProcessInstanceId(idsList);
		List<Integer> hids = holidays.stream()
									.map(Holiday::getId)
									.collect(Collectors.toList());

		publicTaskService.deleTaskByProcessInstanceId(idsList);
		
		holidayMapper.deleteHolidayByProcessInstanceId(idsList);
		
		userHolidayMapper.deleteByHolidayIdList(hids);
		
	}

	public List<Holiday> listLikeTypeAndApproved(String state, String type) {
		List<Holiday> list = holidayMapper.listLikeTypeAndApproved(state,type);
		return list;
	}

	

}
