package com.hanming.oa.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hanming.oa.dao.BBSLabelTopicMapper;
import com.hanming.oa.model.BBSLabelTopic;
import com.hanming.oa.model.BBSTopic;

@Service
public class BBSLabelTopicService {

	@Autowired
	BBSLabelTopicMapper bbsLabelTopicMapper;
	@Autowired
	BBSTopicService bbsTopicService;

	public void insertLabelTopic(BBSLabelTopic bbsLabelTopic) {
		bbsLabelTopicMapper.insertSelective(bbsLabelTopic);
	}


	public void deleByTopicIdList(List<Integer> bbsLabelIds) {
		bbsLabelTopicMapper.deleByTopicIdList(bbsLabelIds);
	}


}
