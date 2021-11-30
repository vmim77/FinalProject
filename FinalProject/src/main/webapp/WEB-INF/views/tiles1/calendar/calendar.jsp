<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>


<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<!-- jquery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- fullcalendar CDN -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>

<style>

/*
	.fc-header-toolbar > div:nth-child(1) {  .fc-scrollgrid-sync-inner
					margin: auto;
	}
*/
	.fc > .fc-button {
		background-color: #ffb84d;
	}
	
	.fc-prev-button {
		background-color: #ffb84d;
	}
	
	.fc-col-header-cell > div:nth-child(1) {
		background-color: #ffb84d;
	}
	
	.fc-scrollgrid-sync-inner > a:nth-child(1) {
		color: white;
	}
	
	.fc-direction-ltr .fc-button-group>.fc-button:not(:first-child) {
		background-color: #ffb84d;
	}
	
	.fc-direction-ltr .fc-button-group>.fc-button:not(:last-child) {
		background-color: #ffb84d;
	}
	
	#add-button {
		background-color: #ffb84d;
		color: white;
		padding: 0.4em 0.65em;
		font-size: 1em;
		line-height: 1.5;
		margin-right: 20px;
		border: solid 1px gray;
		    border-radius: 0.25em;
    border-top-left-radius: 0.25em;
    border-top-right-radius: 0.25em;
    border-bottom-right-radius: 0.25em;
    border-bottom-left-radius: 0.25em;
	}
	
</style>



<script>

	$(document).ready(function(){
		
		$(".fc-dayGridMonth-button").before("<button class='add-button' id='add-button'>일정 추가</button>");
		
		$(document).on('click','#add-button',function(){
			location.href="<%= ctxPath%>/calendarAdd.univ";
		});
	});
	
	

	document.addEventListener('DOMContentLoaded', function() {
		
		var resultArr = [];
		
		var obj = "";
		
		var title = "${requestScope.title}";
		var startDate = "${requestScope.startDate}";
		var endDate = "${requestScope.endDate}";
	
		var titleArr = title.split(",");
		var startDateArr = startDate.split(",");
		var endDateArr = endDate.split(",");
		
		for(var i=0; i<titleArr.length; i++){
			obj = {
					title: titleArr[i],
					start: startDateArr[i],
					end: endDateArr[i]
					}
			resultArr.push(obj);
			
		}
		
		
	
		
		var calendarEl = document.getElementById('calendar');
		
		var calendar = new FullCalendar.Calendar(calendarEl, {
			
			headerToolbar: {
				left: 'prev,next,today',									// 월별 보기
				center: 'title',											// 2021년 11월
				right : 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'	// 월별 보기, 주별 보기, 일별 보기, 일정목록 보기
			},
			
			initialView: 'dayGridMonth',	// 월별 보기
			navLinks: true,					// 날짜 클릭할 수 있게 해주는 것
			businessHours: true,			// 토,일 바탕색 변경
			locale: 'ko',					// 한국말로 출력하기
			editable: true,					// 이벤트 클릭할 수 있게 해주는 것
			
			events: resultArr
		});
		
		calendar.render();
	});
	
</script>

<div id='calendar' style="position: relative;"></div>
