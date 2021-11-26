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
		
		
	});// end of $(document).ready(function(){})-----------------------------------------------------------------
	
	//////////////////////////////////////////////////////////////////
	
	<%-- function goView(seq) {
		
	location.href="<%= ctxPath%>/view.action?seq="+seq;
		
		// === #125. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후 === //
		//           사용자가 목록보기 버튼을 클릭했을 떄 돌아갈 페이지를 알려주기위해
		//			  현재 페이지 주소를 뷰단에 넘겨준다
		var frm = document.goViewFrm;
		frm.seq.value = seq;
		frm.gobackURL.value = "${requestScope.gobackURL}"
		frm.searchType.value = "${requestScope.paraMap.searchType}"; //이전글, 다음글 추가
		frm.searchWord.value = "${requestScope.paraMap.searchWord}";
		
		frm.method = "GET";
		frm.action = "<%= request.getContextPath()%>/view.univ";
		frm.submit();
		
	}// end of function goView(seq) {}--------------------------------

	 --%>
</script>




<div class="container p-5" >
		
		<br>
		
		
		<ul class="nav nav-tabs">
			  <li class="nav-item">
			    <a class="nav-link text-secondary" href="<%= request.getContextPath()%>/receiveList.univ">수신함</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link active text-secondary" href="<%= request.getContextPath()%>/sendList.univ">발신함</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link text-secondary" href="<%= request.getContextPath()%>/sendjjokji.univ">쪽지 보내기</a>
			  </li>
		</ul>	
		
		<br><br>
		
		<h2 style="font-size:23px; font-weight: bold; color: #ffaa29;"><i class="far fa-envelope" style="font-size:29px; margin-left: 7px;"></i>&nbsp;&nbsp;발신함</h2>
		
		<hr>
		
		<button type="button" class="btn btn-light  btn-sm" style="float:right; margin-right: 1.5%; margin-bottom: 1.5%;" onclick="javascript:location.href='<%= request.getContextPath()%>/sendList.univ'"> <i class="fas fa-redo-alt"></i></button>
		<table class="table table-hover">
			<thead>
				<tr>
					<th style="width: 70px; text-align: center;">번호</th>
					<th style="width: 360px;text-align: center;">쪽지 내용</th>
					<th style="width: 360px;text-align: center;">첨부파일</th>
					<th style="width: 85px; text-align: center;">받는 사람</th>
					<th style="width: 85px; text-align: center;">보낸 시간</th>
				</tr>	
			</thead>
			<tbody>
				<c:forEach var="jjokjivo" items="${requestScope.sendList}">
					<tr>
						<td >${jjokjivo.jseq}</td>
						<td style="font-weight: bold;">${jjokjivo.jjokjiContent}</td>
						<td >
						<c:if test="${sessionScope.loginuser != null}">
							<a href="<%= request.getContextPath()%>/download.univ?jseq=${jjokjivo.jseq}">${jjokjivo.orgFilename}</a> 
							</c:if>
							<c:if test="${sessionScope.loginuser == null}">
								${jjokjivo.orgFilename}
							</c:if>
						</td>
						<td >${jjokjivo.name}</td>
						<td >${jjokjivo.jjokjiTime}</td>
					</tr>
				</c:forEach>	
			</tbody>
		</table>
		
		<%-- === #122. 페이지바 보여주기 === --%>
		<div align="center" style="margin:20px auto; width:70%; padding-top: 4%;">
			${requestScope.pageBar}
		</div>
		
		
		
		
		<%-- === #124. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후 === //
		  사용자가 목록보기 버튼을 클릭했을 떄 돌아갈 페이지를 알려주기위해 현재 페이지 주소를 뷰단에 넘겨준다 --%>
		<form name="goViewFrm"> <%-- 폼태그에 담아서 view.jsp에 전송할 것이다. --%>
			<input type="hidden" name="seq" />
			<input type="hidden" name="gobackURL" />
			<input type="hidden" name="searchType" /> 
			<input type="hidden" name="searchWord" />
		</form>
	
</div>	