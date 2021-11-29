<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

/* 부트스트랩 버튼 색 변경    */

.btn-light {
    background-color: #ffffff;
    border-color: #ff9900;
    color:  #ff8c00;}
.btn-light:hover,
.btn-light:focus {
    border-color: #ffcc80;
    background-color: #ffcc80;
    color: #FFF; }
    
    
   .btn-secondary {
    background-color: #ffb84d;
    border-color: #ffb84d;
    color: #FFF; 
    }    
    
	.btn-secondary:hover,
	.btn-secondary:focus {
    border-color: #ffcc80;
    background-color: #ffcc80;
    color: #FFF; }  
    


/* 게시판 정렬 , 글자색, 글자크기*/
table td {
	text-align: center;
	color:#616161; 
	font-size: 15px;
}


</style>

<script type="text/javascript">

	$(document).ready(function(){
	
		
		
		
		// 관리자 선택시 학과선택 감추기
		$("select#receive_hakbun").change(function(){
			var selectAdmin = $("select#receive_hakbun").val();
			if(selectAdmin == "0000001"){
				$("select#detpSelect").hide();
				return;
			} 
			// 받는 사람을 선택해주세요. 선택시 학과선택 보이기
			if(selectAdmin == "받는 사람을 선택해주세요."){
				$("select#detpSelect").show();
				return;
			} 
			
		
		});
	
		
		// 쓰기 버튼
		$("button#btnSend").click(function() { //id를 선택자로 잡음. 쓰기 버튼을 클릭하면 실행하라는 것
			
			
			
			//받는 사람 유효성 검사
			var detpSelectVal = $("select#detpSelect").val(); 
			var selectAdmin = $("select#receive_hakbun").val();
			
			if( !(detpSelectVal != "" || selectAdmin == "0000001") ){
				alert("받는 사람을 선택해주세요!");
				return;
			}
			
			
			
			
			 
			// 쪽지 내용 유효성 검사
			var contentVal = $("textarea#jjokjiContent").val().trim(); 
			if(contentVal == ""){
				alert("쪽지 내용을 입력하세요!!");
				return;
			} 
			
			
			
			
			
			
			// 폼(form)을 전송(submit) //파일첨부를 할때는 무저건 POST방식을 사용한다.
			var frm = document.sendjjokjiFrm;
			frm.method = "POST";
			frm.action = "<%= request.getContextPath()%>/sendjjokjiEnd.univ";
			frm.submit();
			//alert("서브밋 보냄");
			
			
		});
		
		// 선택 버튼 클릭시 리셋
	 	/*
	 	var detpSelectVal = $("select#detpSelect").val(); 
		
		if(detpSelectVal == "학과를 선택해주세요."){
		
			//$("select#receive_hakbun").val('0000001');
			var html = "";
			html += "<option value='0000001'>관리자</option>";
			$("select#receive_hakbun").html(html);
		
		}
		
		*/
		
		/////////////////
	
		///////////////
		
		
		
		// 학과 클릭시 해당학과 교수님 불러오기
		 
			//$("select#detpSelect").click(function(){ //원본
			$("select#detpSelect").change(function(){	//왼쪽으로 바꾸고 deptCode를 컨트롤러랑 여기에서 fk_deptCode로변경
			
			
			$.ajax({
				url:"<%= request.getContextPath()%>/getTeacher.univ",
				type:"GET",
				data:{"fk_deptCode":$(this).val()},
				dataType:"JSON",
				success:function(json){

					var html = "";
							
		  			$.each(json, function(index, item){

						html += "<option value='"+item.hakbun+"'>"+item.name+"</option>";

 
 
		  			});//end of $.each(json, function(index, item){--------------------------------------					
		  							
		  			$("select#receive_hakbun").html(html);	
		  						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					 }
						
				});//end of $.ajax({--------------------------------------------------------
				
					
					
			});
				
				
		 
		
	});// end of $(document).ready(function(){})-----------------------------------------------------------------
	
	
	
</script>




<div class="container p-5" >
		
		<br>
		
		
		<ul class="nav nav-tabs">
			  <li class="nav-item">
			    <a class="nav-link text-secondary" href="<%= request.getContextPath()%>/receiveList.univ">수신함</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link text-secondary" href="<%= request.getContextPath()%>/sendList.univ">발신함</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link active text-secondary" href="<%= request.getContextPath()%>/sendjjokji.univ">쪽지 보내기</a>
			  </li>
		</ul>	
		
		<br><br>
		
	
		
	<div style="margin:auto;">

	<h2 style="font-size:23px; font-weight: bold; color: #ffaa29;"><i class="fas fa-envelope-open-text" style="font-size:29px; margin-left: 7px;"></i>&nbsp;&nbsp;쪽지 보내기</h2>
	<hr style="width: 843px; margin-left: 0px;">
	<form name="sendjjokjiFrm"   enctype="multipart/form-data">
		
			
			<input style="margin-bottom: 30px;" type="hidden" name="sender_hakbun" value="${sessionScope.loginuser.hakbun}" readonly/>
			<%-- <input type="text" name="name" value="${sessionScope.loginuser.name}" readonly/> --%>
			<%-- <div>받는 사람 학번<span>&nbsp;&nbsp;&nbsp;<input type="text" name="receive_hakbun"></input></span></div>--%>
			
	
	
			<!-- 받는사람 선택 모달 시작 -->			
			<!-- Button trigger modal -->
			<button type="button" class="btn btn-light " data-toggle="modal" data-target="#exampleModal" style="margin-left: 676px; margin-bottom: 8px;">
			 	 받는 사람 선택하기
			</button>
			
			
			
			<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel">받는 사람</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body" style="width: 1200px;">
			      
			     
			      <%-- 학과, 교수 선택 --%>
			      
			       <select class="inp" id="detpSelect" style="height: 33px; margin-bottom:10px; margin-right: 10px;">
			       
			       <option value="학과를 선택해주세요.">학과를 선택해주세요.</option>
						<c:forEach var="deptvo" items="${deptList}">
							<option value="${deptvo.deptCode}">${deptvo.deptName}</option>
						</c:forEach>
					</select>
					
					<select name="receive_hakbun" id="receive_hakbun"  style="height: 33px;">
						<option value="받는 사람을 선택해주세요.">받는 사람을 선택해주세요.</option>
						<option value="0000001">관리자</option>
					</select>
				
					
					<%-- 받는 사람 버튼 --%>
					<button type="button" id="reselect" class="btn btn-light" data-dismiss="modal" style="height: 36px; margin-left: 5px; margin-right: 10px;">선택</button>
					<hr>
						<div style="font-size: 10pt;">※ 관리자에게 보내실 경우 학과를 선택하실 필요 없습니다.</div>
					
			      </div>
			      <div class="modal-footer">
			      	
			       <%--  <button type="button" class="btn btn-primary">Save changes</button> --%>
			      </div>
			    </div>
			  </div>
			</div>
		<!-- 모달 끝-->

			
			
			
			
				
				<div style="padding-top: 10px;">					
					<textarea rows="10" cols="102" name="jjokjiContent" id="jjokjiContent"></textarea>
				</div>
		
			<br><br>
			<%-- === #150. 파일첨부 타입 추가하기 === --%>
			<tr>
				<th style="width: 15%; margin-right:50px; background-color: #DDDDDD">파일첨부</th>
				<td>
					<input type="file" name="attach" />
				</td>
			</tr>
			
		
		
		
			<br>
			<hr style="width: 843px; margin-left: 0px;">
			
		<div style="margin-left: 718px;">	
			<div>
				<button type="button" class="btn btn-light" onclick="javascript:history.back()">취소</button>
				<button style="margin-left: 7px;" type="button" class="btn btn-secondary" id="btnSend" >전송</button>	
			</div>
		</div>
		
	</form>

</div>
		
	
</div>	