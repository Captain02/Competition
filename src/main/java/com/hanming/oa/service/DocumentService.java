package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.hanming.oa.dao.DocumentMapper;
import com.hanming.oa.model.DocumentDisplay;

public class DocumentService {
	
	@Autowired
	DocumentMapper documentMapper;

	public List<DocumentDisplay> list(String type, String documentName) {
		List<DocumentDisplay> list = documentMapper.list(type,documentName);
		return list;
	}

}
