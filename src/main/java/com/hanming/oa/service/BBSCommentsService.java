package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.BBSRepliesMapper;

@Service
public class BBSCommentsService {
	
	@Autowired
	BBSRepliesMapper bbsRepliesMapper;

	public void deleByTopicIdList(List<Integer> bbsLabelIds) {
		bbsRepliesMapper.deleteByTopicIdList(bbsLabelIds);
	}

}
