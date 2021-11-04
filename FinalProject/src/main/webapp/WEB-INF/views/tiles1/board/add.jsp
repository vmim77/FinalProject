<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath();%>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 쓰기 버튼
		$("button#btnWrite").click(function(){
			
			//글제목 유효성 검사
			var subjectVal = $("input#subject").val().trim();
			if(subjectVal == ""){
				alert("글제목을 입력하세요!!");
				return;
			}
			
			//글내용 유효성 검사(스마트에디터 사용 안할시)
			var contentVal = $("textarea#content").val().trim();
			if(contentVal == ""){
				alert("글내용을 입력하세요!!");
				return;
			}
			
			//글암호 유효성 검사
			var pwVal = $("input#pw").val().trim();
			if(pwVal == ""){
				alert("글암호을 입력하세요!!");
				return;
			}
			
			//폼(form)을 전송(submit)
			var frm = document.addFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/addEnd.action";
			frm.submit();
		});
		
	}); // end of $(document).ready(function(){})----------------------------

</script>

<div style="display:flex;">
<div style="margin:auto; padding-left:3px;">

	<h2 style="margin-bottom: 30px;">글쓰기</h2>
	
	<form name="addFrm">
		<table style="width:1024px;" class="table table-borderd">
			<tr>
				<th style="width:15%; background-color:#DDDDDD">성명</th>
				<td>
					<input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" readonly/>
					<input type="text" name="name" value="${sessionScope.loginuser.name}" readonly/>
				</td>
			</tr>
			<tr>
				<th style="width:15%; background-color:#DDDDDD">제목</th>
				<td>					
					<input type="text" name="subject"  id="subject" size="100"/>
				</td>
			</tr>
			<tr>
				<th style="width:15%; background-color:#DDDDDD; vertical-align:middle;">내용</th>
				<td>					
					<textarea rows="11" cols="102" name="content" id="content"></textarea>
				</td>
			</tr>
			<tr>
				<th style="width:15%; background-color:#DDDDDD">글 암호</th>
				<td>					
					<input type="password" name="pw"  id="pw" />
				</td>
			</tr>			
		</table>
		
		<div style="margin:20px;">
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite" >글쓰기</button>
			<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
		</div>
	</form>

</div>
</div>