<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<style type="text/css">

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
		margin-left:150px;
		border:solid 1px #ffb84d;
		background-color:white;
		font-size:10pt; 
		height:30px;
	}
	
	table#studentTablelist, table#teacherTablelist, table#subjectTablelist{
		width:1050px;
		margin:0px 0px 0px 20px;
		border:solid 1px #ffb84d;
	}
	
	.pageBar{
		border:solid 1px #ffb84d;
		font-size:11pt;
		width:200px;
		margin-right:10pt;
	}

	.modalbtn{
		border:solid 1px gray;
		width:70px;
		height:30px;
		background-color:#ccefff;
	}
	
	.modalbtn2{
		margin-left:20px;
		width:100px;
		height:30px;
		border:solid 1px #ffb84d;
		background-color:#ffb84d;
		font-size:10pt;
		color:white;
	}

	.modaltd{
		border:solid 1px #ffb84d;
		width:240px;
	}

	.submitbtn{
		border:solid 1px #ffb84d;
		width:70px;
		height:30px;
		background-color:#ccefff;
		font-size:11pt;
	}
	
	.madal_input{
		width:280px;
		border:solid 1px gray;
		color:green;
	}
	
	.modal_button{
		width:60px;
		height:25px;
		border:solid 1px gray;
		background-color:#ccefff;
		font-size:9pt;
		margin-left:10pt;
	}
	
	.v{
		font-size:9pt;
		color:green;
		margin-left:10pt;
	}

	.scheduleTable{
		width:420px;
		height:200px;
		margin:15px 0px 15px 18px;
		border:solid 1px #ffb84d;
		text-align:center;
		font-size:10pt;
	}
	
	.scheduleWeek{
		 width:84px;
		 border:solid 1px #ffb84d;
		 height:30px;
	}
	
	.scheduleTd{
		border:solid 1px #ffb84d;
	}
	.scheduleDiv{
		background-color:#f3ccff;
		height:80px;
		padding-top:30px;
		margin:2px 0px 2px 0px;
	}
	
	.jungongBtn{
		border:solid 1px #ffb84d;
		background-color:white;
		font-size:10pt;
		text-align:center;
		margin-left:20px;
		width:110px;
		height:25px;
	}
	
	.jungongBottom{
		height:350px;
		width:525px;
	}
	
	.jungongScheduleTable{
		margin-left:23px;
		height:350px;
		width:500px;
		text-align:center;
		border:solid 1px #ffb84d;
	}
	
	.jungongSchedule{
		width:100px;
		font-size:11pt;
		height:30px;
		border:solid 1px #ffb84d;
	}
	
	.jgbtn{
		margin-left:25px;
		width:100px;
		height:30px;
		border:solid 1px #ffb84d;
		font-size:10pt;
	}
	
	.subj{
		border:solid 1px #ffb84d;
		background-color:#f5f5f0;
		width:400px;
		height:40px;
		font-size:11pt;
		margin:15px 0px 15px 50px;
	}
	
	.weekdiv{
		width:80px;
		border:solid 1px #ffb84d;
		background-color:#f5f5f0;
		height:70px;
		text-align:center;
		font-size:10pt;
		padding:20px 0px 0px 0px;
		margin:0px 0px 10px 8px;
	}
	
	.x{
		text-align:right;
		font-size:10pt;
		width:80px;
		border:solid 1px #ffb84d;
		background-color:#f5f5f0;
		margin-left:8px;
		border-bottom:none;
		padding-right:5px;
	}
	
	.memberBtn{
		width:80px;
		height:24px;
		border:solid 1px #ffb84d;
		background-color:white;
		font-size:9pt;
		margin:10px 0px 10px 10px;
	}
	
</style>

