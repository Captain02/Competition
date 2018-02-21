package com.hanming.oa.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

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
import com.hanming.oa.model.BBSLabelTopic;
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


	public void updateLikeSubtractOne(Integer topicId) {
		bbsTopicMapper.updateLikeSubtractOne(topicId);
	}


	public void updateLikeAddOne(Integer topicId) {
		bbsTopicMapper.updateLikeAddOne(topicId);
	}


	public void updateCollectionSubstractOne(Integer topicId) {
		bbsTopicMapper.updateCollectionSubstractOne(topicId);
	}


	public void updateCollectionAddOne(Integer topicId) {
		bbsTopicMapper.updateCollectionAddOne(topicId);
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
	public int addKonwledge(String text, String title, String sketch, String ids) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		String[] idsStr = ids.split("-");
		List<String> strIdList = Arrays.asList(idsStr);
		if ("".equals(strIdList.get(0))||strIdList.get(0) == null) {
			return 0;
		}
		List<Integer> intIdsList = new ArrayList<>();
		List<BBSLabelTopic> bbsLabelTopics = new ArrayList<>();

		intIdsList.addAll(strIdList.stream()
								   .map(Integer::valueOf)
								   .collect(Collectors.toList()));

		BBSTopic bbsTopic = new BBSTopic();
		bbsTopic.setSketch(sketch);
		bbsTopic.setText(text);
		bbsTopic.setUserId(userId);
		bbsTopic.setTitle(title);
		bbsTopic.setType("knowledge");
		bbsTopicMapper.insertSelective(bbsTopic);

		for (Integer labelId : intIdsList) {
			BBSLabelTopic bbsLabelTopic = new BBSLabelTopic();
			bbsLabelTopic.setTopicid(bbsTopic.getId());
			bbsLabelTopic.setLabelid(labelId);
			bbsLabelTopics.add(bbsLabelTopic);
		}
		bbsLabelTopicMapper.insertLabelTopics(bbsLabelTopics);
		return 1;
	}

	@Transactional
	public int update(String text, String title, String sketch, String ids, Integer topicId) {
		String[] idsStr = ids.split("-");
		List<String> strIdList = Arrays.asList(idsStr);
		if ("".equals(strIdList.get(0))||strIdList.get(0) == null) {
			return 0;
		}
		
		
		List<Integer> intIdsList = new ArrayList<>();
		List<BBSLabelTopic> bbsLabelTopics = new ArrayList<>();

		intIdsList.addAll(strIdList.stream()
								   .map(Integer::valueOf)
								   .collect(Collectors.toList()));

		BBSTopic bbsTopic = new BBSTopic();
		bbsTopic.setId(topicId);
		bbsTopic.setSketch(sketch);
		bbsTopic.setText(text);
		bbsTopic.setTitle(title);
		
		bbsTopicMapper.updateByPrimaryKeySelective(bbsTopic);
		
		for (Integer labelId : intIdsList) {
			BBSLabelTopic bbsLabelTopic = new BBSLabelTopic();
			bbsLabelTopic.setTopicid(bbsTopic.getId());
			bbsLabelTopic.setLabelid(labelId);
			bbsLabelTopics.add(bbsLabelTopic);
		}
		
		bbsLabelTopicMapper.deleteByTopicId(topicId);
		
		bbsLabelTopicMapper.insertLabelTopics(bbsLabelTopics);
		
		return 1;
	}


	public BBSTopic selectByPrimaryKey(Integer topicId) {
		BBSTopic bbsTopic = bbsTopicMapper.selectByPrimaryKey(topicId);
		return bbsTopic;
	}







}
