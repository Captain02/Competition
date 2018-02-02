package com.hanming.oa.service;

import org.springframework.stereotype.Service;

import com.hanming.oa.dao.WorkAttendencePunishmentMapper;
import com.hanming.oa.model.WorkAttendencePunishment;

@Service
public class WorkAttendencePunishmentService {
	
	WorkAttendencePunishmentMapper workAttendencePunishmentMapper;

	public void insert(WorkAttendencePunishment workAttendencePunishment) {
		workAttendencePunishmentMapper.insertSelective(workAttendencePunishment);
	}

}
