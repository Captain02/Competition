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
	
	@ResponseBody
	@RequestMapping(value="/addFriends",method=RequestMethod.POST)
	public Msg requestAddFriends(@RequestParam("toUserID")Integer toUserId,HttpServletRequest request){
		
		Integer fromUserId = (Integer) SecurityUtils.getSubject().getSession().getAttribute("id");
		User user = UserService.selectByPrimaryKey(fromUserId);
		request.getSession().setAttribute("uid", fromUserId);
		request.getSession().setAttribute("type", "addFrends");
		request.getSession().setAttribute("toUserId", toUserId);
		
		/*Message message = new Message();
		message.setFromId(fromUserId);
		message.setFromName(user.getName());
		message.setDate(DateTool.dateToString(new Date()));
		message.setText(user.getName()+"请求加您为好友");
		message.setToId(toUserId);
		message.setType("添加好友");
		
		request.getSession().setAttribute("message", message);*/
		
		
		return Msg.success().add("uid", fromUserId).add("name", user.getName());
	}
}
