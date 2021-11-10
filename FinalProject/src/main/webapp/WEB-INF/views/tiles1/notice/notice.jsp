<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<% String ctxPath = request.getContextPath(); %>


<%-- <link rel="stylesheet" type="text/css" href="/css/mypage/mypageStyle.css" /> --%>
<title>마이페이지-게시물 관리</title>
<style type="text/css">	
/* 부트스트랩 버튼 색 변경    */
.btn-light {
    background-color: /* #EEEEEE; */		#778899;
    border-color: #778899;
    color: /* #616161; */ #FFF;}
.btn-light:hover,
.btn-light:focus {
    border-color: #cccccc;
    background-color: #cccccc;
    color: #FFF; }

    .btn-dark {
    background-color: #555555;
    border-color: #555555;
    color: #FFF; 
    }
.btn-dark:hover,
.btn-dark:focus {
    border-color: #cccccc;
    background-color: #cccccc;
    color: #FFF; }

/* 게시판 정렬 , 글자색, 글자크기*/
table td {
	text-align: center;
	color:#616161;
	font-size: 15px;
}

table > tbody > tr > td:nth-child(1){
	width: 10%;
}

table > tbody > tr > td:nth-child(3){
	width: 10%;
}

table > tbody > tr > td:nth-child(4){
	width: 20%;
}

table > tbody > tr > td:nth-child(5){
	width: 10%;
}	






</style>

<%-- ////내용 시작//// --%>

	
<div class="container p-5" >


	<div class="pt-5 pb-5">	
<%-- 	  <div class="card">
	    <div class="card-body"> --%>
	    <form id="" name="">	   
			
			<%-- 검색--%>	 
		     <input type="text" id="" name="" style="height: 30px; width: 250px; font-size: 12pt;">&ensp;
		     &ensp; 
			<button type="button"  onclick = "" class="btn btn-dark" style="font-size: 10pt; padding: 5px 8px;">검색</button>&nbsp;
			<button type="button" onclick="javascript:location.href='<%= ctxPath%>/noticeAdd.univ'" class="btn btn-light float-right" style="font-size: 10pt; padding: 5px 12px; text-align: right;">+ 글쓰기</button>&nbsp;		
		</form>
		
	<%--     </div>
	  </div> --%>
	</div>		 
	
	<%-- 게시물 --%>
		<table class="table table-hover">		  
		    <tr>
		      <td>글번호</td>
		      <td>제목</td>
		      <td>작성일</td>
		      <td>글쓴이</td>
		      <td>조회수</td>
		    </tr>
		   <%--  <c:forEach var="" items="">--%>
			    <tr>
			      <td>2</td>
			      <td>장현걸 영원히 사랑해♥</td>
			      <td>2021-12-15</td>
			      <td>교수금길영</td>
			      <td>0</td>
			    </tr>
		    <%-- </c:forEach>--%>
		  <tr>
			      <td>1</td>
			      <td>나는 연약하다..</td>
			      <td>2021-12-13</td>
			      <td>연약한교수이재성</td>
			      <td>0</td>
			    </tr>
		</table>		
		<br>	
	<%-- 페이지네이션 --%>	
	<div align="center" style="width: 70%; border: solid 0px gray; padding-top:40px; margin: 20px auto;">
	  <ul style='list-style: none;'>
	    <li  style='display:inline-block; width:30px; font-size:12pt;'><a class="" href="#" style='text-decoration: none; color: #616161;'><span> « </span></a></li>
	    <li  style='display:inline-block; width:30px; font-size:12pt;'><a class="" href="#" style='text-decoration: none; color: #616161;'><span> ‹ </span></a></li> 	
	    	 <li  style='display:inline-block; width:20px; font-size:12pt;'><a class="" href="#" style='text-decoration: none; color: #616161;'>1</a></li>
	     <li  style='display:inline-block; width:30px; font-size:12pt;'><a class="" href="#" style='text-decoration: none; color: #616161;'><span> › </span></a></li>
	     <li  style='display:inline-block; width:30px; font-size:12pt;'><a class="" href="#" style='text-decoration: none; color: #616161;'><span> » </span></a></li>
	  </ul>
	</div>
	
</div>
<script type="text/javascript">
</script>
