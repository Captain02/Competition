package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.DustyMapper;
import com.hanming.oa.model.DustyDetailed;
import com.hanming.oa.model.DustyDisplay;

@Service
public class DustyService {

	@Autowired
	DustyMapper dustyMapper;
	
	public List<DustyDisplay> list(String type, String state, String dustyName, Integer herfPage, Integer projectId, Integer userId) {
		List<DustyDisplay> list = dustyMapper.list(type,state,dustyName,herfPage,projectId,userId);
		return list;
	}

	public DustyDetailed detailedById(Integer id) {
		DustyDetailed detailedById = dustyMapper.detailedById(id);
		return detailedById;
	}

}
