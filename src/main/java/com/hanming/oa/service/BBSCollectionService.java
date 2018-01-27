package com.hanming.oa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hanming.oa.dao.BBSCollectionMapper;
import com.hanming.oa.model.BBSCollection;

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
		
		bbsTopicService.updateCollectionAddOne(userId,topicId);
		
		return collectionNum;
	}

	@Transactional
	public Integer deleCollectionTopic(Integer userId, Integer topicId) {
		
		bbsCollectionMapper.deleCollectionByUserIdAndTopicId(userId,topicId);
		
		bbsTopicService.updateCollectionSubstractOne(userId,topicId);
		
		Integer collectionNum = bbsCollectionMapper.selectCountCollectionByUserAndTopic(userId,topicId);
		
		return collectionNum;
	}

	public Integer countNumByTopic(Integer topicId) {
		Integer collenctionNum = bbsCollectionMapper.countNumByTopic(topicId);
		return collenctionNum;
	}
	
	
}
