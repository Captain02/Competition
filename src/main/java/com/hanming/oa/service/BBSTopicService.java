package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.BBSTopicMapper;
import com.hanming.oa.model.BBSDetailedTopic;
import com.hanming.oa.model.BBSDisplayTopic;

@Service
public class BBSTopicService {
	
	@Autowired
	BBSTopicMapper bbsTopicMapper;
	

	public List<BBSDisplayTopic> selectDisplayTopic() {
		List<BBSDisplayTopic> list = bbsTopicMapper.selectDisplayTopic();
		return list;
	}


	public BBSDetailedTopic bbsDetailedTopic(Integer topicId) {
		BBSDetailedTopic bbsDetailedTopic = bbsTopicMapper.selectBBSDetailedTopic(topicId);
		return bbsDetailedTopic;
	}

}
