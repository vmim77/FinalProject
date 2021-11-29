<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<!-- 원그래프  -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<!-- 막대그래프  -->
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>

<style type="text/css">

	.highcharts-figure,
	.highcharts-data-table table {
	    min-width: 320px;
	    max-width: 800px;
	    margin: 1em auto;
	}
	
	.highcharts-data-table table {
	    font-family: Verdana, sans-serif;
	    border-collapse: collapse;
	    border: 1px solid #ebebeb;
	    margin: 10px auto;
	    text-align: center;
	    width: 100%;
	    max-width: 500px;
	}
	
	.highcharts-data-table caption {
	    padding: 1em 0;
	    font-size: 1.2em;
	    color: #555;
	}
	
	.highcharts-data-table th {
	    font-weight: 600;
	    padding: 0.5em;
	}
	
	.highcharts-data-table td,
	.highcharts-data-table th,
	.highcharts-data-table caption {
	    padding: 0.5em;
	}
	
	.highcharts-data-table thead tr,
	.highcharts-data-table tr:nth-child(even) {
	    background: #f8f8f8;
	}
	
	.highcharts-data-table tr:hover {
	    background: #f1f7ff;
	}

	input[type="number"] {
	    min-width: 50px;
	}

	div#container{
		width:1200px;
		height:700px;
		margin:50px 0px 0px 200px;
		border:solid 1px #ffb84d;
		border-top:none;
	}
	
	div#menu{
		width:1200px;
		height:40px;
	}
	
	.tbl{
		width:1100px;
		height:600px;
		margin:25px 0px 0px 50px;
		border:solid 1px #ffb84d; 
	}
	
	td.top_td{
		border-bottom:solid 1px #ffd699;
		height:50px;
		background-color:#ffcc80;
	}
	
	td.bottom_td{
		height:550px;
	}
	
	.inp{
		width:150px;
		font-size:10pt;
		margin-left:20px;
	}

	.search{
		width:100px;
		margin-left:600px;
		border:solid 1px #ffb84d;
		background-color:white;
		font-size:10pt; 
		height:30px;
	}
	
	table#messageTable, table#sulmoonTable, table#serveyTable{
		width:1050px;
		margin:0px 0px 0px 20px;
		border:solid 1px #e68a00;
		height:500px;
	}
	
	.tl1{
		width:1050px;
		height:40px;
		background-color:#ff9900;
		border:solid 1px #e68a00;
	}

	.tl2{
		width:1050px;
		height:500px;
		border:solid 1px #e68a00;
	}
	
	.tl3{
		width:1050px;
		border:solid 1px #e68a00;
	}
	
	.topSelect{
		width:150px;
		margin-left:20px;
		font-size:10pt;
		border:solid 1px #e68a00;
	}
	
	.topButton{
		width:100px;
		height:25px;
		margin-left:15px;
		border:solid 1px #e68a00;
		background-color:white;
		font-size:10pt;
	}
	
	.overdiv{
		width:400px;
		height:415px;
		border:solid 1px #e68a00;
		margin:10px 0px 0px 25px;
	}
	
	.ul{
		font-size:11pt;
		margin-top:15px;
	}

	.goexcel{
		margin:30px 0px 10px 75px;
		background-color:white;
		border:solid 1px black;
		font-size:10pt;
	}
	
	.excelTable{
		font-size:10pt;
		border:solid 1px black;
		width:900px;
		margin:0px 0px 30px 75px;
		text-align:center;
	}
	
	.excelText{
		border:solid 1px black;
		background-color:#33ccff;
		height:40px;
		font-size:12pt;
	}
	
	.excelText2{
		width:75px;
		border:solid 1px black;
		height:33px;
		background-color:yellow;
		font-weight:bold;
		color:black;
		font-size:10pt;
	}
	
	.exceltd{
		border:solid 1px black;
		height:25px;	
	}
	
</style>

