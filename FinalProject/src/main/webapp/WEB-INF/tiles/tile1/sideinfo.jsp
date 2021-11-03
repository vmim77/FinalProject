<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">
	.menu  { 
		display: inline-block;
		width: 100%; 
		margin-bottom: 50px; 
		text-align: center; 
		font-size: 10pt;  
		color: #fff; 
		text-decoration: none;
		padding: 15px;
	}
	
	.menu:hover {
		background-color: #fff;
		color: orange;
	}
	
	#hideSideInfo {
		text-align: center;
		margin-botton: 10px;
		padding-top: 10px;
	}
	
	#hideSideInfo:hover {
		background-color: #fff;
	}
	
</style>

<div>
	<a href="#"><img style="max-width: 100%; height: 100%; padding: 50px 0;" src="<%= ctxPath%>/resources/images/logo.png" /></a>
	<a class="menu" href="#">
		<i class="fas fa-user-circle fa-2x"></i>
		<div>계정</div>
	</a>
	<a class="menu" href="#">
		<i class="fas fa-tachometer-alt fa-2x"></i>
		<div>대시보드</div>
	</a>
	<a class="menu" href="#">
		<i class="fas fa-book fa-2x"></i>
		<div>과목</div>
	</a>
	<a class="menu" href="#">
		<i class="far fa-calendar fa-2x"></i>
		<div>캘린더</div>
	</a>
	<a class="menu" href="#">
		<i class="fas fa-envelope-open-text fa-2x"></i>
		<div>메시지</div>
	</a>
	
	<div id="hideSideInfo">
		<i class="fas fa-backward fa-1x"></i>
	</div>
	
</div>


