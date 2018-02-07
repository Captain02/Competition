package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.FriendsMapper;
import com.hanming.oa.model.Friends;
import com.hanming.oa.model.User;

@Service
public class FriendsService {

	@Autowired
	FriendsMapper friendsMapper;
	
	public List<User> listByUserId(Integer userId) {
		List<User> friends = friendsMapper.listByUserId(userId);
		return friends;
	}

}
