<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<style>

 .card {margin-left: 10px;}
 
 .card-text {color: gray; font-size: 10pt;}
 
	table#homework, th, td { border: solid 1px black; }
	
	table#homework { border: solid 2px black; }
	
	th { width: 30%; padding-left: 5px; background-color: #ddd; }
	
	td { width: 50%; padding: 10px; }
 
 .title{font-size: 10pt; color:gray;}
 
 .badge{margin-left: 10px;}
 
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("ul#sideMenuList > li:nth-child(5)").addClass("hoverdEffect");
		
		$("ul#sideMenuList").hover(function(){
			$("ul#sideMenuList > li:nth-child(5)").removeClass("hoverdEffect");
		}, function(){
			$("ul#sideMenuList > li:nth-child(5)").addClass("hoverdEffect");
		});
		

	});
	
</script>

<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left;">${requestScope.subjectMap.subject} 강의실(${requestScope.subjectMap.name}) > <span style="color: #0099ff; text-decoration: underline;">과제및평가</span></h3>
<hr style="clear: both;">

<div id="homeworkContainer" style="width: 100%;">

	<div style="display: flex;">
		<input type="text" placeholder="과제 검색" style="margin-left: 10px;" />
		<div style="margin-left: auto;">
			<button type="button" class="btn btn-secondary">날짜로 보기</button>
			<button type="button" class="btn btn-secondary">유형별 보기</button>
		</div>
	</div>
	
	<div class="container-fluid my-3 p-3" style="background-color: #ddd;">
		<c:if test="${not empty requestScope.homeworkList}">
			<c:forEach var="homeworkvo" items="${requestScope.homeworkList}" varStatus="status">
				<div class="accordion" id="accordion${status.count}">
					<div class="card">
						<div class="card-header" id="heading${status.count}">
							<h2 class="mb-0">
								<button class="btn btn-link btn-block text-left" type="button"
									data-toggle="collapse" data-target="#collapse${status.count}"
									aria-expanded="false" aria-controls="collapse${status.count}">
									${homeworkvo.subject}
									<div class="title">${homeworkvo.regDate} | 작성자: ${homeworkvo.name}</div>
								</button>
							</h2>
						</div>
			
						<div id="collapse${status.count}"class="collapse"
							aria-labelledby="heading${status.count}" data-parent="#accordion${status.count}">
							<div class="card-body d-flex justify-content-center">
							${homeworkvo.content}
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
		<c:if test="${empty requestScope.homeworkList}">
			과제가 없습니다!
		</c:if>
	</div>
</div>
