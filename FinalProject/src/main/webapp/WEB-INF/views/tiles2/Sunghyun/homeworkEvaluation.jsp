<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:if test="${not empty requestScope.sugangList}">
	<div class="accordion" id="accordionExample">
	<c:forEach var="mvo" items="${requestScope.sugangList}" varStatus="status">
			<div class="card">
				<div class="card-header" id="heading${status.count}">
					<h2 class="mb-0">
						<button class="btn btn-link btn-block text-left" type="button"
							data-toggle="collapse" data-target="#collapse${status.count}"
							aria-expanded="true" aria-controls="collapse${status.count}">
							${mvo.name}(${mvo.hakbun}) 과제관리</button>
					</h2>
				</div>
	
				<div id="collapse${status.count}" class="collapse"
					aria-labelledby="heading${status.count}" data-parent="#accordionExample">
					<div class="card-body">
						<table style="width: 100%;">
							<tr>
								<th style="width: 10%;">학번</th>
								<td>${mvo.hakbun}</td>
							</tr>
							<tr>
								<th>성명</th>
								<td>${mvo.name}</td>
							</tr>
							
							<tr>
								<th>제출율</th>
								<c:forEach var="evalMap" items="${requestScope.evalList}">
									<c:if test="${evalMap.fk_hakbun == mvo.hakbun}">
											<td>${evalMap.percentage}</td>
									</c:if>
								</c:forEach>
							</tr>
							
							<tr>
								<th colspan="2" style="margin-bottom: 20px;">제출과제목록</th>
							</tr>
							
							<c:forEach var="hwcvo" items="${requestScope.homeworkCommentList}">
								<c:if test="${mvo.hakbun == hwcvo.fk_hakbun}">
									<tr><td colspan="2">${hwcvo.orgFilename}</td></tr>
								</c:if>
							</c:forEach>
							
						</table>
					</div>
				</div>
			</div>
	</c:forEach>
	</div>
</c:if>

<c:if test="${empty requestScope.sugangList}">
	<div>수강 인원이 없습니다.</div>
</c:if>
