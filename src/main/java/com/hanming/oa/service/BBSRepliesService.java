package com.hanming.oa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.BBSRepliesMapper;
import com.hanming.oa.model.BBSReplies;

@Service
public class BBSRepliesService {

	@Autowired
	BBSRepliesMapper bbsRepliesMapper;

	public void insert(BBSReplies bbsReplies) {
		bbsRepliesMapper.insertSelective(bbsReplies);
	}

	public Integer selectCountCommentByUserAndTopic(Integer topicId) {
		Integer commentsNum = bbsRepliesMapper.selectCountCommentByUserAndTopic(topicId);
		return commentsNum;
	}
}
