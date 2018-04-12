package com.hanming.oa.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hanming.oa.Tool.DateTool;
import com.hanming.oa.dao.BBSCollectionMapper;
import com.hanming.oa.dao.BBSRepliesMapper;
import com.hanming.oa.model.BBSCollection;
import com.hanming.oa.model.BBSReplies;
import com.hanming.oa.model.BBSTopic;
import com.hanming.oa.model.SystemMessage;

@Service
public class BBSCollectionService {

	@Autowired
	BBSCollectionMapper bbsCollectionMapper;
	@Autowired
	BBSTopicService bbsTopicService;
	@Autowired
	SystemMessageService systemMessageService;
	@Autowired
	BBSRepliesMapper BBSRepliesMapper;

	public Integer selectCountCollectionByUserAndTopic(Integer userId, Integer topicId) {
		Integer collectionNum = bbsCollectionMapper.selectCountCollectionByUserAndTopic(userId, topicId);
		return collectionNum;
	}

	@Transactional
	public Integer collectionTopce(Integer userId, Integer topicId) {
		// 插入消息
		BBSTopic bbsTopic = bbsTopicService.selectByPrimaryKey(topicId);
		SystemMessage systemMessage = new SystemMessage(null, userId, "收藏", bbsTopic.getTitle(), topicId, "未读",
				DateTool.dateToString(new Date()));
		if ("knowledge".equals(bbsTopic.getType())) {
			systemMessage.setText("知识");
		} else {
			systemMessage.setText("相册");
		}
		systemMessageService.insert(systemMessage);

		// 收藏
		BBSCollection bbsCollection = new BBSCollection();
		bbsCollection.setTopicid(topicId);
		bbsCollection.setUserid(userId);
		bbsCollectionMapper.insertSelective(bbsCollection);

		Integer collectionNum = bbsCollectionMapper.selectCountCollectionByUserAndTopic(userId, topicId);

		bbsTopicService.updateCollectionAddOne(topicId);

		return collectionNum;
	}

	@Transactional
	public Integer deleCollectionTopic(Integer userId, Integer topicId) {

		bbsCollectionMapper.deleCollectionByUserIdAndTopicId(userId, topicId);

		bbsTopicService.updateCollectionSubstractOne(topicId);

		Integer collectionNum = bbsCollectionMapper.selectCountCollectionByUserAndTopic(userId, topicId);

		return collectionNum;
	}

	public Integer countNumByTopic(Integer topicId) {
		Integer collenctionNum = bbsCollectionMapper.countNumByTopic(topicId);
		return collenctionNum;
	}

	public void deleByTopicIdList(List<Integer> bbsTopicIds) {
		bbsCollectionMapper.deleByTopicIdList(bbsTopicIds);
	}

	@Transactional
	public void addCollection(String text, Integer topicid, Integer byUserId, Integer repliesId, Integer userId,
			String state) {
		// 添加评论
		BBSReplies bbsReplies = new BBSReplies();

		bbsReplies.setRepliesid(repliesId);
		bbsReplies.setUserid(byUserId);
		bbsReplies.setRepliseuserid(userId);
		bbsReplies.setTopicid(topicid);
		bbsReplies.setText(text);
		bbsReplies.setState(state);
		bbsReplies.setDate(DateTool.dateToString(new Date()));
		BBSRepliesMapper.insert(bbsReplies);

		// 插入消息
		BBSTopic bbsTopic = bbsTopicService.selectByPrimaryKey(topicid);
		SystemMessage systemMessage = new SystemMessage(null, userId, "评论", bbsTopic.getTitle(), topicid, "未读",
				DateTool.dateToString(new Date()));
		if ("knowledge".equals(bbsTopic.getType())) {
			systemMessage.setText("知识");
		} else {
			systemMessage.setText("相册");
		}
		systemMessageService.insert(systemMessage);
	}

}
