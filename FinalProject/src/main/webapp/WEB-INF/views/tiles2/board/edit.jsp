<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %> 

<script type="text/javascript">

	$(document).ready(function(){
		
		// 완료버튼
		$("button#btnUpdate").click(function(){
			
			// 글제목 유효성 검사
			var subjectVal = $("input#subject").val().trim();
			if(subjectVal == "") {
				alert("글제목을 입력하세요!!");
				return;
			}
			
			// 글내용 유효성 검사(스마트에디터 사용 안 할시)
			var contentVal = $("textarea#content").val().trim();
			if(contentVal == "") {
				alert("글내용을 입력하세요!!");
				return;
			}
			
			// 글암호 유효성 검사
			var pwVal = $("input#pw").val().trim();
			if(pwVal == "") {
				alert("글암호를 입력하세요!!");
				return;
			}
			
			// 폼(form)을 전송(submit)
			var frm = document.editFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/editEnd.action";
			frm.submit();
		});
		
	});// end of $(document).ready(function(){})--------------------------

</script>   

<div style="display: flex;">
<div style="margin: auto; padding-left: 3%;">

	<h2 style="margin-bottom: 30px;">글수정</h2>
	
	<form name="editFrm">
		<table style="width: 1024px" class="table table-bordered">
			<tr>
				<th style="width: 15%; background-color: #DDDDDD">성명</th>
				<td>
					<input type="hidden" name="seq" value="${requestScope.freeboardvo.seq}" />
					${requestScope.freeboardvo.name}
				</td>
			</tr>
			<tr>
				<th style="width: 15%; background-color: #DDDDDD">제목</th>
				<td>
					<input type="text" name="subject" id="subject" size="100" value="${requestScope.freeboardvo.subject}" /> 
				</td>
			</tr>
			<tr>
				<th style="width: 15%; background-color: #DDDDDD; vertical-align: middle;">내용</th>
				<td>
					<textarea style="width: 100%; height: 612px;" name="content" id="content">${requestScope.freeboardvo.content}</textarea> 
				</td>
			</tr>
			<tr>
				<th style="width: 15%; background-color: #DDDDDD">글암호</th>
				<td>
					<input type="password" name="pw" id="pw" /> 
				</td>
			</tr>
		</table>
		
		<div style="margin: 20px;">
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnUpdate">완료</button>
			<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button> 
		</div>
	</form>

</div>	
</div>

     