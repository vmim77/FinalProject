<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.net.InetAddress"%>

<%-- === #24. tiles 를 사용하는 레이아웃1 페이지 만들기 === --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%
   String ctxPath = request.getContextPath();
%>    

<%
   InetAddress inet = InetAddress.getLocalHost(); 
   String serverIP = inet.getHostAddress();
   int portnumber = request.getServerPort();
   
   String serverName = "http://"+serverIP+":"+portnumber;
%>
    
<!DOCTYPE html>
<html>
<head>
<title>파이널프로젝트 2조 LMS</title>
  <!-- Required meta tags -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> 
  
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

  <!-- Font Awesome 5 Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  
  <!-- 직접 만든 CSS 1 -->
  <link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/style2.css" />
  
  <!-- Optional JavaScript -->
  <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
  <script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 
  <script type="text/javascript" src="<%= ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> 
  
  <%--  ===== 스피너를 사용하기 위해  jquery-ui 사용하기 ===== --%>
  <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.11.4.custom/jquery-ui.css" />
  <script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.11.4.custom/jquery-ui.js"></script>

  <%-- *** ajax로 파일을 업로드할때 가장 널리 사용하는 방법 ==> ajaxForm *** --%>
  <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery.form.min.js"></script>
  	
  <style>
	  @media ( max-width:1024px ) { .hideicon {display:none} } 
	  
	  @media ( max-width:1024px ) { html{font-size:1rem} } 
	  
	  html { word-break: break-all; }
	  
	  div#showMySubject, div#showMyAccount {
	  		box-shadow: 0px 1px 3px;
	  		position: absolute; 
	  		z-index: 7; 
	  		left: 5%; 
	  		width: 15%; 
	  		height: 1024px; 
	  		background-color: #fff;
	  		overflow: hidden;
	  }
	  
	  ul#MySubjectList > li {
	  	font-size: 1em;
	  	height: 20%;
	  	color: #00ccff;
	  }
	  
	  a { text-decoration: none; }
	  
   	  #Messenger::-webkit-scrollbar {
    		display: none;
      }
      
      div#MessengerToggle {
			background-color: #ffb84d;
			position: fixed;
			right: 0.5%;
			bottom: 2%;
			z-index: 9;
			font-size: 15pt;
			padding: 10px;
			border-radius: 20px 20px 20px 20px;
			box-shadow: 0px 2px 3px;
	  }
	  
	  div#MessengerToggle:hover {
	  		background-color: #ff9900;
	  		color: #fff;
			position: fixed;
			right: 0.5%;
			bottom: 2%;
			z-index: 9;
			font-size: 15pt;
			padding: 10px;
			border-radius: 20px 20px 20px 20px;
			box-shadow: 0px 2px 3px;
			cursor: pointer;
	  }
	  
  </style>
  
  <script type="text/javascript">

	$(document).ready(function(){
		
		/////////////////////////////////////////////////////////	
		// 사이드메뉴 보이기 버튼
		/////////////////////////////////////////////////////////
		$("div#showSideInfo").hide();
		
		$("div#hideSideInfo").click(function(){
			$("div#mysideinfo").animate({'left':'-200px'}, 'slow');
			$("div#mycontent").animate({"width":"100%"},'slow');
			$("div#showSideInfo").fadeIn('slow');
			$("div#showMySubject").hide();
			$("div#showMyAccount").hide();
		});
		
		$("div#showSideInfo").click(function(){
			$("div#mysideinfo").animate({'left':'0px'},'slow');
			$("div#mycontent").animate({"width":"95%"},'slow');
			$("div#showSideInfo").hide();
		});
		///////////////////////////////////////////////////////
		
		/////////////////////////////////////////////////////////
		// 수강과목 퀵메뉴
		///////////////////////////////////////////////////////
		$("div#showMySubject").hide();
		
		$("a#subjectMenu").mouseover(function(){
			$("div#showMyAccount").hide();
			$("div#showMySubject").fadeIn('fast');
		});
		
		$("span#closeMysubject").click(function(){
			$("div#showMySubject").fadeOut('fast');
		});
		
		
		///////////////////////////////////////////////////////
		// 계정 퀵메뉴
		/////////////////////////////////////////////////////////
		$("div#showMyAccount").hide();
		
		$("a#accountMenu").mouseover(function(){
			$("div#showMySubject").hide();
			$("div#showMyAccount").fadeIn('fast');
		});
		
		$("span#closeMyAccount").click(function(){
			$("div#showMyAccount").fadeOut('fast');
		});
		///////////////////////////////////////////////////////
		
		
		///////////////////////////////////////////////////////
		// 과목 사이드메뉴
		//////////////////////////////////////////////////////
		$("i.hideSubjectMenu").click(function(){
			$("div#subjectSideMenu").toggle('slow');
			$("#innerContent").animate({"width":"100%"},'slow');
		});
		
		
		
		////////////////////////////////////////////////////////
		// 메신저 
		///////////////////////////////////////////////////////
		$("div#Messenger").hide();
		
		$("#MessengerToggle").click(function(){
			
			$("div#Messenger").append("<div style='padding-top: 20px; height: 60px; background-color: #ffb84d; text-align:center; font-size:15pt; color: #fff; font-weight: bold;'>길영대학교 메신저<span id='MessangerClose' style='height: 100%; font-size:20pt; float:right; margin-right: 10px; cursor: pointer;'>&times;</span></div>");
			$("div#Messenger").append("<div width: 0; height: 0; style='clear:both;'></div>");
			$("div#Messenger").append("<iframe src='<%= serverName%><%= ctxPath%>/messenger.univ' style='width: 100%; height: 100%; border:solid 1px gray; margin: 0;'></iframe>");
			$("div#Messenger").show('slow');
			$(this).hide();
			
		});
		
		
		$(document).on("click","#MessangerClose",function(){
			$("div#Messenger").hide('slow');
			$("div#Messenger").empty();
			$("#MessengerToggle").show();
		});
		
		
		$("#MessengerToggle").hover(function(){$(this).text("Join us!") },function(){ $(this).text("Messenger") });
		
		////////////////////////////////////////////////////////
		
	});
  </script>
  
