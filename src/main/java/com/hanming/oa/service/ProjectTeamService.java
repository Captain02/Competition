package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.ProjectTeamMapper;
import com.hanming.oa.model.User;

@Service
public class ProjectTeamService {

	@Autowired
	ProjectTeamMapper projectTeamMapper;
	
	public List<User> list(Integer projectId) {
		List<User> list = projectTeamMapper.listByProjectId(projectId);
		return list;
	}

}
