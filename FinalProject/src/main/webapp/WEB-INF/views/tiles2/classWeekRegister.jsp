<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath();%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("ul#sideMenuList > li:nth-child(7)").addClass("hoverdEffect");
		
		$("ul#sideMenuList").hover(function(){
			$("ul#sideMenuList > li:nth-child(7)").removeClass("hoverdEffect");
		}, function(){
			$("ul#sideMenuList > li:nth-child(7)").addClass("hoverdEffect");
		});

		$("button#weekRegister").click(function(){
			
			var regExp = /^\d{1,2}$/;;
			
			var week = $("input#week").val();
	        
	        var bool = regExp.test(week);
	        
	        if(!bool || week==0){
	        	
	        	alert("주차에 1부터 숫자만 입력하세요!!");
	        	$("input#week").val("");
	        }
	        else{
	        	
	        	//폼(form)을 전송(submit)
			    var frm = document.weekFrm;
				frm.method = "POST";
				frm.action = "<%=ctxPath%>/classWeekRegisterEnd.univ";
				frm.submit();
	        	
	        }
				
		})// end of $("button#weekRegister").click(function(){-------------------------
		
		
		
	});// end of $(document).ready(function()----------------------------------

</script>
<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left;"><span style="color: #0099ff; text-decoration: underline;">강의콘텐츠</span></h3>
<hr style="clear: both;">
<div style="display:flex;">
<div style="margin:auto; margin-top:200px; padding-left:3px;">

<h2 style="margin-bottom: 30px;"> <span style="font-style:italic;">${requestScope.sbvo.subject}</span>&nbsp;&nbsp;<span style="font-size:16pt;">주차 등록하기</span></h2>

<form id="weekFrm" name="weekFrm">
		<table style="width:1024px;" class="table table-borderd">
			<tr>
				<th style="width:15%; background-color:#DDDDDD">성명</th>
				<td>
					<input type="text" name="name" value="${sessionScope.loginuser.name}" readonly/>	
					<input type="hidden" name="fk_code" value="${requestScope.sbvo.code}"/>
									
				</td>
			</tr>
			<tr>
				<th style="width:15%; background-color:#DDDDDD">주차</th>
				<td>
					<input type="text" id="week" name="week"/>&nbsp; <span style="font-size:9pt; font-style:italic;">현재 &nbsp;${requestScope.getWeekCount}주차 까지 등록되어있습니다.</span>		
				</td>
			</tr>
			
		</table>
	
		<div style="margin:20px;">
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="weekRegister" >등록하기</button>
			<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
		</div>
		
</form>
		
		
		
</div>
</div>
    
    