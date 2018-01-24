package com.hanming.oa.testService;

import java.util.List;
import java.util.stream.Collectors;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hanming.oa.dao.BBSTopicMapper;
import com.hanming.oa.model.BBSDetailedTopic;
import com.hanming.oa.model.BBSDisplayTopic;
import com.hanming.oa.model.Comments;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:/spring/spring-dao.xml" })
public class BBSDaoTest {

	@Autowired
	BBSTopicMapper bbsTopicMapper;

	
	@Test
	public void displayTopic() {
		List<BBSDisplayTopic> list = bbsTopicMapper.selectDisplayTopic();

		for (BBSDisplayTopic bbsDisplayTopic : list) {
			List<String> list2 = bbsDisplayTopic.getLabelName();
			for (String string : list2) {
				System.out.println("+++++++++++" + string);
			}
		}
	}
	
	
	@Test
	public void bbsDetailedTopic() {
		BBSDetailedTopic bbsDetailedTopic = bbsTopicMapper.selectBBSDetailedTopic(1);
		List<Comments> comments = bbsDetailedTopic.getComments();
		List<String> list = comments.stream().map(Comments::getRepliesUserName).collect(Collectors.toList());
		list.forEach(System.out::println);
	}

}
