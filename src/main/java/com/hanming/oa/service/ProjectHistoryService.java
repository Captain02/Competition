package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.ProjectHistoryMapper;
import com.hanming.oa.model.ProjectHistory;
import com.hanming.oa.model.ProjectHistoryDisplay;

@Service
public class ProjectHistoryService {

	@Autowired
	ProjectHistoryMapper projectHistoryMapper;
	
	public void insertSelective(ProjectHistory projectHistory) {
		projectHistoryMapper.insertSelective(projectHistory);
	}

	public List<ProjectHistoryDisplay> listByTypeAndTypeId(Integer id, String string) {
		List<ProjectHistoryDisplay> listByTypeAndTypeId = projectHistoryMapper.listByTypeAndTypeId(id,string);
		return listByTypeAndTypeId;
	}

}
