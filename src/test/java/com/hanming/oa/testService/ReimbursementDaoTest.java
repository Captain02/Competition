package com.hanming.oa.testService;

import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hanming.oa.dao.ReimbursementMapper;
import com.hanming.oa.model.Reimbursement;
import com.hanming.oa.model.ReimbursementAndExaminationTime;
import com.hanming.oa.model.ReportDataBean;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:/spring/spring-dao.xml" })
public class ReimbursementDaoTest {

	@Autowired
	ReimbursementMapper reimbursementMapper;

	@Test
	public void listLikeStateType() {

		List<Reimbursement> list = reimbursementMapper.listLikeStateType("", "");
	}

	@Test
	public void dataAnalysisByMonth() {
		List<Map<String, Float>> dataAnalysisByMonth = reimbursementMapper.dataAnalysisByMonth("2017");
		Object [] objects = new Object [] {
				0,0,0,0,0,0,0,0,0,0,0,0,
		} ;
		Object index = null;
		Object money = null;
		List<Object> categories = Arrays.asList(objects);
		for (Map<String, Float> mapForDataAnalysisByMonth : dataAnalysisByMonth) {
			for (Map.Entry<String, Float> entry : mapForDataAnalysisByMonth.entrySet()) {
				if ("month".equals(entry.getKey())) {
					index=entry.getValue();
				} else if ("money".equals(entry.getKey())) {
					money=entry.getValue();
				}
			}
			categories.set((int) index-1, money);
		}
		System.out.println("================"+categories);
		
	}
	
	@Test
	public void selectCreatByMeLikeStateType() {
		List<Reimbursement> list = reimbursementMapper.selectCreatByMeLikeStateType(140, "状态", "类型");
		for (Reimbursement reimbursement : list) {
			System.out.println(reimbursement.getDate());
		}
		
	}
	
	@Test
	public void selectExaminationByMeLikeStateType() {
		List<ReimbursementAndExaminationTime> list = reimbursementMapper.selectExaminationByMeLikeStateType("admin","状态", "类型");
		for (ReimbursementAndExaminationTime reimbursementAndExaminationTime : list) {
			System.out.println(reimbursementAndExaminationTime.getStartExaminationTime());
		}
	}
	
	@Test
	public void selectCompleteByMeLikeStateType() {
		List<ReimbursementAndExaminationTime> list = reimbursementMapper.selectCompleteByMeLikeStateType("admin","状态", "类型");
		for (ReimbursementAndExaminationTime reimbursementAndExaminationTime : list) {
			System.out.println(reimbursementAndExaminationTime.getExaminationTime());
		}
	}

}
