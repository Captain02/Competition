package com.hanming.oa.webSocket;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import com.alibaba.fastjson.JSON;
import com.hanming.oa.Tool.DateTool;
import com.hanming.oa.model.Message;
import com.hanming.oa.model.User;

/*
 * WebSockect处理器
 * */
@Component
public class MyWebSocketHandler implements WebSocketHandler {
	// 在线用户的SockectSession(存储了所有通信的通道)
	public static final Map<Integer, WebSocketSession> userSocketSessionMap;
	// 存放用户的离线信息 使用队列实现
	public static final Map<Integer, BlockingQueue<TextMessage>> userSocketTalkQueue;
	// 请求添加好友消息队列
	public static final Map<Integer, BlockingQueue<TextMessage>> userSocketAddFriendsQueue;
	// 请求视频通话消息队列
	public static final Map<Integer, BlockingQueue<TextMessage>> userSocketVideoTalkQueue;

	static {
		userSocketSessionMap = new HashMap<>();
		userSocketTalkQueue = new HashMap<>();
		userSocketAddFriendsQueue = new HashMap<>();
		userSocketVideoTalkQueue = new HashMap<>();
	}

	/*
	 * 简历后webSockect建立好连接之后的处理函数, 拦截建立后的准备工作
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 信息去向
		Integer toUserId = (Integer) session.getAttributes().get("toUserId");
		// 信息类型
		String type = (String) session.getAttributes().get("type");
		// 信息发送人信息
		User user = (User) session.getAttributes().get("user");
		// 判断是否重复登录
		if (userSocketSessionMap.get(user.getId()) == null) {
			userSocketSessionMap.put(user.getId(), session);

			// 好友请求
			if ("addFrends".equals(type)) {
				Message message = new Message(user.getId(), user.getName(), toUserId, user.getName() + "请求加您为好友",
						DateTool.dateToString(new Date()), "addFrends", user);
				TextMessage textMessage = new TextMessage(JSON.toJSONString(message));
				// 查询申请人是否还有其他未处理的其他申请
				BlockingQueue<TextMessage> addFriendsQueue = userSocketAddFriendsQueue.get(toUserId);
				if (addFriendsQueue != null) {
					addFriendsQueue.offer(new TextMessage(JSON.toJSONString(message)));
				} else {
					BlockingQueue<TextMessage> newAddFriendsQueue = new LinkedBlockingQueue<TextMessage>(10);
					newAddFriendsQueue.offer(new TextMessage(JSON.toJSONString(message)));
					userSocketAddFriendsQueue.put(toUserId, newAddFriendsQueue);
				}
				// 发送添加好友
				if (null != userSocketSessionMap.get(toUserId)) {
					sendMessageToUser(toUserId, textMessage);
				}
			}

			// 打开连接
			// 接受好友请求，显示未处理的消息
			if ("responseAddFridens".equals(type)) {
				BlockingQueue<TextMessage> addFriendsQueue = userSocketAddFriendsQueue.get(toUserId);
				if (addFriendsQueue != null) {
					for (TextMessage textMessage : addFriendsQueue) {
						sendMessageToUser(toUserId, textMessage);
					}
				}
				BlockingQueue<TextMessage> talkQueue = userSocketTalkQueue.get(toUserId);
				if (talkQueue != null) {
					for (TextMessage textMessage : talkQueue) {
						sendMessageToUser(toUserId, textMessage);
					}
				}
				BlockingQueue<TextMessage> videoTalkQueue = userSocketVideoTalkQueue.get(toUserId);
				if (videoTalkQueue != null) {
					for (TextMessage textMessage : videoTalkQueue) {
						sendMessageToUser(toUserId, textMessage);
					}
				}
			}

		}
	}

	/*
	 * 处理消息
	 */
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		// 是否含有信息
		if (message.getPayloadLength() == 0) {
			return;
		}
		// 设置时间
		Message msg = JSON.parseObject(message.getPayload().toString(), Message.class);
		msg.setDate(DateTool.dateToString(new Date()));

