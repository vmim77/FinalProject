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

</style>

<script>
	$(document).ready(function(){
		
		$("ul#sideMenuList > li:nth-child(2)").addClass("hoverdEffect");
		
		$(".leesonboardRows").click(function(){
			var seq = $(this).find("td:first-child").text();
			location.href="<%= request.getContextPath()%>/lessonnDetail.univ?code=${requestScope.code}&seq="+seq;
		});
		
		
	});

</script>

<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left; color: #0099ff;">${requestScope.subjectMap.subject} 강의실(${requestScope.subjectMap.name}) > 강의자료실</h3>
<hr style="clear: both;">
    
<c:if test="${empty requestScope.boardList}">
	<img src="<%= request.getContextPath()%>/resources/images/nolesson.png" style="width: 100%; padding: 10px;" />
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
				<td>${leesonboardvo.subject}</td>
				<td class="title">${leesonboardvo.regDate}</td>
			</tr>
		</c:forEach>
	</table>
</c:if>