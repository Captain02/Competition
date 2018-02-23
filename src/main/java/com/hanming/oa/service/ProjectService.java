package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.ProjectMapper;
import com.hanming.oa.model.ProjectDisplay;

@Service
public class ProjectService {

	@Autowired
	ProjectMapper projectMapper;

	public List<ProjectDisplay> list(String state, String projectName) {
		List<ProjectDisplay> list = projectMapper.list(state, projectName);
		return list;
	}

	public void updateStateByProjectId(String state, Integer projectId) {
		projectMapper.updateStateByProjectId(state, projectId);
	}

}
