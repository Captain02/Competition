package com.hanming.oa.service;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hanming.oa.dao.ProjectMapper;
import com.hanming.oa.dao.ProjectTeamMapper;
import com.hanming.oa.dao.WhiteListMapper;
import com.hanming.oa.model.Project;
import com.hanming.oa.model.ProjectDetailed;
import com.hanming.oa.model.ProjectDisplay;
import com.hanming.oa.model.ProjectHistory;

@Service
public class ProjectService {

	@Autowired
	ProjectMapper projectMapper;
	@Autowired
	WhiteListMapper whiteListMapper;
	@Autowired
	ProjectHistoryService projectHistoryService;
	
	public List<ProjectDisplay> list(String state, String projectName, Integer userId) {
		List<ProjectDisplay> list = projectMapper.list(state, projectName,userId);
		return list;
	}

	public void updateStateByProjectId(String state, Integer projectId, Integer userId) {
		ProjectHistory projectHistory = new ProjectHistory();
		projectHistory.setOperationPeopleId(userId);
		projectHistory.setHistoryType("项目");
		projectHistory.setTypeId(projectId);
		projectHistory.setOperationType("修改项目状态为"+state);
		projectHistoryService.insertSelective(projectHistory);
		projectMapper.updateStateByProjectId(state, projectId);
	}

	public void insert(Project project, Integer userId) {
		projectMapper.insertSelective(project);
		ProjectHistory projectHistory = new ProjectHistory();
		projectHistory.setOperationPeopleId(userId);
		projectHistory.setHistoryType("项目");
		projectHistory.setTypeId(project.getId());
		projectHistory.setOperationType("创建了项目");
		projectHistoryService.insertSelective(projectHistory);
	}

	public ProjectDetailed projectDetailed(Integer projectId) {
		ProjectDetailed projectDetailed = projectMapper.projectDetailed(projectId);
		return projectDetailed;
	}

	@Transactional
	public void update(Project project, String whiteNameId) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		
		projectMapper.updateByPrimaryKeySelective(project);
		
		//历史记录
		ProjectHistory projectHistory = new ProjectHistory();
		projectHistory.setOperationPeopleId(userId);
		projectHistory.setHistoryType("项目");
		projectHistory.setTypeId(project.getId());
		projectHistory.setOperationType("编辑了项目");
		projectHistoryService.insertSelective(projectHistory);
		
		//白名单
		whiteListMapper.deleteByProjectId(project.getId());
		String[] strIds = whiteNameId.split("-");
		List<String> strIdList = Arrays.asList(strIds);
		if (strIdList.size() > 0 && strIdList != null && strIdList.get(0)!="") {
			List<Integer> intIdList = strIdList.stream().map((x) -> Integer.parseInt(x)).collect(Collectors.toList());
			whiteListMapper.deleByWhiteIdList(strIdList);
			whiteListMapper.insertList(project.getId(),intIdList);
		}
	}

}