</head>


<body>
	<div id="mycontainer">
	
			<div id="mysideinfo">
				<tiles:insertAttribute name="sideinfo" />
			</div>
			
		<!-- 로그인 처리 -->
		 <div id="showMyAccount" class="p-3">
         <span id="closeMyAccount" style="float:right; font-size: 30pt; text-align:center; cursor:pointer;">&times;</span>
         <div style="display:flex; margin-top: 10px; width:100%;">
            <img src="<%= ctxPath%>/resources/images/personimg.png" style="width: 50%; margin: auto;"/>
         </div>
         <div style="clear:both; text-align:center;">
            <div style="font-size: 1em;">
            	이름: ${sessionScope.loginuser.name}<c:if test="${sessionScope.loginuser.authority == 0}">(학생)</c:if><c:if test="${sessionScope.loginuser.authority == 1}">(교수)</c:if>  
            	<br>  학번: ${sessionScope.loginuser.hakbun}</div>
                <c:if test="${empty sessionScope.loginuser}">
                    <a class="btn btn-secondary btn-sm justify-content-center" href="<%=ctxPath%>/MemberLogin.univ">로그인</a>
                 </c:if>
  	                           
               <c:if test="${not empty sessionScope.loginuser}">
                  <a class="btn btn-secondary btn-sm justify-content-center" href="#">나의정보</a>
                  <a class="btn btn-secondary btn-sm justify-content-center" href="<%=ctxPath%>/logout.univ">로그아웃</a>
               </c:if>
         </div>
			<hr>
			<ul id="MySubjectList" class="list-group list-group-flush" style="width: 90%; list-style: none; padding: 0;">
				  <li class="list-group-item icons"><span>설정</span></li>
				  <li class="list-group-item icons"><span>알람</span></li>
				  <li class="list-group-item icons"><span>파일</span></li>
			</ul>
		</div>
		<%-- 계정 퀵메뉴 --%>
		
		<%-- 수강과목 메뉴 --%>
		<div id="showMySubject" class="p-3">
			<h3 class="mt-3" style="float: left;">과목퀵메뉴</h3><span id="closeMysubject" style="float:right; font-size: 30pt; text-align:center; cursor:pointer;">&times;</span>
			<hr style="clear:both;">
			<%-- loginuser의 정보를 이용하여 추후에는 반복문을 이용하여 출력한다. --%>
			<ul id="MySubjectList" class="list-group list-group-flush" style="width: 90%; list-style: none; padding: 0;">
			
			
				  <c:if test="${sessionScope.loginuser.authority == 0 and not empty sessionScope.sugangList}">
				  	<c:forEach var="sugangMap" items="${sugangList}">
				  		<li class="list-group-item icons"><a href="<%= ctxPath%>/subject.univ?code=${sugangMap.code}">${sugangMap.subject}(${sugangMap.teacher})</a></li>
				  	</c:forEach>
				  </c:if>
  				  <c:if test="${sessionScope.loginuser.authority == 0 and empty sessionScope.sugangList}">
				  		<li style="font-size: 10pt; color:blue;" class="list-group-item icons">수강중인 과목이 없습니다.</li>
				  </c:if>
				  
				  
				  <c:if test="${sessionScope.loginuser.authority ==1 and not empty sessionScope.suupList}">
				  	<c:forEach var="suupMap" items="${suupList}">
				  		<li class="list-group-item icons"><a href="<%= ctxPath%>/subject.univ?code=${suupMap.code}">${suupMap.subject}</a></li>
				  	</c:forEach>
				  </c:if>
  				  <c:if test="${sessionScope.loginuser.authority == 1 and empty sessionScope.suupList}">
				  		<li style="font-size: 10pt; color:blue;" class="list-group-item icons">담당중이신 과목이 없으십니다!</li>
				  </c:if>
			</ul>
		</div>
		<%-- 수강과목 메뉴 --%>
		      
			<div id="mycontent">
				<div id="maincontainer" class="m-2">
					<div id="subjectSideMenu">
						<tiles:insertAttribute name="subjectSideMenu" />
					</div>
					<div id="innerContent">
						<tiles:insertAttribute name="content" />
					</div>
				</div>
			
			<div id="showSideInfo" style="position: fixed; top: 50%; left: 10px; z-index: 2">
				<i class="fas fa-forward fa-2x"></i>
			</div>
		</div>
		
		<%-- 메신저용 --%>
		<div id="Messenger" style="position:fixed; width:32%; height: 80%; right: 0%; bottom: 0%; background-color: #fff; z-index: 7; overflow:auto; box-shadow: 0px 1px 3px;">
		
		</div>
		
		
		<div class="toast" role="alert" aria-live="assertive" aria-atomic="true" style="position: fixed; right: 0%; bottom: 0%; z-index: 8;" data-delay="10000">
		  <div class="toast-header">
		    <strong id="messageHead" class="mr-auto" style="font-size: 12pt;"></strong>
		    <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
		      <span aria-hidden="true">&times;</span>
		    </button>
		  </div>
		</div>
		
		<%-- 메신저 toggle --%>
		<div id="MessengerToggle">Messenger</div>
		
		<div id="showSideInfo" style="position: fixed; top: 50%; left: 10px; z-index: 2">
			<i class="fas fa-forward fa-2x"></i>
		</div>
		
	</div>
</body>
</html>