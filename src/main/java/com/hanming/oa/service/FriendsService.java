package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	@Transactional
	public void insert(Friends friends, Friends byFriends) {
		friendsMapper.insertSelective(byFriends);
		friendsMapper.insertSelective(friends);
	}


}
