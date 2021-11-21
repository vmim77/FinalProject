package com.spring.chatting.websockethandler;

import java.util.*;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.spring.univ.model.MemberVO;

public class WebsocketEchoHandler extends TextWebSocketHandler {

	private List<WebSocketSession> connectedUsers = new ArrayList<>();
	
	public void init() throws Exception { }
	
	@Override
    public void afterConnectionEstablished(WebSocketSession wsession) 
    	throws Exception {
		
		connectedUsers.add(wsession);
		
		String connectingUserName = "「  ";
		
		int size = connectedUsers.size();
		int cnt = 0;
		
		
		for(WebSocketSession webSocketSession : connectedUsers) {
			
			cnt++;
			Map<String, Object> map = webSocketSession.getAttributes();
			
			MemberVO loginuser = (MemberVO) map.get("loginuser");
			
			String grade = "";
			if(loginuser.getAuthority() == 0) {
				grade = " 학생";
			}
			
			else if(loginuser.getAuthority() == 1) {
				grade = " 교수";
			}
			
			if(size == cnt) {
				connectingUserName += loginuser.getName()+grade+"("+loginuser.getHakbun()+")"; 
			}
			else {
				connectingUserName += loginuser.getName()+grade+"("+loginuser.getHakbun()+")"+", "; 
			}
			
		}// end of for--------------------
		
		connectingUserName += " 」";
		
		
		for(WebSocketSession webSocketSession : connectedUsers) {
			webSocketSession.sendMessage(new TextMessage(connectingUserName)); 
		}// end of for--------------------
		
	}
	
	@Override
    protected void handleTextMessage(WebSocketSession wsession, TextMessage message) 
    	throws Exception {
		
		Map<String, Object> map = wsession.getAttributes();
		
		MemberVO loginuser = (MemberVO) map.get("loginuser");
		
		MessageVO messageVO = MessageVO.convertMessage(message.getPayload());
		
		String hostAddress = "";
		
		Date now = new Date(); // 현재시각
		String currentTime = String.format("%tp %tl:%tM",now,now,now); 
		
		for(WebSocketSession webSocketSession : connectedUsers) {
			if("all".equals(messageVO.getType())) {
				
				if( !wsession.getId().equals(webSocketSession.getId()) ) {
					
					webSocketSession.sendMessage(new TextMessage("<script>$('.toast', parent.document).toast('show'); $('#messageHead', parent.document).html('"+loginuser.getName()+" 님이 메시지를 보냈습니다!');</script><span>"+wsession.getRemoteAddress().getAddress().getHostAddress()+"</span>&nbsp;[<span style='font-weight:bold; cursor:pointer;' class='loginuserName'>"+ loginuser.getName() +"</span>]<br><div style='border-radius: 25px 25px 25px 25px; background-color: #eeeeee; display: inline-block; max-width: 60%; padding: 7px; border-radius: 15%; word-break: break-all;'> " + messageVO.getMessage() + "</div> <div style='display: inline-block; padding: 20px 0 0 5px; font-size: 7pt;'>"+currentTime+"</div> <div>&nbsp;</div>" ));    
				}
			}
			
			else {
				hostAddress = webSocketSession.getRemoteAddress().getAddress().getHostAddress(); 
			     
			 	if (messageVO.getTo().equals(hostAddress)) { 
			 		
			        webSocketSession.sendMessage(
		                new TextMessage("<span>"+ wsession.getRemoteAddress().getAddress().getHostAddress() +"</span>&nbsp;[<span style='font-weight:bold; cursor:pointer;' class='loginuserName'>" +loginuser.getName()+ "</span>]<br><div style='border-radius: 25px 25px 25px 25px;background-color: #eeeeee; display: inline-block; max-width: 60%; padding: 7px; border-radius: 15%; word-break: break-all; color: red;'>" + messageVO.getMessage() +"</div> <div style='display: inline-block; padding: 20px 0 0 5px; font-size: 7pt;'>"+currentTime+"</div> <div>&nbsp;</div>" ));  
		        		break; 
			     }
				
			}
			
		}// end of for------------------------------------------
		
		
	}
	
	
	@Override
    public void afterConnectionClosed(WebSocketSession wsession, CloseStatus status) 
    	throws Exception {
		
		Map<String, Object> map = wsession.getAttributes();
		MemberVO loginuser = (MemberVO) map.get("loginuser");
		
		connectedUsers.remove(wsession);
		
		for(WebSocketSession webSocketSession : connectedUsers) {
			
			if( !wsession.getId().equals(webSocketSession.getId()) ) {
				
				webSocketSession.sendMessage(new TextMessage(wsession.getRemoteAddress().getAddress().getHostAddress() +" [<span style='font-weight:bold;'>" +loginuser.getName()+ "</span>]" + "님이 <span style='color: red;'>퇴장</span>했습니다."));    
			}
			
		}// end of for------------------------------------------
		
		
        String connectingUserName = "「";
        
        for (WebSocketSession webSocketSession : connectedUsers) {
        	 Map<String, Object> map2 = webSocketSession.getAttributes();
	    	 MemberVO loginuser2 = (MemberVO)map2.get("loginuser");  
	
        	 connectingUserName += loginuser2.getName()+" "; 
        }// end of for------------------------------------------
        
        connectingUserName += "」";
        
        for (WebSocketSession webSocketSession : connectedUsers) {
        	 webSocketSession.sendMessage(new TextMessage(connectingUserName));
        }// end of for------------------------------------------
		
	}
	
	
	
}
