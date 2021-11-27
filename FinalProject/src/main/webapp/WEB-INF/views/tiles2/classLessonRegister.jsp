<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath();%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

	$(document).ready(function(){

		$("button#lessonRegister").click(function(){
			
			var regExp = /^[1-9]$/;
			
			var lesson = $("input#lesson").val();
	        
	        var bool = regExp.test(lesson);
	        
	        if(!bool){	        	
	        	alert("차시에 1부터 9까지 입력하세요!!");
	        	$("input#lesson").val("");
	        	return;
	        }
	        
	        var video = $("input#video").val().trim();
	        
	        if(video==""){	        	
	        	alert("동영상URL을 입력하세요!!");
	        	return;
	        }
	       
	        	
        	//폼(form)을 전송(submit)
		    var frm = document.lessonFrm;
			frm.method = "POST";
			frm.action = "<%=ctxPath%>/classLessonRegisterEnd.univ";
			frm.submit();
        	
	        		
		})// end of $("button#lessonRegister").click(function(){----------------------------
		
		
		
	});// end of $(document).ready(function()----------------------------------

</script>

<div style="display:flex;">
<div style="margin:auto; margin-top:200px; padding-left:3px;">

<h2 style="margin-bottom: 30px;"> <span style="font-style:italic;">${requestScope.sbvo.subject}</span>&nbsp;&nbsp;<span style="font-size:16pt;">차시 등록하기</span></h2>

<form id="lessonFrm" name="lessonFrm">
		<table style="width:1024px;" class="table table-borderd">
			<tr>
				<th style="width:15%; background-color:#DDDDDD">성명</th>
				<td>
					<input type="text" name="name" value="${sessionScope.loginuser.name}" size="10" readonly/>	
					<input type="hidden" name="fk_code" value="${requestScope.sbvo.code}"/>
									
				</td>
			</tr>
			<tr>
				<th style="width:15%; background-color:#DDDDDD">주차</th>
				<td>
					<select name="fk_weekseq" id="fk_weekseq">
						<c:forEach var="map" items="${requestScope.getWeek}">
							<option value="${map.weekseq}">${map.week}&nbsp;주차</option>
						</c:forEach>					
					</select>		
				</td>
			</tr>
			<tr>
				<th style="width:15%; background-color:#DDDDDD">차시</th>
				<td>
					<input type="text" id="lesson" name="lesson" size="10"/>		
				</td>
			</tr>
			<tr>
				<th style="width:15%; background-color:#DDDDDD">동영상 URL 주소</th>
				<td>
					<input type="text" id="video" name="video" size="100"/>		
				</td>
			</tr>
			
		</table>
	
		<div style="margin:20px;">
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="lessonRegister" >등록하기</button>
			<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
		</div>
		
</form>
		
		
		
</div>
</div>
    
    