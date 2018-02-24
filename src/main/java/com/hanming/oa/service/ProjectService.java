package com.hanming.oa.service;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hanming.oa.dao.ProjectMapper;
import com.hanming.oa.dao.WhiteListMapper;
import com.hanming.oa.model.Project;
import com.hanming.oa.model.ProjectDetailed;
import com.hanming.oa.model.ProjectDisplay;

@Service
public class ProjectService {

	@Autowired
	ProjectMapper projectMapper;
	@Autowired
	WhiteListMapper whiteListMapper;

	public List<ProjectDisplay> list(String state, String projectName) {
		List<ProjectDisplay> list = projectMapper.list(state, projectName);
		return list;
	}

	public void updateStateByProjectId(String state, Integer projectId) {
		projectMapper.updateStateByProjectId(state, projectId);
	}

	public void insert(Project project) {
		projectMapper.insertSelective(project);
	}

	public ProjectDetailed projectDetailed(Integer projectId) {
		ProjectDetailed projectDetailed = projectMapper.projectDetailed(projectId);
		return projectDetailed;
	}

	@Transactional
	public void update(Project project, String whiteNameId) {
		projectMapper.updateByPrimaryKeySelective(project);
		String[] strIds = whiteNameId.split("-");
		List<String> strIdList = Arrays.asList(strIds);
		if (strIdList.size() > 0 && strIdList != null) {
			List<Integer> intIdList = strIdList.stream().map((x) -> Integer.parseInt(x)).collect(Collectors.toList());
			whiteListMapper.insertList(project.getId(),intIdList);
		}
	}

}
