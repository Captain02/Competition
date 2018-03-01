package com.hanming.oa.testService;

import java.util.List;
import java.util.stream.Collectors;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hanming.oa.dao.BBSCollectionMapper;
import com.hanming.oa.dao.BBSTopicMapper;
import com.hanming.oa.model.BBSDetailedTopic;
import com.hanming.oa.model.BBSDisplayTopic;
import com.hanming.oa.model.Comments;
import com.hanming.oa.model.MyCollectionDisplay;
import com.hanming.oa.service.BBSCollectionService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:/spring/spring-dao.xml" })
public class BBSDaoTest {

	@Autowired
	BBSTopicMapper bbsTopicMapper;
	@Autowired
	BBSCollectionMapper bbsCollectionMapper;

	@Test
	public void displayTopic() {
		List<BBSDisplayTopic> list = bbsTopicMapper.selectDisplayTopic(1, 1);

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

	@Test
	public void getCommentsByTopicId() {
		List<Comments> list = bbsTopicMapper.getCommentsByTopicId(1);
		for (Comments comments : list) {
			System.out.println(comments.getDate());
		}

	}

	@Test
	public void listByMyId() {
		List<MyCollectionDisplay> listByMyId = bbsCollectionMapper.listByMyId("名称", "类型", 140);
		for (MyCollectionDisplay myCollectionDisplay : listByMyId) {
			System.out.println(myCollectionDisplay.getTopicId());
		}
		
	}
}
