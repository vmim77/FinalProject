<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<style type="text/css">
	th { background-color: #ffb84d; width: 15%; }
	.btn { background-color: #ffb84d; }
</style>

    
<script type="text/javascript">

$(document).ready(function(){
	
	$("ul#sideMenuList > li:nth-child(2)").addClass("hoverdEffect");
	
	$("ul#sideMenuList").hover(function(){
		$("ul#sideMenuList > li:nth-child(2)").removeClass("hoverdEffect");
	}, function(){
		$("ul#sideMenuList > li:nth-child(2)").addClass("hoverdEffect");
	});
	
	$("button#godelete").click(function(){
		
		if($("input[name=pw]").val().trim() == "") {
			alert("글암호를 입력하셔야 합니다.");
			return;
		}
		
		
		var frm = document.lessonBoardDeleteFrm;
		frm.action = "<%= request.getContextPath()%>/lessonBoardDeleteEnd.univ";
		frm.method = "post";
		frm.submit();
		
	});
	
	
});


</script>    

<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left;">${requestScope.subjectMap.subject} 강의실(${requestScope.subjectMap.name}) > 강의자료실 > <span style="color: #0099ff; text-decoration: underline;">${requestScope.seq}번 게시글 삭제하기</span></h3>
<hr style="clear: both;">

<div style="display: flex;">
	<div style="width: 100%; margin: auto;">
		<form name="lessonBoardDeleteFrm">
			 <table id="lessonTbl" class="table table-bordered" style="width: 60%;">
				<tr><th colspan="3">해당 글을 삭제하시겠습니까?</th></tr>		 
				<tr>
					<td colspan="3">${requestScope.seq}번 게시글:  ${requestScope.lbvo.subject}</td>
				</tr>
				<tr>
					<td>글암호</td>
					<td><input type="password" name="pw" /></td>
					<td><input type="hidden" name="seq" value="${requestScope.seq}"/></td>
				</tr>
				<tr>
					<td colspan="3"><button type="button" id="godelete" class="btn btn-md">삭제하기</button>
					<button type="button" class="btn btn-md" onclick="javascript:location.href='<%=request.getContextPath()%>/lesson.univ'">취소하기</button></td>
				</tr>
			</table>
		</form>
	</div>
</div>