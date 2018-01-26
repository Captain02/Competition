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
		bbsTopicService.insertTopic(bbsTopic);

		for (Integer labelId : intIdsList) {
			BBSLabelTopic bbsLabelTopic = new BBSLabelTopic();
			bbsLabelTopic.setTopicid(bbsTopic.getId());
			bbsLabelTopic.setLabelid(labelId);
			bbsLabelTopics.add(bbsLabelTopic);
		}
		bbsLabelTopicMapper.insertLabelTopics(bbsLabelTopics);
		return 1;
	}

}
