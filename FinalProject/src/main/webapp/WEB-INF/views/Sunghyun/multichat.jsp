<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
   String ctxPath = request.getContextPath();
%>    

<!-- Required meta tags -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> 

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
  
    <!-- Optional JavaScript -->
  <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
  <script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 
  <script type="text/javascript" src="<%= ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> 
  

<style>
	body {overflow:auto;}
	body::-webkit-scrollbar {
    		display: none;
    }
</style>

<%-- === #174. (웹채팅관련 5) === --%>

<script type="text/javascript">

	//=== !!! WebSocket 통신 프로그래밍은 HTML5 표준으로써 자바스크립트로 작성하는 것이다. !!! === //
	// WebSocket(웹소켓)은 웹 서버로 소켓을 연결한 후 데이터를 주고 받을 수 있도록 만든 HTML5 표준이다.
	// 그런데 이러한 WebSocket(웹소켓)은 HTTP 프로토콜로 소켓 연결을 하기 때문에 웹 브라우저가 이 기능을 지원하지 않으면 사용할 수 없다. 
	/*
	    >> 소켓(Socket)이란? 
		- 어떤 통신프로그램이 네트워크상에서 데이터를 송수신할 수 있도록 연결해주는 연결점으로써 
		  IP Address와 port 번호의 조합으로 이루어진다. 
		    또한 어떤 하나의 통신프로그램은 하나의 소켓(Socket)만을 가지는 것이 아니라 
		    동일한 프로토콜, 동일한 IP Address, 동일한 port 번호를 가지는 수십개 혹은 수만 개의 소켓(Socket)을 가질 수 있다.
	
		 =================================================================================================  
		    클라이언트  소켓(Socket)                           서버  소켓(Socket)
	       211.238.142.70:7942 ◎------------------------------------------◎  211.238.142.72:9090
	       
	            클라이언트는 서버인 211.238.142.72:9090 소켓으로 클라이언트 자신의 정보인 211.238.142.70:7942 을 
	            보내어 연결을 시도하여 연결이 이루어지면 서버는 클라이언트의 소켓인 211.238.142.70:7942 으로 데이터를 보내면서 통신이 이루어진다.
	     ================================================================================================== 
	            
	            소켓(Socket)은 데이터를 통신할 수 있도록 해주는 연결점이기 때문에 통신할 두 프로그램(Client, Server) 모두에 소켓이 생성되야 한다.
	
		Server는 특정 포트와 연결된 소켓(Server 소켓)을 가지고 서버 컴퓨터 상에서 동작하게 되는데, 
		이 Server는 소켓을 통해 Cilent측 소켓의 연결 요청이 있을 때까지 기다리고 있다(Listening 한다 라고도 표현함).
		Client 소켓에서 연결요청을 하면(올바른 port로 들어왔을 때) Server 소켓이 허락을 하여 통신을 할 수 있도록 연결(connection)되는 것이다.
	*/
	
	$(document).ready(function(){
		
		$("#MessengerBody").css({"background-color":"#cce0ff"});
		
		var url = window.location.host; // 웹브라우저의 주소창의 포트까지 가져옴
	//	console.log("url : " + url);
	//	url : 211.238.142.72:9090
	
	    var pathname = window.location.pathname; // '/'부터 오른쪽에 있는 모든 경로 
	//  console.log("pathname : " + pathname);
	//  pathname : /board/chatting/multichat.action
	
	    var appCtx = pathname.substring(0, pathname.lastIndexOf("/")); // "전체 문자열".lastIndexOf("검사할 문자");
	//  console.log("appCtx : " + appCtx);
	//  appCtx : /board/chatting
	
	    var root = url+appCtx;
	//  console.log("root : " + root);
	//  root : 211.238.142.72:9090/board/chatting
	
	    var wsUrl = "ws://"+root+"/multichatstart.univ"; 
	//  웹소켓통신을 하기위해서는 http:// 을 사용하는 것이 아니라 ws:// 을 사용해야 한다.
	//	console.log("wsUrl : " + wsUrl);
	//	wsUrl : ws://211.238.142.72:9090/board/chatting/multichatstart.action
	
	    var websocket = new WebSocket(wsUrl);
	//  var websocket = new WebSocket("ws://211.238.142.72:9090/board/chatting/multichatstart.action");
	    
	// /WEB-INF/web.xml 에 가서 appServlet 의 contextConfigLocation 을 수정한다.
	
	    
	// >> ====== !!중요!! Javascript WebSocket 이벤트 정리 ====== << //
		/*   -------------------------------------
		               이벤트 종류             설명
		     -------------------------------------
	            onopen        WebSocket 연결
		        onmessage     메시지 수신
		        onerror       전송 에러 발생
		        onclose       WebSocket 연결 해제
	    */	
	
	    var messageObj = {}; // 자바스크립트 객체 생성함.
	    
	    // === 웹소켓에 최초로 연결이 되었을 경우에 실행되어지는 콜백함수 정의하기 ===
	    websocket.onopen = function() {
	    	
	    	$("div#chatStatus").text("정보: 웹소켓에 연결이 성공됨!!");
	    	
	    	messageObj = { message : "채팅방에 <span style='color: red;'>입장</span>했습니다"
	    	              ,type : "all"
	    	              ,to : "all" 
	    	             }; // 자바스크립트에서 객체의 데이터값 초기화 
	    	             
	    	websocket.send(JSON.stringify(messageObj));
	    	            // JSON.stringify(자바객체) 는 자바객체를 JSON 표기법의 문자열(String)로 변환한다
			            /*
			                JSON.stringify({});                  // '{}'
							JSON.stringify(true);                // 'true'
							JSON.stringify('foo');               // '"foo"'
							JSON.stringify([1, 'false', false]); // '[1,"false",false]'
							JSON.stringify({ x: 5 });            // '{"x":5}'
			            */
	    };
	    
	    
	    // === 메시지 수신지 콜백함수 정의하기 === //
	    websocket.onmessage = function(event){
	    	                    // 자음 ㄴ 임
	       // event.data 는 「서영학 엄정화 이순신 」 이다.	                    
	       if(event.data.substr(0,1)=="「" && event.data.substr(event.data.length-1)=="」") {
	    	   $("div#connectingUserList").html(event.data);
	       }
	       else {
	       // event.data 는 수신받은 채팅 문자이다.
	           $("div#chatMessage").append(event.data);
	           $("div#chatMessage").append("<br>");
	           $("body").scrollTop(99999999);
	       }
	    };
	    
	    
	    // === 메시지 입력후 엔터하기 === 
	    $("input#message").keyup(function(event) {
	    	if(event.keyCode == 13) {
	    		$("input#btnSendMessage").click();
	    	}
	    });
	    
	    
	    // === 메시지 보내기 === 
	    var isOnlyOneDialog = false; // 귀속말 여부. true 이면 귀속말, false 이면 모두에게 공개되는 말
	    
	    $("input#btnSendMessage").click(function(){
	    	
	    	if( $("input#message").val() != "" ) {
	    		
	    		// ==== 자바스크립트에서 replace를 replaceAll 처럼 사용하기 ====
                // 자바스크립트에서 replaceAll 은 없다.
                // 정규식을 이용하여 대상 문자열에서 모든 부분을 수정해 줄 수 있다.
                // 수정할 부분의 앞뒤에 슬래시를 하고 뒤에 gi 를 붙이면 replaceAll 과 같은 결과를 볼 수 있다.
                var messageVal = $("input#message").val();
                messageVal = messageVal.replace(/<script/gi, "&lt;script"); 
                // 스크립트 공격을 막으려고 한 것임.
                
             <%--   
                messageObj = { message : messageVal
			  	              ,type : "all"
			  	              ,to : "all" 
			  	             };
			 --%> 	              
	    	   // 또는 	
  	           messageObj = {}; // 자바스크립트 객체 생성함.
  	           messageObj.message = messageVal;
  	           messageObj.type = "all";
  	           messageObj.to = "all";
  	           
	  	       var to = $("input#to").val();
	           if ( to != "" ) {
	               messageObj.type = "one";
	               messageObj.to = to;
	           }
  	           
  	           websocket.send(JSON.stringify(messageObj));
	           // JSON.stringify(자바객체) 는 자바객체를 JSON 표기법의 문자열(String)로 변환한다
	           
	           // 위에서 자신이 보낸 메시지를 웹소켓을 보낸 다음에 자신이 보낸 메시지 내용을 웹페이지에 보여지도록 한다.
  	           var now = new Date();
               var ampm = "오전 ";
               var hours = now.getHours();
             
	           if(hours > 12) {
	              hours = hours - 12;
	              ampm = "오후 ";
	           }
             
               if(hours == 0) {
             	  hours = 12;
               }
               
               if(hours == 12) {
            	   ampm = "오후 ";
               }
             
               var minutes = now.getMinutes();
     		   if(minutes < 10) {
     			   minutes = "0"+minutes;
     		   }
     		
               var currentTime = ampm + hours + ":" + minutes;
               
               if(isOnlyOneDialog == false) { // 귀속말이 아닌 경우 
               	   $("div#chatMessage").append("<div style='background-color: #ffff80; display: inline-block; max-width: 60%; float: right; padding: 7px; border-radius: 15%; word-break: break-all;'>" + messageVal + "</div> <div style='display: inline-block; float: right; padding: 20px 5px 0 0; font-size: 7pt;'>"+currentTime+"</div> <div style='clear: both;'>&nbsp;</div>");
                                                                                                                                                                           /* word-break: break-all; 은 공백없이 영어로만 되어질 경우 해당구역을 빠져나가므로 이것을 막기위해서 사용한다. */ 
               } 
               else { // 귀속말인 경우. 글자색을 빨간색으로 함.
            	   $("div#chatMessage").append("<div style='background-color: #ffff80; display: inline-block; max-width: 60%; float: right; padding: 7px; border-radius: 15%; word-break: break-all; color:red;'>" + messageVal + "</div> <div style='display: inline-block; float: right; padding: 20px 5px 0 0; font-size: 7pt;'>"+currentTime+"</div> <div style='clear: both;'>&nbsp;</div>"); 
            	                                                                                                                                                           /* word-break: break-all; 은 공백없이 영어로만 되어질 경우 해당구역을 빠져나가므로 이것을 막기위해서 사용한다. */
               }
               
  	           $("body").scrollTop(99999999);
                                                                                                                                                                       
  	           $("input#message").val("");                                                                                                                                                        
  	           $("input#message").focus();                                                                                                                                                        
	    	}
	    	
	    });	
	    ////////////////////////////////////////////////////////////////////
	    
	    // 귀속말대화끊기 버튼은 처음에는 보이지 않도록 한다.
        $("button#btnAllDialog").hide();
	    
        // 아래는 귓속말을 위해서 대화를 나누는 상대방의 이름을 클릭하면 상대방IP주소를 귓속말대상IP주소에 입력하도록 하는 것.
        $(document).on("click",".loginuserName",function(){
        	/* class loginuserName 은 
        	   com.spring.chatting.websockethandler.WebsocketEchoHandler 의 
        	   protected void handleTextMessage(WebSocketSession wsession, TextMessage message) 메소드내에
        	   178번 라인에 기재해두었음.
        	*/
        	var ip = $(this).prev().text();
        //	alert(ip);
            $("input#to").val(ip); 
            
            $("span#privateWho").text($(this).text());
            $("button#btnAllDialog").show();
            
            isOnlyOneDialog = true; // 귀속말 대화임을 지정.
        });
	    
        
        // 귀속말대화끊기 버튼을 클릭한 경우는 전체대상으로 채팅하겠다는 말이다. 
        $("button#btnAllDialog").click(function(){
           	$("input#to").val("");
           	$("span#privateWho").text("");
           	$(this).hide();
           	
           	isOnlyOneDialog = false; // 귀속말 대화가 아닌 모두에게 공개되는 대화임을 지정.
        });
		
	});// end of $(document).ready(function(){})----------------------
	
