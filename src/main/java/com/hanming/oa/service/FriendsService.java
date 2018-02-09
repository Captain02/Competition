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

	public Integer countByFreindIdAndMyId(Integer friendId, Integer userId) {
		Integer count = friendsMapper.countByFreindIdAndMyId(friendId,userId);
		return count;
	}

	@Transactional
	public void addFriends(Integer friendId, Integer isAgree, Integer userId) {
		if (isAgree == 1) {
			Integer count = countByFreindIdAndMyId(friendId, userId);
			if (count == 0) {

				// 将他添加为我的好友
				Friends friends = new Friends();
				friends.setMyid(userId);
				friends.setFriendid(friendId);

				// 将我添加为他的好友
				Friends byFriends = new Friends();
				byFriends.setFriendid(userId);
				byFriends.setMyid(friendId);

				insert(friends, byFriends);
			}
		}
	}


}
