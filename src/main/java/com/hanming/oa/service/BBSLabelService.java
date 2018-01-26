package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.BBSLabelMapper;
import com.hanming.oa.model.BBSLabel;

@Service
public class BBSLabelService {
	
	@Autowired
	BBSLabelMapper bbsLabelMapper;

	public List<BBSLabel> list() {
		List<BBSLabel> list = bbsLabelMapper.list();
		return list;
	}

}
