package com.hanming.oa.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hanming.oa.Tool.DateTool;
import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.FriendHistoryTalk;
import com.hanming.oa.model.Message;
import com.hanming.oa.model.User;
import com.hanming.oa.service.FriendHistoryTalkService;
import com.hanming.oa.service.FriendsService;
import com.hanming.oa.service.UserService;

@Controller
@RequestMapping("/admin/friends")
public class WebSocketController {

	@Autowired
	UserService UserService;
	@Autowired
	FriendsService friendsService;
	@Autowired
	FriendHistoryTalkService friendHistoryTalkService;

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
		friendsService.addFriends(friendId, isAgree, userId);

		return Msg.success().add("fromId", userId).add("fromName", user.getName()).add("friend", friend);
	}

	// 删除消息队列确认添加好友消息
	@ResponseBody
	@RequestMapping(value = "/unAgreeAddFriend", method = RequestMethod.POST)
	public Msg unAgreeAddFriend() {
		Integer fromUserId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		User user = UserService.selectByPrimaryKeyWithDeptAndRole(fromUserId);

		return Msg.success().add("fromId", fromUserId).add("fromName", user.getName());
	}

	// 聊天消息
	@ResponseBody
	@RequestMapping(value = "/talk", method = RequestMethod.POST)
	public Msg talk(HttpServletRequest request, @RequestParam("toId") Integer toId, @RequestParam("text") String text) {
		Integer fromUserId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		FriendHistoryTalk friendHistoryTalk = new FriendHistoryTalk(null, fromUserId, fromUserId, toId,
				DateTool.dateToString(new Date()), text);
		FriendHistoryTalk friendHistoryTalk2 = new FriendHistoryTalk(null, toId, fromUserId, toId,
				DateTool.dateToString(new Date()), text);
		friendsService.insertTalkRecord(friendHistoryTalk, friendHistoryTalk2);

		User user = UserService.selectByPrimaryKeyWithDeptAndRole(fromUserId);
		// 发送人信息
		request.getSession().setAttribute("user", user);

		return Msg.success().add("fromId", fromUserId).add("fromName", user.getName()).add("user", user).add("sendTime",
				DateTool.dateToString(new Date()));
	}

	// 释放离线消息
	@ResponseBody
	@RequestMapping(value = "/acceptTalk", method = RequestMethod.POST)
	public Msg acceptTalk() {
		Integer fromUserId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		User user = UserService.selectByPrimaryKeyWithDeptAndRole(fromUserId);

		return Msg.success().add("fromId", fromUserId).add("fromName", user.getName());
	}

	// 查看历史记录
	@RequestMapping(value = "/historyTalk", method = RequestMethod.GET)
	public String historyTalk(@RequestParam(value="pn",defaultValue="1")Integer pn,@RequestParam("friendId") Integer friendId, Model model) {
		Integer fromUserId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		System.out.println(pn);
		PageInfo<Message> pageInfo = null;
		PageHelper.startPage(pn,8);
		List<Message> list = friendHistoryTalkService.list(fromUserId, friendId);
		pageInfo = new PageInfo<Message>(list,5);
		
		model.addAttribute("pageInfo",pageInfo);
		model.addAttribute("myId",fromUserId);
		model.addAttribute("friendId",friendId);
		return "personPage/message";
	}
	
	// 删除好友
	@ResponseBody
	@RequestMapping(value="/deleFrend",method=RequestMethod.POST)
	public Msg deleFriend(@RequestParam("friendId")Integer friendId) {
		Integer fromUserId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		friendsService.deleFriend(fromUserId,friendId);
		return Msg.success();
	}
}
