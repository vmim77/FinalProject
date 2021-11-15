<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<style type="text/css">
	th { background-color: #f5a100; width: 15%; }
	.btn { background-color: #f5a100; }
</style>

    
<script type="text/javascript">

$(document).ready(function(){
	
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