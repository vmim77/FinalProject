<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	
	table#subjectInfo, th, td { border: solid 1px black; }
	
	table#subjectInfo { border: solid 2px black; }
	
	th { width: 30%; padding-left: 5px; background-color: #ddd; }
	
	td { width: 50%; padding: 10px; }
	
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("ul#sideMenuList > li:first-child").addClass("hoverdEffect");
		
		$("ul#sideMenuList").hover(function(){
			$("ul#sideMenuList > li:first-child").removeClass("hoverdEffect");
		}, function(){
			$("ul#sideMenuList > li:first-child").addClass("hoverdEffect");
		});
		
		
	});
</script>

<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left; color: #0099ff;">${requestScope.subjectMap.subject} 강의실(${requestScope.subjectMap.name})</h3>
<hr style="clear: both;">

<div style="width: 80%; margin-top: 10px; padding: 10px;">
	<img style="position: relative;  width: 30%; float:left; margin-left: 5px;" src="<%= ctxPath%>/resources/images/${requestScope.subjectMap.code}.jpg" /> 
	
	<table id="subjectInfo" class="table" style="width: 60%; float: right;">
		<tr>
			<th colspan="2"><h2>강좌소개</h2></th>
		</tr>
		<tr>
			<th>수강코드</th>
			<td>${requestScope.subjectMap.code}</td>
		</tr>
		<tr>
			<th>과목명</th>
			<td>${requestScope.subjectMap.subject}</td>
		</tr>
		<tr>
			<th>교수명</th>
			<td>${requestScope.subjectMap.name}</td>
		</tr>
		<tr>
			<th>학점</th>
			<td>${requestScope.subjectMap.hakjum}점</td>
		</tr>
		<tr>
			<th>수업요일</th>
			<td>${requestScope.subjectMap.classdate}요일</td>
		</tr>
		<tr>
			<th>강의실</th>
			<td>${requestScope.subjectMap.deptName}&nbsp;${requestScope.subjectMap.deptLocation}</td>
		</tr>
	</table>
</div>



<div style="clear: both;"></div>
</div>
	
