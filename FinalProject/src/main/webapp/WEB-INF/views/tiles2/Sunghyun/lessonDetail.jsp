<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<style type="text/css">
	#lessonTbl th { background-color: #f5a100; width: 15%; }
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
			location.href="<%= request.getContextPath()%>/lessonnDetail.univ?code=${sessionScope.code}&seq="+seq;
		});
		
	});
	
</script>

<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left;">${requestScope.subjectMap.subject} 강의실(${requestScope.subjectMap.name}) > 강의자료실 >  <span style="color: #0099ff; text-decoration: underline;">${requestScope.lbvo.seq}번 게시글</span></h3>
<hr style="clear: both;">


<div style="display: flex;">
	<div style="width: 100%; margin: auto;">
		 <table id="lessonTbl" class="table table-bordered">
			<tr><th colspan="2"></th></tr>		 
			<tr>
				<td colspan="2"><h2>${requestScope.lbvo.subject}</h2></td>
			</tr>
			<tr>
				<td colspan="2">작성자: 교수 ${requestScope.lbvo.name}<img src="<%= request.getContextPath()%>/resources/images/personimg.png" /></td>
			</tr>
			<tr>
				<td colspan="2">작성일: ${requestScope.lbvo.regDate}</td>
			</tr>
			<tr>
				<td colspan="2">${requestScope.lbvo.content}</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>${requestScope.lbvo.orgFilename}</td>
			</tr>
			<tr>
				<th>파일용량(bytes)</th>
				<td><fmt:formatNumber value="${requestScope.lbvo.fileSize}" pattern="#,###" /></td>
			</tr>
		</table>
		<span class="alert" role="alert" style="float:left; text-align:center; background-color: #f5a100">이전글:&nbsp;${requestScope.lbvo.previousSubject}</span>
		<span class="alert" role="alert" style="float:right; text-align:center; background-color: #f5a100">다음글:&nbsp;${requestScope.lbvo.nextSubject}</span>
	</div>
</div>