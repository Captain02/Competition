package com.hanming.oa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hanming.oa.dao.BBSCollectionMapper;
import com.hanming.oa.model.BBSCollection;
import com.hanming.oa.model.BBSTopic;

@Service
public class BBSCollectionService {
	
	@Autowired
	BBSCollectionMapper bbsCollectionMapper;
	@Autowired
	BBSTopicService bbsTopicService;

	public Integer selectCountCollectionByUserAndTopic(Integer userId, Integer topicId) {
		Integer collectionNum = bbsCollectionMapper.selectCountCollectionByUserAndTopic(userId,topicId);
		return collectionNum;
	}

	@Transactional
	public Integer collectionTopce(Integer userId, Integer topicId) {
		BBSCollection bbsCollection = new BBSCollection();
		bbsCollection.setTopicid(topicId);
		bbsCollection.setUserid(userId);
		bbsCollectionMapper.insertSelective(bbsCollection);
		
		Integer collectionNum = bbsCollectionMapper.selectCountCollectionByUserAndTopic(userId,topicId);
		
		BBSTopic bbsTopic = new BBSTopic();
		bbsTopic.setId(topicId);
		bbsTopic.setUserId(userId);
		bbsTopic.setCollection(collectionNum);
		bbsTopicService.update(bbsTopic);
		
		return collectionNum;
	}

	@Transactional
	public Integer deleCollectionTopic(Integer userId, Integer topicId) {
		bbsCollectionMapper.deleCollectionByUserIdAndTopicId(userId,topicId);
		
		Integer collectionNum = bbsCollectionMapper.selectCountCollectionByUserAndTopic(userId,topicId);
		
		BBSTopic bbsTopic = new BBSTopic();
		bbsTopic.setId(topicId);
		bbsTopic.setUserId(userId);
		bbsTopic.setCollection(collectionNum);
		bbsTopicService.update(bbsTopic);
		return collectionNum;
	}
	
	
}
