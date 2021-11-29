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
td {
	vertical-align : middle;
	text-align: center;
	color:#616161; 
	font-size: 15px;
	 line-height: 45px;
	
}



.subjectStyle {font-weight: bold; 
			   cursor: pointer;} 
			   
#innerContent > div > table > thead > tr > th {
 	height: 10px;
 }

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("span.subject").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("subjectStyle");
		});
				
		$("span.subject").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("subjectStyle");
		});
		
		
		
		
				
		////////////////////////////////////////////////////////////////////////
		// 수신함 전체선택시
		$("input#senderAll").click(function(){
		
		if($(this).is(":checked")){
		
		$("input:checkbox[name=schk]").prop("checked", true);
		$("span#senderSpan").text("전체선택 해제");
		
		}
		else{
		
		$("input:checkbox[name=schk]").prop("checked", false);
		$("span#senderSpan").text("전체선택");
		
		}
		
		});//end of $("checkbox#senderAll").click(function(){---------------------------
		
		


	
		
		// 수신함 선택항목 삭제
		$("button#sendDel").click(function(){
		
		var jseq = "";
		var cnt = 0;
		
		$("input:checkbox[name=schk]").each(function(){
		
		if($(this).is(":checked")){
		
			jseq += $(this).next().val() + ",";
			cnt++;
		
		}//end of if($(this).is(":checked")){-----------------------------------
		
		});//end of $("input:checkbox[name=schk]").each(function(){-----------------
		
		if(cnt == 0){
			alert("체크된 항목이 없습니다.");   
			}
		else{
			
			$.ajax({
			url:"<%= request.getContextPath()%>/jjokjiListDel.univ",
			type:"GET",
			data:{"jseq":jseq},
			dataType:"JSON",
			success:function(json){
			
			if(json.n > 0){
			alert(json.n+"개의 쪽지가 삭제되었습니다.");
			}
			
			
			},
			error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});//end of $.ajax({--------------------------------------------------------
		
		}//end of if(cnt == 0){-----------------------------------------------------
		
		// 체크박스 해제
		$("input:checkbox[name=schk]").prop("checked", false);
		
		});//end of $("button#senderDel").click(function(){-----------------------------
		
		
		
				
				
				
				
				
				
				
			
		
		
		
		
		
		
	});// end of $(document).ready(function(){})-----------------------------------------------------------------
	
	//////////////////////////////////////////////////////////////////
	
	
</script>




<div class="container p-5" >
		
		<br>
		
		<ul class="nav nav-tabs" style="margin-bottom: 50px;">
			  <li class="nav-item">
			    <a class="nav-link active text-secondary" href="<%= request.getContextPath()%>/receiveList.univ">수신함</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link text-secondary" href="<%= request.getContextPath()%>/sendList.univ">발신함</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link text-secondary" href="<%= request.getContextPath()%>/sendjjokji.univ">쪽지 보내기</a>
			  </li>
		</ul>	
		
		<br><br>
		
		
		<h2 style="font-size:23px; font-weight: bold; color: #ffaa29;"><i class="far fa-envelope-open" style="font-size:29px; margin-left: 7px;"></i>&nbsp;&nbsp;수신함</h2>
		
		<hr>
		
		
		<button type="button" class="btn btn-light  btn-sm" style="float:right; margin-left:15px; margin-right: 1.5%; margin-bottom: 1.5%;" onclick="javascript:location.href='<%= request.getContextPath()%>/receiveList.univ'"> <i class="fas fa-redo-alt"></i></button>
		
		<button type="button" class="btn btn-light  btn-sm" style="float:right; " id="sendDel">선택 삭제</button>
		
		<table class="table table-hover">
			<thead>
				<tr>
					<th style="width: 70px; text-align: center;"><input id="senderAll" type="checkbox"/></th> <%-- 전체삭제 체크박스 --%>
					
					<th style="width: 360px;text-align: center;">쪽지 내용</th>
					<th style="width: 360px;text-align: center;">첨부파일</th>
					<th style="width: 150px; text-align: center;">보낸 사람</th>
					<th style="width: 150px; text-align: center;">보낸 시간</th>
				</tr>	
			</thead>
			<tbody>
				<c:forEach var="jjokjivo" items="${requestScope.receiveList}">
					<tr>
						<td><input class="schkbox" type="checkbox" name="schk"/> <input type="hidden" value="${jjokjivo.jseq}"/></td>
						
						<td  style="font-weight: bold;">${jjokjivo.jjokjiContent}</td>
						<td>
							<c:if test="${sessionScope.loginuser != null}">
							<a href="<%= request.getContextPath()%>/download.univ?jseq=${jjokjivo.jseq}">${jjokjivo.orgFilename}</a> 
							</c:if>
							<c:if test="${sessionScope.loginuser == null}">
								${jjokjivo.orgFilename}
							</c:if>
						</td>
						<td>${jjokjivo.name}</td>
						<td >${jjokjivo.jjokjiTime}</td>
					</tr>
				</c:forEach>	
			</tbody>
		</table>
		
		<%-- === #122. 페이지바 보여주기 === --%>
		<div align="center" style="margin:20px auto; width:70%; padding-top: 4%;">
			${requestScope.pageBar}
		</div>
		
		
		
		
	
	
</div>	