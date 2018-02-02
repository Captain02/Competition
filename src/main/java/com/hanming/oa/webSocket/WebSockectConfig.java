package com.hanming.oa.webSocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

/*
 * WebSockect主处理器
 * */
@Component
@EnableWebSocket //配置并开启WebSockect服务用来接收ws请求
public class WebSockectConfig extends WebMvcConfigurerAdapter implements WebSocketConfigurer {

	//处理对象
	@Autowired
	MyWebSocketHandler handler;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		
		//添加一个处理器还有定义的处理器的处理路径
		//参数1：：WebSocket处理器（用来处理信息）
		//参数2：WebSocket访问路径
		//添加过滤器，监听连接
		 registry.addHandler(handler, "/ws").addInterceptors(new HandShake());		
		/*
		 * 这里我们用到.withSockJS(),SockJS是spring用来处理浏览器对websocket的兼容性
		 * 目前浏览器支持websocket不是很好，特别是IE11以下
		 * SockJS能根据能否支持websocket来提供三种方式用于websocket请求，
		 * 三种方式分别是WebSocket，HTTP Streaming以及Http Long Polling 
		 */
		 registry.addHandler(handler, "/ws/sockjs").addInterceptors(new HandShake()).withSockJS();
		
		
	}

}
