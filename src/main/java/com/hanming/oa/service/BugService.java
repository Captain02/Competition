package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.ProjectBugMapper;
import com.hanming.oa.model.BugDetailed;
import com.hanming.oa.model.BugDisplay;


@Service
public class BugService {

	@Autowired
	ProjectBugMapper projectBugMapper;

	public List<BugDisplay> list(String state, String name, Integer hrefPage, Integer projectId, Integer userId) {
		List<BugDisplay> list = projectBugMapper.list(state,name,hrefPage,projectId,userId);
		return list;
	}

	public BugDetailed detailedById(Integer id) {
		BugDetailed bugDetailed = projectBugMapper.detailedById(id);
		return bugDetailed;
	}

}
