package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.ThingsMapper;
import com.hanming.oa.model.Reimbursement;
import com.hanming.oa.model.Things;

@Service
public class ThingsService {
	
	@Autowired
	ThingsMapper thingsMapper;

	public List<Things> listLikeStateType(String state, String name) {
		List<Things> list = thingsMapper.listLikeStateType(state,name);
		return list;
	}


}
