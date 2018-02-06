package com.hanming.oa.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hanming.oa.Tool.Msg;
import com.hanming.oa.model.User;
import com.hanming.oa.service.UserService;

@Controller
@RequestMapping("/admin/friends")
public class WebSocketController {

	@Autowired
	UserService UserService;
	
	//发送申请好友
	@ResponseBody
	@RequestMapping(value="/addFriends",method=RequestMethod.POST)
	public Msg requestAddFriends(@RequestParam("toUserID")Integer toUserId,HttpServletRequest request){
		
		Integer fromUserId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		User user = UserService.selectByPrimaryKey(fromUserId);
		//信息类型
		request.getSession().setAttribute("type", "addFrends");
		//信息去向
		request.getSession().setAttribute("toUserId", toUserId);
		//发送人信息
		request.getSession().setAttribute("user", user);
		
		//用于前台添加连接和后台确认连接
		request.getSession().setAttribute("uid", fromUserId);
		
		return Msg.success().add("uid", fromUserId).add("name", user.getName());
	}
	
	//接受申请好友
	@ResponseBody
	@RequestMapping(value="/responseAddFridens",method=RequestMethod.GET)
	public Msg responseAddFridens(HttpServletRequest request) {
		Integer fromUserId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		User user = UserService.selectByPrimaryKey(fromUserId);
		request.getSession().setAttribute("type", "responseAddFridens");
		request.getSession().setAttribute("toUserId",fromUserId);
		request.getSession().setAttribute("user", user);
		//用于前台添加连接和后台确认连接
		request.getSession().setAttribute("uid",fromUserId);
		return Msg.success().add("uid", fromUserId);
	}
}
