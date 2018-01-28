package com.hanming.oa.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hanming.oa.dao.BBSCollectionMapper;
import com.hanming.oa.dao.BBSLabelMapper;
import com.hanming.oa.dao.BBSLabelTopicMapper;
import com.hanming.oa.dao.BBSLikeMapper;
import com.hanming.oa.dao.BBSRepliesMapper;
import com.hanming.oa.dao.BBSTopicMapper;
import com.hanming.oa.model.BBSLabel;
import com.hanming.oa.model.BBSLabelTopic;

@Service
public class BBSLabelService {
	
	@Autowired
	BBSLabelMapper bbsLabelMapper;
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

	
	public List<BBSLabel> list() {
		List<BBSLabel> list = bbsLabelMapper.list();
		return list;
	}

	public void update(BBSLabel bbsLabel) {
		bbsLabelMapper.updateByPrimaryKeySelective(bbsLabel);
	}

	public BBSLabel select(Integer labelId) {
		BBSLabel bbsLabel = bbsLabelMapper.selectByPrimaryKey(labelId);
		return bbsLabel;
	}

	@Transactional
	public void deleLabel(Integer labelId) {
		List<BBSLabel> bbsLabellist = bbsLabelMapper.list();
		List<Integer> bbsLabelIds = bbsLabellist.stream()
												.map(BBSLabel::getId)
												.collect(Collectors.toList());
		
		List<BBSLabelTopic> bbsLabelTopic = bbsLabelTopicMapper.getTopicListByLabelIds(bbsLabelIds);
		
		List<Integer> topicIds = bbsLabelTopic.stream()
					.map(BBSLabelTopic::getTopicid)
					.collect(Collectors.toList());
		bbsTopicMapper.deleByTopicIdList(topicIds);
		bbsCollectionMapper.deleByTopicIdList(topicIds);
		bbsLikeMapper.deleByTopicIdList(topicIds);
		bbsLabelTopicMapper.deleByTopicIdList(topicIds);
		bbsRepliesMapper.deleteByTopicIdList(topicIds);
		bbsLabelMapper.deleteByPrimaryKey(labelId);
	}

	public void insert(BBSLabel bbsLabel) {
		bbsLabelMapper.insertSelective(bbsLabel);
	}

}
