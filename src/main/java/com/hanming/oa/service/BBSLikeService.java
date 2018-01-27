package com.hanming.oa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hanming.oa.dao.BBSLikeMapper;
import com.hanming.oa.model.BBSLike;

@Service
public class BBSLikeService {
	
	@Autowired
	BBSLikeMapper bbsLikeMapper;
	@Autowired
	BBSTopicService bbsTopicService;

	public Integer selectCountLikeByUserIdAndTopicId(Integer userId, Integer topicId) {
		Integer likeNum = bbsLikeMapper.selectCountLikeByUserIdAndTopicId(userId,topicId);
		return likeNum;
	}

	@Transactional
	public Integer likeTopic(Integer userId, Integer topicId) {
		
		BBSLike bbsLike = new BBSLike();
		bbsLike.setUserid(userId);
		bbsLike.setTopicid(topicId);
		bbsLikeMapper.insertSelective(bbsLike);
		
		bbsTopicService.updateLikeAddOne(userId, topicId);
		
		Integer likeNum = bbsLikeMapper.selectCountLikeByUserIdAndTopicId(userId, topicId);
		
		return likeNum;
	}

	@Transactional
	public Integer deleLikeTopic(Integer userId, Integer topicId) {
		
		bbsLikeMapper.deletByUserIdAndTopicId(userId,topicId);
		
		bbsTopicService.updateLikeSubtractOne(userId,topicId);
		
		Integer likeNum = bbsLikeMapper.selectCountLikeByUserIdAndTopicId(userId, topicId);
		
		return likeNum;
	}

	public Integer countByTopicId(Integer topicId) {
		
		Integer likeNum = bbsLikeMapper.countByToicpId(topicId);
		
		return likeNum;
	}

}
