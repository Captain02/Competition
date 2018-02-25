package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.DocumentMapper;
import com.hanming.oa.model.DocumentDisplay;

@Service
public class DocumentService {
	
	@Autowired
	DocumentMapper documentMapper;

	public List<DocumentDisplay> list(String type, String documentName, Integer projectId) {
		List<DocumentDisplay> list = documentMapper.list(type,documentName,projectId);
		return list;
	}

}
