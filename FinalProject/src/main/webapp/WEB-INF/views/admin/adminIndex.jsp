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
		border:solid 1px gray;
	}
	
	div#menu{
		width:1200px;
		height:40px;
	}
	
	.tbl{
		width:1100px;
		height:600px;
		margin:25px 0px 0px 50px;
		border:solid 1px gray; 
	}
	
	td.top_td{
		border-bottom:solid 1px gray;
		height:50px;
		background-color:#f5f5f0;
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
		border:solid 1px gray;
		background-color:white;
		font-size:10pt; 
		height:30px;
	}
	
	table#studentTablelist, table#teacherTablelist, table#subjectTablelist{
		width:1050px;
		margin:0px 0px 0px 20px;
		border:solid 1px gray;
	}
	
	.pageBar{
		border:solid 1px gray;
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
		border:solid 1px gray;
		background-color:#ccf3ff;
		font-size:10pt;
	}

	.modaltd{
		border:solid 1px gray;
		width:240px;
	}

	.submitbtn{
		border:solid 1px gray;
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

</style>

<script src= "<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" >

	$(document).ready(function(){
		
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
			
		// 교수조회 클릭시
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
					   				+"<td style='border:solid 1px gray; width:250px;'>과목명</td>"
									+"<td style='border:solid 1px gray; width:250px;'>담당교수</td>"
									+"<td style='border:solid 1px gray; width:150px;'>반</td>"
									+"<td style='border:solid 1px gray; width:150px;'>이수학점</td>"
									+"<td style='border:solid 1px gray; width:150px;'>수업요일</td>"
									+"<td style='border:solid 1px gray; width:250px;'>학과명</td>"
							   	  +"</tr>";
		  				
		  				// 검색된 데이터가 있는경우		   
		  				if(json.length > 0) {
							
		  					$.each(json, function(index, item){
	
								html += "<tr id='studentList' style='text-align:center; font-size:10pt;'>"
										+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+item.subject+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+item.teacher+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:150px;'>"+item.ban+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:150px;'>"+item.hakjum+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:150px;'>"+item.classDate+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+item.fk_deptCode+"</td>"
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
			$("td#deptname").text($(this).next().next().next().next().next().next().next().val()); // 과명넣기
			$("td#address").text($(this).next().next().next().next().next().next().next().next().val()); // 주소넣기		
				
		});//end of $(document).on("click","button#memberBtn",function(){---------------	
			
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////		
			
		// 학생등록시
		$("button#membersubmit").click(function(){
		
			var flag = false;
			
			// 학번 입력시
			if($("input#student_hakbun").val() != ""){
				flag = true;
			}
			// 학번 조회시
			if($("span#stdv").text() == "v"){
				flag = true;
			}
			// 이름 입력시
			if($("input#student_name").val() != ""){
				flag = true;
			}
						
			if(flag == true){
				
				$.ajax({
					url:"<%= request.getContextPath()%>/updateMember.univ",
					type:"POST",
					data:{"hakbun":$("input#student_hakbun").val()
						 ,"fk_deptCode":$("select#student_fk_deptCode").val()
						 ,"name":$("input#student_name").val()
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
						$("span#stdv").text("");
						$("td#stderrmsg").text("");
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({----------------------------------------------------
				
			}
			else{
				alert("필수 입력사항을 기재 및 조회 부탁드립니다");				
			}
			
		});//end of $("button#membersubmit").click(function(){--------------------------
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// 학생 학번 조회
		$("button#CheckStudentHakbun").click(function(){
			
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
		
		// 교수님 등록시
		$("button#teachersubmit").click(function(){
		
			var flag = false;
			
			// 학번 입력시
			if($("input#teacher_hakbun").val() != ""){
				flag = true;
			}
			// 학번 조회시
			if($("span#teav").text() == "v"){
				flag = true;
			}
			// 이름 입력시
			if($("input#teacher_name").val() != ""){
				flag = true;
			}
						
			if(flag == true){
				
				$.ajax({
					url:"<%= request.getContextPath()%>/updateMember.univ",
					type:"POST",
					data:{"hakbun":$("input#teacher_hakbun").val()
						 ,"fk_deptCode":$("select#teacher_fk_deptCode").val()
						 ,"name":$("input#teacher_name").val()
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
						$("span#teav").text("");
						$("td#teaerrmsg").text("");
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({----------------------------------------------------
				
			}
			else{
				alert("필수 입력사항을 기재 및 조회 부탁드립니다");			
			}	
			
		});//end of $("button#teachersubmit").click(function(){-------------------------
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// 교수님 학번 조회
		$("button#CheckTeacherHakbun").click(function(){
			
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
		
			var flag = false;
			
			// 과목코드 입력시
			if($("input#subject_code").val() != ""){
				flag = true;
			}
			// 과목코드 조회시
			if($("span#subv1").text() == "v"){
				flag = true;
			}
			// 과목명 미입력시
			if($("input#subject_subject").val() != ""){
				flag = true;
			}
			// 학번 미 조회시
			if($("span#subv2").text() == "v"){
				flag = true;
			}
			// 담당교수 시간표 조회시
			if($("span#subv3").text() == "v"){
				flag = true;
			}
			// 학점 선택시
			if($("select#subject_hakjum").val() != ""){
				flag = true;
			}
			// 요일 선택시
			if($("select#subject_classDate").val() != ""){
				flag = true;
			}
					
			if(flag == true){
				
				$.ajax({
					url:"<%= request.getContextPath()%>/updateSubject.univ",
					type:"POST",
					data:{"code":$("input#subject_code").val()
						 ,"subject":$("input#subject_subject").val()
						 ,"fk_deptCode":$("select#subject_fk_deptCode").val()
						 ,"teacher":$("select#subject_teacher").val()
						 ,"hakjum":$("select#subject_hakjum").val()
						 ,"classDate":$("select#subject_classDate").val()},
					dataType:"JSON",
					success:function(json){
						if(json.n > 0){
							alert("입력 되었습니다");		
						}
						// 비우기
						$("input#subject_code").val("");
						$("input#subject_subject").val("");
						$("input#subject_classDate").val("");
						$("span#subv1").text("");
						$("span#subv2").text("");
						$("span#subv3").text("");
						$("td#suberrmsg").text("");
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({----------------------------------------------------
				
			}
			else{
				alert("필수 입력사항을 기재 및 조회 부탁드립니다");			
			}
			
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
				
			});//end of $.ajax({----------------------------------------------------
			
		});//end of $("button#CheckSubjectCode").click(function(){--------------------		
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// 학과 클릭시 해당학과 교수님 불러오기
		$("select#subject_fk_deptCode").click(function(){
			
			
		});	
		
			
	});//end of $(document).ready(function(){-------------------------------------------
	
</script>

<div style="flex">
	<div id="container">
  		<%-- 상단 메뉴바 --%>
  		<nav>
		  	<div class="nav nav-tabs" id="nav-tab" role="tablist">
		    	<button class="nav-link active" id="student" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">학생정보</button>
		    	<button class="nav-link" id="teacher" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">교사정보</button>
		    	<button class="nav-link" id="subject" data-bs-toggle="tab" data-bs-target="#nav-contact" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">전공정보</button>
			</div>
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
		  						<option value="월">월</option>
		  						<option value="화">화</option>
		  						<option value="수">수</option>
		  						<option value="목">목</option>
		  						<option value="금">금</option>
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
		  						<option value="teacher">담당교수명</option>
		  						<option value="ban">반</option>
		  						<option value="subject">과목명</option>
		  					</select>		  					
		  					<input class="inp" type="text" id="subjectSearchWord" autocomplete="off"/>	
		  					<button class="search" id="Search_subject">조회</button>		  					
							<button type="button" class="modalbtn2" id="Input_subject" data-bs-toggle="modal" data-bs-target="#Input_subjectList">등록</button>		  				
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
		</div>
	</div>
</div>

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
        				<td class="modaltd" colspan="3" style="background-color:#e6ffff;">주소</td>
        			</tr>
        			<tr>  				
        				<td id="address" class="modaltd" colspan="3"></td>
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
        					<input class="madal_input" type="text" style="width:230px;" id="student_hakbun"/>
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
		  							<option value="${deptvo.deptCode}">${deptvo.deptName}</option>
		  						</c:forEach>
		  					</select>	
        				</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">이름</td>
        				<td style="width:300px; border:solid 1px gray;"><input class="madal_input" type="text" id="student_name"/></td>
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
        					<input class="madal_input" type="text" style="width:230px;" id="teacher_hakbun"/>
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
        				<td style="width:300px; border:solid 1px gray;"><input class="madal_input" type="text" id="teacher_name"/></td>
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
        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      		</div>
      		<div class="modal-body">
        		<table style="border:solid 1px gray; width:460px; text-align:center; font-size:11pt; margin-left:3px;">
        			<tr>
        				<td colspan="2" style="background-color:#ccefff; height:40px;">필수 입력사항</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">과목코드</td>
        				<td style="width:330px; border:solid 1px gray;">
        					<input class="madal_input" type="text" style="width:230px;" id="subject_code"/>
        					<button id="CheckSubjectCode" class="modal_button">조회</button>
        					<span id="subv1" class="v"></span>
        				</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">과목명</td>
        				<td style="width:330px; border:solid 1px gray;">
        					<input class="madal_input" type="text" style="width:230px;" id="subject_subject"/>
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
		  					<select style="width:230px;" id="subject_teacher">	

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
								<option value="">요일</option>
		  						<option value="월">월</option>
		  						<option value="화">화</option>
		  						<option value="수">수</option>
		  						<option value="목">목</option>
		  						<option value="금">금</option>
		  					</select>	
        				</td>
        			</tr>
        			<tr>
        				<td colspan="2" id="suberrmsg" style="width:560px; height:40px; border:solid 1px gray; color:red; font-size:11pt;">
        					
        				</td>
        			</tr>
        		</table>
      		</div>
      		<div class="modal-footer">
        		<button type="button" class="submitbtn" id="subjectsubmit">등록</button>
      		</div>
    	</div>
  	</div>
</div>