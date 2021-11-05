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
  <link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/style1.css" />
  
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
  </style>
  
  <script type="text/javascript">

	$(document).ready(function(){
		
		$("div#showSideInfo").hide();
		
		$("div#hideSideInfo").click(function(){
			$("div#mysideinfo").animate({'left':'-200px'}, 'slow');
			$("div#mycontent").animate({"width":"100%"},'slow');
			$("div#showSideInfo").fadeIn('slow');
		});
		
		$("div#showSideInfo").click(function(){
			$("div#mysideinfo").animate({'left':'0px'},'slow');
			$("div#mycontent").animate({"width":"95%"},'slow');
			$(this).hide();
		});
		
	});
  </script>
  
</head>


<body>
	<div id="mycontainer">
	
		<div id="mysideinfo">
			<tiles:insertAttribute name="sideinfo" />
		</div>
	      
		<div id="mycontent">
			<div class="m-2">
				<tiles:insertAttribute name="content" />
			</div>
		</div>
		
		<div id="showSideInfo" style="position: fixed; top: 50%; left: 10px; z-index: 2">
			<i class="fas fa-forward fa-2x"></i>
		</div>
	</div>
</body>
</html>