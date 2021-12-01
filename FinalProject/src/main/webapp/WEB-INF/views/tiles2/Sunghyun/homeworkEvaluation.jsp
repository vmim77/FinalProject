<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<style type="text/css">

	.evalTbl th { background-color: #ffb84d; width: 20%; }
	
	.card {margin-left: 10px;}
 
    .card-text {color: gray; font-size: 10pt;}
 
    .title{font-size: 10pt; color:gray;}
    
	.highcharts-figure,
	.highcharts-data-table table {
	    min-width: 310px;
	    max-width: 800px;
	    margin: 1em auto;
	}
	
	#datatable {
	    font-family: Verdana, sans-serif;
	    border-collapse: collapse;
	    border: 1px solid #ebebeb;
	    margin: 10px auto;
	    text-align: center;
	    width: 100%;
	    max-width: 500px;
	}
	
	#datatable caption {
	    padding: 1em 0;
	    font-size: 1.2em;
	    color: #555;
	}
	
	#datatable th {
	    font-weight: 600;
	    padding: 0.5em;
	}
	
	#datatable td,
	#datatable th,
	#datatable caption {
	    padding: 0.5em;
	}
	
	#datatable thead tr,
	#datatable tr:nth-child(even) {
	    background: #f8f8f8;
	}
	
	#datatable tr:hover {
	    background: #f1f7ff;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("ul#sideMenuList > li:nth-child(6)").addClass("hoverdEffect");
		
		$("ul#sideMenuList").hover(function(){
			$("ul#sideMenuList > li:nth-child(6)").removeClass("hoverdEffect");
		}, function(){
			$("ul#sideMenuList > li:nth-child(6)").addClass("hoverdEffect");
		});
		
		Highcharts.chart('container', {
		    data: {
		        table: 'datatable'
		    },
		    chart: {
		        type: 'column'
		    },
		    title: {
		        text: '${requestScope.subjectMap.subject} 과제평가'
		    },
		    yAxis: {
		        allowDecimals: false,
		        title: {
		            text: '제출횟수'
		        }
		    },
		    tooltip: {
		        formatter: function () {
		            return '<b>' + this.series.name + '</b><br/>' +
		                this.point.y + ' ' + this.point.name.toLowerCase();
		        }
		    }
		});

	});
		
</script>

<i class="hideSubjectMenu fas fa-bars fa-2x"
	style="float: left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float: left;">${requestScope.subjectMap.subject}
	강의실(${requestScope.subjectMap.name}) > <span
		style="color: #0099ff; text-decoration: underline;">과제 평가</span>
</h3>
<hr style="clear: both;">

<c:if test="${not empty evalList}">
	<button type="button" class="btn btn-md my-2" style="background-color: #ffb84d; color: #fff;" onclick="javascript:location.href='<%= request.getContextPath()%>/homework.univ'">돌아가기</button>
	<button type="button" class="btn btn-md my-2"
		style="background-color: #ffb84d; color: #fff; border: none; margin-left: 10px;" onclick="javascript:location.href='<%= request.getContextPath()%>/downloadExcel.univ'">Excel다운로드</button>
	<figure class="highcharts-figure my-2">
		<div id="container"></div>

		<table id="datatable" style="display: none;">
			<thead>
				<tr>
					<th></th>
					<th>과제제출횟수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="evalMap" items="${evalList}">
					<tr>
						<th>${evalMap.name}(${evalMap.hakbun})</th>
						<td>${evalMap.StudentCnt}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</figure>

	<div class="container-fluid my-3 p-3"
		style="background-color: #ffb84d;">
		<c:forEach var="evalMap" items="${evalList}" varStatus="status">
			<div class="accordion" id="accordion${status.count}">
				<div class="card">
					<div class="card-header" id="heading${status.count}"
						style="background-color: #fff;">
						<h2 class="mb-0">
							<button class="btn btn-link btn-block text-left" type="button"
								data-toggle="collapse" data-target="#collapse${status.count}"
								aria-expanded="true" aria-controls="collapse${status.count}">
								<span style="color: black;">${requestScope.subjectMap.subject} -
								${evalMap.name}(${evalMap.hakbun})</span></button>
						</h2>
					</div>

					<div id="collapse${status.count}" class="collapse"
						aria-labelledby="heading${status.count}"
						data-parent="#accordion${status.count}">
						<div class="card-body">
							<table style="text-align: center;" class="evalTbl table table-bordered">
								<tr><th colspan="2">과제관리</th></tr>
								<tr>
									<th>학생명</th>
									<td>${evalMap.name}</td>
								</tr>
								<tr>
									<th>학번</th>
									<td>${evalMap.hakbun}</td>
								</tr>
								<tr>
									<th>과제제출횟수</th>
									<td>${evalMap.StudentCnt}&nbsp;/&nbsp;${evalMap.totalCnt}</td>
								</tr>
								<tr>
									<th>과제제출율</th>
									<td>${evalMap.StudentCnt / evalMap.totalCnt * 100}%</td>
								</tr>
								<tr>
									<th colspan="2" style="text-align: center;">제출과제목록</th>
								</tr>
								<c:if test="${not empty homeworkCommentList}">
									<c:forEach var="hwcvo" items="${homeworkCommentList}">
										<c:if test="${hwcvo.fk_hakbun eq evalMap.hakbun}">
										<tr>
											<td>제출일자: ${hwcvo.regDate}</td>
											<td><a href='<%= request.getContextPath()%>/homeworkCommentFileDownload.univ?seq=${hwcvo.seq}'>${hwcvo.orgFilename}</a></td>
										</tr>
										</c:if>
									</c:forEach>
								</c:if>
							</table>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</c:if>

<c:if test="${empty evalList}">
	<div>수강생이 없습니다.</div>
</c:if>