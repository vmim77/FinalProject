<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<% String ctxPath = request.getContextPath(); %>

<style>

 .card {
 	margin: 10px;
 }
 
 .card-text {
 	color: gray;
 	font-size: 10pt;
 }
 
 span.toDo {
 	color: gray;
 	font-size: 8pt;
 }
 
 .icons > .fas, .icons > .far {
 	margin: 0 20px;
 	color: gray;
 }
 
 .fa-bullhorn {
 	margin-left: 5px;
 }
 
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		
	});
	
</script>

<c:if test="${not empty sessionScope.sugangList}"> <%-- 학생이면 가장 상단에 얘를 보여줍니다. --%>
	<h2>대시보드 - 수강과목(학생)</h2>
</c:if>
<c:if test="${not empty sessionScope.suupList}"> <%-- 교수이면 가장 상단에 얘를 보여줍니다. --%>
	<h2>대시보드 - 담당과목(교수)</h2>
</c:if>
<hr>

<div id="maincontainer" style="display: flex;">
	<section style="width: 100%; margin-right: auto;">
		<div class="row mx-1">
			
			<%-- 학생이라면 수강한 과목을 반복문으로 카드로 만들어서 찍어줍니다. --%>
			<c:if test="${not empty sessionScope.sugangList}">
				<c:forEach var="sugangMap" items="${sessionScope.sugangList}">
				     <div class="card col-2 p-0" style="width: 5%; box-shadow: 0px 1px 3px;">
				 	   <div style="width: 100%; height: 200px;"><img style="width: 100%; height: 100%;" src='<%= request.getContextPath()%>/resources/images/${sugangMap.code}.jpg' /></div>
				 	   <div class="card-body">
				 	     <h5 class="card-title">${sugangMap.subject}</h5>
				 	     <p class="card-text" style="font-size: 8pt; color: gray;">담당교수: ${sugangMap.teacher}<br>수업요일: ${sugangMap.classdate}<br>배정학점: ${sugangMap.hakjum}</p>
				 	     <a href='/univ/subject.univ?code=${sugangMap.code}' class='stretched-link btn btn-primary btn-sm' role='button'>강의실 입장</a>
				 	   </div>
				     </div>
				</c:forEach>
			</c:if>
			
			<%-- 교수이라면 담당 과목을 반복문으로 카드로 만들어서 찍어줍니다. --%>
			<c:if test="${not empty sessionScope.suupList}">
				<c:forEach var="suupMap" items="${suupList}">
				     <div class="card col-2 p-0" style="width: 5%; box-shadow: 0px 1px 3px;">
				 	   <div style="width: 100%; height: 200px;"><img style="width: 100%; height: 100%;" src='<%= request.getContextPath()%>/resources/images/${suupMap.code}.jpg' /></div>
				 	   <div class="card-body">
				 	     <h5 class="card-title">${suupMap.subject}</h5>
				 	     <p class="card-text" style="font-size: 12pt; color: gray;">수업요일: ${suupMap.classdate}<br>배정학점: ${suupMap.hakjum}점<br>수강인원: ${suupMap.cnt} 명</p>
				 	     <a href='/univ/subject.univ?code=${suupMap.code}' class='stretched-link btn btn-primary btn-sm' role='button'>강의실 입장</a>
				 	   </div>
				     </div>
				</c:forEach>
			</c:if>
			
			<%-- 위의 둘은 공통점이 카드의 어디든 누르면 과목의 인덱스페이지로 과목코드를 가지고 GET으로 간다는 점입니다. --%>
			
			<c:if test="${sessionScope.suupList == null and sessionScope.sugangList == null}">
				<h3 style="color: red;">등록된 수업이 없습니다.</h3>
			</c:if>
		</div>
	</section>
	
</div>