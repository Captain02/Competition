package com.hanming.oa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hanming.oa.dao.BBSLikeMapper;
import com.hanming.oa.model.BBSLike;
import com.hanming.oa.model.BBSTopic;

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
		
		Integer likeNum = bbsLikeMapper.selectCountLikeByUserIdAndTopicId(userId, topicId);
		
		BBSTopic bbsTopic = new BBSTopic();
		bbsTopic.setId(topicId);
		bbsTopic.setUserId(userId);
		bbsTopic.setLike(likeNum);
		bbsTopicService.update(bbsTopic);
		
		return likeNum;
	}

	public Integer deleLikeTopic(Integer userId, Integer topicId) {
		bbsLikeMapper.deletByUserIdAndTopicId(userId,topicId);
		
		Integer likeNum = bbsLikeMapper.selectCountLikeByUserIdAndTopicId(userId, topicId);
		BBSTopic bbsTopic = new BBSTopic();
		bbsTopic.setId(topicId);
		bbsTopic.setUserId(userId);
		bbsTopic.setLike(likeNum);
		bbsTopicService.update(bbsTopic);
		return likeNum;
	}

}
