<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">

	table#lessonboard {
		width: 100%;
		margin: auto;
	}
	
	.title {
		text-align: center;
	}
	
	.leesonboardRows {
		cursor: pointer;
	}
	
	

</style>

<script>
	$(document).ready(function(){
		
		$("ul#sideMenuList > li:nth-child(2)").addClass("hoverdEffect");
		
		$("ul#sideMenuList").hover(function(){
			$("ul#sideMenuList > li:nth-child(2)").removeClass("hoverdEffect");
		}, function(){
			$("ul#sideMenuList > li:nth-child(2)").addClass("hoverdEffect");
		});
		
		$(".leesonboardRows").click(function(){
			var seq = $(this).find("td:first-child").text();
			location.href="<%= request.getContextPath()%>/lessonDetail.univ?code=${sessionScope.code}&seq="+seq;
		});
		
	});
	
	//Function Declaration
	function goLessonWrite() {
		
		if(${sessionScope.loginuser.authority==0}){
			alert("교수만 접근이 가능합니다!!");
			return;
		}
		
		location.href="<%= request.getContextPath()%>/lessonWrite.univ";
	}// end of goLessonWrite()---------------------------------------
	

</script>

<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left;">${requestScope.subjectMap.subject} 강의실(${requestScope.subjectMap.name}) > <span style="color: #0099ff; text-decoration: underline;">강의자료실</span></h3>
<hr style="clear: both;">
    
<c:if test="${empty requestScope.boardList}">
	<div style="display: flex;">
		<img src="<%= request.getContextPath()%>/resources/images/nolesson.png" style="width: 80%; padding: 10px; margin: auto;" />
	</div>
</c:if>

<c:if test="${not empty requestScope.boardList}">
	<table id="lessonboard" class="table table-striped table-bordered table-hover">
		<tr>
			<th class="title">글번호</th>
			<th class="title">글쓴이</th>
			<th class="title">글제목</th>
			<th class="title">작성일자</th>
		</tr>
		<c:forEach var="leesonboardvo" items="${requestScope.boardList}" varStatus="status">
			<tr class="leesonboardRows">
				<td style="display: none;">${leesonboardvo.seq}</td>
				<td class="title">${status.index+1}</td>
				<td class="title">${leesonboardvo.name}</td>
				<td>${leesonboardvo.subject}<c:if test="${not empty leesonboardvo.fileName}"><img src='<%= request.getContextPath()%>/resources/images/disk.gif' style="margin-left: 10px;" /></c:if></td>
				<td class="title">${leesonboardvo.regDate}</td>
			</tr>
		</c:forEach>
	</table>
</c:if>
<hr>
<c:if test="${sessionScope.loginuser.authority == 1}">
	<div class="text-right">
		<button type="button" class="btn btn-dark btn-md" onclick="goLessonWrite()">글쓰기</button>
	</div>
	
</c:if>