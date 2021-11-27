<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">

	table#lessonboard {
		width: 100%;
		margin: auto;
	}
	
	table#lessonboard th {
		background-color: #ffb84d;
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
		
		var searchWord = "${requestScope.searchWord}";
		var searchType = "${requestScope.searchType}";
		
		if(searchWord != "") {
			$("#searchWord").val(searchWord);
			$("#searchType").val(searchType);
		}
		
		
		
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
		
		$("#btnSearch").click(function(){
			
			var frm = document.searchFrm;
			frm.action = "<%= request.getContextPath()%>/lesson.univ";
			frm.method = "GET";
			frm.submit();
		});
		
		
		
	});
	
	//Function Declaration
	function goLessonWrite() {
		
		if(${sessionScope.loginuser.authority==0}){
			swal("warning", "교수만 접근이 가능합니다!", "warning");
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
	<table id="lessonboard" class="table table-bordered table-hover">
		<tr>
			<th class="title">글번호</th>
			<th class="title">글쓴이</th>
			<th class="title">글제목</th>
			<th class="title">작성일자</th>
		</tr>
		<c:forEach var="leesonboardvo" items="${requestScope.boardList}" varStatus="status">
			<tr class="leesonboardRows">
				<td style="width: 5%;" class="title">${leesonboardvo.seq}</td>
				<td style="width: 5%;" class="title">${leesonboardvo.name}</td>
				<td style="width: 40%;">${leesonboardvo.subject}<c:if test="${not empty leesonboardvo.fileName}"><img src='<%= request.getContextPath()%>/resources/images/disk.gif' style="margin-left: 10px;" /></c:if><c:if test="${leesonboardvo.commentCount ne 0}"><span style="font-size: 8pt; color:gray; margin-left:10px;">[${leesonboardvo.commentCount}]</span></c:if></td>
				<td style="width: 20%;" class="title">${leesonboardvo.regDate}</td>
			</tr>
		</c:forEach>
	</table>
	<br />
	<div align="center" style="display: flex; width: 100%;">
		${requestScope.pageBar}
	</div>
</c:if>
<hr>
<c:if test="${sessionScope.loginuser.authority == 1}">
	<div class="text-right">
		<button type="button" class="btn btn-md" onclick="goLessonWrite()" style="background-color: #ffb84d; color:#fff; border: none;">글쓰기</button>
	</div>
</c:if>

<br />
<div style="width: 100%; text-align: center;">

	<form name="searchFrm" style="width: 100%;">
		<select id="searchType" name="searchType">
			<option value="subject">제목</option>
			<option value="content">내용</option>
		</select>
		
		<input id="searchWord" type="text" name="searchWord" size="50" />
		<input type="text" style="display: none;" />
		
		
		<button type="button" class="btn btn-sm" id="btnSearch" style="background-color: #ffb84d; color:#fff;">검색</button>
	</form>
</div>