<script src= "<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		// 저장 수정버튼 초기에 숨기기
		$("button#update").hide();
		$("button#save").hide();
		
		// 학생조회 클릭시
		$("button#Search_student").click(function(){

			// 검색타입을 선택했는데 검색어 미 입력시
			if($("select#studentSearchType").val() != "no" && $("input#studentSearchWord").val() == ""){
				
				$("table#studentTablelist").html(""); // 항상 테이블 내용 지우고 시작하기	
				alert("검색어를 입력해주세요");			  // 메시지	
				$("input#studentSearchWord").focus(); // 포커스잡기
			}
			else{
				
				$.ajax({
					url:"<%= request.getContextPath()%>/memberList.univ",
					type:"POST",
					data:{"status":$("select#studentStatus").val()
						 ,"fk_deptCode":$("select#studentFk_deptCode").val()
						 ,"searchType":$("select#studentSearchType").val()
						 ,"searchWord":$("input#studentSearchWord").val()
						 ,"authority":"0"},
					dataType:"JSON",
					success:function(json){
						
						// 항상 테이블 내용 지우고 시작하기
						$("table#studentTablelist").html("");	
						
						var html = "<tr style='height:35px; text-align:center; background-color:#ccf3ff; font-size:11pt;'>"
							   		+"<td style='border:solid 1px gray; width:250px;'>성명</td>"
									+"<td style='border:solid 1px gray; width:250px;'>재적상태</td>"
		  							+"<td style='border:solid 1px gray; width:250px;'>학번</td>"
		  							+"<td style='border:solid 1px gray; width:250px;'>학과</td>"
		  							+"<td style='border:solid 1px gray; width:100px;'>상세보기</td>"
		  						   +"</tr>";
		  				
		  				// 검색된 데이터가 있는경우		   
		  				if(json.length > 0) {
							
		  					$.each(json, function(index, item){
	
								// 상태 가져오기
								var itemStatus = item.status;
								
								if(itemStatus == 0){
									status = "등록예정";
								}
								else if(itemStatus == 1){
									status = "재학";
								}
								else if(itemStatus == 2){
									status = "휴학";
								}
								else if(itemStatus == 3){
									status = "자퇴";
								}
								else{
									status = "졸업";
								}
								
								html += "<tr style='text-align:center; font-size:10pt;'>"
		  									+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+item.name+"</td>"
				  							+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+status+"</td>"
				  							+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+item.hakbun+"</td>"
				  							+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+item.fk_deptCode+"</td>"
				  							+"<td style='border:solid 1px gray; height:45px; width:100px;'>"
				  								+"<button type='button' id='memberBtn' class='modalbtn' data-bs-toggle='modal' data-bs-target='#information'>보기</button>"
				  								/* 모달을 위해 값 잠시 넣어주기 */
				  								+"<input type='hidden' value='"+item.picture+"'/>"
				  								+"<input type='hidden' value='"+item.name+"'/>"
				  								+"<input type='hidden' value='"+item.birth+"'/>"
				  								+"<input type='hidden' value='"+item.phone+"'/>"
				  								+"<input type='hidden' value='"+item.email+"'/>"
				  								+"<input type='hidden' value='"+item.hakbun+"'/>"
				  								+"<input type='hidden' value='"+item.fk_deptCode+"'/>"
				  								+"<input type='hidden' value='"+item.address+"'/>"
				  								+"<input type='hidden' value='"+item.authority+"'/>"
				  							+"</td>"
			  							+"</tr>";
	
		  					});//end of $.each(json, function(index, item){--------------------------------------
	  									
							$("table#studentTablelist").html(html);	
							
						}//end of if(json.length > 0) {--------------------------------------------------
								
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({--------------------------------------------------------
			
			}//end of if($("select#studentSearchType").val() != "no" && $("input#studentSearchWord").val() == ""){	
				
		});//end of $("button#Search_student").click(function(){------------------------

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
			
		// 교수조회 클릭시
		$("button#Search_teacher").click(function(){

			// 검색타입을 선택했는데 검색어 미 입력시
			if($("select#teacherSearchType").val() != "no" && $("input#teacherSearchWord").val() == ""){
				
				$("table#teacherTablelist").html(""); // 항상 테이블 내용 지우고 시작하기
				alert("검색어를 입력해주세요");			  // 메시지	
				$("input#teacherSearchWord").focus(); // 포커스잡기
			}
			else{
			
				$.ajax({
					url:"<%= request.getContextPath()%>/memberList.univ",
					type:"POST",
					data:{"status":$("select#teacherStatus").val()
						 ,"fk_deptCode":$("select#teacherFk_deptCode").val()
						 ,"searchType":$("select#teacherSearchType").val()
						 ,"searchWord":$("input#teacherSearchWord").val()
						 ,"authority":"1"},
					dataType:"JSON",
					success:function(json){
						
						// 항상 테이블 내용 지우고 시작하기
						$("table#teacherTablelist").html("");	
						
						var html = "<tr style='height:35px; text-align:center; background-color:#ccf3ff; font-size:11pt;'>"
					   				+"<td style='border:solid 1px gray; width:250px;'>성명</td>"
									+"<td style='border:solid 1px gray; width:250px;'>재적상태</td>"
									+"<td style='border:solid 1px gray; width:250px;'>학번</td>"
									+"<td style='border:solid 1px gray; width:250px;'>학과</td>"
									+"<td style='border:solid 1px gray; width:100px;'>상세보기</td>"
							   	  +"</tr>";
		  				
		  				// 검색된 데이터가 있는경우		   
		  				if(json.length > 0) {
							
		  					$.each(json, function(index, item){
	
								// 상태 가져오기
								var itemStatus = item.status;
								
								if(itemStatus == 0){
									status = "등록예정";
								}
								else if(itemStatus == 1){
									status = "재학";
								}
								else if(itemStatus == 2){
									status = "휴가";
								}
								else if(itemStatus == 4){
									status = "종료";
								}
								
								html += "<tr style='text-align:center; font-size:10pt;'>"
										+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+item.name+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+status+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+item.hakbun+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+item.fk_deptCode+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:100px;'>"
			  								+"<button type='button' id='memberBtn' class='modalbtn' data-bs-toggle='modal' data-bs-target='#information'>보기</button>"
			  								/* 모달을 위해 값 잠시 넣어주기 */
			  								+"<input type='hidden' value='"+item.picture+"'/>"
			  								+"<input type='hidden' value='"+item.name+"'/>"
			  								+"<input type='hidden' value='"+item.birth+"'/>"
			  								+"<input type='hidden' value='"+item.phone+"'/>"
			  								+"<input type='hidden' value='"+item.email+"'/>"
			  								+"<input type='hidden' value='"+item.hakbun+"'/>"
			  								+"<input type='hidden' value='"+item.fk_deptCode+"'/>"
			  								+"<input type='hidden' value='"+item.address+"'/>"
			  								+"<input type='hidden' value='"+item.authority+"'/>"
			  							+"</td>"
		  							+"</tr>";
	
		  					});//end of $.each(json, function(index, item){--------------------------------------				
	  									
							$("table#teacherTablelist").html(html);	
							
						}//end of if(json.length > 0) {--------------------------------------------------
								
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({--------------------------------------------------------
			
			}//end of if($("select#teacherSearchType").val() != "no" && $("input#teacherSearchWord").val() == ""){
					
		});//end of $("button#Search_student").click(function(){------------------------	
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
		// 과목조회 클릭시
		$("button#Search_subject").click(function(){
	
			// 검색타입을 선택했는데 검색어 미 입력시
			if($("select#subjectSearchType").val() != "no" && $("input#subjectSearchWord").val() == ""){
				
				$("table#subjectTablelist").html(""); // 항상 테이블 내용 지우고 시작하기	
				alert("검색어를 입력해주세요");			  // 메시지
				$("input#subjectSearchWord").focus(); // 포커스잡기
			}
			else{
			
				$.ajax({
					url:"<%= request.getContextPath()%>/subjectList.univ",
					type:"POST",
					data:{"classDate":$("select#classDate").val()
						 ,"fk_deptCode":$("select#subjectFk_deptCode").val()
						 ,"searchType":$("select#subjectSearchType").val()
						 ,"searchWord":$("input#subjectSearchWord").val()},
					dataType:"JSON",
					success:function(json){
						
						// 항상 테이블 내용 지우고 시작하기
						$("table#subjectTablelist").html("");	
						
						var html = "<tr style='height:35px; text-align:center; background-color:#ccf3ff; font-size:11pt;'>"
					   				+"<td style='border:solid 1px gray; width:260px;'>과목명</td>"
									+"<td style='border:solid 1px gray; width:200px;'>담당교수</td>"
									+"<td style='border:solid 1px gray; width:160px;'>이수학점</td>"
									+"<td style='border:solid 1px gray; width:160px;'>수업요일</td>"
									+"<td style='border:solid 1px gray; width:260px;'>학과명</td>"
									+"<td style='border:solid 1px gray; width:160px;'>과목정보수정</td>"
							   	  +"</tr>";
		  				
		  				// 검색된 데이터가 있는경우		   
		  				if(json.length > 0) {
							
		  					$.each(json, function(index, item){
	
								html += "<tr id='studentList' style='text-align:center; font-size:10pt;'>"
										+"<td style='border:solid 1px gray; height:45px; width:260px;'>"+item.subject+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:260px;'>"+item.fk_hakbun+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:160px;'>"+item.hakjum+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:160px;'>"+item.classDate+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:260px;'>"+item.fk_deptCode+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:160px;'>"
			  								+"<button type='button' class='modalbtn2' id='Input_subject' data-bs-toggle='modal' data-bs-target='#Input_subjectList'>정보수정</button>"
			  								+"<input type='hidden' value='update'/>"
			  								+"<input type='hidden' value='"+item.code+"'/>"
			  								+"<input type='hidden' value='"+item.subject+"'/>"
			  							+"</td>"
		  							+"</tr>";
	
		  					});//end of $.each(json, function(index, item){--------------------------------------					
	  									
							$("table#subjectTablelist").html(html);	
							
						}//end of if(json.length > 0) {--------------------------------------------------
								
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({--------------------------------------------------------
			
			}//end of if($("select#subjectSearchType").val() != "no" && $("input#subjectSearchWord").val() == ""){		
					
		});//end of $("button#Search_student").click(function(){------------------------	
			
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
		
		// 회원 상세보기 버튼 클릭시
		$(document).on("click","button#memberBtn",function(){

			var picture = "<img src='resources/images/"+$(this).next().val()+"' style='width:240px; height:280px;'/>";
			$("td#picture").html(picture); // 사진넣기
			$("td#name").text($(this).next().next().val()); // 이름넣기
			$("td#birth").text($(this).next().next().next().val()); // 생일넣기
			$("td#phone").text($(this).next().next().next().next().val()); // 연락처넣기
			$("td#email").text($(this).next().next().next().next().next().val()); // 이메일넣기	 
			$("td#hakbun").text($(this).next().next().next().next().next().next().val()); // 학번넣기
			$("input#hiddenHakbun").val($(this).next().next().next().next().next().next().val()); // 수정용 학번넣기
			$("td#deptname").text($(this).next().next().next().next().next().next().next().val()); // 과명넣기
			$("td#address").text($(this).next().next().next().next().next().next().next().next().val()); // 주소넣기		
			
			var authority = $(this).next().next().next().next().next().next().next().next().next().val(); // 신분
			
			var html = "";
			
			// 학생이면
			if(authority == 0){	
				html = "<option value='0'>등록예정</option>"
					  +"<option value='1'>재학</option>"
					  +"<option value='2'>휴학</option>"
					  +"<option value='3'>자퇴</option>"
					  +"<option value='4'>졸업</option>";
			}
			// 교수님이면
			else{
				html = "<option value='0'>등록예정</option>"
					  +"<option value='1'>재학</option>"
					  +"<option value='2'>휴가</option>"
					  +"<option value='4'>종료</option>";
			}
			
			// 옵션 값 넣기		  
			$("select#status").html(html);
			
		});//end of $(document).on("click","button#memberBtn",function(){---------------	
			
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////		
					
        // status 수정 시
        $("button#updateStatus").click(function(){
        	
        	$.ajax({
				url:"<%= request.getContextPath()%>/updateStatus.univ",
				type:"POST",
				data:{"hakbun":$(this).next().val()
					 ,"status":$("select#status").val()},
				dataType:"JSON",
				success:function(json){
					
					if(json.n > 0){
						alert("입력 되었습니다");		
					}

				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
				
			});//end of $.ajax({----------------------------------------------------
        	
        });//end of  $("button#updateStatus").click(function(){------------------------
        					
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////							
        					
		// 학생등록시
		$("button#membersubmit").click(function(){
		
			var flag = true;
			
			var alerthtml = "";
			
			// 학번 입력시
			if($("input#student_hakbun").val() == ""){
				flag = false;
				alerthtml += "학번 입력, ";		
			}			
			// 학번 조회시
			if($("span#stdv").text() != "v"){
				flag = false;
				alerthtml += "학번 검토, ";
			}
			// 이름 입력시
			if($("input#student_name").val() == ""){
				flag = false;
				alerthtml += "학생 이름 입력, ";		
			}
			if($("input#student_email").val() == ""){
				flag = false;
				alerthtml += "이메일 입력";		
			}

			if(alerthtml != ""){
				alert(alerthtml + " 부탁드립니다");
			}
						
			if(flag == true){
				
				$.ajax({
					url:"<%= request.getContextPath()%>/updateMember.univ",
					type:"POST",
					data:{"hakbun":$("input#student_hakbun").val()
						 ,"fk_deptCode":$("select#student_fk_deptCode").val()
						 ,"name":$("input#student_name").val()
						 ,"email":$("input#student_email").val()
						 ,"authority":"0"},
					dataType:"JSON",
					success:function(json){
						if(json.n > 0){
							alert("입력 되었습니다");		
						}
						// 비우기
						$("input#student_hakbun").val("");
						$("select#student_fk_deptCode").val("no");
						$("input#student_name").val("");
						$("input#student_email").val("");
						$("span#stdv").text("");
						$("td#stderrmsg").text("");
					},
					error: function(request, status, error){
						alert("중복된 이메일 입니다. 다시 확인해주세요");		
				 	}
					
				});//end of $.ajax({----------------------------------------------------
				
			}//end of if(flag == true){-------------------------------------------------
						
		});//end of $("button#membersubmit").click(function(){--------------------------
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// 학생 학번 조회
		$("button#CheckStudentHakbun").click(function(){
			
			// 우선 비워주기
			$("td#stderrmsg").text("");
			
			// 올바른 학번이 아닌경우
			if($("input#student_hakbun").val().length != 7 || $("input#student_hakbun").val() == "" || !($("input#student_hakbun").val()*1 > 0)){
				alert("학번은 7자리 숫자로만 입력 해주세요");
				$("td#stderrmsg").text("");
			}
			else{
				
				$.ajax({
					url:"<%= request.getContextPath()%>/selecthakbun.univ",
					type:"POST",
					data:{"hakbun":$("input#student_hakbun").val()},
					dataType:"JSON",
					success:function(json){
						
						// 검색된 데이터가 있는경우		   
		  				if(json.checkHakbun == "cannot") {
		  					$("td#stderrmsg").text("이미 존재하는 학번입니다");
		  					$("span#stdv").text("");
		  				}
		  				else{
		  					$("span#stdv").text("v");
		  					$("td#stderrmsg").text("사용가능한 학번입니다");
		  				}//end of if(json.length > 0) {---------------------------------
						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({----------------------------------------------------
			
			}//end of if($("input#student_hakbun").val().length != 7 || $("input#student_hakbun").val() == "" || !($("input#student_hakbun").val()*1 > 0)){
				
		});//end of $("button#CheckStudentHakbun").click(function(){--------------------
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		
		// 전공등록 및 수정 모달창 닫으면 값 지워주기
		
		$("button#closeBtn").click(function(){
			
			$("input#subject_code").val("");
			$("input#subject_subject").val("");
			$("select#subjectTeacher_fk_hakbun").val("");
			$("select#subject_hakjum").html("<option value=''>학점</option><option value='2'>2</option><option value='3'>3</option>");
			$("select#subject_classDate").val("");
			$("td#suberrmsg").html("");
			$("td.scheduleTd").html("");
			$("h5#staticBackdropLabel").text("전공등록");
			$("input#checkUpdate").val("");
			
		});//end of $("button#closeBtn").click(function(){-----------------------------------------------------------
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// 교수님 등록시
		$("button#teachersubmit").click(function(){
		
			var flag = true;
			
			var alerthtml = "";
			
			// 학번 입력시
			if($("input#teacher_hakbun").val() == ""){
				flag = false;
				alerthtml += "학번 입력, ";		
			}			
			// 학번 조회시
			if($("span#teav").text() != "v"){
				flag = false;
				alerthtml += "학번 검토, ";
			}
			// 이름 입력시
			if($("input#teacher_name").val() == ""){
				flag = false;
				alerthtml += "교수 이름 입력, ";		
			}
			if($("input#teacher_email").val() == ""){
				flag = false;
				alerthtml += "이메일 입력";		
			}

			if(alerthtml != ""){
				alert(alerthtml + " 부탁드립니다");
			}
			
			if(flag == true){
				
				$.ajax({
					url:"<%= request.getContextPath()%>/updateMember.univ",
					type:"POST",
					data:{"hakbun":$("input#teacher_hakbun").val()
						 ,"fk_deptCode":$("select#teacher_fk_deptCode").val()
						 ,"name":$("input#teacher_name").val()
						 ,"email":$("input#teacher_email").val()
						 ,"authority":"1"},
					dataType:"JSON",
					success:function(json){
						if(json.n > 0){
							alert("입력 되었습니다");		
						}
						// 비우기
						$("input#teacher_hakbun").val("");
						$("select#teacher_fk_deptCode").val("no");
						$("input#teacher_name").val("");
						$("input#teacher_email").val("");
						$("span#teav").text("");
						$("td#teaerrmsg").text("");
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({----------------------------------------------------
				
			}//end of if(flag == true){------------------------------------------------
			
		});//end of $("button#teachersubmit").click(function(){-------------------------
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// 교수님 학번 조회
		$("button#CheckTeacherHakbun").click(function(){
			
			// 우선 비워주기
			$("td#teaerrmsg").text("");
			
			// 올바른 학번이 아닌경우
			if($("input#teacher_hakbun").val().length != 7 || $("input#teacher_hakbun").val() == "" || !($("input#teacher_hakbun").val()*1 > 0)){
				alert("학번은 7자리 숫자로만 입력 해주세요");
				$("td#teaerrmsg").text("");
			}
			else{
				
				$.ajax({
					url:"<%= request.getContextPath()%>/selecthakbun.univ",
					type:"POST",
					data:{"hakbun":$("input#teacher_hakbun").val()},
					dataType:"JSON",
					success:function(json){
						
						// 검색된 데이터가 있는경우		   
		  				if(json.checkHakbun == "cannot") {
		  					$("td#teaerrmsg").text("이미 존재하는 학번입니다");
		  					$("span#teav").text("v");
		  				}
		  				else{
		  					$("span#teav").text("v");
		  					$("td#teaerrmsg").text("사용가능한 학번입니다");
		  				}//end of if(json.length > 0) {---------------------------------
						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({----------------------------------------------------
			
			}//end of if($("input#teacher_hakbun").val().length != 7 || $("input#teacher_hakbun").val() == "" || !($("input#teacher_hakbun").val()*1 > 0)){
				
		});//end of $("button#CheckTeacherHakbun").click(function(){--------------------
			
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		
		// 전공 등록시
		$("button#subjectsubmit").click(function(){
		
			var flag = true;
			
			var alerthtml = "";
			
			// 과목코드 입력시
			if($("input#subject_code").val() == ""){
				flag = false;
				alerthtml += "과목코드, ";	
			}
			// 과목코드 조회시
			if($("span#subv1").text() != "v"){
				flag = false;
				alerthtml += "과목코드 조회, ";	
			}
			// 과목명 미입력시
			if($("input#subject_subject").val() == ""){
				flag = false;
				alerthtml += "과목명 입력, ";	
			}
			// 과목명 미 조회시
			if($("span#subv2").text() != "v"){
				flag = false;
				alerthtml += "과목명 조회, ";	
			}
			// 담당교수 시간표 조회시
			if($("span#subv3").text() != "v"){
				flag = false;
				alerthtml += "담당교수 시간표 조회, ";	
			}
			// 학점 선택시
			if($("select#subject_hakjum").val() == ""){
				flag = false;
				alerthtml += "학점선택, ";	
			}
			// 요일 선택시
			if($("select#subject_classDate").val() == ""){
				flag = false;
				alerthtml += "수업일자 선택";	
			}
			
			if(alerthtml != ""){
				alert(alerthtml + "부탁드립니다");
			}
					
			if(flag == true){
				
				$.ajax({
					url:"<%= request.getContextPath()%>/updateSubject.univ",
					type:"POST",
					data:{"code":$("input#subject_code").val()
						 ,"subject":$("input#subject_subject").val()
						 ,"fk_deptCode":$("select#subject_fk_deptCode").val()
						 ,"fk_hakbun":$("select#subjectTeacher_fk_hakbun").val()
						 ,"hakjum":$("select#subject_hakjum").val()
						 ,"classDate":$("select#subject_classDate").val()
						 ,"checkUpdate":$("input#checkUpdate").val()},
					dataType:"JSON",
					success:function(json){
						if(json.n == 1){
							alert("전공정보가 입력 되었습니다");		
						}
						if(json.n == 2){
							alert("전공정보가 수정 되었습니다");		
						}
						// 비우기
						$("input#subject_code").val("");
						$("input#subject_subject").val("");
						$("span#subv1").text("");
						$("span#subv2").text("");
						$("span#subv3").text("");
						$("td#suberrmsg").text("");
						$("td#mon").html("");
						$("td#tue").html("");
						$("td#wed").html("");
						$("td#thu").html("");
						$("td#fri").html("");
						$("select#subject_fk_deptCode").val("01");
						$("select#subjectTeacher_fk_hakbun").html("");
						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({----------------------------------------------------
				
			}//end of if(flag == true){-------------------------------------------------
			
		});//end of $("button#teachersubmit").click(function(){-------------------------
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// 과목코드 조회
		$("button#CheckSubjectCode").click(function(){
			
			// 올바른 학번이 아닌경우
			if($("input#subject_code").val().length != 4 || $("input#subject_code").val() == "" || !($("input#subject_code").val()*1 > 0)){
				alert("학번코드는 4자리 숫자로만 입력 해주세요");
				$("td#suberrmsg").text("");
			}
			else{
				
				$.ajax({
					url:"<%= request.getContextPath()%>/selectcode.univ",
					type:"POST",
					data:{"code":$("input#subject_code").val()},
					dataType:"JSON",
					success:function(json){
						
						// 검색된 데이터가 있는경우		   
		  				if(json.checkCode == "cannot") {
		  					$("td#suberrmsg").text("이미 존재하는 학과코드입니다");
		  					$("span#subv1").text("");
		  				}
		  				else{
		  					$("span#subv1").text("v");
		  					$("td#suberrmsg").text("사용가능한 학과코드 입니다");
		  				}//end of if(json.length > 0) {---------------------------------
						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({----------------------------------------------------
			
			}//end of if($("input#teacher_hakbun").val().length != 4 || $("input#teacher_hakbun").val() == "" || !($("input#teacher_hakbun").val()*1 > 0)){
				
		});//end of $("button#CheckSubjectCode").click(function(){--------------------	
			
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// 과목명 조회
		$("button#CheckSubjectSubject").click(function(){
			
			// 입력을 안했다면
			if($("input#subject_subject").val() == ""){
				alert("과목명을 입력 해주세요.")
			}
			else{
			
				$.ajax({
					url:"<%= request.getContextPath()%>/selectsubject.univ",
					type:"POST",
					data:{"subject":$("input#subject_subject").val()},
					dataType:"JSON",
					success:function(json){
						
						// 검색된 데이터가 있는경우		   
		  				if(json.checkSubject == "cannot") {
		  					$("td#suberrmsg").text("이미 존재하는 과목명입니다");
		  					$("span#subv2").text("");
		  				}
		  				else{
		  					$("span#subv2").text("v");
		  					$("td#suberrmsg").text("사용가능한 과목명 입니다");
		  				}//end of if(json.length > 0) {---------------------------------
						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({------------------------------------------------------
				
			}//end of if($("input#subject_subject").val() == ""){-------------------------		
			
		});//end of $("button#CheckSubjectCode").click(function(){------------------------		
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// 학과 클릭시 해당학과 교수님 불러오기
		$("select#subject_fk_deptCode").click(function(){
	
			// 다른사람 시간표도 조회해야 하니 지워준다
			$("span#subv3").text("");
			
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
  							
  					$("select#subjectTeacher_fk_hakbun").html(html);	
  						
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
				
			});//end of $.ajax({--------------------------------------------------------
			
		});//end of $("select#subject_fk_deptCode").click(function(){-------------------	
		
		////////////////////////////////////////////////////////////////////////////////	
		
		// 교수 시간표 조회해오기		
		$("button#CheckSubjectTeacher").click(function(){

			// 요일선택 지워주기
			$("select#subject_classDate").html("");
			$("span#subv3").text("v");
			
			// 우선 비워주기
			$("td#mon").html("");
			$("td#tue").html("");
			$("td#wed").html("");
			$("td#thu").html("");
			$("td#fri").html("");
			
			$.ajax({
				url:"<%= request.getContextPath()%>/TeacherScheduleList.univ",
				type:"POST",
				data:{"fk_hakbun":$("select#subjectTeacher_fk_hakbun").val()},
				dataType:"JSON",
				success:function(json){
					
					// 넣어줄 시간표
					var monHtml = "";
					var tueHtml = "";
					var wedHtml = "";
					var thuHtml = "";
					var friHtml = "";
					
					// 몇개의 시간표가 있는지 확인용
					var monCnt = 0;
					var tueCnt = 0;
					var wedCnt = 0;
					var thuCnt = 0;
					var friCnt = 0;
					
  					$.each(json, function(index, item){
						
  						// 월요일에 스케줄이있다면
						if(item.classDate == 1){
							monHtml += "<div class='scheduleDiv'>"+item.subject+"</div>";
							monCnt++;
						}
						// 화요일에 스케줄이있다면
						else if(item.classDate == 2){
							tueHtml += "<div class='scheduleDiv'>"+item.subject+"</div>";
							tueCnt++;
						}
						// 수요일에 스케줄이있다면
						else if(item.classDate == 3){
							wedHtml += "<div class='scheduleDiv'>"+item.subject+"</div>";
							wedCnt++;
						}
						// 목요일에 스케줄이있다면
						else if(item.classDate == 4){
							thuHtml += "<div class='scheduleDiv'>"+item.subject+"</div>";
							thuCnt++;
						}
						// 금요일에 스케줄이있다면
						else {
							friHtml += "<div class='scheduleDiv'>"+item.subject+"</div>";
							friCnt++;
						}

  					});//end of $.each(json, function(index, item){--------------------------------------						
  						
  					$("td#mon").html(monHtml);
  					$("td#tue").html(tueHtml);
  					$("td#wed").html(wedHtml);
  					$("td#thu").html(thuHtml);
  					$("td#fri").html(friHtml);

  					var optHtml = "";
  					
					// 요일 선택 넣어주기
  					if(monCnt < 2)
  						optHtml += "<option value='1'>월</option>";
  					if(tueCnt < 2)
  						optHtml += "<option value='2'>화</option>";
  					if(wedCnt < 2)
  						optHtml += "<option value='3'>수</option>";
  					if(thuCnt < 2)
  						optHtml += "<option value='4'>목</option>";
  					if(friCnt < 2)
  						optHtml += "<option value='5'>금</option>";
  					
  					$("select#subject_classDate").html(optHtml);	
  						
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
				
			});//end of $.ajax({--------------------------------------------------------
			
		});//end of $("button#CheckSubjectTeacher").click(function(){------------------
		
		///////////////////////////////////////////////////////////////////////////////
		
		// 과 선택시 들어간 내용 지워주기
		$("select#jungong_deptCode").click(function(){
			
			// 인원선택 먼저 비워주기
			$("select#jungong_nomember").html("<option value=''>수강미신청 인원</option>");
			$("select#jungong_yesmember").html("<option value=''>수강신청완료 인원</option>");
			
			// 미신청 인원 알아오기
			$.ajax({
				url:"<%= request.getContextPath()%>/sugangNoMember.univ",
				type:"POST",
				data:{"fk_deptCode":$("select#jungong_deptCode").val()},
				dataType:"JSON",
				success:function(json){
					
					var html = "<option value=''>수강미신청 인원</option>";
					
					$.each(json, function(index, item){

						html += "<option value='"+item.hakbun+"'>"+item.name+"</option>";

  					});//end of $.each(json, function(index, item){--------------------------------------
  						
  					$("select#jungong_nomember").html(html);	
  						
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
				
			});//end of $.ajax({--------------------------------------------------------
			
			///////////////////////////////////////////////////////////////////////////////////////////////	
				
			// 신청 인원 알아오기
			$.ajax({
				url:"<%= request.getContextPath()%>/sugangYesMember.univ",
				type:"POST",
				data:{"fk_deptCode":$("select#jungong_deptCode").val()},
				dataType:"JSON",
				success:function(json){
					
					var html = "<option value=''>수강신청완료 인원</option>";
					
					$.each(json, function(index, item){

						html += "<option value='"+item.hakbun+"'>"+item.name+"</option>";

  					});//end of $.each(json, function(index, item){--------------------------------------
  						
  					$("select#jungong_yesmember").html(html);	
  						
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
				
			});//end of $.ajax({--------------------------------------------------------
			
			///////////////////////////////////////////////////////////////////////////////////////////////	
			
			// 해당과의 수업목록
			$.ajax({
				url:"<%= request.getContextPath()%>/sugangSubject.univ",
				type:"POST",
				data:{"fk_deptCode":$("select#jungong_deptCode").val()},
				dataType:"JSON",
				success:function(json){
					
					var html = "";
					
					$.each(json, function(index, item){
						
						html += "<button value='"+item.code+"' class='subj'>"+item.subject+"</button><input type='hidden' value='"+item.classDate+"' />";

  					});//end of $.each(json, function(index, item){--------------------------------------
  						
  					$("div#in").html(html);	
  						
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
				
			});//end of $.ajax({--------------------------------------------------------	
				
		});//end of $("select#jungong_deptCode").click(function(){----------------------
		
		// 하루 2과목 추가를 위한 카운트 ==> 지역변수방지 : 전체삭제시 카운트를 내려주기 위함
		var cnt1 = 0;
		var cnt2 = 0;
		var cnt3 = 0;
		var cnt4 = 0;
		var cnt5 = 0;	
			
		////////////////////////////////////////////////////////////////////////////////
		
		// 과목클릭시
		$(document).on("click", ".subj", function(){
			
			// 과목명
			var subject = $(this).text();
			// 과목코드
			var code = $(this).val();
			// 무슨요일 수업인지 알아오기 ( 과목선택시 해당과목 리스트에서 지워주기 위해 가져옴 )
			var cdate = $(this).next().val();
			
			// 두과목이 꽉차기 전까지는 해당과목 리스트에서 지워주기
			if("cnt"+cdate == "cnt1" && cnt1 != 2){
				$(this).remove();
			}
			if("cnt"+cdate == "cnt2" && cnt2 != 2){
				$(this).remove();
			}
			if("cnt"+cdate == "cnt3" && cnt3 != 2){
				$(this).remove();
			}
			if("cnt"+cdate == "cnt4" && cnt4 != 2){
				$(this).remove();
			}
			if("cnt"+cdate == "cnt5" && cnt5 != 2){
				$(this).remove();
			}

			// 무슨요일인지 알아오기
			$.ajax({
				url:"<%= request.getContextPath()%>/subjectClassDate.univ",
				type:"POST",
				data:{"code":$(this).val()},
				dataType:"JSON",
				success:function(json){
					
					// 가져온 요일이 무슨요일인지
					if(json.classDate == '1'){						
						cnt1++;
						if(cnt1 !=3){
							$("td#jungong_mon").append("<div class='x'>x</div><div class='weekdiv'>"+subject+"</div><input type='hidden' value='"+json.classDate+"' /><input type='hidden' value='"+code+"' />");				
		  					$("input#submit_code").val($("input#submit_code").val() + code + ","); // 전송용을 위해 값 넣어주기
						}
					}
					if(cnt1 == 3){
						alert("하루 최대 2과목까지만 신청 가능합니다.");
						cnt1=2;
					}
				
					if(json.classDate == '2'){						
						cnt2++;
						if(cnt2 !=3){
							$("td#jungong_tue").append("<div class='x'>x</div><div class='weekdiv'>"+subject+"</div><input type='hidden' value='"+json.classDate+"' /><input type='hidden' value='"+code+"' />");				
							$("input#submit_code").val($("input#submit_code").val() + code + ","); // 전송용을 위해 값 넣어주기
						}
					}
					if(cnt2 == 3){
						alert("하루 최대 2과목까지만 신청 가능합니다.");
						cnt2=2;
					}
					
					if(json.classDate == '3'){						
						cnt3++;
						if(cnt3 !=3){
							$("td#jungong_wed").append("<div class='x'>x</div><div class='weekdiv'>"+subject+"</div><input type='hidden' value='"+json.classDate+"' /><input type='hidden' value='"+code+"' />");				
							$("input#submit_code").val($("input#submit_code").val() + code + ","); // 전송용을 위해 값 넣어주기
						}
					}
					if(cnt3 == 3){
						alert("하루 최대 2과목까지만 신청 가능합니다.");
						cnt3=2;
					}
					
					if(json.classDate == '4'){						
						cnt4++;
						if(cnt4 !=3){
							$("td#jungong_thu").append("<div class='x'>x</div><div class='weekdiv'>"+subject+"</div><input type='hidden' value='"+json.classDate+"' /><input type='hidden' value='"+code+"' />");				
							$("input#submit_code").val($("input#submit_code").val() + code + ","); // 전송용을 위해 값 넣어주기
						}
					}
					if(cnt4 == 3){
						alert("하루 최대 2과목까지만 신청 가능합니다.");
						cnt4=2;
					}
					
					if(json.classDate == '5'){						
						cnt5++;
						if(cnt5 !=3){
							$("td#jungong_fri").append("<div class='x'>x</div><div class='weekdiv'>"+subject+"</div><input type='hidden' value='"+json.classDate+"' /><input type='hidden' value='"+code+"' />");				
							$("input#submit_code").val($("input#submit_code").val() + code + ","); // 전송용을 위해 값 넣어주기
						}
					}
					if(cnt5 == 3){
						alert("하루 최대 2과목까지만 신청 가능합니다.");
						cnt5=2;
					}
					
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
				
			});//end of $.ajax({--------------------------------------------------------
			
		});//end of $("button.subj").click(function(){----------------------------------
		
		////////////////////////////////////////////////////////////////////////////////
		
		// 과목지우기 클릭시
		$(document).on("click", ".x", function(){
			
			// 해당 요일과목 카운트 내리기
			if($(this).next().next().val() == 1){
				cnt1--;
			}	
			if($(this).next().next().val() == 2){
				cnt2--;
			}
			if($(this).next().next().val() == 3){
				cnt3--;
			}
			if($(this).next().next().val() == 4){
				cnt4--;
			}
			if($(this).next().next().val() == 5){
				cnt5--;
			}
			
			var subject = $(this).next().text(); 		    // 과목명
			var classDate = $(this).next().next().val();    // 수업요일
			var code = $(this).next().next().next().val();  // 과목코드
			
			// 전송용을 위해 담아줬던 값 지워주기		
			var text = $("input#submit_code").val().replace(code+",", "");
			$("input#submit_code").val(text);
			// 과목지우면 해당과목 다시 넣어주기
			var html = "<button value='"+code+"' class='subj'>"+subject+"</button><input type='hidden' value='"+classDate+"' />";
			
			$("div#in").append(html);	
			
			$(this).next().remove();
			$(this).remove();
			
		});//end of $(document).on("click", ".subj", function(){------------------------
			
		////////////////////////////////////////////////////////////////////////////////
		
		// 학생추가 클릭시
		$("button#memberAdd").click(function(){
			
			// 학생 선택 후 추가하게 하기
			if($("select#jungong_nomember").val() == ""){
				alert("미신청 학생 선택 후 추가를 눌러주세요");
			}
			else{
			
				// 수정학생과 등록학생은 겹치면 안되기 때문에
				if($("input#update_hakbun").val() != ""){
					$("div#inMember").html("");
				}
				
				$("button#update").hide();
				$("button#save").show();
				
				// 신청학생 때 불러왔던 값들 다 비워주기
				// 시간표
				$("td#jungong_mon").html("");
				$("td#jungong_tue").html("");
				$("td#jungong_wed").html("");
				$("td#jungong_thu").html("");
				$("td#jungong_fri").html("");
				
				// 하루 2과목 추가를 위한 카운트
				cnt1 = 0;
				cnt2 = 0;
				cnt3 = 0;
				cnt4 = 0;
				cnt5 = 0;
				
				// 과목 다시 가져오므로 전송과목 지우기
				$("input#submit_code").val("");
				
				// 수정학생 담겨있던 값 지우기
				$("input#update_hakbun").val("");
				
				// 해당과의 수업목록 다시 가져오기
				$.ajax({
					url:"<%= request.getContextPath()%>/sugangSubject.univ",
					type:"POST",
					data:{"fk_deptCode":$("select#jungong_deptCode").val()},
					dataType:"JSON",
					success:function(json){
						
						var html = "";
						
						$.each(json, function(index, item){
							
							html += "<button value='"+item.code+"' class='subj'>"+item.subject+"</button><input type='hidden' value='"+item.classDate+"' />";
	
	  					});//end of $.each(json, function(index, item){--------------------------------------
	  						
	  					$("div#in").html(html);	
	  						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({--------------------------------------------------------
				
				// 전공신청자 셀렉트 벨류 바꿔주기
				$("select#jungong_yesmember").val("");
				
				// 우선 추가를 했었던 학생인지 구별 해야함
				
				// 추가를 했었더라면
				if($("select#jungong_nomember").val() != "" && $("input#submit_hakbun").val().indexOf($("select#jungong_nomember").val()) != -1){
					alert("이미 추가 된 학생입니다.");
				}
				else{
				
					// 해당학생 학번을 넘겨 이름 및 학번 가져오기
					$.ajax({
						url:"<%= request.getContextPath()%>/searchNoMember.univ",
						type:"POST",
						data:{"hakbun":$("select#jungong_nomember").val()},
						dataType:"JSON",
						success:function(json){
							
							var html = "";
							
							$.each(json, function(index, item){
								
								html = "<button class='memberBtn' value='"+item.hakbun+"'>"+item.name+"&nbsp;&nbsp;X</button>";
		
			  					// 전송용을 위해 값 넣어주기
			  					$("input#submit_hakbun").val($("input#submit_hakbun").val() + item.hakbun + ",");
								
		  					});//end of $.each(json, function(index, item){--------------------------------------				
								
		  					// 넣어주기
		  					$("div#inMember").append(html);	
		  						
						},
						error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					 	}
						
					});//end of $.ajax({--------------------------------------------------------
				
				}//end of if($("input#submit_hakbun").val().indexOf($("select#jungong_nomember").val()) != -1){
			
			}//end of if($("select#jungong_nomember").val() == ""){-----------------------------	
				
		});//end of $("button#memberAdd").click(function(){-------------------------------------
		
		////////////////////////////////////////////////////////////////////////////////////////	
			
		// 선택학생 목록에서 지우기
		
		$(document).on("click", ".memberBtn", function(){
			
			var hakbun = $(this).val();
			// 전송용을 위해 담아줬던 값 지워주기		
			var text1 = $("input#submit_hakbun").val().replace(hakbun+",", "");
			$("input#submit_hakbun").val(text1);
			
			// 전공신청자를 선택 후 삭제를 눌렀을 때
			if($("input#update_hakbun").val() != ""){

				// 시간표 비우기
				$("div#in").html("");  
				$("td#jungong_mon").html("");  
				$("td#jungong_tue").html("");
				$("td#jungong_wed").html("");
				$("td#jungong_thu").html("");
				$("td#jungong_fri").html("");
				
				// 전송할 값들 지우기
				$("input#submit_hakbun").val("");
				$("input#update_hakbun").val("");
				$("input#submit_code").val("");
				
				// 하루 2과목 추가를 위한 카운트
				cnt1 = 0;
				cnt2 = 0;
				cnt3 = 0;
				cnt4 = 0;
				cnt5 = 0;
			}
			
			$(this).remove();
			
			if($("div#inMember").html() == ""){
				$("button#update").hide();
				$("button#save").hide();
			}
			
		});//end of $(document).on("click", ".memberBtn", function(){-----------------------
		
		///////////////////////////////////////////////////////////////////////////////////////
		
		// 선택된 학생 전체 목록 지우기
		
		$("button#memberDelete").click(function(){
			
			$("button#update").hide();
			$("button#save").hide();
			
			// 학생목록 지우기
			$("div#inMember").html("");     		
			
			// 시간표 비우기
			$("div#in").html("");  
			$("td#jungong_mon").html("");  
			$("td#jungong_tue").html("");
			$("td#jungong_wed").html("");
			$("td#jungong_thu").html("");
			$("td#jungong_fri").html("");
			
			// 전송할 값들 지우기
			$("input#submit_hakbun").val("");
			$("input#update_hakbun").val("");
			$("input#submit_code").val("");
			
			// 하루 2과목 추가를 위한 카운트
			cnt1 = 0;
			cnt2 = 0;
			cnt3 = 0;
			cnt4 = 0;
			cnt5 = 0;	
			
		});//end of $("button#omemberDelete").click(function(){---------------------------------
		
		////////////////////////////////////////////////////////////////////////////////////////	
		
		// 전체 학생 추가시
		
		$("button#allmemberAdd").click(function(){
		
			// 가져온 전체학생이 없을 경우 시간표 추가 방지를 위한 변수
			var cnt = 0;
			
			$("button#update").hide();
			$("button#save").show();
			
			// 학생목록 지우기
			$("div#inMember").html("");     		
			// 시간표 비우기
			$("div#in").html("");  
			$("td#jungong_mon").html("");  
			$("td#jungong_tue").html("");
			$("td#jungong_wed").html("");
			$("td#jungong_thu").html("");
			$("td#jungong_fri").html("");
			
			// 전송할 값들 지우기
			$("input#submit_hakbun").val("");
			$("input#submit_code").val("");
			$("input#update_hakbun").val("");
			
			// 미신청 인원 알아와서 목록에 넣어주기
			$.ajax({
				url:"<%= request.getContextPath()%>/sugangNoMember.univ",
				type:"POST",
				data:{"fk_deptCode":$("select#jungong_deptCode").val()},
				dataType:"JSON",
				success:function(json){
					
					var html = "";
					
					$.each(json, function(index, item){

						html += "<button class='memberBtn' value='"+item.hakbun+"'>"+item.name+"&nbsp;&nbsp;X</button>";
						
	  					// 전송용을 위해 값 넣어주기
	  					$("input#submit_hakbun").val($("input#submit_hakbun").val() + item.hakbun + ",");
						
	  					cnt++;
	  					
  					});//end of $.each(json, function(index, item){--------------------------------------
  						
  					$("div#inMember").html(html);	
  						
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
				
			});//end of $.ajax({----------------------------------------------------------------
				
			if(cnt > 0){	
				
				// 해당과의 수업목록 다시 가져오기
				$.ajax({
					url:"<%= request.getContextPath()%>/sugangSubject.univ",
					type:"POST",
					data:{"fk_deptCode":$("select#jungong_deptCode").val()},
					dataType:"JSON",
					success:function(json){
						
						var html = "";
						
						$.each(json, function(index, item){
							
							html += "<button value='"+item.code+"' class='subj'>"+item.subject+"</button><input type='hidden' value='"+item.classDate+"' />";

	  					});//end of $.each(json, function(index, item){--------------------------------------
	  						
	  					$("div#in").html(html);	
	  						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({--------------------------------------------------------
			
			}
			else{
			
				alert("수강 미 신청자가 더이상 없습니다.");
				$("input#submit_hakbun").val("");
				$("button#update").hide();
				$("button#save").hide();
				
			}//end of if(cnt > 0){--------------------------------------------------------------
				
		});//end of $("button#allmemberAdd").click(function(){----------------------------------
		
		////////////////////////////////////////////////////////////////////////////////////////
		
		// 전공정보 저장
		
		$("button#save").click(function(){
			
			// 입력을 다 했는지 확인
			if( $("input#submit_hakbun").val() != "" && $("input#submit_code").val() != "") {
			
				$.ajax({
					url:"<%= request.getContextPath()%>/saveSugang.univ",
					type:"POST",
					data:{"hakbun":$("input#submit_hakbun").val()
						 ,"code":$("input#submit_code").val()},
					dataType:"JSON",
					success:function(json){
						if(json.n > 0){
							alert("수강신청 완료 되었습니다.");		
						}
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({----------------------------------------------------
			
			}
			else{

				alert("과목 및 학생 입력 확인 부탁 드립니다.");	
				
			}//end of if( $("input#submit_hakbun").val() != "" && $("input#submit_code").val() != "") {
				
			// 보내주고 전송용 값 비워주기
			
			// 학생목록 지우기
			$("div#inMember").html("");     		
			// 시간표 비우기
			$("div#in").html("");  
			$("td#jungong_mon").html("");  
			$("td#jungong_tue").html("");
			$("td#jungong_wed").html("");
			$("td#jungong_thu").html("");
			$("td#jungong_fri").html("");
			
			// 전송할 값들 지우기
			$("input#submit_hakbun").val("");
			$("input#submit_code").val("");
			
			// 하루 2과목 추가를 위한 카운트
			cnt1 = 0;
			cnt2 = 0;
			cnt3 = 0;
			cnt4 = 0;
			cnt5 = 0;			
					
		});//end of $("button#save").click(function(){------------------------------------------
		
		////////////////////////////////////////////////////////////////////////////////////////
		
		// 전공신청자 데이터 가져오기
		
		$("select#jungong_yesmember").click(function(){
		
			if($("select#jungong_deptCode").val() != "no" && $(this).val() != ""){
				$("button#update").show();
			}
			
			$("button#save").hide();
			
			// 전송용 값 넣어주기
			$("input#update_hakbun").val($(this).val());
			
			// 학생을 선택 했는지 확인
			if($("select#jungong_yesmember").val() != ""){
			
				// 값 비워주기
				// 학생목록 지우기
				$("div#inMember").html("");     		
				// 시간표 비우기
				$("div#in").html("");  
				$("td#jungong_mon").html("");  
				$("td#jungong_tue").html("");
				$("td#jungong_wed").html("");
				$("td#jungong_thu").html("");
				$("td#jungong_fri").html("");
				
				// 전송할 값들 지우기
				$("input#submit_hakbun").val("");
				$("input#submit_code").val("");
				
				// 하루 2과목 추가를 위한 카운트
				cnt1 = 0;
				cnt2 = 0;
				cnt3 = 0;
				cnt4 = 0;
				cnt5 = 0;	
				
				// 시간표 및 과목 가져오기	 ( 단 수강듣지 않는 과목은 따로 가져온다 )	
				$.ajax({
					url:"<%= request.getContextPath()%>/SelectSugangMember.univ",
					type:"POST",
					data:{"hakbun":$("select#jungong_yesmember").val()},
					dataType:"JSON",
					success:function(json){
						
						var html = ""; // 학생선택
						
						$.each(json, function(index, item){
	
							html = "<button class='memberBtn' value='"+item.hakbun+"'>"+item.name+"&nbsp;&nbsp;X</button>";
							
							// 가져온 요일이 무슨요일인지
							if(item.classDate == '1'){						
								cnt1++;
								if(cnt1 !=3){
									$("td#jungong_mon").append("<div class='x'>x</div><div class='weekdiv'>"+item.subject+"</div><input type='hidden' value='"+item.classDate+"' /><input type='hidden' value='"+item.code+"' />");				
				  					$("input#submit_code").val($("input#submit_code").val() + item.code + ","); // 전송용을 위해 값 넣어주기
								}
							}
							if(cnt1 == 3){
								alert("하루 최대 2과목까지만 신청 가능합니다.");
								cnt1=2;
							}
						
							if(item.classDate == '2'){						
								cnt2++;
								if(cnt2 !=3){
									$("td#jungong_tue").append("<div class='x'>x</div><div class='weekdiv'>"+item.subject+"</div><input type='hidden' value='"+item.classDate+"' /><input type='hidden' value='"+item.code+"' />");				
									$("input#submit_code").val($("input#submit_code").val() + item.code + ","); // 전송용을 위해 값 넣어주기
								}
							}
							if(cnt2 == 3){
								alert("하루 최대 2과목까지만 신청 가능합니다.");
								cnt2=2;
							}
							
							if(item.classDate == '3'){						
								cnt3++;
								if(cnt3 !=3){
									$("td#jungong_wed").append("<div class='x'>x</div><div class='weekdiv'>"+item.subject+"</div><input type='hidden' value='"+item.classDate+"' /><input type='hidden' value='"+item.code+"' />");				
									$("input#submit_code").val($("input#submit_code").val() + item.code + ","); // 전송용을 위해 값 넣어주기
								}
							}
							if(cnt3 == 3){
								alert("하루 최대 2과목까지만 신청 가능합니다.");
								cnt3=2;
							}
							
							if(item.classDate == '4'){						
								cnt4++;
								if(cnt4 !=3){
									$("td#jungong_thu").append("<div class='x'>x</div><div class='weekdiv'>"+item.subject+"</div><input type='hidden' value='"+item.classDate+"' /><input type='hidden' value='"+item.code+"' />");				
									$("input#submit_code").val($("input#submit_code").val() + item.code + ","); // 전송용을 위해 값 넣어주기
								}
							}
							if(cnt4 == 3){
								alert("하루 최대 2과목까지만 신청 가능합니다.");
								cnt4=2;
							}
							
							if(item.classDate == '5'){						
								cnt5++;
								if(cnt5 !=3){
									$("td#jungong_fri").append("<div class='x'>x</div><div class='weekdiv'>"+item.subject+"</div><input type='hidden' value='"+item.classDate+"' /><input type='hidden' value='"+item.code+"' />");				
									$("input#submit_code").val($("input#submit_code").val() + item.code + ","); // 전송용을 위해 값 넣어주기
								}
							}
							if(cnt5 == 3){
								alert("하루 최대 2과목까지만 신청 가능합니다.");
								cnt5=2;
							}
							
							// 전송용을 위해 값 넣어주기
		  					$("input#submit_hakbun").val(item.hakbun + ",");
		  					// 넣어주기
		  					$("div#inMember").html(html);
							
	  					});//end of $.each(json, function(index, item){--------------------------------------				
		
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({------------------------------------------------------------
					
				// 수강하지 않는 과목 가져와서 값 넣어주기
				$.ajax({
					url:"<%= request.getContextPath()%>/sugangNoSubject.univ",
					type:"POST",
					data:{"hakbun":$("select#jungong_yesmember").val()},
					dataType:"JSON",
					success:function(json){
						
						var html = "";
						
						$.each(json, function(index, item){
							
							html += "<button value='"+item.code+"' class='subj'>"+item.subject+"</button><input type='hidden' value='"+item.classDate+"' />";
	
	  					});//end of $.each(json, function(index, item){--------------------------------------
	  						
	  					$("div#in").html(html);	
	  						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
				
				});//end of $.ajax({--------------------------------------------------------
			
			}//end of if($("select#jungong_yesmember").val() == ""){----------------------------
				
		});//end of $("button#memberUpdate").click(function(){----------------------------------
		
		////////////////////////////////////////////////////////////////////////////////////////
		
		// 업데이트 하기
		
		$("button#update").click(function(){
			
			$.ajax({
				url:"<%= request.getContextPath()%>/UpdateSugang.univ",
				type:"POST",
				data:{"hakbun":$("input#update_hakbun").val()
					 ,"code":$("input#submit_code").val()},	 
				dataType:"JSON",
				success:function(json){				
					alert("수강 정보변경 성공");					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
				
			});//end of $.ajax({----------------------------------------------------
				
			// 보내주고 전송용 값 비워주기
			
			// 학생목록 지우기
			$("div#inMember").html("");     		
			// 시간표 비우기
			$("div#in").html("");  
			$("td#jungong_mon").html("");  
			$("td#jungong_tue").html("");
			$("td#jungong_wed").html("");
			$("td#jungong_thu").html("");
			$("td#jungong_fri").html("");
			
			// 전송할 값들 지우기
			$("input#submit_hakbun").val("");
			$("input#update_hakbun").val("");
			$("input#submit_code").val("");
			
			// 하루 2과목 추가를 위한 카운트
			cnt1 = 0;
			cnt2 = 0;
			cnt3 = 0;
			cnt4 = 0;
			cnt5 = 0;		
			
			$(this).hide();
					
		});//end of $(document).on("click", "#update", function(){
			
		////////////////////////////////////////////////////////////////////////////////////////
		
		// 전공 수정 시작
		
		// 전공 모달창 열기 클릭시
		$(document).on("click", "#Input_subject", function(){
			
			if($(this).next().val() == "update"){
				
				$("h5#staticBackdropLabel").text("전공수정");
				var code = $(this).next().next().val();
				var subject = $(this).next().next().next().val();
				
				$("input#subject_code").val(code);
				$("input#subject_subject").val(subject);
				
				$("input#checkUpdate").val("update");
				
			}//end of if($(this).next().val() == "update"){------------------------------------
			
		});//end of $(document).on("click", "#Input_subject", function(){----------------------
		
		///////////////////////////////////////////////////////////////////////////////////////	
			
		// 평가분석 이동하기	
			
		$("button#servey").click(function(){
			
			var confrimflag = confirm("설문조사 페이지로 이동하시겠습니까?");
			
			if(confrimflag){
				
				var frm = document.no;
				
				frm.method = "POST";
				frm.action = "<%= ctxPath%>/adminChart.univ";
				frm.submit();
				 
			}
			
		});//end of $("button#servey").click(function(){---------------------------------------	
			
		///////////////////////////////////////////////////////////////////////////////////////	
		
		// 쪽지함 이동하기	
			
		$("button#jjokji").click(function(){
			
			var confrimflag = confirm("쪽지함 페이지로 이동하시겠습니까?");
			
			if(confrimflag){

				var frm = document.no;
				
				frm.method = "POST";
				frm.action = "<%= ctxPath%>/adminJjokji.univ";
				frm.submit();
				
			}
			
		});//end of $("button#jjokji").click(function(){----------------------------------------		
			
	});//end of $(document).ready(function(){---------------------------------------------------
	
</script>

<div style="flex">
	<div id="container">
  		<%-- 상단 메뉴바 --%>
  		<nav>
  			<form name="no">
			  	<div class="nav nav-tabs" id="nav-tab" role="tablist" style="border:solid 1px #ffb84d;">
			    	<button style="color:#ffb84d;" class="nav-link active" id="student" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">학생정보</button>
			    	<button style="color:#ffb84d;" class="nav-link" id="teacher" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">교사정보</button>
			    	<button style="color:#ffb84d;" class="nav-link" id="subject" data-bs-toggle="tab" data-bs-target="#nav-contact" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">전공정보</button>
			    	<button style="color:#ffb84d;" class="nav-link" id="sugang" data-bs-toggle="tab" data-bs-target="#nav-contact2" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">수강신청</button>
			    	<button style="color:#ffb84d;" class="nav-link" id="servey" data-bs-toggle="tab" data-bs-target="#nav-contact3" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">평가분석</button>
			    	<button style="color:#ffb84d;" class="nav-link" id="jjokji" data-bs-toggle="tab" data-bs-target="#nav-contact4" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">쪽지함</button>
				</div>
			</form>
		</nav>
		
		<%-- 하단 내용 --%>
		<div class="tab-content" id="nav-tabContent">
		  	<%-- 학생정보 --%>
		  	<div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
		  		<table class="tbl">
		  			<tr>
		  				<td class="top_td">
		  					<select class="inp" id="studentStatus">
		  						<option value="no">재적상태 (전체)</option>
		  						<option value="0">미등록</option>
		  						<option value="1">재학</option>
		  						<option value="2">휴학</option>
		  						<option value="3">자퇴</option>
		  						<option value="4">졸업</option>
		  					</select>		  					
		  					<select class="inp" id="studentFk_deptCode">
		  						<option value="no">학과 (전체)</option>
		  						
		  						<%-- 과 가져오기 --%>
		  						<c:forEach var="deptvo" items="${requestScope.deptList}">
		  							<option value="${deptvo.deptCode}">${deptvo.deptName}</option>
		  						</c:forEach>
		  						
		  					</select>		  					
		  					<select class="inp" id="studentSearchType">
		  						<option value="no">조회명 (전체)</option>
		  						<option value="hakbun">학번조회</option>
		  						<option value="name">이름조회</option>
		  						<option value="phone">연락처조회</option>
		  					</select>		  					
		  					<input class="inp" type="text" id="studentSearchWord" autocomplete="off"/>		  					
		  					<button class="search" id="Search_student">조회</button>				
		  					<button type="button" class="modalbtn2" id="Input_member" data-bs-toggle="modal" data-bs-target="#Input_memberList">등록</button>
		  				</td>
		  			</tr>
		  			<tr>
		  				<td class="bottom_td">
		  					<div style="height:500px; overflow:auto;">
			  					<table id="studentTablelist">
			  						
			  					</table>
			  				</div>	
		  				</td>
		  			</tr>
		  		</table>
		  	</div>
		  			  	
		  	<%-- 교사정보 --%>
		  	<div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
		  		<table class="tbl">
		  			<tr>
		  				<td class="top_td">
		  					<select class="inp" id="teacherStatus">
		  						<option value="no">재적상태 (전체)</option>
		  						<option value="1">재학</option>
		  						<option value="2">휴가</option>
		  						<option value="4">퇴사</option>
		  					</select>		  					
		  					<select class="inp" id="teacherFk_deptCode">
		  						<option value="no">학과 (전체)</option>
		  						
		  						<%-- 과 가져오기 --%>
		  						<c:forEach var="deptvo" items="${requestScope.deptList}">
		  							<option value="${deptvo.deptCode}">${deptvo.deptName}</option>
		  						</c:forEach>
		  						
		  					</select>		  					
		  					<select class="inp" id="teacherSearchType">
		  						<option value="no">조회명 (전체)</option>
		  						<option value="hakbun">학번조회</option>
		  						<option value="name">이름조회</option>
		  						<option value="phone">연락처조회</option>
		  					</select>		  					
		  					<input class="inp" type="text" id="teacherSearchWord" autocomplete="off"/>		  					
		  					<button class="search" id="Search_teacher">조회</button>
		  					<button type="button" class="modalbtn2" id="Input_teacher" data-bs-toggle="modal" data-bs-target="#Input_teacherList">등록</button>
		  				</td>
		  			</tr>
		  			<tr>
		  				<td class="bottom_td">
		  					<div style="height:500px; overflow:auto;">
			  					<table id="teacherTablelist">
			  						
			  					</table>
		  					</div>
		  				</td>
		  			</tr>
		  		</table>	  	
		  	</div>
		  			  	
		  	<%-- 전공정보 --%>
			<div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
				<table class="tbl">
		  			<tr>
		  				<td class="top_td">
		  					<select class="inp" id="classDate">
		  						<option value="no">요일 (전체)</option>
		  						<option value="1">월</option>
		  						<option value="2">화</option>
		  						<option value="3">수</option>
		  						<option value="4">목</option>
		  						<option value="5">금</option>
		  					</select>		  					
		  					<select class="inp" id="subjectFk_deptCode">
		  						<option value="no">학과 (전체)</option>
		  						
		  						<%-- 과 가져오기 --%>
		  						<c:forEach var="deptvo" items="${requestScope.deptList}">
		  							<option value="${deptvo.deptCode}">${deptvo.deptName}</option>
		  						</c:forEach>
		  						
		  					</select>		  					
		  					<select class="inp" id="subjectSearchType">
		  						<option value="no">조회명 (전체)</option>
		  						<option value="fk_hakbun">담당교수명</option>
		  						<option value="subject">과목명</option>
		  					</select>		  					
		  					<input class="inp" type="text" id="subjectSearchWord" autocomplete="off"/>	
		  					<button class="search" id="Search_subject">조회</button>		  					
							<button type="button" class="modalbtn2" id="Input_subject" data-bs-toggle="modal" data-bs-target="#Input_subjectList">등록</button>
							<input type="hidden" value="search"/>		  				
		  				</td>
		  			</tr>
		  			<tr>
		  				<td class="bottom_td">
		  					<div style="height:500px; overflow:auto;">
			  					<table id="subjectTablelist">
			  						
			  					</table>
			  				</div>	
		  				</td>
		  			</tr>
		  		</table>
			</div>
			
			<%-- 전공신청 --%>
		  	<div class="tab-pane fade" id="nav-contact2" role="tabpanel" aria-labelledby="nav-contact-tab">
		  		<table class="tbl">
		  			<tr>
		  				<td  colspan="2" class="top_td">		  					
		  					<select class="inp" id="jungong_deptCode">
		  						<option value="no">학과 (전체)</option>
		  						
		  						<%-- 과 가져오기 --%>
		  						<c:forEach var="deptvo" items="${requestScope.deptList}">
		  							<option value="${deptvo.deptCode}">${deptvo.deptName}</option>
		  						</c:forEach>
		  						
		  					</select>
		  					<select class="inp" id="jungong_nomember">		  						
		  						<option value="">수강미신청 인원</option>
		  					</select>
		  					<button class="jungongBtn" id="memberAdd">학생추가</button>
		  					<button class="jungongBtn" id="allmemberAdd">전체학생추가</button>
		  					<button class="jungongBtn" id="memberDelete">전체삭제</button>
		  					<select class="inp" id="jungong_yesmember">		  						
		  						<option value="">수강신청완료 인원</option>
		  					</select>		  						  							  					
		  				</td>
		  			</tr>
		  			<tr>
		  				<td colspan="2" style="height:100px;">
		  					<div id="inMember" style="height:100px; width:1050px; margin:10px 0px 0px 23px; border:solid 1px gray; overflow:auto;">
		  						
		  					</div>
		  				</td>
		  			</tr>
		  			<tr>
		  				<td class="jungongBottom">
		  					<table class="jungongScheduleTable">
								<tr>
									<td class="jungongSchedule" style="background-color:#ff5c33;">월</td>
									<td class="jungongSchedule" style="background-color:#ffc266;">화</td>
									<td class="jungongSchedule" style="background-color:#ffff99;">수</td>
									<td class="jungongSchedule" style="background-color:#b3ff99;">목</td>
									<td class="jungongSchedule" style="background-color:#99ffdd;">금</td>
								</tr>
								<tr>
									<td id="jungong_mon" class="scheduleTd"></td>
									<td id="jungong_tue" class="scheduleTd"></td>
									<td id="jungong_wed" class="scheduleTd"></td>
									<td id="jungong_thu" class="scheduleTd"></td>
									<td id="jungong_fri" class="scheduleTd"></td>
								</tr>
								<tr>
									<td colspan="5" style="text-align:left; font-size:9pt; border:solid 1px gray; height:70px;">
										<ul style="margin-top:10px;">
											<li>모든 사람에게 같은 과목을 입력할 수 있습니다.</li>
											<li>단 수정은 개개인만 가능 합니다.</li>
											<li>하루 최대 2과목 까지만 수강신청 가능합니다</li>
											<li>시간표는 위 아래는 시간과 관계 없습니다</li>
											<li>학생조회 시스템 이용 후 서비스 이용을 권장합니다.</li>
										</ul>
									</td>
								</tr>	        					
        					</table>
		  				</td>
		  				<td class="jungongBottom">
		  					<form>
			  					<button id="save" class="jgbtn" style="background-color:#f0f5f5">저장</button>
			  					<button id="update" class="jgbtn" style="background-color:#d0e1e1">수정</button>
		  					</form>	
		  					<%-- 해당 과 과목 들어오는 곳 --%>
		  					<div id="in" style="height:305px; width:500px; margin:10px 0px 0px 23px; border:solid 1px gray; overflow:auto;">
		  						
		  					</div>
		  				</td>
		  			</tr>
		  		</table>
		  	</div>
		</div>
	</div>
</div>

<%-- 전송용 히든인풋 --%>
<input type="hidden" value="" id="submit_hakbun"/>
<input type="hidden" value="" id="submit_code"/>

<input type="hidden" value="" id="update_hakbun"/>

<%-- ======================================= 모달 시작 ======================================= --%>


<%-- 교사, 학생 자세히 보기 --%>		
<div class="modal fade" id="information" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    	<div class="modal-content" style="width:1000px; margin-left:-250px;">
      		<div class="modal-header">
        		<h5 class="modal-title" id="exampleModalLabel">상세보기</h5>
        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      		</div>
      		<div class="modal-body">
        		<table style="border:solid 1px gray; width:960px; text-align:center; font-size:10pt; margin-left:3px;">
        			<tr>
        				<td colspan="4" style="background-color:#ccefff; height:40px;">
        					신상정보
        				</td>
        			</tr>
        			<tr>
        				<td id="picture" class="modaltd" rowspan="6">
        					 
        				</td>
        				<td class="modaltd" style="background-color:#e6ffff;">이름</td>
        				<td class="modaltd" style="background-color:#e6ffff;">생년월일</td>
        				<td class="modaltd" style="background-color:#e6ffff;">연락처</td>
        			</tr>
        			<tr>
        				<td id="name" class="modaltd"></td>
        				<td id="birth" class="modaltd"></td>
        				<td id="phone" class="modaltd"></td>
        			</tr>
        			<tr>
        				<td class="modaltd" style="background-color:#e6ffff;">이메일</td>
        				<td class="modaltd" style="background-color:#e6ffff;">학번</td>
        				<td class="modaltd" style="background-color:#e6ffff;">학과</td>
        			</tr>
        			<tr>	
        				<td id="email" class="modaltd"></td>
        				<td id="hakbun" class="modaltd"></td>
        				<td id="deptname" class="modaltd"></td>
        			</tr>
        			<tr>	
        				<td class="modaltd" colspan="2" style="background-color:#e6ffff;">주소</td>
        				<td class="modaltd" style="background-color:#e6ffff;">재학상태 변경</td>
        			</tr>
        			<tr>  				
        				<td id="address" class="modaltd" colspan="2"></td>
        				<td class="modaltd">
        					<select id="status" style="width:150px;">

        					</select>
        					<button id="updateStatus" style="margin-left:10px; width:50px; border:solid 1px gray; background-color:#e6ffff;">수정</button>
        					<input type="hidden" id="hiddenHakbun"/>
        				</td>
        			</tr>
        		</table>
      		</div>
    	</div>
  	</div>
</div>

<%-- 학생 등록 --%>	
<div class="modal fade" id="Input_memberList" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
    	<div class="modal-content" style="width:500px; margin-left:0px;">
      		<div class="modal-header">
        		<h5 class="modal-title" id="staticBackdropLabel">학생등록</h5>
        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      		</div>
      		<div class="modal-body">     		
        		<table style="border:solid 1px gray; width:460px; text-align:center; font-size:11pt; margin-left:3px;">
        			<tr>
        				<td colspan="2" style="background-color:#ccefff; height:40px;">필수 입력사항</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">학번</td>
        				<td style="width:330px; border:solid 1px gray;">
        					<input class="madal_input" type="text" style="width:230px;" id="student_hakbun" autocomplete="off"/>
        					<button id="CheckStudentHakbun" class="modal_button">조회</button>
        					<span id="stdv" class="v"></span>
        				</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">학과</td>
        				<td style="width:330px; border:solid 1px gray;">
        				<%-- 과 가져오기 --%>
		  					<select style="width:280px;" id="student_fk_deptCode">	
		  						<c:forEach var="deptvo" items="${requestScope.deptList}">
		  							<option>학과(전체)</option>
		  							<option value="${deptvo.deptCode}">${deptvo.deptName}</option>
		  						</c:forEach>
		  					</select>	
        				</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">이름</td>
        				<td style="width:300px; border:solid 1px gray;"><input class="madal_input" type="text" id="student_name" autocomplete="off"/></td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">이메일</td>
        				<td style="width:300px; border:solid 1px gray;"><input class="madal_input" type="text" id="student_email" autocomplete="off"/></td>
        			</tr>
        			<tr>
        				<td colspan="2" id="stderrmsg" style="width:560px; height:40px; border:solid 1px gray; color:red; font-size:11pt;">
        					
        				</td>
        			</tr>
        		</table>
      		</div>
      		<div class="modal-footer">
        		<button type="button" class="submitbtn" id="membersubmit">등록</button>
      		</div>
    	</div>
  	</div>
</div>

<%-- 교사 등록 --%>	
<div class="modal fade" id="Input_teacherList" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
    	<div class="modal-content" style="width:500px; margin-left:-0px;">
      		<div class="modal-header">
        		<h5 class="modal-title" id="staticBackdropLabel">교수 등록</h5>
        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      		</div>
      		<div class="modal-body">
        		<table style="border:solid 1px gray; width:460px; text-align:center; font-size:11pt; margin-left:3px;">
        			<tr>
        				<td colspan="2" style="background-color:#ccefff; height:40px;">필수 입력사항</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">학번</td>
        				<td style="width:330px; border:solid 1px gray;">
        					<input class="madal_input" type="text" style="width:230px;" id="teacher_hakbun" autocomplete="off"/>
        					<button id="CheckTeacherHakbun" class="modal_button">조회</button>
        					<span id="teav" class="v"></span>
        				</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">학과</td>
        				<td style="width:330px; border:solid 1px gray;">
        				<%-- 과 가져오기 --%>
		  					<select style="width:280px;" id="teacher_fk_deptCode">	
		  						<c:forEach var="deptvo" items="${requestScope.deptList}">
		  							<option value="${deptvo.deptCode}">${deptvo.deptName}</option>
		  						</c:forEach>
		  					</select>	
        				</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">이름</td>
        				<td style="width:300px; border:solid 1px gray;"><input class="madal_input" type="text" id="teacher_name" autocomplete="off"/></td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">이메일</td>
        				<td style="width:300px; border:solid 1px gray;"><input class="madal_input" type="text" id="teacher_email" autocomplete="off"/></td>
        			</tr>
        			<tr>
        				<td colspan="2" id="teaerrmsg" style="width:560px; height:40px; border:solid 1px gray; color:red; font-size:11pt;">
        					
        				</td>
        			</tr>
        		</table>
      		</div>
      		<div class="modal-footer">
        		<button type="button" class="submitbtn" id="teachersubmit">등록</button>
      		</div>
    	</div>
  	</div>
</div>

<%-- 과목 등록 --%>	
<div class="modal fade" id="Input_subjectList" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
    	<div class="modal-content" style="width:500; margin-left:-0px;">
      		<div class="modal-header">
        		<h5 class="modal-title" id="staticBackdropLabel">전공등록</h5>
        		<button type="button" id="closeBtn" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      		</div>
      		<div class="modal-body">
        		<table style="border:solid 1px gray; width:460px; text-align:center; font-size:11pt; margin-left:3px;">
        			<tr>
        				<td colspan="2" style="background-color:#ccefff; height:40px;">필수 입력사항</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">과목코드</td>
        				<td style="width:330px; border:solid 1px gray;">
        					<input class="madal_input" type="text" style="width:230px;" id="subject_code" autocomplete="off"/>
        					<button id="CheckSubjectCode" class="modal_button">조회</button>
        					<span id="subv1" class="v"></span>
        				</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">과목명</td>
        				<td style="width:330px; border:solid 1px gray;">
        					<input class="madal_input" type="text" style="width:230px;" id="subject_subject" autocomplete="off"/>
        					<button id="CheckSubjectSubject" class="modal_button">조회</button>
        					<span id="subv2" class="v"></span>
        				</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">학과</td>
        				<td style="width:330px; border:solid 1px gray;">
        				<%-- 과 가져오기 --%>
		  					<select style="width:280px;" id="subject_fk_deptCode">	
		  						<c:forEach var="deptvo" items="${requestScope.deptList}">
		  							<option value="${deptvo.deptCode}">${deptvo.deptName}</option>
		  						</c:forEach>
		  					</select>	
        				</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">담당교수</td>
        				<td style="width:330px; border:solid 1px gray;">
        				<%-- 담당교수 가져오기 --%>
		  					<select style="width:230px;" id="subjectTeacher_fk_hakbun">	

		  					</select>
		  					<button id="CheckSubjectTeacher" class="modal_button">조회</button>
        					<span id="subv3" class="v"></span>	
        				</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">상세정보</td>
        				<td style="width:330px; border:solid 1px gray;">
		  					<select style="width:124px; margin-left:10px;" id="subject_hakjum">	
								<option value="">학점</option>
		  						<option value="2">2</option>
		  						<option value="3">3</option>
		  					</select>
		  					<select style="width:125px; margin-left:10px;" id="subject_classDate">	
		  						
		  					</select>	
        				</td>
        			</tr>
        			<tr>
        				<td colspan="2" id="suberrmsg" style="width:560px; height:40px; border:solid 1px gray; color:red; font-size:11pt;">
        					
        				</td>
        			</tr>
        			<tr>
        				<td colspan="2">
        					<table class="scheduleTable">
								<tr>
									<td class="scheduleWeek" style="background-color:#ff5c33;">월</td>
									<td class="scheduleWeek" style="background-color:#ffc266;">화</td>
									<td class="scheduleWeek" style="background-color:#ffff99;">수</td>
									<td class="scheduleWeek" style="background-color:#b3ff99;">목</td>
									<td class="scheduleWeek" style="background-color:#99ffdd;">금</td>
								</tr>
								<tr>
									<td id="mon" class="scheduleTd"></td>
									<td id="tue" class="scheduleTd"></td>
									<td id="wed" class="scheduleTd"></td>
									<td id="thu" class="scheduleTd"></td>
									<td id="fri" class="scheduleTd"></td>
								</tr>	        					
        					</table>
        				</td>
        			</tr>
        		</table>
      		</div>
      		<div class="modal-footer">
        		<button type="button" class="submitbtn" id="subjectsubmit">등록</button>
        		<input type="hidden" value="" id="checkUpdate" />
      		</div>
    	</div>
  	</div>
</div>