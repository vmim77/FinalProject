<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">
	.menu  { 
		display: inline-block;
		width: 100%; 
		text-align: center; 
		font-size: 10pt;  
		color: #fff; 
		text-decoration: none;
		padding: 10px 5px;
	}
	
	
	#hideSideInfo {
		color: #fff; 
		text-align: center;
		padding: 20px 5px;
	}
	
	.menu:hover, #hideSideInfo:hover, .dropdown-item:hover {
		background-color: orange;
		color: #fff;
		text-decoration: none;
	}
	
	
	.dropright .dropdown-toggle::after {
    	display: none;
    }
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
	
	});

</script>

<a href="#">
	<img style="max-width:100%; margin: auto; padding: 30px 0;" src="<%= ctxPath%>/resources/images/logo.png" />
</a>
<a class="menu" href="#">
	<i class="hideicon fas fa-user-circle fa-2x"></i>
	<div>계정</div>
</a>
<a class="menu" href="<%= ctxPath%>/dashboard.univ">
	<i class="hideicon fas fa-tachometer-alt fa-2x"></i>
	<div>대시보드</div>
</a>

<!-- Default dropright button -->
<div class="menu btn-group dropright">
  <a class="menu btn dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
	<i class="hideicon fas fa-book fa-2x"></i>
	<div>과목</div>
  </a>
  <div class="dropdown-menu ml-2">
    <button class="dropdown-item" type="button">홈</button>
    <button class="dropdown-item" type="button">수업계획서</button>
    <button class="dropdown-item" type="button">강의자료실</button>
    <button class="dropdown-item" type="button">열린게시판</button>
    <button class="dropdown-item" type="button">문의게시판</button>
    <button class="dropdown-item" type="button" onclick="javascript:location.href='<%= ctxPath%>/homework.univ'">과제 및 평가</button>
    <button class="dropdown-item" type="button">토론</button>
    <button class="dropdown-item" type="button">강의콘텐츠</button>
    <button class="dropdown-item" type="button">ClassMix</button>
    <button class="dropdown-item" type="button">사용자 및 그룹</button>
    <button class="dropdown-item" type="button">성적</button>
    <button class="dropdown-item" type="button">출결/학습 현황</button>
  </div>
</div>


<a class="menu" href="#">
	<i class="hideicon far fa-calendar fa-2x"></i>
	<div>캘린더</div>
</a>
<a class="menu" href="#">
	<i class="hideicon fas fa-envelope-open-text fa-2x"></i>
	<div>메시지</div>
</a>
<a class="menu" href="#">
	<i class="hideicon fas fa-users-cog fa-2x"></i>
	<div>관리</div>
</a>
<a class="menu" href="#">
	<i class="hideicon far fa-question-circle fa-2x"></i>
	<div>도움말</div>
</a>

<div id="hideSideInfo">
	<p style="text-align: center; "><i class="fas fa-backward fa-1x center"></i></p>
</div>


