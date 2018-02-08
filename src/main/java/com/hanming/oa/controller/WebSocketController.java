package com.hanming.oa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.Friends;
import com.hanming.oa.model.User;
import com.hanming.oa.service.FriendsService;
import com.hanming.oa.service.UserService;

@Controller
@RequestMapping("/admin/friends")
public class WebSocketController {

	@Autowired
	UserService UserService;
	@Autowired
	FriendsService friendsService;

	// 发送申请好友
	@ResponseBody
	@RequestMapping(value = "/addFriends", method = RequestMethod.POST)
	public Msg requestAddFriends(@RequestParam("toUserID") Integer toUserId, HttpServletRequest request) {

		Integer fromUserId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		User user = UserService.selectByPrimaryKeyWithDeptAndRole(fromUserId);
		// 信息类型
		request.getSession().setAttribute("type", "addFrends");
		// 信息去向
		request.getSession().setAttribute("toUserId", toUserId);
		// 发送人信息
		request.getSession().setAttribute("user", user);

		// 用于前台添加连接和后台确认连接
		request.getSession().setAttribute("uid", fromUserId);

		return Msg.success().add("uid", fromUserId).add("name", user.getName());
	}

	// 接受申请好友
	@ResponseBody
	@RequestMapping(value = "/responseAddFridens", method = RequestMethod.GET)
	public Msg responseAddFridens(HttpServletRequest request) {
		Integer fromUserId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		User user = UserService.selectByPrimaryKeyWithDeptAndRole(fromUserId);
		request.getSession().setAttribute("type", "responseAddFridens");
		request.getSession().setAttribute("toUserId", fromUserId);
		request.getSession().setAttribute("user", user);
		// 用于前台添加连接和后台确认连接
		request.getSession().setAttribute("uid", fromUserId);
		return Msg.success().add("uid", fromUserId);
	}

	// 遍历我的好友列表
	@ResponseBody
	@RequestMapping(value = "/friends", method = RequestMethod.GET)
	public Msg myFriends() {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		List<User> friends = friendsService.listByUserId(userId);

		return Msg.success().add("friends", friends);
	}

	// 同意添加好友
	@ResponseBody
	@RequestMapping(value = "/agreeAddFriend", method = RequestMethod.POST)
	public Msg agreeAddFriend(@RequestParam(value = "friendId") Integer friendId,
			@RequestParam(value = "isAgree") Integer isAgree) {
		Integer userId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		User user = UserService.selectByPrimaryKeyWithDeptAndRole(userId);
		User friend = UserService.selectByPrimaryKeyWithDeptAndRole(friendId);
		if (isAgree == 1) {
			Integer count = friendsService.countByFreindIdAndMyId(friendId, userId);
			if (count == 0) {

				// 将他添加为我的好友
				Friends friends = new Friends();
				friends.setMyid(userId);
				friends.setFriendid(friendId);

				// 将我添加为他的好友
				Friends byFriends = new Friends();
				byFriends.setFriendid(userId);
				byFriends.setMyid(friendId);

				friendsService.insert(friends, byFriends);
			}
		}

		return Msg.success().add("fromId", userId).add("fromName", user.getName()).add("friend", friend);
	}
	
	//删除消息队列确认添加好友消息
	@ResponseBody
	@RequestMapping(value = "/unAgreeAddFriend", method = RequestMethod.POST)
	public Msg unAgreeAddFriend() {
		Integer fromUserId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		User user = UserService.selectByPrimaryKeyWithDeptAndRole(fromUserId);
		
		return Msg.success().add("fromId", fromUserId).add("fromName", user.getName());
	}
}
