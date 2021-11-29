package com.spring.chatting.websockethandler;

import com.google.gson.Gson;

public class MessageVO {
	
	private String message;// 메시지 내용
	private String type;   // 전체채팅 or 비밀채팅
	private String to;     // 비밀채팅 대상
	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	
	public static MessageVO convertMessage(String source) {
		
		MessageVO messagevo = new MessageVO();
		Gson gson = new Gson();
		
		messagevo = gson.fromJson(source, MessageVO.class);
		return messagevo;
		
	}
	
}