		// 取消回执
		if ("unAgreeAddFriend".equals(msg.getType())) {
			BlockingQueue<TextMessage> byRequestAddFriend = userSocketAddFriendsQueue.get(msg.getFromId());
			freeQueue(msg, byRequestAddFriend);
		}

		// 同意或拒绝添加好友
		if ("agreeAddFriend".equals(msg.getType())) {
			// 释放被申请人的添加好友请求
			BlockingQueue<TextMessage> byRequestAddFriend = userSocketAddFriendsQueue.get(msg.getFromId());
			freeQueue(msg, byRequestAddFriend);
			WebSocketSession socketSession = userSocketSessionMap.get(msg.getToId());
			BlockingQueue<TextMessage> addFriendsQueue = userSocketAddFriendsQueue.get(msg.getToId());
			// 如果此人有未处理的添加好友请求
			if (addFriendsQueue != null) {
				addFriendsQueue.offer(new TextMessage(JSON.toJSONString(msg)));
			} else if (addFriendsQueue == null) {
				// 如果此人没有有未处理的添加好友请求
				BlockingQueue<TextMessage> newAddFriendsQueue = new LinkedBlockingQueue<TextMessage>(10);
				newAddFriendsQueue.offer(new TextMessage(JSON.toJSONString(msg)));
				userSocketAddFriendsQueue.put(msg.getToId(), newAddFriendsQueue);
			}
			// 判断用户是否在线
			if (socketSession != null) {
				// 发送同意好友请求
				sendMessageToUser(msg.getToId(), new TextMessage(JSON.toJSONString(msg)));
			}
		}

		// 发送消息
		if ("sendTalk".equals(msg.getType())) {
			WebSocketSession webSocketSession = userSocketSessionMap.get(msg.getToId());
			BlockingQueue<TextMessage> talkQueue = userSocketTalkQueue.get(msg.getToId());
			// 判断是否有未处理的回话会话
			if (talkQueue != null) {
				talkQueue.offer((new TextMessage(JSON.toJSONString(msg))));
				userSocketTalkQueue.put(msg.getToId(), talkQueue);
			} else if (talkQueue == null) {
				BlockingQueue<TextMessage> acceptTalk = new LinkedBlockingQueue<>(100);
				acceptTalk.offer(new TextMessage(JSON.toJSONString(msg)));
				userSocketTalkQueue.put(msg.getToId(), acceptTalk);
			}
			if (webSocketSession != null) {
				sendMessageToUser(msg.getToId(), new TextMessage(JSON.toJSONString(msg)));
			}
		}
		// 发送消息
		if ("videoTalk".equals(msg.getType())) {
			WebSocketSession webSocketSession = userSocketSessionMap.get(msg.getToId());
			BlockingQueue<TextMessage> talkQueue = userSocketVideoTalkQueue.get(msg.getToId());
			// 判断是否有未处理的回话会话
			if (talkQueue != null) {
				talkQueue.offer((new TextMessage(JSON.toJSONString(msg))));
				userSocketVideoTalkQueue.put(msg.getToId(), talkQueue);
			} else if (talkQueue == null) {
				BlockingQueue<TextMessage> acceptTalk = new LinkedBlockingQueue<>(100);
				acceptTalk.offer(new TextMessage(JSON.toJSONString(msg)));
				userSocketVideoTalkQueue.put(msg.getToId(), acceptTalk);
			}
			if (webSocketSession != null) {
				sendMessageToUser(msg.getToId(), new TextMessage(JSON.toJSONString(msg)));
			}
		}
		// 发送消息
		if ("unVideoTalk".equals(msg.getType())) {
			// 释放被申请人的添加好友请求
			BlockingQueue<TextMessage> byRequestAddFriend = userSocketVideoTalkQueue.get(msg.getFromId());
			freeQueue(msg, byRequestAddFriend);
			WebSocketSession socketSession = userSocketSessionMap.get(msg.getToId());
			/*BlockingQueue<TextMessage> addFriendsQueue = userSocketVideoTalkQueue.get(msg.getToId());
			// 如果此人有未处理的添加好友请求
			if (addFriendsQueue != null) {
				addFriendsQueue.offer(new TextMessage(JSON.toJSONString(msg)));
			} else if (addFriendsQueue == null) {
				// 如果此人没有有未处理的添加好友请求
				BlockingQueue<TextMessage> newAddFriendsQueue = new LinkedBlockingQueue<TextMessage>(10);
				newAddFriendsQueue.offer(new TextMessage(JSON.toJSONString(msg)));
				userSocketAddFriendsQueue.put(msg.getToId(), newAddFriendsQueue);
			}*/
			// 判断用户是否在线
			if (socketSession != null) {
				// 发送同意好友请求
				sendMessageToUser(msg.getToId(), new TextMessage(JSON.toJSONString(msg)));
			}
		}

