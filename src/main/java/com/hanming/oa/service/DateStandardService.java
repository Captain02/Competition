package com.hanming.oa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.DateStandardMapper;
import com.hanming.oa.model.DateStandard;

@Service
public class DateStandardService {

	@Autowired
	DateStandardMapper dateStandardMapper;

	public DateStandard selectByprimaryKey(Integer id) {
		DateStandard dateStandard = dateStandardMapper.selectByPrimaryKey(id);
		return dateStandard;
	}

	public void update(DateStandard dateStandard) {
		dateStandardMapper.updateByPrimaryKeySelective(dateStandard);
	}
}
