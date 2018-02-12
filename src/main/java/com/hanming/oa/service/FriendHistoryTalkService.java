package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.FriendHistoryTalkMapper;
import com.hanming.oa.model.Message;

@Service
public class FriendHistoryTalkService {

	@Autowired
	FriendHistoryTalkMapper friendHistoryTalkMapper;
	
	public List<Message> list(Integer fromUserId, Integer friendId) {
		List<Message> Messages = friendHistoryTalkMapper.list(fromUserId,friendId);
		return Messages;
	}

}
