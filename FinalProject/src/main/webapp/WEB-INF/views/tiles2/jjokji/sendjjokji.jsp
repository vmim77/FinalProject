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
		
		// 쓰기 버튼
		$("button#btnSend").click(function() { //id를 선택자로 잡음. 쓰기 버튼을 클릭하면 실행하라는 것
			
			//받는 사람 유효성 검사
			/* var subjectVal = $("input#subject").val().trim(); // 글제목 인풋칸에 입력한 값에서 공백을 제거한걸 변수에 담음
			if(subjectVal == ""){
				alert("글제목을 입력하세요!!");
				return;
			}
			 */
			 
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
			alert("서브밋 보냄");
			alert("<%= request.getContextPath()%>");
		});
		
		
		
		// 학과 클릭시 해당학과 교수님 불러오기
		$("select#deptSelct").click(function(){
			
			$.ajax({
				url:"<%= request.getContextPath()%>/getTeacher.univ",
				type:"GET",
				data:{"deptCode":$(this).val()},
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
		
		<br>
		<br>
		<br>
	
		
	<div style="margin:auto; margin-left: padding-top:70px;">

	<h2 style=" font-size:23px; font-weight: bold;">쪽지 보내기</h2>
	<hr style="width: 843px; margin-left: 0px;">
	<form name="sendjjokjiFrm"   enctype="multipart/form-data">
		
			
			<span> 확인용 보내는 사람 학번</span><input   style="margin-bottom: 30px;" type="text" name="sender_hakbun" value="${sessionScope.loginuser.hakbun}" readonly/>
			<%-- <input type="text" name="name" value="${sessionScope.loginuser.name}" readonly/> --%>
			<div>받는 사람 학번<span>&nbsp;&nbsp;&nbsp;<input type="text" name="receive_hakbun"></input></span></div>
			
	
	
			<!-- 받는사람 선택 모달 시작 -->			
			<!-- Button trigger modal -->
			<button type="button" class="btn btn-light " data-toggle="modal" data-target="#exampleModal">
			 	 받는 사람
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
			      <div class="modal-body">
			       <select class="inp" id="detpSelect">
						<c:forEach var="deptvo" items="${requestScope.deptList}">
							<option value="${deptvo.deptCode}">${deptvo.deptName}</option>
						</c:forEach>
					</select>
					
					<select name="receive_hakbun" id="receive_hakbun">
					    
					</select>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			        <button type="button" class="btn btn-primary">Save changes</button>
			      </div>
			    </div>
			  </div>
			</div>
		<!-- 모달 끝-->

			
			
			
			
				
				<div style="padding-top: 10px;">					
					<textarea rows="17" cols="102" name="jjokjiContent" id="jjokjiContent"></textarea>
				</div>
		
			<br>
			<%-- === #150. 파일첨부 타입 추가하기 === --%>
			<tr>
				<th style="width: 15%; background-color: #DDDDDD">파일첨부</th>
				<td>
					<input type="file" name="attach" />
				</td>
			</tr>
			
		
		
		
			<br>
			<hr style="width: 843px; margin-left: 0px;">
			
		<div style="margin-left: 736px;">	
			<div>
				<button type="button" class="btn btn-light  btn-sm" onclick="javascript:history.back()">취소</button>
				<button style="margin-left: 7px;" type="button" class="btn btn-secondary btn-sm" id="btnSend" >전송</button>	
			</div>
		</div>
		
	</form>

</div>
		
	
</div>	