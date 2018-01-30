package com.hanming.oa.service;

import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hanming.oa.dao.BBSCollectionMapper;
import com.hanming.oa.dao.BBSLabelTopicMapper;
import com.hanming.oa.dao.BBSLikeMapper;
import com.hanming.oa.dao.BBSRepliesMapper;
import com.hanming.oa.dao.BBSTopicMapper;
import com.hanming.oa.model.BBSDetailedTopic;
import com.hanming.oa.model.BBSDisplayTopic;
import com.hanming.oa.model.BBSReplies;
import com.hanming.oa.model.BBSTopic;
import com.hanming.oa.model.Comments;

@Service
public class BBSTopicService {
	
	@Autowired
	BBSTopicMapper bbsTopicMapper;
	@Autowired
	BBSCollectionMapper bbsCollectionMapper;
	@Autowired
	BBSLikeMapper bbsLikeMapper;
	@Autowired
	BBSLabelTopicMapper bbsLabelTopicMapper;
	@Autowired
	BBSRepliesMapper bbsRepliesMapper;
	

	public List<BBSDisplayTopic> selectDisplayTopic(Integer labelId, Integer isByMyId) {
		List<BBSDisplayTopic> list = bbsTopicMapper.selectDisplayTopic(labelId,isByMyId);
		return list;
	}


	public BBSDetailedTopic bbsDetailedTopic(Integer topicId) {
		BBSDetailedTopic bbsDetailedTopic = bbsTopicMapper.selectBBSDetailedTopic(topicId);
		Integer commentsNum = bbsRepliesMapper.selectCountCommentByUserAndTopic(topicId);
		bbsDetailedTopic.setComment(commentsNum);
		return bbsDetailedTopic;
	}


	public void insertTopic(BBSTopic bbsTopic) {
		bbsTopicMapper.insertSelective(bbsTopic);
	}


	public List<Comments> getCommentsByTopicId(Integer topicId) {
		List<Comments> comments = bbsTopicMapper.getCommentsByTopicId(topicId);
		return comments;
	}


	public void update(BBSTopic bbsTopic) {
		bbsTopicMapper.updateByPrimaryKeySelective(bbsTopic);
	}


	public void updateLikeSubtractOne(Integer userId, Integer topicId) {
		bbsTopicMapper.updateLikeSubtractOne(userId,topicId);
	}


	public void updateLikeAddOne(Integer userId, Integer topicId) {
		bbsTopicMapper.updateLikeAddOne(userId,topicId);
	}


	public void updateCollectionSubstractOne(Integer userId, Integer topicId) {
		bbsTopicMapper.updateCollectionSubstractOne(userId,topicId);
	}


	public void updateCollectionAddOne(Integer userId, Integer topicId) {
		bbsTopicMapper.updateCollectionAddOne(userId,topicId);
	}

	@Transactional
	public void deleTopicById(Integer topicId) {
		bbsTopicMapper.deleteByPrimaryKey(topicId);
		bbsLabelTopicMapper.deleteByTopicId(topicId);
		bbsCollectionMapper.deleteByTopicId(topicId);
		bbsLikeMapper.deleteByTopicId(topicId);
		bbsRepliesMapper.deleteByTopicId(topicId);
	}


	public void deleByTopicIdList(List<Integer> bbsLabelIds) {
		bbsTopicMapper.deleByTopicIdList(bbsLabelIds);
	}


	public void updateCommentsAddOne(Integer topicid) {
		bbsTopicMapper.updateCommentsAddOne(topicid);
	}
	
	@Transactional
	public void addReplies(String text, Integer topicid, Integer byUserId, Integer repliesId) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		BBSReplies bbsReplies = new BBSReplies();
		
		bbsReplies.setRepliesid(repliesId);
		bbsReplies.setUserid(byUserId);
		bbsReplies.setRepliseuserid(userId);
		bbsReplies.setTopicid(topicid);
		bbsReplies.setText(text);
		bbsRepliesMapper.insert(bbsReplies);
		
		updateCommentsAddOne(topicid);
	}

}
