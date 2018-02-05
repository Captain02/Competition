package com.hanming.oa.webSocket;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

public class HandShake implements HandshakeInterceptor {

	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {
		System.out.println("Websocket:用户[ID:" + ((ServletServerHttpRequest) request).getServletRequest().getSession(false).getAttribute("uid") + "]已经建立连接");
		if (request instanceof ServletServerHttpRequest) {
			ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
			HttpSession session = servletRequest.getServletRequest().getSession(false);
			// 标记用户
			Integer uid = (Integer) session.getAttribute("uid");
			String name = (String) session.getAttribute("name");
			String type = (String) session.getAttribute("type");
			Integer toUserId = (Integer) session.getAttribute("toUserId");
			//Long fuid = (Long) session.getAttribute("fuid");
			//若果用户登录，允许登录
			if(uid!=null){
			//将用户放入sockect处理器的回话（WebSocketSession）中
				attributes.put("uid", uid);
				attributes.put("name", name);
				attributes.put("type", type);
				attributes.put("toUserId", toUserId);
				//attributes.put("fuid", fuid);
			}else{
				//用户没有登录，拒绝聊天，握手失败
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
