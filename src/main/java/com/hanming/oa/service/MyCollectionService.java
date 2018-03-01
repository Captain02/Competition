package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.BBSCollectionMapper;
import com.hanming.oa.model.MyCollectionDisplay;

@Service
public class MyCollectionService {
	
	@Autowired
	BBSCollectionMapper bbsCollectionMapper;

	public List<MyCollectionDisplay> list(String name, String type, Integer userId) {
		List<MyCollectionDisplay> list = bbsCollectionMapper.listByMyId(name,type,userId);
		return list;
	}

}
