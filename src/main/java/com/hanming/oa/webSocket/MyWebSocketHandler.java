package com.hanming.oa.webSocket;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.BlockingQueue;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

/*
 * WebSockect处理器
 * */
@Component
public class MyWebSocketHandler implements WebSocketHandler {
	//在线用户的SockectSession(存储了所有通信的通道)
	public static final Map<Long, WebSocketSession> userSocketSessionMap;
	// 存放用户的离线信息 使用队列实现
	public static final Map<Long, BlockingQueue<TextMessage>> userSocketQueue;
	
	public static final Map<Long, WebSocketSession> userSocketSessionMap2;
	
	public static final Map<Long, BlockingQueue<TextMessage>> userSocketQueue2;
	
	static {
		userSocketSessionMap = new HashMap<>();
		userSocketQueue = new HashMap<>();
		userSocketSessionMap2 = new HashMap<>();
		userSocketQueue2 = new HashMap<>();
	}
	
	/*
	 * 简历后webSockect建立好连接之后的处理函数,  拦截建立后的准备工作
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession arg0, CloseStatus arg1) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession arg0) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void handleMessage(WebSocketSession arg0, WebSocketMessage<?> arg1) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void handleTransportError(WebSocketSession arg0, Throwable arg1) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean supportsPartialMessages() {
		// TODO Auto-generated method stub
		return false;
	}

}
