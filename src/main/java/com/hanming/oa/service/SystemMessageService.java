package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.SystemMessageMapper;
import com.hanming.oa.model.SystemMessage;
import com.hanming.oa.model.SystemMessageDisplay;

@Service
public class SystemMessageService {
	@Autowired
	SystemMessageMapper SystemMessageMapper;

	public void insert(SystemMessage systemMessage) {
		SystemMessageMapper.insertSelective(systemMessage);
	}


	public List<SystemMessageDisplay> list(String type, String state, Integer myId) {
		List<SystemMessageDisplay> list = SystemMessageMapper.list(type,state,myId);
		return list;
	}

}
