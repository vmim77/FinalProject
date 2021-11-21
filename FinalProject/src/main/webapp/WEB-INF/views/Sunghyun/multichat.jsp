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

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  

<style>
	body {overflow:auto;}
	
	body::-webkit-scrollbar {
    		display: none;
    }
    
    chatMessage {overflow:auto;}
    
    chatMessage::-webkit-scrollbar {
    		display: none;
    }
</style>


<script type="text/javascript">

	
	$(document).ready(function(){
		
		var url = window.location.host; // 웹브라우저의 주소창의 포트까지 가져옴
	
	    var pathname = window.location.pathname; // '/'부터 오른쪽에 있는 모든 경로 

	    var appCtx = pathname.substring(0, pathname.lastIndexOf("/")); // "전체 문자열".lastIndexOf("검사할 문자");
	
	    var root = url+appCtx;
	
	    var wsUrl = "ws://"+root+"/multichatstart.univ"; 
	
	    var websocket = new WebSocket(wsUrl);
	    
		/*   -------------------------------------
		               이벤트 종류             설명
		     -------------------------------------
	            onopen        WebSocket 연결
		        onmessage     메시지 수신
		        onerror       전송 에러 발생
		        onclose       WebSocket 연결 해제
	    */	
	
	    var messageObj = {};
	    
	    websocket.onopen = function() {
	    	
	    	messageObj = { message : "채팅방에 <span style='color: red;'>입장</span>했습니다"
	    	              ,type : "all"
	    	              ,to : "all" 
	    	             };
	    	             
	    	websocket.send(JSON.stringify(messageObj));
	    };
	    
	    
	    websocket.onmessage = function(event){
	       if(event.data.substr(0,1)=="「" && event.data.substr(event.data.length-1)=="」") {
	    	   
	    	   var userList = event.data.substr(1, event.data.length-2).trim();
	    	   
	    	   var userArr =  userList.split(",");
	    	   
	    	   $("div#connectingUserList").html(userList+"<br> [ " + userArr.length + "명 접속중 ]");
	    	   
	       }
	       else {
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
	    var isOnlyOneDialog = false; //귓속말
	    
	    $("input#btnSendMessage").click(function(){
	    	
	    	if( $("input#message").val() != "" ) {
	    		
                var messageVal = $("input#message").val();
                messageVal = messageVal.replace(/<script/gi, "&lt;script"); 
                
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
               
               if(isOnlyOneDialog == false) { // 전체채팅
               	   $("div#chatMessage").append("<div style='border-radius: 25px 25px 25px 25px; background-color: #ffb84d; display: inline-block; max-width: 60%; float: right; padding: 7px; border-radius: 15%; word-break: break-all;'>" + messageVal + "</div> <div style='display: inline-block; float: right; padding: 20px 5px 0 0; font-size: 7pt;'>"+currentTime+"</div> <div style='clear: both;'>&nbsp;</div>");
                                                                                                                                                                           /* word-break: break-all; 은 공백없이 영어로만 되어질 경우 해당구역을 빠져나가므로 이것을 막기위해서 사용한다. */ 
               } 
               else { // 비밀채팅
            	   $("div#chatMessage").append("<div style='border-radius: 25px 25px 25px 25px; background-color: #ffb84d; display: inline-block; max-width: 60%; float: right; padding: 7px; border-radius: 15%; word-break: break-all; color:red;'>" + messageVal + "</div> <div style='display: inline-block; float: right; padding: 20px 5px 0 0; font-size: 7pt;'>"+currentTime+"</div> <div style='clear: both;'>&nbsp;</div>"); 
            	                                                                                                                                                           /* word-break: break-all; 은 공백없이 영어로만 되어질 경우 해당구역을 빠져나가므로 이것을 막기위해서 사용한다. */
               }
               
  	           $("body").scrollTop(99999999);
                                                                                                                                                                       
  	           $("input#message").val("");                                                                                                                                                        
  	           $("input#message").focus();                                                                                                                                                        
	    	}
	    	
	    });	
	    ////////////////////////////////////////////////////////////////////
	    
        $("button#btnAllDialog").hide();
	    
        $(document).on("click",".loginuserName",function(){
        	var ip = $(this).prev().text();
        	
            $("input#to").val(ip); 
            
            $("span#privateWho").text($(this).text());
            $("button#btnAllDialog").show();
            
            isOnlyOneDialog = true;
        });
	    
        
        $("button#btnAllDialog").click(function(){
           	$("input#to").val("");
           	$("span#privateWho").text("");
           	$(this).hide();
           	
           	isOnlyOneDialog = false;
        });
		
	});// end of $(document).ready(function(){})----------------------
	
</script>  

<div id="MessengerBody" class="container-fluid" style="height: 100%;">
<div class="row" style="height: 100%;">
<div class="col-md-10 offset-md-1" style="height: 100%;">
	<div id="chatStatus"></div>
	<input type="hidden" id="to"/>
	<br/>
	<span style="font-weight: bold;">비밀채팅 대상자</span> : <span id="privateWho" style="font-weight: bold; color: red;"></span>
	<br>
	<button type="button" id="btnAllDialog" class="btn btn-secondary btn-sm my-2">비밀채팅종료</button>
	<hr>
	<br>
	<span style="font-weight: bold;">접속자명단</span>:<br/>
	<div id="connectingUserList" style=" max-height: 100px; overFlow: auto;"></div>
	<hr>
	
	<div id="chatMessage" style="max-height: 500px; overFlow: auto; margin: 20px 0;"></div>

	<input type="text"   id="message" class="form-control" placeholder="Type your message" autocomplete="off"/>
	<div style="display: flex;">
	<div style="margin: auto;">
		<input type="button" id="btnSendMessage" class="btn btn-primary btn-md my-3" value="Send to Message" />
		<input type="button" class="btn btn-secondary btn-md my-3 mx-3" onClick="$('#MessangerClose', parent.document).click();" value="Exit Messenger" />
	</div>
	</div>
</div>
</div>
</div>