</script>  

<div id="MessengerBody" class="container-fluid">
<div class="row">
<div class="col-md-10 offset-md-1">
	<div id="chatStatus"></div>
	<div class="my-3">
	- 상대방의 대화내용이 검정색으로 보이면 채팅에 참여한 모두에게 보여지는 것입니다.<br>
	- 상대방의 대화내용이 <span style="color: red;">붉은색</span>으로 보이면 나에게만 보여지는 1:1 귓속말 입니다.<br>
	- 1:1 채팅(귓속말)을 하시려면 예를 들어, 채팅시 보이는 172.30.1.45[이순신] ▶ ㅎㅎㅎ 에서 이순신을 클릭하시면 됩니다.
	</div>
	<input type="text" id="to" placeholder="귓속말대상IP주소"/>
	<br/>
	♡ 귓속말대상 : <span id="privateWho" style="font-weight: bold; color: red;"></span>
	<br>
	<button type="button" id="btnAllDialog" class="btn btn-secondary btn-sm">귀속말대화끊기</button>
	<br><br>
	현재접속자명단:<br/>
	<div id="connectingUserList" style=" max-height: 100px; overFlow: auto;"></div>
	
	<div id="chatMessage" style="max-height: 500px; overFlow: auto; margin: 20px 0;"></div>

	<input type="text"   id="message" class="form-control" placeholder="메시지 내용" autocomplete="off"/>
	<input type="button" id="btnSendMessage" class="btn btn-success btn-sm my-3" value="메시지보내기" />
	<input type="button" class="btn btn-danger btn-sm my-3 mx-3" onClick="$('#MessangerClose', parent.document).click();" value="채팅방나가기" />
	

	
</div>
</div>
</div>