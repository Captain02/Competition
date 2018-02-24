package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.DemandMapper;
import com.hanming.oa.model.DemandDetailed;
import com.hanming.oa.model.DemandDisplay;

@Service
public class DemandService {
	
	@Autowired
	DemandMapper demandMapper;

	public List<DemandDisplay> list(String state, String demandName, Integer projectId) {
		
		List<DemandDisplay> list = demandMapper.list(state,demandName,projectId);
		return list;
	}

	public DemandDetailed detaileById(Integer demandId) {
		DemandDetailed detaileById = demandMapper.detaileById(demandId);
		return detaileById;
	}

}
