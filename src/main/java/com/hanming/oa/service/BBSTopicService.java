package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.BBSTopicMapper;
import com.hanming.oa.model.BBSDetailedTopic;
import com.hanming.oa.model.BBSDisplayTopic;
import com.hanming.oa.model.BBSTopic;
import com.hanming.oa.model.Comments;

@Service
public class BBSTopicService {
	
	@Autowired
	BBSTopicMapper bbsTopicMapper;
	

	public List<BBSDisplayTopic> selectDisplayTopic(Integer labelId, Integer isByMyId) {
		List<BBSDisplayTopic> list = bbsTopicMapper.selectDisplayTopic(labelId,isByMyId);
		return list;
	}


	public BBSDetailedTopic bbsDetailedTopic(Integer topicId) {
		BBSDetailedTopic bbsDetailedTopic = bbsTopicMapper.selectBBSDetailedTopic(topicId);
		return bbsDetailedTopic;
	}


	public void insertTopic(BBSTopic bbsTopic) {
		bbsTopicMapper.insertSelective(bbsTopic);
	}


	public List<Comments> getCommentsByTopicId(Integer topicId) {
		List<Comments> comments = bbsTopicMapper.getCommentsByTopicId(topicId);
		return comments;
	}

}
