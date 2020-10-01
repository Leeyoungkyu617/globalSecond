package project.spring.main.controller;

import java.util.ArrayList;
import java.util.List;
 
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
 

@Controller("/chat")
public class WebSocketChat extends TextWebSocketHandler{
	private static final Logger logger = LoggerFactory.getLogger(WebSocketChat.class);
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	//클라이언트 연결
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		sessionList.add(session);
		logger.info("{} 연결됨",session.getId());
		System.out.println("채팅방 입장자 : "+ session.getPrincipal().getName());
	}
	//chat
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		logger.info("{}로 부터 {} 받음",session.getId(),message.getPayload());
		
		//모든 클라이언트에게 전송
		for(WebSocketSession sess : sessionList) {
			sess.sendMessage(new TextMessage(session.getPrincipal().getName() +":"+message.getPayload()));
		}
	}
	
	//클라이언트 연결해제
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		logger.info("{} 연결됨",session.getId());
		System.out.println("채팅방 퇴장 : "+ session.getPrincipal().getName());
	}
	
	
}
