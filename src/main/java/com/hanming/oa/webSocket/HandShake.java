package com.hanming.oa.webSocket;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import com.hanming.oa.model.User;

public class HandShake implements HandshakeInterceptor {

	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {
		System.out.println("Websocket:用户[ID:"
				+ ((ServletServerHttpRequest) request).getServletRequest().getSession(false).getAttribute("uid")
				+ "]已经建立连接");
		if (request instanceof ServletServerHttpRequest) {
			ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
			HttpSession session = servletRequest.getServletRequest().getSession(false);
			//信息类型
			String type = (String) session.getAttribute("type");
			//信息去向
			Integer toUserId = (Integer) session.getAttribute("toUserId");
			//信息发送人信息
			User user = (User) session.getAttribute("user");
			if (type != null) {

				attributes.put("type", type);
			}
			if (toUserId != null) {

				attributes.put("toUserId", toUserId);
			}
			if (user != null) {

				attributes.put("user", user);
			}else {
				// 用户没有登录，拒绝聊天，握手失败
				return false;
			}
		}
		return true;
	}

	@Override
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Exception exception) {
		// TODO Auto-generated method stub

	}

}
