<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style type="text/css">
	
	.move {
		cursor: pointer;
		color: navy;
	}
	
	.moveColor {
		color: #660029;
		font-weight: bold;
		background-color: #ffffe6;
	}
	
	td.comment {
		text-align: center;
	}
	
	#commentDisplay > tr:nth-child(1) > td:nth-child(1) {
		width: 5%;
	}
	
	#commentDisplay > tr:nth-child(1) > td:nth-child(3) {
		width: 9%;
	}
	
	#commentDisplay > tr:nth-child(1) > td:nth-child(4) {
		width: 19%;
	}
	
	.btn-light {
		background-color: #ffffff;
		border-color: #ff9900;
		color:  #ff8c00;
	}
	
	.btn-light:hover, .btn-light:focus {
		border-color: #ffcc80;
		background-color: #ffcc80;
		color: #FFF;
	}
	
	.btn-secondary {
		background-color: #ffb84d;
		border-color: #ffb84d;
		color: #FFF;
	}
	
	.btn-secondary:hover, .btn-secondary:focus {
		border-color: #ffcc80;
		background-color: #ffcc80;
		color: #FFF;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("ul#sideMenuList > li:nth-child(2)").addClass("hoverdEffect");
		
		$("ul#sideMenuList").hover(function(){
			$("ul#sideMenuList > li:nth-child(2)").removeClass("hoverdEffect");
		}, function(){
			$("ul#sideMenuList > li:nth-child(2)").addClass("hoverdEffect");
		});
		
	//	goReadComment();  // 페이징처리 안한 댓글 읽어오기 
		goViewComment(1); // 페이징처리 한 댓글 읽어오기 
		
		$("span.move").hover(function(){
			                   $(this).addClass("moveColor");
		                     }
		                   , function(){
		                	   $(this).removeClass("moveColor");
		                   });
		
	});// end of $(document).ready(function(){})------------------------------
	
	
	// Function Declration
	function goAddWrite() {
		
		//var contentVal = $("input#commentContent").val().trim();
		var contentVal = $('textarea[name*="commentContent"]').val().trim();
		if(contentVal == "") {
			alert("댓글 내용을 입력하세요!!");
			return; // 종료
		}
		else {
			goAddWrite_noAttach(); // 첨부파일이 없는 댓글쓰기 
		}
		
	}// end of function goAddWrite()------------------------------------------
	
	
</script>    
<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left;"><span style="color: #0099ff; text-decoration: underline;">공지사항</span></h3>
<hr style="clear: both;">
<%-- 게시판 글내용보기 --%>
<div style="display: flex;">
	<div style="margin: auto; padding-left: 3%; padding-top: 4%;">
		<c:if test="${not empty requestScope.noticevo}">
			<div class="card-body" style="display: flex; height: 13%;   background-color:#ffd699;  border: solid 1px #ffd699; padding: 1.4%  0% 1.4% 0% ; margin-left: 0%; ">
		  		<button type="button" style="height: 36px; margin-left: 2.5%;"  class="btn btn-secondary" onclick="javascript:location.href='<%= request.getContextPath()%>/notice.univ'">전체목록보기</button>
		  		&nbsp;&nbsp;
		  		<button type="button" style="height: 36px;"  class="btn btn-secondary" onclick="javascript:location.href='<%= request.getContextPath()%>${requestScope.gobackURL}'">검색된 결과목록보기</button>
		  		<c:if test="${sessionScope.loginuser.authority == 1}">
		  		<button type="button"  onclick="javascript:location.href='<%= request.getContextPath()%>/noticeEdit.univ?fk_code=${sessionScope.code}&seq=${requestScope.noticevo.seq}'" class="btn btn-light" style="height: 36px; margin-left: 52%;font-weight:bold; font-size: 10pt; padding: 7px 12px; text-align: right; "><i class="far fa-edit"></i>&nbsp;수정</button> <%-- fk_code추가함 --%>
		  		&nbsp;&nbsp;
		  		<button type="button"  onclick="javascript:location.href='<%= request.getContextPath()%>/noticeDel.univ?fk_code=${sessionScope.code}&seq=${requestScope.noticevo.seq}'" class="btn btn-light" style="height: 36px; font-weight:bold; font-size: 10pt; padding: 7px 12px;"><i class="far fa-trash-alt"></i>&nbsp;삭제</button>&nbsp;
		  		</c:if>
			</div>
			
			<%-- 글내용보기  --%>
			<div class="pl-4">
				<br>
				<br>
				<div style="font-weight: bold; font-size: 20px; word-break: break-all;">${noticevo.subject}</div>
				<br>
				<span >작성자 :&ensp;${noticevo.name} &ensp;|&ensp;작성일 :&ensp;${noticevo.regDate}&ensp;</span>
				<span style="margin-left: 480px;"> 조회수: ${noticevo.readCount}</span>
				<br>
				<br>
				<div style="word-break: break-all;">${noticevo.content}</div>
			</div>
			
			<c:set var="v_gobackURL" value='${ fn:replace(requestScope.gobackURL, "&", " ") }' />
			<br>    
			<br>
			<hr>
			<button type="button"  onclick="javascript:location.href='noticeView.univ?seq=${requestScope.noticevo.previousseq}&searchType=${requestScope.searchType}&searchWord=${requestScope.searchWord}&gobackURL=${v_gobackURL}'" class="btn btn-light" style="font-weight:bold; font-size: 10pt; padding: 7px 12px; text-align: right; height: 36px;"> ‹ 이전글 </button>&nbsp;
			<button type="button"  onclick="javascript:location.href='noticeView.univ?seq=${requestScope.noticevo.nextseq}&searchType=${requestScope.searchType}&searchWord=${requestScope.searchWord}&gobackURL=${v_gobackURL}'" class="btn btn-light float-right" style="font-weight:bold; font-size: 10pt; padding: 7px 12px; text-align: right; height: 36px;"> › 다음글 </button>&nbsp;
			<br>
			<br>
			<%-- 글내용보기 끝 === --%>
		</c:if>
			
		
		<c:if test="${empty requestScope.noticevo}">
			<div style="padding: 100px 0; font-weight: bold; font-size: 16pt; color: red; text-align: center;">존재하지 않습니다</div>
			<button type="button" style="height: 36px; margin-left: 2.5%;"  class="btn btn-secondary" onclick="javascript:location.href='<%= request.getContextPath()%>/notice.univ'">목록보기</button>
		</c:if>
	</div>
</div>








