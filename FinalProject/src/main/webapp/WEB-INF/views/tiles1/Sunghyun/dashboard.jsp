<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

<div id="maincontainer" style="display: flex;">
	<section style="width: 70%; margin-right: auto;">
		<h1>대시보드</h1>
		<hr>
		
		<div class="row mx-1">
			   <div class="card col-3 p-0" style="width: 16rem; box-shadow: 0px 1px 3px;">
				  <div style="width: 100%; height: 200px; background-color: orange;"></div>
				  <div class="card-body">
				    <h5 class="card-title">하이테크 마케팅</h5>
				    <p class="card-text">하이테크 마케팅_001분반</p>
				    <button type="button" class="btn btn-primary btn-md">강의실 입장</button>
				  </div>
			   </div>
		
			   <div class="card col-3 p-0" style="width: 16rem; box-shadow: 0px 1px 3px;">
				  <div style="width: 100%; height: 200px; background-color: green;"></div>
				  <div class="card-body">
				    <h5 class="card-title">빅데이터 실무</h5>
				    <p class="card-text">빅데이터 실무_002분반</p>
				    <button type="button" class="btn btn-primary btn-md">강의실 입장</button>
				  </div>
			   </div>
		
			   <div class="card col-3 p-0" style="width: 16rem; box-shadow: 0px 1px 3px;">
				  <div style="width: 100%; height: 200px; background-color: purple;"></div>
				  <div class="card-body">
				    <h5 class="card-title">재무관리실무</h5>
				    <p class="card-text">재무관리실무_003분반</p>
				    <button type="button" class="btn btn-primary btn-md">강의실 입장</button>
				  </div>
			   </div>
			   
			   <div class="card col-3 p-0" style="width: 16rem; box-shadow: 0px 1px 3px;">
				  <div style="width: 100%; height: 200px; background-color: gray;"></div>
				  <div class="card-body">
				    <h5 class="card-title">IT융합비즈니스 사례연구</h5>
				    <p class="card-text">IT융합비즈니스 사례연구_001분반</p>
				    <button type="button" class="btn btn-primary btn-md">강의실 입장</button>
				  </div>
			   </div>
		</div>
	</section>
	
	<section style="width: 30%; margin-top: 15px; margin-left: 15px;">
		<h3>To do</h3>
		<hr>
		<ul class="list-group list-group-flush" style="width: 80%;">
			  <li class="list-group-item icons"><i class="fas fa-bullhorn" ></i><span class="toDo">중간고사</span></li>
			  <li class="list-group-item icons"><i class="fas fa-paste"></i><span class="toDo">하이테크 마케팅_001분반_과제제출</span></li>
			  <li class="list-group-item icons"><i class="fas fa-paste"></i><span class="toDo">하이테크 마케팅_001분반_2주차 수업시청</span></li>
			  <li class="list-group-item icons"><i class="fas fa-paste"></i><span class="toDo">재무관리실무_001분반_수업시청</span></li>
		</ul>
		
		<h3 style="margin-top: 20px;">예정</h3>
		<hr>
		<ul class="list-group list-group-flush" style="width: 80%;">
			  <li class="list-group-item icons"><i class="fas fa-bullhorn" ></i><span class="toDo">기말고사</span></li>
			  <li class="list-group-item icons"><i class="fas fa-paste"></i><span class="toDo">하이테크 마케팅_001분반_3주차 수업시청</span></li>
			  <li class="list-group-item icons"><i class="fas fa-paste"></i><span class="toDo">하이테크 마케팅_001분반_4주차 수업시청</span></li>
			  <li class="list-group-item icons"><i class="fas fa-paste"></i><span class="toDo">재무관리실무_001분반_2주차 수업시청</span></li>
		</ul>
	</section>
</div>