<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	
	table#subjectInfo, th, td { border: solid 1px black; }
	
	table#subjectInfo { border: solid 2px black; }
	
	th { width: 30%; padding-left: 5px; background-color: #ddd; }
	
	td { width: 50%; padding: 10px; }
	
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("ul#sideMenuList > li:first-child").addClass("hoverdEffect");
		
		$("ul#sideMenuList").hover(function(){
			$("ul#sideMenuList > li:first-child").removeClass("hoverdEffect");
		}, function(){
			$("ul#sideMenuList > li:first-child").addClass("hoverdEffect");
		});
		
		
	});
</script>

<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left; color: #0099ff;">${requestScope.subjectMap.subject} 강의실(${requestScope.subjectMap.name})</h3>
<hr style="clear: both;">

<div style="width: 80%; margin-top: 10px; padding: 10px;">
	<img style="position: relative;  width: 30%; float:left; margin-left: 5px;" src="<%= ctxPath%>/resources/images/${requestScope.subjectMap.code}.jpg" /> 
	
	<table id="subjectInfo" class="table" style="width: 60%; float: right; text-align: center;">
		<tr>
			<th colspan="2" class="bg"><h2>강좌소개</h2></th>
		</tr>
		<tr>
			<th class="bg">수강코드</th>
			<td>${requestScope.subjectMap.code}</td>
		</tr>
		<tr>
			<th class="bg">과목명</th>
			<td>${requestScope.subjectMap.subject}</td>
		</tr>
		<tr>
			<th class="bg">교수명</th>
			<td>${requestScope.subjectMap.name}</td>
		</tr>
		<tr>
			<th class="bg">학점</th>
			<td>${requestScope.subjectMap.hakjum}점</td>
		</tr>
		<tr>
			<th class="bg">수업요일</th>
			<td>${requestScope.subjectMap.classdate}요일</td>
		</tr>
		<tr>
			<th class="bg">강의실</th>
			<td>${requestScope.subjectMap.deptName}&nbsp;${requestScope.subjectMap.deptLocation}</td>
		</tr>
	</table>
</div>

<div style="clear: both;"></div>

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0; margin-top: 20px; width: 80%;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:15px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:15px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-baqh{text-align:center;vertical-align:top}
.tg .tg-13pz{font-size:18px;text-align:center;vertical-align:top}
.tg .tg-amwm{font-weight:bold;text-align:center;vertical-align:top}
.bg {background-color: #ffb84d; }
</style>
<table class="tg">
<thead>
  <tr>
    <th class="tg-13pz bg" colspan="15"><span style="font-weight:bold">강의 계획서</span></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-baqh bg" colspan="15"><span style="font-weight:bold">성적평가</span></td>
  </tr>
  <tr>
    <td class="tg-baqh" colspan="5"><span style="font-weight:bold">평가문항</span></td>
    <td class="tg-baqh" colspan="5"><span style="font-weight:bold">기준만점</span></td>
    <td class="tg-baqh" colspan="5"><span style="font-weight:bold">반영비율</span></td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="1">중간고사</td>
    <td class="tg-amwm" colspan="7">100점</td>
    <td class="tg-amwm" colspan="7">25%</td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="1">기말고사</td>
    <td class="tg-amwm" colspan="7">100점</td>
    <td class="tg-amwm" colspan="7">25%</td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="1">과제물</td>
    <td class="tg-amwm" colspan="7">100점</td>
    <td class="tg-amwm" colspan="7">20%</td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="1">출석</td>
    <td class="tg-amwm" colspan="7">100점</td>
    <td class="tg-amwm" colspan="7">30%</td>
  </tr>
  <tr>
    <td class="tg-baqh bg" colspan="15"><span style="font-weight:bold">차별 수업계획(Course Schedule)</span></td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="4">1주차</td>
    <td class="tg-baqh" colspan="11">${requestScope.subjectMap.subject} 오리엔테이션</td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="4">2주차</td>
    <td class="tg-baqh" colspan="11">${requestScope.subjectMap.subject} 수업 & 과제</td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="4">3주차</td>
    <td class="tg-baqh" colspan="11">${requestScope.subjectMap.subject} 수업</td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="4">4주차</td>
    <td class="tg-baqh" colspan="11">${requestScope.subjectMap.subject} 수업</td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="4">5주차</td>
    <td class="tg-baqh" colspan="11">${requestScope.subjectMap.subject} 수업</td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="4">6주차</td>
    <td class="tg-baqh" colspan="11">${requestScope.subjectMap.subject} 수업</td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="4">7주차</td>
    <td class="tg-baqh" colspan="11">${requestScope.subjectMap.subject} 지정보강일</td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="4">8주차</td>
    <td class="tg-baqh" colspan="11">${requestScope.subjectMap.subject} 중간고사</td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="4">9주차</td>
    <td class="tg-baqh" colspan="11">${requestScope.subjectMap.subject} 수업</td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="4">10주차</td>
    <td class="tg-baqh" colspan="11">${requestScope.subjectMap.subject} 수업</td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="4">11주차</td>
    <td class="tg-baqh" colspan="11">${requestScope.subjectMap.subject} 수업</td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="4">12주차</td>
    <td class="tg-baqh" colspan="11">${requestScope.subjectMap.subject} 수업</td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="4">13주차</td>
    <td class="tg-baqh" colspan="11">${requestScope.subjectMap.subject} 수업</td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="4">14주차</td>
    <td class="tg-baqh" colspan="11">${requestScope.subjectMap.subject} 수업</td>
  </tr>
  <tr>
    <td class="tg-amwm" colspan="4">15주차</td>
    <td class="tg-baqh" colspan="11">${requestScope.subjectMap.subject} 기말고사</td>
  </tr>
</tbody>
</table>
	
