package com.hanming.oa.testService;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hanming.oa.dao.WorkAttendanceMapper;
import com.hanming.oa.model.WorkAttendenceDisplay;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:/spring/spring-dao.xml" })
public class WorkAtendenceDaoTest {

	@Autowired
	WorkAttendanceMapper workAttendanceMapper;
	
	@Test
	public void list() {
		List<WorkAttendenceDisplay> list = workAttendanceMapper.list("2018-02-01",0,"姓名");
		for (WorkAttendenceDisplay workAttendenceDisplay : list) {
			for (String state : workAttendenceDisplay.getState()) {
				System.out.println(state);
			}
		}
	}
	@Test
	public void selectNormalByMonthStatistics() {
		Integer integer = workAttendanceMapper.selectNormalByMonthStatistics("2018-02-02");
		System.out.println(integer);
	}
	
	@Test
	public void selectCountByDate() {
		Integer integer = workAttendanceMapper.selectCountByDate("2018-02-02");
		System.out.println(integer);
	}
}
