<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === #24. tiles 를 사용하는 레이아웃1 페이지 만들기 === --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<%
   String ctxPath = request.getContextPath();
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
	  
	  div#showMySubject, div#showMyAccount {
	  		box-shadow: 0px 1px 3px;
	  		position: absolute; 
	  		z-index: 1; 
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
			$(this).hide();
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
		});
		
		
	});
  </script>
  
</head>


<body>
	<div id="mycontainer">
	
			<div id="mysideinfo">
				<tiles:insertAttribute name="sideinfo" />
			</div>
			
			<%-- 계정 퀵메뉴 --%>
			<div id="showMyAccount" class="p-3">
				<span id="closeMyAccount" style="float:right; font-size: 30pt; text-align:center; cursor:pointer;">&times;</span>
				<div style="display:flex; margin-top: 10px; width:100%;">
					<img src="<%= ctxPath%>/resources/images/personimg.png" style="width: 50%; margin: auto;"/>
				</div>
				<div style="clear:both; text-align:center;">
					<div style="font-size: 1em;">금길영<br>(18###19)</div>
					<button class="btn btn-secondary btn-sm justify-content-center">로그아웃</button>
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
				<h3 class="mt-3" style="float: left;">수강과목</h3><span id="closeMysubject" style="float:right; font-size: 30pt; text-align:center; cursor:pointer;">&times;</span>
				<hr style="clear:both;">
				<%-- loginuser의 정보를 이용하여 추후에는 반복문을 이용하여 출력한다. --%>
				<ul id="MySubjectList" class="list-group list-group-flush" style="width: 90%; list-style: none; padding: 0;">
				  <li class="list-group-item icons"><a href="<%= ctxPath%>/subject.univ?code=0202">빅데이터실무_0202_B분반</a></li>
				  <li class="list-group-item icons"><a href="<%= ctxPath%>/subject.univ?code=0201">재무관리실무_0201_A분반</a></li>
				  <li class="list-group-item icons"><a href="<%= ctxPath%>/subject.univ?code=0204">하이테크마케팅_0204_D분반</a></li>
				  <li class="list-group-item icons"><a href="<%= ctxPath%>/subject.univ?code=0101">다이어트비법_0101_A분반</a></li>
				  <li class="list-group-item icons"><a href="<%= ctxPath%>/subject.univ?code=0102">소녀 미용학개론_0102_B분반</a></li>
				  <li class="list-group-item icons"><a href="<%= ctxPath%>/subject.univ?code=0103">보컬의기초_0103_C분반</a></li>
				  <li class="list-group-item icons"><a href="<%= ctxPath%>/subject.univ?code=0104">실전무술_0104_D분반</a></li>
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
		
	</div>
</body>
</html>