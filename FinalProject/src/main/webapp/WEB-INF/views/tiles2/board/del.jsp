<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath();%>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 쓰기 버튼
		$("button#btnDelete").click(function(){
			
			//폼(form)을 전송(submit)
			var frm = document.DelFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/delEnd.univ";
			frm.submit();
		});
		
	}); // end of $(document).ready(function(){})----------------------------

</script>

<div style="display:flex;">
<div style="margin:auto; padding-left:3px;">

	<h2 style="margin-bottom: 30px;">글삭제</h2>
	
	<form name="DelFrm">
		<table style="width:1024px;" class="table table-borderd">
			<tr>
				<th style="width:15%; background-color:#DDDDDD">글 암호</th>
				<td>				
					<input type="hidden" name="seq" value="${requestScope.freeboardvo.seq}"/>	
					<input type="password" name="pw"  id="pw"/>
				</td>
			</tr>			
		</table>
		
		<div style="margin:20px;">
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnDelete" >글삭제</button>
			<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
		</div>
	</form>

</div>
</div>