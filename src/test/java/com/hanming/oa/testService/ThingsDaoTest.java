package com.hanming.oa.testService;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hanming.oa.dao.ThingsMapper;
import com.hanming.oa.model.Things;
import com.hanming.oa.model.ThingsAndExaminationTime;
import com.hanming.oa.model.UserThingsByThingsId;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:/spring/spring-dao.xml" })
public class ThingsDaoTest {

	@Autowired
	ThingsMapper thingsMapper;

	@Test
	public void listLikeStateType() {
		List<Things> list = thingsMapper.listLikeStateType("审核中", "");
		for (Things Things : list) {
			System.out.println("++++++++++++++" + Things.getDate());
		}
	}

	@Test
	public void selectUserThingsByThingsId() {
		UserThingsByThingsId thingsId2 = thingsMapper.selectUserThingsByThingsId(2);
		System.out.println(thingsId2.getName());
	}

	@Test
	public void selectThingsByProcessInstanceIdLikeStateName() {
		Things things = thingsMapper.selectThingsByProcessInstanceIdLikeStateName("60001", "审核中", "");
		System.out.println(things.getDate());
	}

	@Test
	public void selectListThingsByProcessInstanceId() {
		List<String> list = new ArrayList<String>();
		list.add("60002");
		list.add("60001");
		List<Things> list2 = thingsMapper.selectListThingsByProcessInstanceId(list);
		for (Things things : list2) {
			System.out.println(things.getNumber());
		}
	}

	@Test
	public void selectCreatByMeLikeStateName() {
		List<Things> things = thingsMapper.selectCreatByMeLikeStateName(140, "状态", "");
		for (Things things2 : things) {
			System.out.println(things2.getName());
		}
	}

	@Test
	public void selectExaminationByMeLikeStateName() {
		List<ThingsAndExaminationTime> things = thingsMapper.selectExaminationByMeLikeStateName("admin", "状态", "");
		for (ThingsAndExaminationTime thingsAndExaminationTime : things) {
			System.out.println(thingsAndExaminationTime.getStartExaminationTime());
		}
	}

	@Test
	public void selectCompleteByMeLikeStateName() {
		List<ThingsAndExaminationTime> list = thingsMapper.selectCompleteByMeLikeStateName("admin", "状态", "");
		for (ThingsAndExaminationTime thingsAndExaminationTime : list) {
			System.out.println(thingsAndExaminationTime.getStartExaminationTime());
			System.out.println(thingsAndExaminationTime.getExaminationTime());
		}
	}

}
