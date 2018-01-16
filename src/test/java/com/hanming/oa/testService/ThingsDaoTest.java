package com.hanming.oa.testService;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hanming.oa.dao.ThingsMapper;
import com.hanming.oa.model.Reimbursement;
import com.hanming.oa.model.Things;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:/spring/spring-dao.xml" })
public class ThingsDaoTest {
	
	@Autowired
	ThingsMapper thingsMapper;
	
	@Test
	public void listLikeStateType() {
		List<Things> list = thingsMapper.listLikeStateType("审核中","");
		for (Things Things : list) {
			System.out.println("++++++++++++++"+Things.getDate());
		}
	}

}
