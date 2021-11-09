<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">



</style>

<script type="text/javascript">

   $(document).ready(function(){

	
   });

</script>


<div class="container" style="margin-top:200px;">
	<div>
		<div class="btn" style=" border:1px solid #DDD; margin-bottom:15px;">Ξ 목록으로 돌아가기</div><div class="btn btn-secondary" style="display:inline-block; float:right;">학습 종료</div>
	</div>
	
	<table style="width:100%; margin-bottom:50px; font-size:10pt;">
		<tr style="border:0.7px solid #DDD; height:40px;">
			<td style="width:100px; text-align:center; border-right:0.7px solid #DDD;">
				<div class="dropdown">
				  <button class="btn dropdown-toggle" type="button" id="list" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false" style="box-shadow: none;">
				    목차
				  </button>
				  <div class="dropdown-menu" aria-labelledby="list">  <!-- aria-labelledby="dropdownMenuButton"이게 id값 맵핑 해준것!! -->
				    <a class="dropdown-item" href="#">1교시</a>
				    <a class="dropdown-item active" href="#">2교시</a>
				    <a class="dropdown-item" href="#">3교시</a>
				  </div>
				</div>
			</td>	
			<td style="text-align:right;  border-right:0.7px solid #DDD;">◁이전학습&nbsp;&nbsp;</td>
			<td style="text-align:left;">&nbsp;&nbsp;다음학습▷</td>
		</tr>
	</table>
	
	<div style="font-weight:bold; font-size:15pt; margin-bottom:15px;">
		<img src="<%= ctxPath%>/resources/images/재생버튼.png" style="width:30px;"> 빅데이터실무 01 주차- 1교시
	</div>
	
	<table style="width:100%; margin-bottom:15px; font-size:10pt; color:gray;">
		<tr style="border-top:0.7px solid #DDD; border-bottom:0.7px solid #DDD; height:40px;">
			<td >출석 마감일 9월 19일 오후 11:59</td>
			<td >지각 마감일 12월 17일 오후 11:59</td>
			<td >열람기간 8월 30일 오전 00:01~12월 17일 오후 11:59</td>
			<td>재생 시간 26분 26초</td>
		</tr>
	</table>
	<table style="width:100%; font-size:10pt;">
		<tr style="background-color:#ffe6e6; width:100%; height:40px;">
			<td style="width:100%; color:#ff4d4d; font-weight:bold; padding-left:10px;">※ 지각 인정 기간입니다.</td>
		</tr>
	</table>
	
	<img src="<%= ctxPath%>/resources/images/동영상캡처.png" style="width:1024px;">
	
	<div style="margin-top:30px; color:gray; margin-bottom:70px;">
	학습 진행 상태 : 26분 26초(100%) 
	<input type="checkbox"/><span style="color:#0066ff; margin-left:10px; margin-right:10px;">&nbsp;완료</span>
	<button style="background-color:#1a75ff; color:white; border-radius: 20px; border:none; font-size:9pt; width:50px; height:30px; margin-right:10px;">&nbsp;출석&nbsp;</button>
	<span class="btn" style=" border:1px solid #DDD; font-size:9pt;"><img src="<%= ctxPath%>/resources/images/새로고침.png" style="width:17px; ">&nbsp;학습상태 확인</span>
	</div>
	
	
	
	<div style="font-weight:bold; font-size:15pt; margin-bottom:15px;">
		<img src="<%= ctxPath%>/resources/images/요약본3.png" style="width:30px;"> 빅데이터실무 01 주차- 요약본
	</div>
	<table style="width:100%; margin-bottom:15px; font-size:10pt; color:gray;">
		<tr style="border-top:0.7px solid #DDD; border-bottom:0.7px solid #DDD; height:40px;">
			<td >출석 마감일 9월 19일 오후 11:59</td>
			<td >지각 마감일 12월 17일 오후 11:59</td>
			<td >열람기간 8월 30일 오전 00:01~12월 17일 오후 11:59</td>
			<td>배점 1점</td>
		</tr>
	</table>
	<table style="width:100%; font-size:10pt; margin-bottom:15px;">
		<tr style="background-color:#ffe6e6; width:100%; height:40px;">
			<td style="width:100%; color:#ff4d4d; font-weight:bold; padding-left:10px;">※ 지각 인정 기간입니다.</td>
		</tr>
	</table>
	
	<table style="width:100%; border:0.5px solid #DDD; margin-bottom:40px;">
		<tr style="background-color:#f2f2f2; height:60px;">
			<td><button style="display:inline-block; float:right; width:30px; background-color:#f2f2f2; border:0.5px solid #DDD; margin-right:10px;">⋮</button></td>
		</tr>
		<tr style="height:50px;">
			<td >
				<div style="width:99%; height:30px; background-color:#ccefff; border-radius:5px; margin:auto; font-size:10pt; padding-left:10px; padding-top:5px;"><span style="color:#008bcc; font-size:10pt; font-weight:bold;">채점대상 토론입니다.</span> : 1점 가능<div style="display:inline-block; float:right; margin-right:10px;">마감 9월 19일</div></div>
			</td>
		</tr>
		<tr>
			<td>
				<div><div style="display:inline-block; font-size:15pt;"><img src="<%= ctxPath%>/resources/images/회원사진.png" style="width:40px;">빅데이터실무 01 주차- 요약정리<br><span style="color:#1ab6ff; font-size:9pt;">운영자</span></div></div>
			</td>
		</tr>
		<tr style="height:200px;">
			<td>
				학습을 완료하셨습니까?
				<br>
				여러분의 학습여부를 댓글로 작성하여 주시길 바랍니다.
			</td>
		</tr>
		<tr>
			<td style="font-style:italic; font-size:9pt;">
			이 주제를 이재성이 편집함.
			</td>
		</tr>
		<tr>
			<td style="font-style:italic; font-size:9pt;">
			빅데이터 실무 요약정리.pptx
			</td>
		</tr>
		<tr style="height:50px; background-color:#f2f2f2;">
			<td>
			<input type="text" placeholder="항목이나 작성자 검색 " style="margin-left:10px;"/> <button class="btn" style="border:0.5px solid #DDD;">읽지 않은 메시지</button><div class="btn btn-success" style="display:inline-block; float:right; margin-right:20px;">Ｖ 구독함</div>
			</td>
		</tr>
	</table>
	
	
	
	<!-- 학생들 댓글 들어오는곳 -->
	<table style="width:100%; border:0.5px solid #DDD; margin-bottom:20px;">
		<tr style="height:100px;">
			<td rowspan="2" style="width:50px;  padding-left:10px;">
				<img src="<%= ctxPath%>/resources/images/회원사진.png" style="width:40px;">
			</td>
			<td style="font-size:10pt; padding-left:10px;">
				<br><span style="color:#0099ff;">이재성(123456)</span><br><span>2021-11-07</span>
			</td>
		</tr>
		<tr>
			<td>
				
			</td>
		</tr>
		<tr  style="height:100px;">
			<td colspan="2">
				수강완료.
			</td>
		</tr>
		<tr style="height:60px; border-top:0.5px solid #DDD;">
			<td colspan="2">
				<input type="text" placeholder="↖ 댓글작성" style="width:99%; border:0.5px solid #DDD; margin-left:5px; ">
			</td>
		</tr>
	</table>
	
	
	<table style="width:100%; border:0.5px solid #DDD;">
		<tr style="height:100px;">
			<td rowspan="2" style="width:50px;  padding-left:10px;">
				<img src="<%= ctxPath%>/resources/images/회원사진.png" style="width:40px;">
			</td>
			<td style="font-size:10pt; padding-left:10px;">
				<br><span style="color:#0099ff;">소녀장현걸(123456)</span><br><span>2021-11-07</span>
			</td>
		</tr>
		<tr>
			<td>
				
			</td>
		</tr>
		<tr  style="height:100px;">
			<td colspan="2">
				연약한 저는 수업이 너무 어렵습니다.
			</td>
		</tr>
		<tr style="height:60px; border-top:0.5px solid #DDD;">
			<td colspan="2">
				<input type="text" placeholder="↖ 댓글작성" style="width:99%; border:0.5px solid #DDD; margin-left:5px; ">
			</td>
		</tr>
	</table>
	
	



</div>