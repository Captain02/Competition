package com.hanming.oa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.BBSLikeMapper;

@Service
public class BBSLikeService {
	
	@Autowired
	BBSLikeMapper bbsLikeMapper;

	public Integer selectCountLikeByUserIdAndTopicId(Integer id, Integer topicId) {
		Integer i = bbsLikeMapper.selectCountLikeByUserIdAndTopicId(id,topicId);
		return i;
	}

}
