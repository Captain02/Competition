package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.NoticeMapper;
import com.hanming.oa.model.Notice;
import com.hanming.oa.model.NoticeDisplay;

@Service
public class NoticeService {
	
	@Autowired
	NoticeMapper noticeMapper;

	public List<NoticeDisplay> list() {
		List<NoticeDisplay> list = noticeMapper.list();
		return list;
	}

	public void insert(Notice notice) {
		noticeMapper.insertSelective(notice);
	}

}