<script src= "<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		// 학과 클릭시 해당학과 교수님 불러오기
		$("select#deptCode").click(function(){
			
			var val = $(this).next().val();
			
			$.ajax({
				url:"<%= request.getContextPath()%>/TeacherList.univ",
				type:"POST",
				data:{"deptCode":$(this).val()},
				dataType:"JSON",
				success:function(json){

					var html = "";
					
  					$.each(json, function(index, item){

						html += "<option value='"+item.hakbun+"'>"+item.name+"</option>";

  					});//end of $.each(json, function(index, item){--------------------------------------					
  						
  					if(val == "servey"){  					
  						$("select#servey_teacher").html(html);
  						
  					}	
  					else{
  						$("select#message_teacher").html(html);
  					}	
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
				
			});//end of $.ajax({--------------------------------------------------------
			
		});//end of $("select#subject_fk_deptCode").click(function(){-------------------	
		
		////////////////////////////////////////////////////////////////////////////////
		
		// 담당 과목 가져오기
		
		$("select#servey_teacher").click(function(){
			
			$.ajax({
				url:"<%= request.getContextPath()%>/serveySubject.univ",
				type:"POST",
				data:{"fk_hakbun":$(this).val()},
				dataType:"JSON",
				success:function(json){
					
					var html = "";
					
  					$.each(json, function(index, item){

  						html += "<option value='"+item.code+"'>"+item.subject+"</option>";

  					});//end of $.each(json, function(index, item){--------------------------------------						
  					
  					$("select#servey_subject").html(html);	
  						
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
				
			});//end of $.ajax({--------------------------------------------------------
			
		});//end of $("select#servey_teacher").click(function(){------------------------
		
		////////////////////////////////////////////////////////////////////////////////
		
		$("table#serveyTable").hide();
		
		// 숨긴 테이블 보이기
		
		$("select#servey_subject").click(function(){
			if($(this).val() != null){
				$("table#serveyTable").show();		 
			}
		});//end of $("select#servey_subject").click(function(){------------------------
		
		////////////////////////////////////////////////////////////////////////////////
		
		// 차트 조회시
		
		$("button#serey_search").click(function(){
			
			// 먼저 비우기
			$("td#chart_container").empty();
			$("td#serveyMoonhang").empty();
			$("td#serveyBoonsuk").empty();
			
			var what = $("select#chechNum").val();
			
			// 전송용 값 넣기
			$("input#ExcelServeyNum").val(what);
			$("input#Excelfk_serveyCode").val($("select#servey_subject").val());
			
			// 차트제목
			var charttext = "";

			if(what == "4,5,6,7,11,12"){
				charttext = "교수 만족도 조사";
			}
			if(what == "2,3,8"){
				charttext = "강의자료 만족도 조사";
			}
			if(what == "1,9,10"){
				charttext = "강의 만족도 조사";
			}	
				
			$.ajax({
				url:"<%= ctxPath%>/checkNum.univ",
				type:"POST",
				dataType:"JSON",
				data:{"serveyNum":what,
					  "fk_serveyCode":$("select#servey_subject").val()},
				success:function(json){
					
					var resultArr = [];
						
					var obj1 = {name: "매우 만족",
						        y: Number(json.result5),
						   	 	sliced: true,
						   	 	selected: true};
					resultArr.push(obj1); // 배열속에 객체를 넣기
					
					var obj2 = {name: "만족",
						        y: Number(json.result4)};
					resultArr.push(obj2); // 배열속에 객체를 넣기
					
					var obj3 = {name: "보통",
						        y: Number(json.result3)};
					resultArr.push(obj3); // 배열속에 객체를 넣기
					
					var obj4 = {name: "불만족",
						       y: Number(json.result2)};
					resultArr.push(obj4); // 배열속에 객체를 넣기
					
					var obj5 = {name: "매우 불만족",
						        y: Number(json.result1)};
						
					resultArr.push(obj5); // 배열속에 객체를 넣기 

					////////////////////////////////////////////////////////////////////////////////
					
					Highcharts.chart('chart_container', {
					    chart: {
					        plotBackgroundColor: null,
					        plotBorderWidth: null,
					        plotShadow: false,
					        type: 'pie'
					    },
					    title: {
					        text: charttext
					    },
					    tooltip: {
					        pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
					    },
					    accessibility: {
					        point: {
					            valueSuffix: '%'
					        }
					    },
					    plotOptions: {
					        pie: {
					            allowPointSelect: true,
					            cursor: 'pointer',
					            dataLabels: {
					                enabled: true,
					                format: '<b>{point.name}</b>: {point.percentage:.2f} %'
					            }
					        }
					    },
					    series: [{
					        name: '만족도 비율',
					        colorByPoint: true,
					        data: resultArr
					    }]
					});

					////////////////////////////////////////////////////////////////////////////////
						
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
				
			});//end of $.ajax({---------------------------------------------------------------------
			
			/////////////////////////////////////////////////////////////////////////////////////////	
				
			// 평가문항 가져오기
			$.ajax({
				url:"<%= request.getContextPath()%>/pyungga.univ",
				type:"POST",
				data:{"fk_serveyCode":$("select#servey_subject").val()
					 ,"serveyNum":what},
				dataType:"JSON",
				success:function(json){
					
					var html = "<ul class='ul'>";
					var html2 = "<button id='saveExcel1' class='goexcel'>엑셀 저장</button>"
							   +"<table class='excelTable'>"
							   		+"<tr>"
										+"<td class='excelText' colspan='6'>평가결과</td>"
									+"</tr>"
									+"<tr>"
										+"<td class='excelText2' style='width:550px;'>평가문항</td>"
										+"<td class='excelText2'>매우만족</td>"
										+"<td class='excelText2'>만족</td>"
										+"<td class='excelText2'>보통</td>"
										+"<td class='excelText2'>불만족</td>"
										+"<td class='excelText2'>매우불만족</td>"
									+"</tr>";
									
					$.each(json, function(index, item){

						if(item.serveyNum == 4 || item.serveyNum == 5 || item.serveyNum == 6 || item.serveyNum == 7 || item.serveyNum == 11 || item.serveyNum == 12){
							html += "<li>문항"+item.serveyNum+"번 : "+item.name + " " +item.serveyContent+"</li>";
							html2 += "<tr>"
										+"<td class='exceltd' style='text-align:left; padding-left:5px;'>"+item.name + " " +item.serveyContent+"</td>"
										+"<td class='exceltd'>"+item.checkone+"</td>"
										+"<td class='exceltd'>"+item.checktwo+"</td>"
										+"<td class='exceltd'>"+item.checkthree+"</td>"
										+"<td class='exceltd'>"+item.checkfour+"</td>"
										+"<td class='exceltd'>"+item.checkfive+"</td>"
									+"</tr>";
						}
						else if(item.serveyNum == 2 || item.serveyNum == 3 || item.serveyNum == 8 || item.serveyNum == 10){
							html += "<li>문항"+item.serveyNum+"번 : "+item.subject + " " +item.serveyContent+"</li>";
							html2 += "<tr>"
										+"<td class='exceltd' style='text-align:left; padding-left:5px;'>"+item.subject + " " +item.serveyContent+"</td>"
										+"<td class='exceltd'>"+item.checkone+"</td>"
										+"<td class='exceltd'>"+item.checktwo+"</td>"
										+"<td class='exceltd'>"+item.checkthree+"</td>"
										+"<td class='exceltd'>"+item.checkfour+"</td>"
										+"<td class='exceltd'>"+item.checkfive+"</td>"
									+"</tr>";
						}
						else{
							html += "<li>문항"+item.serveyNum+"번 : "+item.serveyContent+"</li>";
							html2 += "<tr>"
										+"<td class='exceltd' style='text-align:left; padding-left:5px;'>"+item.serveyContent+"</td>"
										+"<td class='exceltd'>"+item.checkone+"</td>"
										+"<td class='exceltd'>"+item.checktwo+"</td>"
										+"<td class='exceltd'>"+item.checkthree+"</td>"
										+"<td class='exceltd'>"+item.checkfour+"</td>"
										+"<td class='exceltd'>"+item.checkfive+"</td>"
									+"</tr>";
						}

  					});//end of $.each(json, function(index, item){---------------------------------
  						
  					html += "</ul>";	
  					html2 += "</table>";	
  					
  					$("td#serveyMoonhang").html(html);
  					$("td#serveyBoonsuk").html(html2);

				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
				
			});//end of $.ajax({--------------------------------------------------------	
					
		});//end of $("button#serey_search").click(function(){------------------------------
		
		////////////////////////////////////////////////////////////////////////////////////
		
		// 엑셀 저장하기
		
		$(document).on("click", "#saveExcel1", function(){

			var frm = document.goExcelFrm;

         	frm.method = "POST";
         	frm.action = "<%= request.getContextPath()%>/excel/downloadExcelFile.univ"; 
         	frm.submit();
			
		});//end of $(document).on("click", "#saveExcel1", function(){----------------------
		
		////////////////////////////////////////////////////////////////////////////////////	

		// 설문내용 및 차트 불러오기
		
		$("button#sulmoon_search").click(function(){
			
			if($("select#sulmoonType").val() == ""){
				alert("검색조건을 선택 해주세요.");
			}
			else{

				// 먼저 비우기
				$("div#accordionExample").empty();
				
				// 설문 문항 가져오기
				$.ajax({
					url:"<%= ctxPath%>/sulmoonMoonhang.univ",
					type:"POST",
					dataType:"JSON",
					data:{"fk_serveyCode":$("select#sulmoon").val()},
					success:function(json){
						
						var html = "";
						
						$.each(json, function(index, item){
							
							html += "<div class='accordion-item'>"
										+"<h2 class='accordion-header' id='id"+item.firstID+"'>"
					      					+"<button class='accordion-button collapsed' type='button' data-bs-toggle='collapse' data-bs-target='#"+item.secondID+"' aria-expanded='false' aria-controls='"+item.secondID+"'>"
					      					+"문항 : " + item.serveyContent
					      					+"</button>"
					      					+"<input type='hidden' value='"+item.serveyNum+"' />"
					    				+"</h2>"
					    				+"<div id='"+item.secondID+"' class='accordion-collapse collapse' aria-labelledby='id"+item.firstID+"' data-bs-parent='#accordionExample'>"
					    					+"<div class='accordion-body'><div id='chart_container"+(index+2)+"'></div></div>"
					    				+"</div>"
					  				+"</div>";
				
						});//end of $.each(json, function(index, item){--------------------
	  					
	  					$("div#accordionExample").append(html);
						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
					
				});//end of $.ajax({--------------------------------------------------------
					
				////////////////////////////////////////////////////////////////////////////	
		
			}//end of if($("select#sulmoonType").val() == ""){------------------------------		
			
		});//end of $("button#sulmoon_search").click(function(){----------------------------
		
		////////////////////////////////////////////////////////////////////////////////////

		// 아코디언 버튼 클릭시
		
		$(document).on("click", ".accordion-button", function(){
			
			// 차트 먼저 지우기
			for(var i=2; i<=10; i++){
				$("div#chart_container"+i).empty();	
			}
			
			var serveyNum = $(this).next().val();
			
			var boonsukArr = [];
			var resultArr = new Array();
			
			// 설문분석대상 가져오기
			$.ajax({
				url:"<%= ctxPath%>/boonsuk.univ",
				type:"POST",
				dataType:"JSON",
				data:{"serveyNum":serveyNum},
				success:function(json){
					
					$.each(json, function(index, item){
						
						var obj = "";
						
						obj = item.boonsuk;
		
						boonsukArr.push(obj);

					});//end of $.each(json, function(index, item){--------------------

				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
				
			});//end of $.ajax({---------------------------------------------------------------------
				
			/////////////////////////////////////////////////////////////////////////////////////////
			
			// 설문분석결과 가져오기	
			$.ajax({
				url:"<%= ctxPath%>/boonsukChart.univ",
				type:"POST",
				dataType:"JSON",
				data:{"serveyNum":serveyNum,
					  "gijoon":$("select#sulmoonType").val()},
				success:function(json){
					
				    $.each(json, function(index, item){
				    	
				    	var arr = item.boonsuk.split(",").map(Number);
				    	
				    	var obj = {"name":item.gijoon, "data":arr};
				    	
				    	resultArr.push(obj);
				    
				    });//end of $.each(json, function(index, item){--------------------	
				
					Highcharts.chart('chart_container'+(serveyNum-2), {
					    chart: {
					        type: 'bar'
					    },
					    title: {
					        text: '설문조사 차트분석'
					    },
					    xAxis: {
					        categories: boonsukArr,
					        title: {
					            text: null
					        }
					    },
					    yAxis: {
					        min: 0,
					        title: {
					            text: '참여인원수 (명)',
					            align: 'high'
					        },
					        labels: {
					            overflow: 'justify'
					        }
					    },
					    tooltip: {
					        valueSuffix: ' millions'
					    },
					    plotOptions: {
					        bar: {
					            dataLabels: {
					                enabled: true
					            }
					        }
					    },
					    legend: {
					        layout: 'vertical',
					        align: 'right',
					        verticalAlign: 'top',
					        x: -40,
					        y: 80,
					        floating: true,
					        borderWidth: 1,
					        backgroundColor:
					            Highcharts.defaultOptions.legend.backgroundColor || '#FFFFFF',
					        shadow: true
					    },
					    credits: {
					        enabled: false
					    },
					    series: resultArr	
					});	
						
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
				
			});//end of $.ajax({---------------------------------------------------------------------	
				
		});//end of $(document).on("click", ".accordion-button", function(){----------------
		
		////////////////////////////////////////////////////////////////////////////////////	
			
		// 메인이동
		
		$("button#main").click(function(){
			
			var confrimflag = confirm("관리자 메인 페이지로 이동하시겠습니까?");
			
			if(confrimflag){
				location.href = "<%= ctxPath%>/adminIndex.univ";
			}
			
		});//end of $("button#main").click(function(){----------------------------------
		
	});//end of $(document).ready(function(){-----------------------------------------------

</script>

<form name="goExcelFrm">
	<input type="hidden" value="" name="serveyNum" id="ExcelServeyNum"/>
	<input type="hidden" value="" name="fk_serveyCode" id="Excelfk_serveyCode"/>
</form>

<div style="flex">
	<div id="container">
  		<%-- 상단 메뉴바 --%>
  		<nav>
		  	<div class="nav nav-tabs" id="nav-tab" role="tablist" style="border:solid 1px #ffb84d;">
		    	<button style="color:#ffb84d;" class="nav-link active" id="student" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">강의평가 결과분석</button>
		    	<button style="color:#ffb84d;" class="nav-link" id="teacher" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">설문조사 결과분석</button>
		    	<button style="color:#ffb84d;" class="nav-link" id="main" data-bs-toggle="tab" data-bs-target="#nav-contact4" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">메인이동</button>
			</div>
		</nav>
		
		<%-- 강의평가 결과분석 --%>
		<div class="tab-content" id="nav-tabContent">
		  	<%-- 학생정보 --%>
		  	<div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
		  		<table class="tbl">
		  			<tr>
		  				<td class="top_td">		  					
		  					<select class="inp" id="deptCode">
		  						<option value="no">학과 (전체)</option>
		  						
		  						<%-- 과 가져오기 --%>
		  						<c:forEach var="deptvo" items="${requestScope.deptList}">
		  							<option value="${deptvo.deptCode}">${deptvo.deptName}</option>
		  						</c:forEach>
		  						
		  					</select>
		  					<input type="hidden" value="servey"/>		  					
		  					<select class="inp" id="servey_teacher">	

		  					</select>
		  					<select class="inp" id="servey_subject">	

		  					</select>		  					  								
		  				</td>
		  			</tr>
		  			<tr>
		  				<td class="bottom_td">
		  					<div style="height:500px; overflow:auto;">
			  					<table id="serveyTable">
			  						<tr>
				  						<td class="tl1">
				  						 	<select id="chechNum" class="topSelect">
				  								<option value="1,2,3,4,5,6,7,8,9,10,11,12">전체 만족도</option>
				  								<option value="4,5,6,7,11,12">교수 만족도</option>
				  								<option value="2,3,8">강의자료 만족도</option>
				  								<option value="1,9,10">강의 만족도</option>
				  							</select>
				  							<button id="serey_search" class="topButton">조회</button>
				  						</td>
			  						</tr>
			  						<tr>
			  							<td id="chart_container" class="tl2"></td>
			  						</tr>
			  						<tr>
			  							<td class="tl1" style="text-align:center;">평가문항</td>
			  						</tr>
			  						<tr>
			  							<td id="serveyMoonhang" class="tl3"></td>
			  						</tr>
			  						<tr>
			  							<td class="tl1" style="text-align:center;">평가결과 자료</td>
			  						</tr>
			  						<tr>
			  							<td id="serveyBoonsuk" class="tl3"></td>
			  						</tr>
			  					</table>
		  					</div>
		  				</td>
		  			</tr>
		  		</table>
		  	</div>
		  			  	
		  	<%-- 설문조사 결과분석 --%>
		  	<div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
		  		<table class="tbl">
		  			<tr>
		  				<td class="top_td">		  					
		  					<select class="inp" id="sulmoon">
		  						<%-- 설문조사 가져오기 --%>
		  						<c:forEach var="serveyvo" items="${requestScope.serveyList}">
		  							<option value="${serveyvo.serveyCode}">${serveyvo.serveyTopic}</option>
		  						</c:forEach>
		  					</select>
		  					<select class="inp" id="sulmoonType">
		  						<option value="">검색조건</option>
		  						<option value="남자,여자">성별 결과보기</option>
		  						<option value="인문사회계열,이공계열">전공별 결과보기</option>
		  						<option value="1학년,2학년,3학년,4학년">학년별 결과보기</option>
		  					</select>
		  					<button id="sulmoon_search" class="topButton">조회</button>	  					  								
		  				</td>
		  			</tr>
		  			<tr>
		  				<td class="bottom_td">
		  					<div style="height:500px; overflow:auto;">
			  					<div class="accordion" id="accordionExample">

			  					</div>
		  					</div>
		  				</td>
		  			</tr>
		  		</table>
		  	</div>
		</div>
	</div>
</div>