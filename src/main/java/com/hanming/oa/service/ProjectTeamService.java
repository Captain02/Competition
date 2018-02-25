package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.ProjectTeamMapper;
import com.hanming.oa.model.UserByProjectId;

@Service
public class ProjectTeamService {

	@Autowired
	ProjectTeamMapper projectTeamMapper;
	
	public List<UserByProjectId> list(Integer projectId, String userName) {
		List<UserByProjectId> list = projectTeamMapper.listByProjectId(projectId,userName);
		return list;
	}

}
