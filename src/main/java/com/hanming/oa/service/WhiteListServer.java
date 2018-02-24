package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.WhiteListMapper;
import com.hanming.oa.model.User;

@Service
public class WhiteListServer {
	
	@Autowired
	WhiteListMapper whiteListMapper;

	public List<User> listByProjectId(Integer projectId) {
		List<User> listByProjectId = whiteListMapper.listByProjectId(projectId);
		return listByProjectId;
	}

}
