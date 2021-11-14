<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<style type="text/css">

	#lessonTbl th { background-color: #f5a100; width: 15%; }
	
	.alert{ cursor:pointer; }
	
</style>


<script>

	$(document).ready(function(){
		
		getCommentList();
		
		$("ul#sideMenuList > li:nth-child(2)").addClass("hoverdEffect");
		
		$("ul#sideMenuList").hover(function(){
			$("ul#sideMenuList > li:nth-child(2)").removeClass("hoverdEffect");
		}, function(){
			$("ul#sideMenuList > li:nth-child(2)").addClass("hoverdEffect");
		});
		
		$("#previousSubject").click(function(){
			location.href="<%= request.getContextPath()%>/lessonDetail.univ?code=${sessionScope.code}&seq=${requestScope.lbvo.previousSeq}";
		});
		
		$("#nextSubject").click(function(){
			location.href="<%= request.getContextPath()%>/lessonDetail.univ?code=${sessionScope.code}&seq=${requestScope.lbvo.nextSeq}";
		});
		
		$("#goBackList").click(function(){
			location.href="<%= request.getContextPath()%>/lesson.univ";
		});
		
	});
	
	function goWrite() {
		
		if($("input[name=content]").val().trim() == ""){
			alert("댓글내용을 반드시 입력해야 합니다!");
			return;
		}
		
		
		var form_data = $("form[name=lessonBoardCommentFrm]").serialize();
		
		$.ajax({
			url:"<%= request.getContextPath()%>/addComment_LessonBoard.univ",
			data:form_data,
			type:"POST",
			dataType:"JSON",
			success:function(json){
				if(json.n==0){
					alert("댓글쓰기 실패!!");
				}
				else{
					alert("댓글쓰기 성공!!");
					getCommentList();
				}
				
				$("input[name=content]").val("");
			},
	        error: function(request, status, error){
	              alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
		
	}
	
	function getCommentList(){
		
		
		$.ajax({
			url:"<%= request.getContextPath()%>/getComment_LessonBoard.univ",
			data:{"parentSeq":${requestScope.lbvo.seq}},
			dataType:"JSON",
			success:function(json){
				
				var html = "";
				if(json.length > 0){
					
					$.each(json, function(index, item){
						
						html += "<tr>";
						html += "<td style='width: 10%; text-align: center; font-weight: bold;'><img src='<%= request.getContextPath()%>/resources/images/personimg.png' />"+item.name+"("+item.fk_hakbun+")</td>"
						html += "<td style='width: 40%;'>"+item.content+"</td>"
						html += "<td style='width: 10%; text-align: center;'>"+item.regDate+"</td>"
						html += "</tr>";
					});
					
				}
				else{
					html +="<tr><td>댓글이 없습니다.</td></tr>"
				}
				
				$("#commentList").html(html);
			},
	        error: function(request, status, error){
	              alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
		
	}
	
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
				<td><a href="<%= request.getContextPath()%>/downloadLessonFile.univ?code=${sessionScope.code}&seq=${requestScope.lbvo.seq}">${requestScope.lbvo.orgFilename}</a></td>
			</tr>
			<tr>
				<th>파일용량</th>
				<td><fmt:formatNumber value="${requestScope.lbvo.fileSize}" pattern="#,###" /></td>
			</tr>
		</table>
		
		
		<div style="display: flex;">
			<div style="margin-left: auto;">
				<div class="alert" role="alert" style="display:inline-block; text-align:center; background-color: #f5a100">이전글:&nbsp;<span id="previousSubject" style="color: #fff;">${requestScope.lbvo.previousSubject}</span></div>
				<div class="alert" role="alert" style="display:inline-block; text-align:center; background-color: #f5a100; margin: 0 20px;"><span id="goBackList">목록보기</span></div>
				<div class="alert" role="alert" style="display:inline-block; text-align:center; background-color: #f5a100">다음글:&nbsp;<span id="nextSubject" style="color: #fff;">${requestScope.lbvo.nextSubject}</span></div>
			</div>
		</div>
		
		<c:if test="${sessionScope.loginuser != null}">
			<form name="lessonBoardCommentFrm" style="margin-top: 30px;">
				<table class="table">
					<tr>
						<th style="width: 10%;">작성자</th>
						<td><input type="text" name="name" value="${sessionScope.loginuser.name}" readonly /></td>
						<td><input type="hidden" name="fk_hakbun" value="${sessionScope.loginuser.hakbun}" /></td>
					</tr>
					<tr>
						<th>댓글내용</th>
						<td><input type="text" name="content" size="100"  /></td>
						<td><input type="hidden" name="parentSeq" value="${requestScope.lbvo.seq}" /></td>
					</tr>
					<tr>
						<th colspan="3">
							<button type="button" class="btn" style="background-color:#f5a100; margin-right: 20px;" onclick="goWrite()">댓글쓰기</button>
							<button type="reset"  class="btn" style="background-color:#f5a100;">댓글쓰기 취소</button>
						</th>
					</tr>
				</table>
			</form>
		</c:if>
		
		<table id="commentList" class="table" style="margin-top: 30px;">
		
		</table>
	</div>
</div>