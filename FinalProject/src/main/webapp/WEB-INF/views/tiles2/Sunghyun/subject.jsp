<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	
	table#subjectInfo, th, td {margin-top: 10px; border: solid 1px gray;}
	
	table#subjectInfo { width: 80%; }
	
	th { width: 30%; padding-left: 5px; }
	
	td { width: 70%; padding: 10px; }
	
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("ul#sideMenuList > li:first-child").addClass("hoverdEffect");
		
		for(var i=0; i<12; i++){
			
			var html = "<div class='card'>";
			
			html+="<div class='card-header' id='heading'"+i+">";
			html+="<h2 class='mb-0'>";
			html+="<button class='btn btn-link btn-block text-left' type='button' data-toggle='collapse' data-target='#collapse"+i+"' aria-expanded='false' aria-controls='collapse"+i+"'>";
			html+="<i class='fas fa-book'></i>&nbsp;${requestScope.subjectMap.subject}_${requestScope.subjectMap.ban}반 "+(i+1)+"주차 수업계획";
			html+="</button>";
			html+="</h2>";
			html+="</div>";
			
			html+="<div id='collapse"+i+"' class='collapse' aria-labelledby='heading"+i+"' data-parent='#accordionExample'>";
			html+="<div class='card-body'>";
			html+="${requestScope.subjectMap.subject}_${requestScope.subjectMap.ban}반 "+(i+1)+"주차 수업계획";
			html+="</div></div></div>";
			
			$("div#accordionExample").append(html);
		}
		
	});
</script>

<h3>${requestScope.subjectMap.subject}_${requestScope.subjectMap.ban}반(${requestScope.subjectMap.teacher}) 강의실</h3>
<hr>

<h2>강좌소개</h2>
<table id="subjectInfo">
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
		<td>${requestScope.subjectMap.teacher}</td>
	</tr>
	<tr>
		<th>분반</th>
		<td>${requestScope.subjectMap.ban}반</td>
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

<h2 style="margin-top: 20px;">주차별 수업계획</h2>
<div class="accordion" id="accordionExample" style="width: 80%; margin-top: 20px;">
</div>
	
