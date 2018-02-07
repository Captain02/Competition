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
import com.hanming.oa.model.RequestAddFriend;
import com.hanming.oa.model.User;

/*
 * WebSockect处理器
 * */
@Component
public class MyWebSocketHandler implements WebSocketHandler {
	// 在线用户的SockectSession(存储了所有通信的通道)
	public static final Map<Integer, WebSocketSession> userSocketSessionMap;
	// 存放用户的离线信息 使用队列实现
	public static final Map<Integer, BlockingQueue<TextMessage>> userSocketQueue;
	// 请求添加好友消息队列
	public static final Map<Integer, BlockingQueue<TextMessage>> userSocketAddFriendsQueue;

	static {
		userSocketSessionMap = new HashMap<>();
		userSocketQueue = new HashMap<>();
		userSocketAddFriendsQueue = new HashMap<>();
	}

	/*
	 * 简历后webSockect建立好连接之后的处理函数, 拦截建立后的准备工作
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//信息去向
		Integer toUserId = (Integer) session.getAttributes().get("toUserId");
		//信息类型
		String type = (String) session.getAttributes().get("type");
		//信息发送人信息
		User user = (User) session.getAttributes().get("user");
		// 判断是否重复登录
		if (userSocketSessionMap.get(user.getId()) == null) {
			userSocketSessionMap.put(user.getId(), session);

			// 好友请求
			if ("addFrends".equals(type)) {
				Message message = new Message(user.getId(), user.getName(), toUserId, user.getName() + "请求加您为好友",
						DateTool.dateToString(new Date()), "addFrends", user);
				TextMessage textMessage = new TextMessage(JSON.toJSONString(message));
				// 发送添加好友
				if (null != userSocketSessionMap.get(toUserId)) {
					sendMessageToUser(toUserId, textMessage);
				} else {
					// 查询申请人是否还有其他未处理的其他申请
					BlockingQueue<TextMessage> addFriendsQueue = userSocketAddFriendsQueue.get(toUserId);
					if (addFriendsQueue != null) {
						addFriendsQueue.offer(new TextMessage(JSON.toJSONString(message)));
					} else {
						BlockingQueue<TextMessage> newAddFriendsQueue = new LinkedBlockingQueue<TextMessage>(100);
						newAddFriendsQueue.offer(new TextMessage(JSON.toJSONString(message)));
						userSocketAddFriendsQueue.put(toUserId, newAddFriendsQueue);
					}
				}
			}
			
			// 接受好友请求
			if ("responseAddFridens".equals(type)) {
				BlockingQueue<TextMessage> addFriendsQueue = userSocketAddFriendsQueue.get(toUserId);
				if (addFriendsQueue != null) {

					for (TextMessage textMessage : addFriendsQueue) {
						addFriendsQueue.remove(textMessage);
							sendMessageToUser(toUserId, textMessage);
					}
				}
			}

//			// 某人离线消息
//			if ("talk".equals(type)) {
//				BlockingQueue<TextMessage> addFriendsQueue = userSocketQueue.get(toUserId);
//				if (addFriendsQueue != null) {
//					for (TextMessage textMessage : addFriendsQueue) {
//						Message msg = JSON.parseObject(textMessage.getPayload().toString(), Message.class);
//						if (msg.getToId() == toUserId) {
//							if (msg.getFromId() == fromUserId) {
//								sendMessageToUser(toUserId, addFriendsQueue.poll());
//							}
//							// blockingQueue.p
//						}
//					}
//				}
//			}

			/*
			 * BlockingQueue<TextMessage> blockingQueue = userSocketQueue.get(uid); if
			 * (blockingQueue != null) { for (TextMessage textMessage : blockingQueue) {
			 * Message msg = JSON.parseObject(textMessage.getPayload().toString(),
			 * Message.class); if (msg.getFromId() == fuid) { sendMessageToUser(uid,
			 * textMessage); blockingQueue.remove(textMessage); } } return; }
			 * BlockingQueue<TextMessage> queue = new LinkedBlockingQueue<TextMessage>(100);
			 * userSocketQueue.put(uid, queue);
			 */
		}
	}

	/*
	 * 处理消息
	 */
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		System.out.println(message.getPayloadLength() + "++++++++++++++++++++++++++++++++");
		// if (message.getPayloadLength() == 0) {
		// return;
		// }
		// Message msg = JSON.parseObject(message.getPayload().toString(),
		// Message.class);
		// msg.setDate(DateTool.dateToString(new Date()));
		//
		// WebSocketSession socketSession = userSocketSessionMap.get(msg.getToId());
		// if (socketSession != null) {
		// sendMessageToUser(msg.getToId(), new TextMessage(JSON.toJSONString(msg)));
		// return;
		// } else if (socketSession == null) {
		//
		// //好友请求
		// if ("addFrends".equals(msg.getType())) {
		// //若不在线
		// BlockingQueue<TextMessage> addFriendsQueue =
		// userSocketAddFriendsQueue.get(msg.getFromId());
		// // 如果此人有未处理的添加好友请求
		// if (addFriendsQueue != null) {
		// addFriendsQueue.offer(new TextMessage(JSON.toJSONString(msg)));
		// } else if (addFriendsQueue == null) {
		// // 如果此人没有有未处理的添加好友请求
		// BlockingQueue<TextMessage> newAddFriendsQueue = new
		// LinkedBlockingQueue<TextMessage>(100);
		// newAddFriendsQueue.offer(new TextMessage(JSON.toJSONString(msg)));
		// userSocketAddFriendsQueue.put(msg.getToId(), newAddFriendsQueue);
		// }
		// }

		/*
		 * BlockingQueue<TextMessage> blockingQueue =
		 * userSocketQueue.get(msg.getToId());
		 * 
		 * if (blockingQueue == null) { BlockingQueue<TextMessage> queue = new
		 * LinkedBlockingQueue<TextMessage>(100); queue.offer(new
		 * TextMessage(JSON.toJSONString(msg))); userSocketQueue.put(msg.getToId(),
		 * queue); } if (blockingQueue != null) { BlockingQueue<TextMessage> queue =
		 * userSocketQueue.get(msg.getToId()); queue.offer(new
		 * TextMessage(JSON.toJSONString(msg))); userSocketQueue.put(msg.getToId(),
		 * queue); }
		 */
		// }
	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		Integer uid = (Integer) session.getAttributes().get("uid");
		// Integer fuid = (Integer) session.getAttributes().get("fuid");
		if (session.isOpen()) {
			session.close();
		}
		Iterator<Entry<Integer, WebSocketSession>> it = userSocketSessionMap.entrySet().iterator();
		// 移除Socket会话
		while (it.hasNext()) {
			Entry<Integer, WebSocketSession> entry = it.next();
			if (entry.getValue().getId().equals(session.getId())) {
				userSocketSessionMap.remove(entry.getKey());
				userSocketQueue.remove(entry.getKey());
				System.out.println("Socket会话已经移除:用户ID" + entry.getKey());
				break;
			}
		}

		/*
		 * BlockingQueue<TextMessage> queue = userSocketQueue.get(uid); for (TextMessage
		 * textMessage : queue) { Message msg =
		 * JSON.parseObject(textMessage.getPayload().toString(), Message.class); if
		 * (msg.getFromId() == fuid) { queue.remove(textMessage); } }
		 */
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