		// 释放离线信息
		if ("acceptTalks".equals(msg.getType())) {
			BlockingQueue<TextMessage> acceptTalk = userSocketTalkQueue.get(msg.getFromId());
			freeQueue(msg, acceptTalk);
		}
	}

	// 释放资源
	private void freeQueue(Message msg, BlockingQueue<TextMessage> byRequestAddFriend) {
		if (byRequestAddFriend == null) {
			return;
		}
		for (TextMessage textMessage : byRequestAddFriend) {
			Message byRequestAddFriendMessage = JSON.parseObject(textMessage.getPayload().toString(), Message.class);
			// 找到我要释放的信息是，我发送同意信息接收人和发送给我的信息的发送人一致时，此信息被释放
			Integer fromId = byRequestAddFriendMessage.getFromId();
			Integer toId = msg.getToId();
			if (toId.equals(fromId)) {
				byRequestAddFriend.remove(textMessage);
			}
		}
	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		if (session.isOpen()) {
			session.close();
		}
		Iterator<Entry<Integer, WebSocketSession>> it = userSocketSessionMap.entrySet().iterator();
		// 移除Socket会话
		while (it.hasNext()) {
			Entry<Integer, WebSocketSession> entry = it.next();
			if (entry.getValue().getId().equals(session.getId())) {
				userSocketSessionMap.remove(entry.getKey());
				System.out.println("Socket会话已经移除:用户ID" + entry.getKey());
				break;
			}
		}

	}

	@Override
	public boolean supportsPartialMessages() {
		// TODO Auto-generated method stub
		return false;
	}

	/*
	 * 关闭连接
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
		// 当前的连接的用户放入MAP，key使用户编号
		System.out.println("Websocket:" + session.getId() + "已经关闭");
		Iterator<Entry<Integer, WebSocketSession>> iterator = userSocketSessionMap.entrySet().iterator();
		while (iterator.hasNext()) {
			Entry<Integer, WebSocketSession> entry = iterator.next();
			if (entry.getValue().getId().equals(session.getId())) {
				userSocketSessionMap.remove(entry.getKey());
				System.out.println("Sockect回话已经移除：用户ID" + entry.getKey());
				break;
			}
		}
	}

	/**
	 * 给所有在线用户发送消息
	 * 
	 * @param message
	 */
	public static void broadcast(final TextMessage message) {
		Iterator<Entry<Integer, WebSocketSession>> it = userSocketSessionMap.entrySet().iterator();
		// 对用户发送的消息内容进行转义

		// 多线程群发
		while (it.hasNext()) {
			// 某用户的WebSocketSession对象
			final Entry<Integer, WebSocketSession> entry = it.next();
			// 判断用户的WebSock
			if (entry.getValue().isOpen()) {
				// entry.getValue().sendMessage(message);
				new Thread(new Runnable() {

					@Override
					public void run() {
						try {
							if (entry.getValue().isOpen()) {
								entry.getValue().sendMessage(message);
							}
						} catch (IOException e) {
							e.printStackTrace();
						}
					}

				}).start();
			}

		}
	}

	/**
	 * 给某个用户发送消息
	 * 
	 * @param userName
	 * @param message
	 * @throws IOException
	 */
	public static void sendMessageToUser(Integer uid, TextMessage message) throws IOException {
		WebSocketSession session = userSocketSessionMap.get(uid);
		if (session != null && session.isOpen()) {
			session.sendMessage(message);
		}
	}
}
