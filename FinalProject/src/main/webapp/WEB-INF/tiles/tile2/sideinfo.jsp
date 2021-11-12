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
	
	.menu:hover, #hideSideInfo:hover {
		background-color: orange;
		color: #fff;
		text-decoration: none;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
	});

</script>

<a href="#">
	<img style="max-width:100%; margin: auto; padding: 30px 0;" src="<%= ctxPath%>/resources/images/logo.png" />
</a>
<a id="accountMenu" class="menu" href="<%= ctxPath%>/dashboard.univ">
	<i class="hideicon fas fa-user-circle fa-2x"></i>
	<div>계정</div>
</a>
<a class="menu" href="<%= ctxPath%>/dashboard.univ">
	<i class="hideicon fas fa-tachometer-alt fa-2x"></i>
	<div>대시보드</div>
</a>

<a id="subjectMenu" class="menu" href="#">
	<i class="hideicon fas fa-book fa-2x"></i>
	<div>과목</div>
</a>

<a class="menu" href="#">
	<i class="hideicon far fa-calendar fa-2x"></i>
	<div>캘린더</div>
</a>
<a class="menu" href="#">
	<i class="hideicon fas fa-envelope-open-text fa-2x"></i>
	<div>메신저</div>
</a>

<div id="hideSideInfo">
	<p style="text-align: center; "><i class="fas fa-backward fa-1x center"></i></p>
</div>


