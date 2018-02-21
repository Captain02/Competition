package com.hanming.oa.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hanming.oa.Tool.DateTool;
import com.hanming.oa.dao.BBSLikeMapper;
import com.hanming.oa.model.BBSLike;
import com.hanming.oa.model.BBSTopic;
import com.hanming.oa.model.SystemMessage;

@Service
public class BBSLikeService {

	@Autowired
	BBSLikeMapper bbsLikeMapper;
	@Autowired
	BBSTopicService bbsTopicService;
	@Autowired
	SystemMessageService systemMessageService;

	public Integer selectCountLikeByUserIdAndTopicId(Integer userId, Integer topicId) {
		Integer likeNum = bbsLikeMapper.selectCountLikeByUserIdAndTopicId(userId, topicId);
		return likeNum;
	}

	@Transactional
	public Integer likeTopic(Integer userId, Integer topicId) {

		// 插入消息
		BBSTopic bbsTopic = bbsTopicService.selectByPrimaryKey(topicId);
		SystemMessage systemMessage = new SystemMessage(null, userId, "点赞", bbsTopic.getTitle(), topicId, "未读",
				DateTool.dateToString(new Date()));
		if ("knowledge".equals(bbsTopic.getType())) {
			systemMessage.setText("知识");
		} else {
			systemMessage.setText("相册");
		}
		systemMessageService.insert(systemMessage);

		// 点赞操作
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

		bbsLikeMapper.deletByUserIdAndTopicId(userId, topicId);

		bbsTopicService.updateLikeSubtractOne(userId, topicId);

		Integer likeNum = bbsLikeMapper.selectCountLikeByUserIdAndTopicId(userId, topicId);

		return likeNum;
	}

	public Integer countByTopicId(Integer topicId) {

		Integer likeNum = bbsLikeMapper.countByToicpId(topicId);

		return likeNum;
	}

	public void deleByTopicIdList(List<Integer> bbsLabelIds) {
		bbsLikeMapper.deleByTopicIdList(bbsLabelIds);
	}

}
