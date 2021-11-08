<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>

 .card {margin-left: 10px;}
 
 .card-text {color: gray; font-size: 10pt;}
 
 table#homework, th, td {border: solid 1px gray;}

 th, td{padding: 10px 0 10px 10px;}
 
 .title{font-size: 10pt; color:gray;}
 
 .badge{margin-left: 10px;}
 
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("ul#sideMenuList > li:nth-child(5)").addClass("hoverdEffect");
		
	});
	
</script>

<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left; color: #0099ff;">${requestScope.subjectMap.subject}_${requestScope.subjectMap.ban}반(${requestScope.subjectMap.teacher}) 강의실 > 과제및평가</h3>
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

	<div class="accordion" id="accordionExample">
		<div class="card">
			<div class="card-header" id="headingOne">
				<h2 class="mb-0">
					<button class="btn btn-link btn-block text-left" type="button"
						data-toggle="collapse" data-target="#collapseOne"
						aria-expanded="false" aria-controls="collapseOne">
						과제1<span class="badge badge-danger">미열람</span><br>
						<div class="title">열람 종료일: 12월 17일 | 마감일 9월 19일 오후 13:59 |
							-/1점 | 평가 안 됨</div>
					</button>
				</h2>
			</div>

			<div id="collapseOne" class="collapse"
				aria-labelledby="headingOne" data-parent="#accordionExample">
				<div class="card-body d-flex justify-content-center">
					<table id="homework" style="width: 80%;">
						<tr>
							<th>작성자</th>
							<td>교수 금길영</td>
						</tr>
						<tr>
							<th>제목</th>
							<td>학생 여러분 안녕하십니까?</td>
						</tr>
						<tr>
							<th colspan="2">내용</th>
						</tr>
						<tr>
							<td colspan="2">
								<p>학생여러분 안녕하십니까? 한학기동안 여러분들과 함께할 빅데이터실무 교수 '금길영'입니다.</p>
								<p>저희 빅데이터실무 과목은 절대평가입니다.</p>
								<p>아래에 수업에 필요한 교재를 첨부하오니 다음주 수업시작전까지 모두 준비하시기 바랍니다.</p>
							</td>
						</tr>
						<tr>
							<th colspan="2">댓글</th>
						</tr>
						<tr>
							<th>수강생1</th>
							<td>댓글내용1</td>
						</tr>

					</table>
				</div>
			</div>
		</div>

		<div class="accordion" id="accordionExample">
			<div class="card">
				<div class="card-header" id="headingOne">
					<h2 class="mb-0">
						<button class="btn btn-link btn-block text-left" type="button"
							data-toggle="collapse" data-target="#collapseTwo"
							aria-expanded="false" aria-controls="collapseTwo">
							과제2<span class="badge badge-warning">New</span>
							<div class="title">열람 종료일: 12월 17일 | 마감일 9월 19일 오후 13:59 |
								-/1점 | 평가 안 됨</div>
						</button>
					</h2>
				</div>

				<div id="collapseTwo" class="collapse"
					aria-labelledby="headingOne" data-parent="#accordionExample">
					<div class="card-body d-flex justify-content-center">
						<table style="width: 80%;">
							<tr>
								<th>작성자</th>
								<td>교수 금길영</td>
							</tr>
							<tr>
								<th>제목</th>
								<td>2주차 과제입니다.</td>
							</tr>
							<tr>
								<th colspan="2">내용</th>
							</tr>
							<tr>
								<td colspan="2">
									<p>학생여러분 안녕하십니까? 빅데이터실무 교수 '금길영'입니다.</p>
									<p>2주차 과제에 대해 안내해드리겠습니다.</p>
									<p>주제는 '빅데이터란 무엇인가?'로 A4용지 5장 분량으로 다음주까지 저의 연구실에 제출해주시면
										됩니다.</p>
								</td>
							</tr>
							<tr>
								<th colspan="2">댓글</th>
							</tr>
							<tr>
								<th>수강생</th>
								<td>과제 분량 줄여주세요</td>
							</tr>
							<tr>
								<th>금길영 교수</th>
								<td>싫어요</td>
							</tr>
							<tr>
								<th>금길영 교수</th>
								<td>내일 과사로 오세요</td>
							</tr>

						</table>
					</div>
				</div>
			</div>

		</div>
	</div>
</div>
</div>
