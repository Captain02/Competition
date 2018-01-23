package com.hanming.oa.testService;

import java.util.List;
import java.util.stream.Collectors;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hanming.oa.dao.HolidayMapper;
import com.hanming.oa.model.Holiday;
import com.hanming.oa.model.HolidayAndExaminationTime;
import com.hanming.oa.model.UserHolidayByHolidayId;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:/spring/spring-dao.xml" })
public class HolidayDaoTest {

	@Autowired
	HolidayMapper holidayMapper;

	@Test
	public void list() {
		List<Holiday> list = holidayMapper.list();
		for (Holiday holiday : list) {
			System.out.println(holiday.getId());
			System.out.println(holiday.getEnclosure());
			System.out.println(holiday.getProcessinstanceid());
			System.out.println(holiday.getReason());
			System.out.println(holiday.getTest());
			System.out.println(holiday.getType());
			System.out.println(holiday.getStartday());
			System.out.println(holiday.getEndday());
		}
	}

	@Test
	public void selectHolidayByHolidayId() {
		UserHolidayByHolidayId userHolidayByHolidayId = holidayMapper.selectHolidayByHolidayId(6);
		System.out.println(userHolidayByHolidayId.getEnclosure());
		System.out.println(userHolidayByHolidayId.getTuId());
		System.out.println(userHolidayByHolidayId.getRole());
		System.out.println(userHolidayByHolidayId.getDepartment());
	}

	@Test
	public void selectHolidayByProcessInstanceId() {
		Holiday holiday = holidayMapper.selectHolidayByProcessInstanceId("2501");
		System.out.println(holiday.getId());
		System.out.println(holiday.getEnclosure());
		System.out.println(holiday.getProcessinstanceid());
		System.out.println(holiday.getReason());
		System.out.println(holiday.getTest());
		System.out.println(holiday.getType());
		System.out.println(holiday.getStartday());
		System.out.println(holiday.getEndday());
	}

	@Test
	public void listLikeStateType() {

		List<Holiday> list = holidayMapper.listLikeStateType("状态", "病假");

		for (Holiday holiday : list) {
			System.out.println("++++++++++++++" + holiday.getType());
			System.out.println("++++++++++++++" + holiday.getReason());
		}
	}

	@Test
	public void selectHolidayByProcessInstanceIdLikeStateType() {
		Holiday holiday = holidayMapper.selectHolidayByProcessInstanceIdLikeStateType("5", "通过", "病假");

		System.out.println("++++++++++++++" + holiday.getType());
		System.out.println("++++++++++++++" + holiday.getReason());
	}

	@Test
	public void selectCreatByMeLikeStateType() {
		List<Holiday> holiday = holidayMapper.selectCreatByMeLikeStateType(140, "通过", "病假");
		for (Holiday holiday2 : holiday) {
			System.out.println(holiday2.getEnclosure());
		}
	}
	@Test
	public void selectExaminationByMeLikeStateType() {
		List<HolidayAndExaminationTime> holiday = holidayMapper.selectExaminationByMeLikeStateType("admin","状态", "类型");
		for (HolidayAndExaminationTime holiday2 : holiday) {
			System.out.println(holiday2.getExaminationTime());
		}
	}
	
	@Test
	public void selectCompleteByMeLikeStateType() {
		List<HolidayAndExaminationTime> holiday = holidayMapper.selectCompleteByMeLikeStateType("admin","状态", "类型");
		for (HolidayAndExaminationTime holiday2 : holiday) {
			System.out.println(holiday2.getExaminationTime());
		}
	}
	
	@Test
	public void listLikeTypeAndApproved() {
		List<Holiday> list = holidayMapper.listLikeTypeAndApproved("已通过", "类型");
		List<String> list2 = list.stream()
			.map(Holiday::getTest)
			.collect(Collectors.toList());
		list2.forEach(System.out::println);
	}

}
