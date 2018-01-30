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

	public List<NoticeDisplay> list(Integer isByMyId) {
		List<NoticeDisplay> list = noticeMapper.list(isByMyId);
		return list;
	}

	public void insert(Notice notice) {
		noticeMapper.insertSelective(notice);
	}

	public Notice selectByPrimaryKey(Integer id) {
		Notice notice = noticeMapper.selectByPrimaryKey(id);
		return notice;
	}

	public void update(Notice notice) {
		noticeMapper.updateByPrimaryKeySelective(notice);
	}

	public void dele(Integer noticeId) {
		noticeMapper.deleteByPrimaryKey(noticeId);
	}

}
