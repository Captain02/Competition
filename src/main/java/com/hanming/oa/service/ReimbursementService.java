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

import com.hanming.oa.dao.ReimbursementMapper;
import com.hanming.oa.dao.UserReimbursementMapper;
import com.hanming.oa.model.DetailedRembursement;
import com.hanming.oa.model.Holiday;
import com.hanming.oa.model.Reimbursement;
import com.hanming.oa.model.ReimbursementAndExaminationTime;
import com.hanming.oa.model.ReimbursementCollect;
import com.hanming.oa.model.UserReimbursement;
import com.hanming.oa.model.UserReimbursementByReimbursementId;

@Service
public class ReimbursementService {

	@Autowired
	ReimbursementMapper reimbursementMapper;
	@Autowired
	UserReimbursementMapper userReimbursementMapper;
	@Autowired
	RuntimeService runtimeService;
	@Autowired
	TaskService taskService;
	@Autowired
	PublicTaskService publicTaskService;

	@Transactional
	public int addReimbursement(String persons, MultipartFile file, Reimbursement reimbursement,
			HttpServletRequest request, String processDefinitionKey) {
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
		reimbursement.setTest("审核中");
		if (file != null || file.getOriginalFilename() != null || !("".equals(file.getOriginalFilename()))) {
			String path = request.getSession().getServletContext().getRealPath("ExaminationFile");
			String fileName = new Date().toString().replace(":", "-") + file.getOriginalFilename();
			
			reimbursement.setEnclosure(fileName);
			reimbursement.setFilename(file.getOriginalFilename());
			File dir = new File(path,fileName);
			if (!dir.exists()) {
				dir.mkdirs();
			}

			try {
				file.transferTo(dir);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		UserReimbursement userReimbursement = new UserReimbursement();
		userReimbursement.setUserid((Integer) SecurityUtils.getSubject().getSession().getAttribute("id"));
		insertReimbursement(reimbursement);
		userReimbursement.setReimbursementid(reimbursement.getId());
		insertUserReimbursement(userReimbursement);
		// 设置启动流程变量
		variables.put("reimbursementId", reimbursement.getId());
		if (processDefinitionKey.equals("")) {
			return 0;
		}else {
			// 启动流程
			ProcessInstance pi = runtimeService.startProcessInstanceByKey(processDefinitionKey, variables);
			// 根据流程实例Id查询任务
			Task task = taskService.createTaskQuery().processInstanceId(pi.getProcessInstanceId()).singleResult();
			// 完成 学生填写请假单任务
			taskService.complete(task.getId());
			// 修改状态
			reimbursement.setProcessinstanceid(pi.getProcessInstanceId());
			updateReimbursement(reimbursement);
			return 1;
		}
	}

	private void insertUserReimbursement(UserReimbursement userReimbursement) {

		userReimbursementMapper.insertSelective(userReimbursement);
	}

	public void updateReimbursement(Reimbursement reimbursement) {
		reimbursementMapper.updateByPrimaryKeySelective(reimbursement);

	}

	private void insertReimbursement(Reimbursement reimbursement) {

		reimbursementMapper.insertSelective(reimbursement);
	}

	public List<Reimbursement> listLikeStateType(String state, String type) {

		return reimbursementMapper.listLikeStateType(state, type);
	}

	public List<Object> dataAnalysisByMonth(String date) {
		List<Map<String, Float>> dataAnalysisByMonth = reimbursementMapper.dataAnalysisByMonth(date);
		Object[] objects = new Object[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, };
		Object index = null;
		Object money = null;
		List<Object> categories = Arrays.asList(objects);
		for (Map<String, Float> mapForDataAnalysisByMonth : dataAnalysisByMonth) {
			for (Map.Entry<String, Float> entry : mapForDataAnalysisByMonth.entrySet()) {
				if ("month".equals(entry.getKey())) {
					index = entry.getValue();
				} else if ("money".equals(entry.getKey())) {
					money = entry.getValue();
				}
			}
			categories.set((int) index - 1, money);
		}
		return categories;
	}

	public Reimbursement selectReimbursementByProcessInstanceIdLikeStateType(String processInstanceId, String state,
			String type) {
		Reimbursement reimbursement = reimbursementMapper
				.selectReimbursementByProcessInstanceIdLikeStateType(processInstanceId, state, type);

		return reimbursement;
	}

	public UserReimbursementByReimbursementId selectReimbursementByReimbursementId(Integer reimbursementId) {
		UserReimbursementByReimbursementId userReimbursementByReimbursementId = reimbursementMapper
				.selectReimbursementByReimbursementId(reimbursementId);
		return userReimbursementByReimbursementId;
	}

	public List<Reimbursement> selectCreatByMeLikeStateType(Integer userId, String state, String type) {
		List<Reimbursement> Reimbursement = reimbursementMapper.selectCreatByMeLikeStateType(userId, state, type);
		return Reimbursement;
	}

	public List<ReimbursementAndExaminationTime> selectExaminationByMeLikeStateType(String username, String state,
			String type) {
		List<ReimbursementAndExaminationTime> reimbursementAndExaminationTimelist = reimbursementMapper
				.selectExaminationByMeLikeStateType(username, state, type);

		return reimbursementAndExaminationTimelist;
	}

	public List<ReimbursementAndExaminationTime> selectCompleteByMeLikeStateType(String username, String state,
			String type) {
		List<ReimbursementAndExaminationTime> reimbursementExaminationTimelist = reimbursementMapper
				.selectCompleteByMeLikeStateType(username, state, type);
		return reimbursementExaminationTimelist;
	}

	public List<Reimbursement> selectListReimbursementByProcessInstanceId(List<String> listProcessinstanceid) {
		List<Reimbursement> listReimbursement = reimbursementMapper
				.selectListReimbursementByProcessInstanceId(listProcessinstanceid);
		return listReimbursement;
	}

	public void deleteReimbursementServiceByProcessInstanceId(List<String> processInstanceId) {
		reimbursementMapper.deleteReimbursementServiceByProcessInstanceId(processInstanceId);
	}

	@Transactional
	public void deleteHolidayTaskByProcessInstanceId(String ids) {
		String[] idsStr = ids.split("-");
		List<String> idsList = Arrays.asList(idsStr);
		List<Reimbursement> reimbursements = reimbursementMapper.selectListReimbursementByProcessInstanceId(idsList);
		List<Integer> hids = reimbursements.stream()
									.map(Reimbursement::getId)
									.collect(Collectors.toList());

		publicTaskService.deleTaskByProcessInstanceId(idsList);
		
		reimbursementMapper.deleteReimbursementServiceByProcessInstanceId(idsList);
		
		userReimbursementMapper.deleteByReimbursementIdList(hids);
		
	}

	public List<Reimbursement> listLikeTypeAndApproved(String state, String type) {
		List<Reimbursement> list = reimbursementMapper.listLikeTypeAndApproved(state,type);
		return list;
	}

	public List<ReimbursementCollect> dataCollectPage(String username, String date) {
		List<ReimbursementCollect> reimbursementCollect = reimbursementMapper.dataCollectPage(username, date);
		return reimbursementCollect;
	}

	public List<DetailedRembursement> selectByUsernameAndDate(String username, String date) {
		List<DetailedRembursement> detailedRembursement = reimbursementMapper.selectByUsernameAndDate( username,  date);
		return detailedRembursement;
	}

}
