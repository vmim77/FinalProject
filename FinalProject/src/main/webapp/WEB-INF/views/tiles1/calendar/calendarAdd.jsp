<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath();%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<style type="text/css">
	
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
	       
		// 쓰기 버튼
		$("button#btnWrite").click(function(){
	        
			//글제목 유효성 검사
			var titleVal = $("input#title").val().trim();
			if(titleVal == ""){
				alert("제목을 입력하세요!!");
				return;
			}
			
			//글내용 유효성 검사
			var detailVal = $("textarea#detail").val().trim();
			if(detailVal == ""){
				alert("내용을 입력하세요!!");
				return;
			}
			
			//글제목 유효성 검사
			var yearVal = $("input#year").val().trim();
			if(yearVal == ""){
				alert("시작년도를 입력하세요!!");
				return;
			}
			
			//글제목 유효성 검사
			var monthVal = $("input#month").val().trim();
			if(monthVal == ""){
				alert("시작월을 입력하세요!!");
				return;
			}
			
			//글제목 유효성 검사
			var dayVal = $("input#day").val().trim();
			if(dayVal == ""){
				alert("시작일을 입력하세요!!");
				return;
			}
			
			//글제목 유효성 검사
			var timeVal = $("input#time").val().trim();
			if(timeVal == ""){
				alert("시작시간을 입력하세요!!");
				return;
			}
			
			//글제목 유효성 검사
			var minuteVal = $("input#minute").val().trim();
			if(minuteVal == ""){
				alert("시작분을 입력하세요!!");
				return;
			}
			
			//글제목 유효성 검사
			var year1Val = $("input#year1").val().trim();
			if(year1Val == ""){
				alert("끝나는 년도를 입력하세요!!");
				return;
			}
			
			//글제목 유효성 검사
			var month1Val = $("input#month1").val().trim();
			if(month1Val == ""){
				alert("끝나는 월을 입력하세요!!");
				return;
			}
			
			//글제목 유효성 검사
			var day1Val = $("input#day1").val().trim();
			if(day1Val == ""){
				alert("끝나는 일을 입력하세요!!");
				return;
			}
			
			//글제목 유효성 검사
			var time1Val = $("input#time1").val().trim();
			if(time1Val == ""){
				alert("끝나는 시간을 입력하세요!!");
				return;
			}
			
			//글제목 유효성 검사
			var minute1Val = $("input#minute1").val().trim();
			if(minute1Val == ""){
				alert("끝나는 분을 입력하세요!!");
				return;
			}
			
			
			//폼(form)을 전송(submit)
			var frm = document.addFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/calendarAddEnd.univ";
			frm.submit();
		});
		
	}); // end of $(document).ready(function(){})----------------------------

</script>

<div class="container p-5 pl-3" >
	<div>
		<div style="margin:auto; margin-left: padding-top:70px;">
			<h2 style=" font-size:23px; font-weight: bold;"><i class="far fa-edit" style="margin-right: 8px; font-size: 29px;"></i>일정 추가</h2>
			<hr style="width: 843px; margin-left: 0px;">
			<form name="addFrm">
				<input type="hidden" name="fk_hakbun" value="${sessionScope.loginuser.hakbun}" readonly />
				
				<div>
					<input style="margin-bottom: 13px;" type="text" name="title" id="title" size="100" placeholder="제목을 입력해주세요"/>
				</div>
				
				<div>
					<textarea rows="10" cols="102" name="detail" id="detail" placeholder="내용을 입력해주세요"></textarea>
				</div>
				
				<div>
					<input style="margin-top: 13px; text-align: right;" type="text" name="year" id="year" size="12" />년   
					<input style="margin-top: 13px; text-align: right;" type="text" name="month" id="month" size="12" />월   
					<input style="margin-top: 13px; text-align: right;" type="text" name="day" id="day" size="12" />일   
					<input style="margin-top: 13px; text-align: right;" type="text" name="time" id="time" size="12" />시  
					<input style="margin-top: 13px; text-align: right;" type="text" name="minute" id="minute" size="12" />분 부터
				</div>
				
				<div>
					<input style="margin-top: 13px; text-align: right;" type="text" name="year1" id="year1" size="12" />년   
					<input style="margin-top: 13px; text-align: right;" type="text" name="month1" id="month1" size="12" />월   
					<input style="margin-top: 13px; text-align: right;" type="text" name="day1" id="day1" size="12" />일   
					<input style="margin-top: 13px; text-align: right;" type="text" name="time1" id="time1" size="12" />시  
					<input style="margin-top: 13px; text-align: right;" type="text" name="minute1" id="minute1" size="12" />분 까지
				</div>
				
				
				
				<br>
				<hr style="width: 843px; margin-left: 0px;">
				
				
				<div style="margin-left: 736px;">
					<div>
						<button style="margin-left: 7px;"type="button" class="btn btn-secondary btn-sm" id="btnWrite" >추가</button>
						<button type="button" class="btn btn-light  btn-sm" onclick="javascript:history.back()">취소</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>