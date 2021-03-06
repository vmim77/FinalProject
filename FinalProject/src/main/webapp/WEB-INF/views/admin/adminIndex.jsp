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
		
		// ?????? ???????????? ????????? ?????????
		$("button#update").hide();
		$("button#save").hide();
		
		// ???????????? ?????????
		$("button#Search_student").click(function(){

			// ??????????????? ??????????????? ????????? ??? ?????????
			if($("select#studentSearchType").val() != "no" && $("input#studentSearchWord").val() == ""){
				
				$("table#studentTablelist").html(""); // ?????? ????????? ?????? ????????? ????????????	
				alert("???????????? ??????????????????");			  // ?????????	
				$("input#studentSearchWord").focus(); // ???????????????
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
						
						// ?????? ????????? ?????? ????????? ????????????
						$("table#studentTablelist").html("");	
						
						var html = "<tr style='height:35px; text-align:center; background-color:#ccf3ff; font-size:11pt;'>"
							   		+"<td style='border:solid 1px gray; width:250px;'>??????</td>"
									+"<td style='border:solid 1px gray; width:250px;'>????????????</td>"
		  							+"<td style='border:solid 1px gray; width:250px;'>??????</td>"
		  							+"<td style='border:solid 1px gray; width:250px;'>??????</td>"
		  							+"<td style='border:solid 1px gray; width:100px;'>????????????</td>"
		  						   +"</tr>";
		  				
		  				// ????????? ???????????? ????????????		   
		  				if(json.length > 0) {
							
		  					$.each(json, function(index, item){
	
								// ?????? ????????????
								var itemStatus = item.status;
								
								if(itemStatus == 0){
									status = "????????????";
								}
								else if(itemStatus == 1){
									status = "??????";
								}
								else if(itemStatus == 2){
									status = "??????";
								}
								else if(itemStatus == 3){
									status = "??????";
								}
								else{
									status = "??????";
								}
								
								html += "<tr style='text-align:center; font-size:10pt;'>"
		  									+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+item.name+"</td>"
				  							+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+status+"</td>"
				  							+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+item.hakbun+"</td>"
				  							+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+item.fk_deptCode+"</td>"
				  							+"<td style='border:solid 1px gray; height:45px; width:100px;'>"
				  								+"<button type='button' id='memberBtn' class='modalbtn' data-bs-toggle='modal' data-bs-target='#information'>??????</button>"
				  								/* ????????? ?????? ??? ?????? ???????????? */
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
			
		// ???????????? ?????????
		$("button#Search_teacher").click(function(){

			// ??????????????? ??????????????? ????????? ??? ?????????
			if($("select#teacherSearchType").val() != "no" && $("input#teacherSearchWord").val() == ""){
				
				$("table#teacherTablelist").html(""); // ?????? ????????? ?????? ????????? ????????????
				alert("???????????? ??????????????????");			  // ?????????	
				$("input#teacherSearchWord").focus(); // ???????????????
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
						
						// ?????? ????????? ?????? ????????? ????????????
						$("table#teacherTablelist").html("");	
						
						var html = "<tr style='height:35px; text-align:center; background-color:#ccf3ff; font-size:11pt;'>"
					   				+"<td style='border:solid 1px gray; width:250px;'>??????</td>"
									+"<td style='border:solid 1px gray; width:250px;'>????????????</td>"
									+"<td style='border:solid 1px gray; width:250px;'>??????</td>"
									+"<td style='border:solid 1px gray; width:250px;'>??????</td>"
									+"<td style='border:solid 1px gray; width:100px;'>????????????</td>"
							   	  +"</tr>";
		  				
		  				// ????????? ???????????? ????????????		   
		  				if(json.length > 0) {
							
		  					$.each(json, function(index, item){
	
								// ?????? ????????????
								var itemStatus = item.status;
								
								if(itemStatus == 0){
									status = "????????????";
								}
								else if(itemStatus == 1){
									status = "??????";
								}
								else if(itemStatus == 2){
									status = "??????";
								}
								else if(itemStatus == 4){
									status = "??????";
								}
								
								html += "<tr style='text-align:center; font-size:10pt;'>"
										+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+item.name+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+status+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+item.hakbun+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:250px;'>"+item.fk_deptCode+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:100px;'>"
			  								+"<button type='button' id='memberBtn' class='modalbtn' data-bs-toggle='modal' data-bs-target='#information'>??????</button>"
			  								/* ????????? ?????? ??? ?????? ???????????? */
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
			
		// ???????????? ?????????
		$("button#Search_subject").click(function(){
	
			// ??????????????? ??????????????? ????????? ??? ?????????
			if($("select#subjectSearchType").val() != "no" && $("input#subjectSearchWord").val() == ""){
				
				$("table#subjectTablelist").html(""); // ?????? ????????? ?????? ????????? ????????????	
				alert("???????????? ??????????????????");			  // ?????????
				$("input#subjectSearchWord").focus(); // ???????????????
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
						
						// ?????? ????????? ?????? ????????? ????????????
						$("table#subjectTablelist").html("");	
						
						var html = "<tr style='height:35px; text-align:center; background-color:#ccf3ff; font-size:11pt;'>"
					   				+"<td style='border:solid 1px gray; width:260px;'>?????????</td>"
									+"<td style='border:solid 1px gray; width:200px;'>????????????</td>"
									+"<td style='border:solid 1px gray; width:160px;'>????????????</td>"
									+"<td style='border:solid 1px gray; width:160px;'>????????????</td>"
									+"<td style='border:solid 1px gray; width:260px;'>?????????</td>"
									+"<td style='border:solid 1px gray; width:160px;'>??????????????????</td>"
							   	  +"</tr>";
		  				
		  				// ????????? ???????????? ????????????		   
		  				if(json.length > 0) {
							
		  					$.each(json, function(index, item){
	
								html += "<tr id='studentList' style='text-align:center; font-size:10pt;'>"
										+"<td style='border:solid 1px gray; height:45px; width:260px;'>"+item.subject+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:260px;'>"+item.fk_hakbun+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:160px;'>"+item.hakjum+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:160px;'>"+item.classDate+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:260px;'>"+item.fk_deptCode+"</td>"
			  							+"<td style='border:solid 1px gray; height:45px; width:160px;'>"
			  								+"<button type='button' class='modalbtn2' id='Input_subject' data-bs-toggle='modal' data-bs-target='#Input_subjectList'>????????????</button>"
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
		
		// ?????? ???????????? ?????? ?????????
		$(document).on("click","button#memberBtn",function(){

			var picture = "<img src='resources/images/"+$(this).next().val()+"' style='width:240px; height:280px;'/>";
			$("td#picture").html(picture); // ????????????
			$("td#name").text($(this).next().next().val()); // ????????????
			$("td#birth").text($(this).next().next().next().val()); // ????????????
			$("td#phone").text($(this).next().next().next().next().val()); // ???????????????
			$("td#email").text($(this).next().next().next().next().next().val()); // ???????????????	 
			$("td#hakbun").text($(this).next().next().next().next().next().next().val()); // ????????????
			$("input#hiddenHakbun").val($(this).next().next().next().next().next().next().val()); // ????????? ????????????
			$("td#deptname").text($(this).next().next().next().next().next().next().next().val()); // ????????????
			$("td#address").text($(this).next().next().next().next().next().next().next().next().val()); // ????????????		
			
			var authority = $(this).next().next().next().next().next().next().next().next().next().val(); // ??????
			
			var html = "";
			
			// ????????????
			if(authority == 0){	
				html = "<option value='0'>????????????</option>"
					  +"<option value='1'>??????</option>"
					  +"<option value='2'>??????</option>"
					  +"<option value='3'>??????</option>"
					  +"<option value='4'>??????</option>";
			}
			// ???????????????
			else{
				html = "<option value='0'>????????????</option>"
					  +"<option value='1'>??????</option>"
					  +"<option value='2'>??????</option>"
					  +"<option value='4'>??????</option>";
			}
			
			// ?????? ??? ??????		  
			$("select#status").html(html);
			
		});//end of $(document).on("click","button#memberBtn",function(){---------------	
			
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////		
					
        // status ?????? ???
        $("button#updateStatus").click(function(){
        	
        	$.ajax({
				url:"<%= request.getContextPath()%>/updateStatus.univ",
				type:"POST",
				data:{"hakbun":$(this).next().val()
					 ,"status":$("select#status").val()},
				dataType:"JSON",
				success:function(json){
					
					if(json.n > 0){
						alert("?????? ???????????????");		
					}

				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
				
			});//end of $.ajax({----------------------------------------------------
        	
        });//end of  $("button#updateStatus").click(function(){------------------------
        					
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////							
        					
		// ???????????????
		$("button#membersubmit").click(function(){
		
			var flag = true;
			
			var alerthtml = "";
			
			// ?????? ?????????
			if($("input#student_hakbun").val() == ""){
				flag = false;
				alerthtml += "?????? ??????, ";		
			}			
			// ?????? ?????????
			if($("span#stdv").text() != "v"){
				flag = false;
				alerthtml += "?????? ??????, ";
			}
			// ?????? ?????????
			if($("input#student_name").val() == ""){
				flag = false;
				alerthtml += "?????? ?????? ??????, ";		
			}
			if($("input#student_email").val() == ""){
				flag = false;
				alerthtml += "????????? ??????";		
			}

			if(alerthtml != ""){
				alert(alerthtml + " ??????????????????");
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
							alert("?????? ???????????????");		
						}
						// ?????????
						$("input#student_hakbun").val("");
						$("select#student_fk_deptCode").val("no");
						$("input#student_name").val("");
						$("input#student_email").val("");
						$("span#stdv").text("");
						$("td#stderrmsg").text("");
					},
					error: function(request, status, error){
						alert("????????? ????????? ?????????. ?????? ??????????????????");		
				 	}
					
				});//end of $.ajax({----------------------------------------------------
				
			}//end of if(flag == true){-------------------------------------------------
						
		});//end of $("button#membersubmit").click(function(){--------------------------
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// ?????? ?????? ??????
		$("button#CheckStudentHakbun").click(function(){
			
			// ?????? ????????????
			$("td#stderrmsg").text("");
			
			// ????????? ????????? ????????????
			if($("input#student_hakbun").val().length != 7 || $("input#student_hakbun").val() == "" || !($("input#student_hakbun").val()*1 > 0)){
				alert("????????? 7?????? ???????????? ?????? ????????????");
				$("td#stderrmsg").text("");
			}
			else{
				
				$.ajax({
					url:"<%= request.getContextPath()%>/selecthakbun.univ",
					type:"POST",
					data:{"hakbun":$("input#student_hakbun").val()},
					dataType:"JSON",
					success:function(json){
						
						// ????????? ???????????? ????????????		   
		  				if(json.checkHakbun == "cannot") {
		  					$("td#stderrmsg").text("?????? ???????????? ???????????????");
		  					$("span#stdv").text("");
		  				}
		  				else{
		  					$("span#stdv").text("v");
		  					$("td#stderrmsg").text("??????????????? ???????????????");
		  				}//end of if(json.length > 0) {---------------------------------
						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({----------------------------------------------------
			
			}//end of if($("input#student_hakbun").val().length != 7 || $("input#student_hakbun").val() == "" || !($("input#student_hakbun").val()*1 > 0)){
				
		});//end of $("button#CheckStudentHakbun").click(function(){--------------------
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		
		// ???????????? ??? ?????? ????????? ????????? ??? ????????????
		
		$("button#closeBtn").click(function(){
			
			$("input#subject_code").val("");
			$("input#subject_subject").val("");
			$("select#subjectTeacher_fk_hakbun").val("");
			$("select#subject_hakjum").html("<option value=''>??????</option><option value='2'>2</option><option value='3'>3</option>");
			$("select#subject_classDate").val("");
			$("td#suberrmsg").html("");
			$("td.scheduleTd").html("");
			$("h5#staticBackdropLabel").text("????????????");
			$("input#checkUpdate").val("");
			
		});//end of $("button#closeBtn").click(function(){-----------------------------------------------------------
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// ????????? ?????????
		$("button#teachersubmit").click(function(){
		
			var flag = true;
			
			var alerthtml = "";
			
			// ?????? ?????????
			if($("input#teacher_hakbun").val() == ""){
				flag = false;
				alerthtml += "?????? ??????, ";		
			}			
			// ?????? ?????????
			if($("span#teav").text() != "v"){
				flag = false;
				alerthtml += "?????? ??????, ";
			}
			// ?????? ?????????
			if($("input#teacher_name").val() == ""){
				flag = false;
				alerthtml += "?????? ?????? ??????, ";		
			}
			if($("input#teacher_email").val() == ""){
				flag = false;
				alerthtml += "????????? ??????";		
			}

			if(alerthtml != ""){
				alert(alerthtml + " ??????????????????");
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
							alert("?????? ???????????????");		
						}
						// ?????????
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
		
		// ????????? ?????? ??????
		$("button#CheckTeacherHakbun").click(function(){
			
			// ?????? ????????????
			$("td#teaerrmsg").text("");
			
			// ????????? ????????? ????????????
			if($("input#teacher_hakbun").val().length != 7 || $("input#teacher_hakbun").val() == "" || !($("input#teacher_hakbun").val()*1 > 0)){
				alert("????????? 7?????? ???????????? ?????? ????????????");
				$("td#teaerrmsg").text("");
			}
			else{
				
				$.ajax({
					url:"<%= request.getContextPath()%>/selecthakbun.univ",
					type:"POST",
					data:{"hakbun":$("input#teacher_hakbun").val()},
					dataType:"JSON",
					success:function(json){
						
						// ????????? ???????????? ????????????		   
		  				if(json.checkHakbun == "cannot") {
		  					$("td#teaerrmsg").text("?????? ???????????? ???????????????");
		  					$("span#teav").text("v");
		  				}
		  				else{
		  					$("span#teav").text("v");
		  					$("td#teaerrmsg").text("??????????????? ???????????????");
		  				}//end of if(json.length > 0) {---------------------------------
						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({----------------------------------------------------
			
			}//end of if($("input#teacher_hakbun").val().length != 7 || $("input#teacher_hakbun").val() == "" || !($("input#teacher_hakbun").val()*1 > 0)){
				
		});//end of $("button#CheckTeacherHakbun").click(function(){--------------------
			
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		
		// ?????? ?????????
		$("button#subjectsubmit").click(function(){
		
			var flag = true;
			
			var alerthtml = "";
			
			// ???????????? ?????????
			if($("input#subject_code").val() == ""){
				flag = false;
				alerthtml += "????????????, ";	
			}
			// ???????????? ?????????
			if($("span#subv1").text() != "v"){
				flag = false;
				alerthtml += "???????????? ??????, ";	
			}
			// ????????? ????????????
			if($("input#subject_subject").val() == ""){
				flag = false;
				alerthtml += "????????? ??????, ";	
			}
			// ????????? ??? ?????????
			if($("span#subv2").text() != "v"){
				flag = false;
				alerthtml += "????????? ??????, ";	
			}
			// ???????????? ????????? ?????????
			if($("span#subv3").text() != "v"){
				flag = false;
				alerthtml += "???????????? ????????? ??????, ";	
			}
			// ?????? ?????????
			if($("select#subject_hakjum").val() == ""){
				flag = false;
				alerthtml += "????????????, ";	
			}
			// ?????? ?????????
			if($("select#subject_classDate").val() == ""){
				flag = false;
				alerthtml += "???????????? ??????";	
			}
			
			if(alerthtml != ""){
				alert(alerthtml + "??????????????????");
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
							alert("??????????????? ?????? ???????????????");		
						}
						if(json.n == 2){
							alert("??????????????? ?????? ???????????????");		
						}
						// ?????????
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
		
		// ???????????? ??????
		$("button#CheckSubjectCode").click(function(){
			
			// ????????? ????????? ????????????
			if($("input#subject_code").val().length != 4 || $("input#subject_code").val() == "" || !($("input#subject_code").val()*1 > 0)){
				alert("??????????????? 4?????? ???????????? ?????? ????????????");
				$("td#suberrmsg").text("");
			}
			else{
				
				$.ajax({
					url:"<%= request.getContextPath()%>/selectcode.univ",
					type:"POST",
					data:{"code":$("input#subject_code").val()},
					dataType:"JSON",
					success:function(json){
						
						// ????????? ???????????? ????????????		   
		  				if(json.checkCode == "cannot") {
		  					$("td#suberrmsg").text("?????? ???????????? ?????????????????????");
		  					$("span#subv1").text("");
		  				}
		  				else{
		  					$("span#subv1").text("v");
		  					$("td#suberrmsg").text("??????????????? ???????????? ?????????");
		  				}//end of if(json.length > 0) {---------------------------------
						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({----------------------------------------------------
			
			}//end of if($("input#teacher_hakbun").val().length != 4 || $("input#teacher_hakbun").val() == "" || !($("input#teacher_hakbun").val()*1 > 0)){
				
		});//end of $("button#CheckSubjectCode").click(function(){--------------------	
			
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// ????????? ??????
		$("button#CheckSubjectSubject").click(function(){
			
			// ????????? ????????????
			if($("input#subject_subject").val() == ""){
				alert("???????????? ?????? ????????????.")
			}
			else{
			
				$.ajax({
					url:"<%= request.getContextPath()%>/selectsubject.univ",
					type:"POST",
					data:{"subject":$("input#subject_subject").val()},
					dataType:"JSON",
					success:function(json){
						
						// ????????? ???????????? ????????????		   
		  				if(json.checkSubject == "cannot") {
		  					$("td#suberrmsg").text("?????? ???????????? ??????????????????");
		  					$("span#subv2").text("");
		  				}
		  				else{
		  					$("span#subv2").text("v");
		  					$("td#suberrmsg").text("??????????????? ????????? ?????????");
		  				}//end of if(json.length > 0) {---------------------------------
						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({------------------------------------------------------
				
			}//end of if($("input#subject_subject").val() == ""){-------------------------		
			
		});//end of $("button#CheckSubjectCode").click(function(){------------------------		
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// ?????? ????????? ???????????? ????????? ????????????
		$("select#subject_fk_deptCode").click(function(){
	
			// ???????????? ???????????? ???????????? ?????? ????????????
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
		
		// ?????? ????????? ???????????????		
		$("button#CheckSubjectTeacher").click(function(){

			// ???????????? ????????????
			$("select#subject_classDate").html("");
			$("span#subv3").text("v");
			
			// ?????? ????????????
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
					
					// ????????? ?????????
					var monHtml = "";
					var tueHtml = "";
					var wedHtml = "";
					var thuHtml = "";
					var friHtml = "";
					
					// ????????? ???????????? ????????? ?????????
					var monCnt = 0;
					var tueCnt = 0;
					var wedCnt = 0;
					var thuCnt = 0;
					var friCnt = 0;
					
  					$.each(json, function(index, item){
						
  						// ???????????? ?????????????????????
						if(item.classDate == 1){
							monHtml += "<div class='scheduleDiv'>"+item.subject+"</div>";
							monCnt++;
						}
						// ???????????? ?????????????????????
						else if(item.classDate == 2){
							tueHtml += "<div class='scheduleDiv'>"+item.subject+"</div>";
							tueCnt++;
						}
						// ???????????? ?????????????????????
						else if(item.classDate == 3){
							wedHtml += "<div class='scheduleDiv'>"+item.subject+"</div>";
							wedCnt++;
						}
						// ???????????? ?????????????????????
						else if(item.classDate == 4){
							thuHtml += "<div class='scheduleDiv'>"+item.subject+"</div>";
							thuCnt++;
						}
						// ???????????? ?????????????????????
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
  					
					// ?????? ?????? ????????????
  					if(monCnt < 2)
  						optHtml += "<option value='1'>???</option>";
  					if(tueCnt < 2)
  						optHtml += "<option value='2'>???</option>";
  					if(wedCnt < 2)
  						optHtml += "<option value='3'>???</option>";
  					if(thuCnt < 2)
  						optHtml += "<option value='4'>???</option>";
  					if(friCnt < 2)
  						optHtml += "<option value='5'>???</option>";
  					
  					$("select#subject_classDate").html(optHtml);	
  						
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
				
			});//end of $.ajax({--------------------------------------------------------
			
		});//end of $("button#CheckSubjectTeacher").click(function(){------------------
		
		///////////////////////////////////////////////////////////////////////////////
		
		// ??? ????????? ????????? ?????? ????????????
		$("select#jungong_deptCode").click(function(){
			
			// ???????????? ?????? ????????????
			$("select#jungong_nomember").html("<option value=''>??????????????? ??????</option>");
			$("select#jungong_yesmember").html("<option value=''>?????????????????? ??????</option>");
			
			// ????????? ?????? ????????????
			$.ajax({
				url:"<%= request.getContextPath()%>/sugangNoMember.univ",
				type:"POST",
				data:{"fk_deptCode":$("select#jungong_deptCode").val()},
				dataType:"JSON",
				success:function(json){
					
					var html = "<option value=''>??????????????? ??????</option>";
					
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
				
			// ?????? ?????? ????????????
			$.ajax({
				url:"<%= request.getContextPath()%>/sugangYesMember.univ",
				type:"POST",
				data:{"fk_deptCode":$("select#jungong_deptCode").val()},
				dataType:"JSON",
				success:function(json){
					
					var html = "<option value=''>?????????????????? ??????</option>";
					
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
			
			// ???????????? ????????????
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
		
		// ?????? 2?????? ????????? ?????? ????????? ==> ?????????????????? : ??????????????? ???????????? ???????????? ??????
		var cnt1 = 0;
		var cnt2 = 0;
		var cnt3 = 0;
		var cnt4 = 0;
		var cnt5 = 0;	
			
		////////////////////////////////////////////////////////////////////////////////
		
		// ???????????????
		$(document).on("click", ".subj", function(){
			
			// ?????????
			var subject = $(this).text();
			// ????????????
			var code = $(this).val();
			// ???????????? ???????????? ???????????? ( ??????????????? ???????????? ??????????????? ???????????? ?????? ????????? )
			var cdate = $(this).next().val();
			
			// ???????????? ????????? ???????????? ???????????? ??????????????? ????????????
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

			// ?????????????????? ????????????
			$.ajax({
				url:"<%= request.getContextPath()%>/subjectClassDate.univ",
				type:"POST",
				data:{"code":$(this).val()},
				dataType:"JSON",
				success:function(json){
					
					// ????????? ????????? ??????????????????
					if(json.classDate == '1'){						
						cnt1++;
						if(cnt1 !=3){
							$("td#jungong_mon").append("<div class='x'>x</div><div class='weekdiv'>"+subject+"</div><input type='hidden' value='"+json.classDate+"' /><input type='hidden' value='"+code+"' />");				
		  					$("input#submit_code").val($("input#submit_code").val() + code + ","); // ???????????? ?????? ??? ????????????
						}
					}
					if(cnt1 == 3){
						alert("?????? ?????? 2??????????????? ?????? ???????????????.");
						cnt1=2;
					}
				
					if(json.classDate == '2'){						
						cnt2++;
						if(cnt2 !=3){
							$("td#jungong_tue").append("<div class='x'>x</div><div class='weekdiv'>"+subject+"</div><input type='hidden' value='"+json.classDate+"' /><input type='hidden' value='"+code+"' />");				
							$("input#submit_code").val($("input#submit_code").val() + code + ","); // ???????????? ?????? ??? ????????????
						}
					}
					if(cnt2 == 3){
						alert("?????? ?????? 2??????????????? ?????? ???????????????.");
						cnt2=2;
					}
					
					if(json.classDate == '3'){						
						cnt3++;
						if(cnt3 !=3){
							$("td#jungong_wed").append("<div class='x'>x</div><div class='weekdiv'>"+subject+"</div><input type='hidden' value='"+json.classDate+"' /><input type='hidden' value='"+code+"' />");				
							$("input#submit_code").val($("input#submit_code").val() + code + ","); // ???????????? ?????? ??? ????????????
						}
					}
					if(cnt3 == 3){
						alert("?????? ?????? 2??????????????? ?????? ???????????????.");
						cnt3=2;
					}
					
					if(json.classDate == '4'){						
						cnt4++;
						if(cnt4 !=3){
							$("td#jungong_thu").append("<div class='x'>x</div><div class='weekdiv'>"+subject+"</div><input type='hidden' value='"+json.classDate+"' /><input type='hidden' value='"+code+"' />");				
							$("input#submit_code").val($("input#submit_code").val() + code + ","); // ???????????? ?????? ??? ????????????
						}
					}
					if(cnt4 == 3){
						alert("?????? ?????? 2??????????????? ?????? ???????????????.");
						cnt4=2;
					}
					
					if(json.classDate == '5'){						
						cnt5++;
						if(cnt5 !=3){
							$("td#jungong_fri").append("<div class='x'>x</div><div class='weekdiv'>"+subject+"</div><input type='hidden' value='"+json.classDate+"' /><input type='hidden' value='"+code+"' />");				
							$("input#submit_code").val($("input#submit_code").val() + code + ","); // ???????????? ?????? ??? ????????????
						}
					}
					if(cnt5 == 3){
						alert("?????? ?????? 2??????????????? ?????? ???????????????.");
						cnt5=2;
					}
					
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
				
			});//end of $.ajax({--------------------------------------------------------
			
		});//end of $("button.subj").click(function(){----------------------------------
		
		////////////////////////////////////////////////////////////////////////////////
		
		// ??????????????? ?????????
		$(document).on("click", ".x", function(){
			
			// ?????? ???????????? ????????? ?????????
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
			
			var subject = $(this).next().text(); 		    // ?????????
			var classDate = $(this).next().next().val();    // ????????????
			var code = $(this).next().next().next().val();  // ????????????
			
			// ???????????? ?????? ???????????? ??? ????????????		
			var text = $("input#submit_code").val().replace(code+",", "");
			$("input#submit_code").val(text);
			// ??????????????? ???????????? ?????? ????????????
			var html = "<button value='"+code+"' class='subj'>"+subject+"</button><input type='hidden' value='"+classDate+"' />";
			
			$("div#in").append(html);	
			
			$(this).next().remove();
			$(this).remove();
			
		});//end of $(document).on("click", ".subj", function(){------------------------
			
		////////////////////////////////////////////////////////////////////////////////
		
		// ???????????? ?????????
		$("button#memberAdd").click(function(){
			
			// ?????? ?????? ??? ???????????? ??????
			if($("select#jungong_nomember").val() == ""){
				alert("????????? ?????? ?????? ??? ????????? ???????????????");
			}
			else{
			
				// ??????????????? ??????????????? ????????? ????????? ?????????
				if($("input#update_hakbun").val() != ""){
					$("div#inMember").html("");
				}
				
				$("button#update").hide();
				$("button#save").show();
				
				// ???????????? ??? ???????????? ?????? ??? ????????????
				// ?????????
				$("td#jungong_mon").html("");
				$("td#jungong_tue").html("");
				$("td#jungong_wed").html("");
				$("td#jungong_thu").html("");
				$("td#jungong_fri").html("");
				
				// ?????? 2?????? ????????? ?????? ?????????
				cnt1 = 0;
				cnt2 = 0;
				cnt3 = 0;
				cnt4 = 0;
				cnt5 = 0;
				
				// ?????? ?????? ??????????????? ???????????? ?????????
				$("input#submit_code").val("");
				
				// ???????????? ???????????? ??? ?????????
				$("input#update_hakbun").val("");
				
				// ???????????? ???????????? ?????? ????????????
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
				
				// ??????????????? ????????? ?????? ????????????
				$("select#jungong_yesmember").val("");
				
				// ?????? ????????? ????????? ???????????? ?????? ?????????
				
				// ????????? ???????????????
				if($("select#jungong_nomember").val() != "" && $("input#submit_hakbun").val().indexOf($("select#jungong_nomember").val()) != -1){
					alert("?????? ?????? ??? ???????????????.");
				}
				else{
				
					// ???????????? ????????? ?????? ?????? ??? ?????? ????????????
					$.ajax({
						url:"<%= request.getContextPath()%>/searchNoMember.univ",
						type:"POST",
						data:{"hakbun":$("select#jungong_nomember").val()},
						dataType:"JSON",
						success:function(json){
							
							var html = "";
							
							$.each(json, function(index, item){
								
								html = "<button class='memberBtn' value='"+item.hakbun+"'>"+item.name+"&nbsp;&nbsp;X</button>";
		
			  					// ???????????? ?????? ??? ????????????
			  					$("input#submit_hakbun").val($("input#submit_hakbun").val() + item.hakbun + ",");
								
		  					});//end of $.each(json, function(index, item){--------------------------------------				
								
		  					// ????????????
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
			
		// ???????????? ???????????? ?????????
		
		$(document).on("click", ".memberBtn", function(){
			
			var hakbun = $(this).val();
			// ???????????? ?????? ???????????? ??? ????????????		
			var text1 = $("input#submit_hakbun").val().replace(hakbun+",", "");
			$("input#submit_hakbun").val(text1);
			
			// ?????????????????? ?????? ??? ????????? ????????? ???
			if($("input#update_hakbun").val() != ""){

				// ????????? ?????????
				$("div#in").html("");  
				$("td#jungong_mon").html("");  
				$("td#jungong_tue").html("");
				$("td#jungong_wed").html("");
				$("td#jungong_thu").html("");
				$("td#jungong_fri").html("");
				
				// ????????? ?????? ?????????
				$("input#submit_hakbun").val("");
				$("input#update_hakbun").val("");
				$("input#submit_code").val("");
				
				// ?????? 2?????? ????????? ?????? ?????????
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
		
		// ????????? ?????? ?????? ?????? ?????????
		
		$("button#memberDelete").click(function(){
			
			$("button#update").hide();
			$("button#save").hide();
			
			// ???????????? ?????????
			$("div#inMember").html("");     		
			
			// ????????? ?????????
			$("div#in").html("");  
			$("td#jungong_mon").html("");  
			$("td#jungong_tue").html("");
			$("td#jungong_wed").html("");
			$("td#jungong_thu").html("");
			$("td#jungong_fri").html("");
			
			// ????????? ?????? ?????????
			$("input#submit_hakbun").val("");
			$("input#update_hakbun").val("");
			$("input#submit_code").val("");
			
			// ?????? 2?????? ????????? ?????? ?????????
			cnt1 = 0;
			cnt2 = 0;
			cnt3 = 0;
			cnt4 = 0;
			cnt5 = 0;	
			
		});//end of $("button#omemberDelete").click(function(){---------------------------------
		
		////////////////////////////////////////////////////////////////////////////////////////	
		
		// ?????? ?????? ?????????
		
		$("button#allmemberAdd").click(function(){
		
			// ????????? ??????????????? ?????? ?????? ????????? ?????? ????????? ?????? ??????
			var cnt = 0;
			
			$("button#update").hide();
			$("button#save").show();
			
			// ???????????? ?????????
			$("div#inMember").html("");     		
			// ????????? ?????????
			$("div#in").html("");  
			$("td#jungong_mon").html("");  
			$("td#jungong_tue").html("");
			$("td#jungong_wed").html("");
			$("td#jungong_thu").html("");
			$("td#jungong_fri").html("");
			
			// ????????? ?????? ?????????
			$("input#submit_hakbun").val("");
			$("input#submit_code").val("");
			$("input#update_hakbun").val("");
			
			// ????????? ?????? ???????????? ????????? ????????????
			$.ajax({
				url:"<%= request.getContextPath()%>/sugangNoMember.univ",
				type:"POST",
				data:{"fk_deptCode":$("select#jungong_deptCode").val()},
				dataType:"JSON",
				success:function(json){
					
					var html = "";
					
					$.each(json, function(index, item){

						html += "<button class='memberBtn' value='"+item.hakbun+"'>"+item.name+"&nbsp;&nbsp;X</button>";
						
	  					// ???????????? ?????? ??? ????????????
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
				
				// ???????????? ???????????? ?????? ????????????
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
			
				alert("?????? ??? ???????????? ????????? ????????????.");
				$("input#submit_hakbun").val("");
				$("button#update").hide();
				$("button#save").hide();
				
			}//end of if(cnt > 0){--------------------------------------------------------------
				
		});//end of $("button#allmemberAdd").click(function(){----------------------------------
		
		////////////////////////////////////////////////////////////////////////////////////////
		
		// ???????????? ??????
		
		$("button#save").click(function(){
			
			// ????????? ??? ????????? ??????
			if( $("input#submit_hakbun").val() != "" && $("input#submit_code").val() != "") {
			
				$.ajax({
					url:"<%= request.getContextPath()%>/saveSugang.univ",
					type:"POST",
					data:{"hakbun":$("input#submit_hakbun").val()
						 ,"code":$("input#submit_code").val()},
					dataType:"JSON",
					success:function(json){
						if(json.n > 0){
							alert("???????????? ?????? ???????????????.");		
						}
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({----------------------------------------------------
			
			}
			else{

				alert("?????? ??? ?????? ?????? ?????? ?????? ????????????.");	
				
			}//end of if( $("input#submit_hakbun").val() != "" && $("input#submit_code").val() != "") {
				
			// ???????????? ????????? ??? ????????????
			
			// ???????????? ?????????
			$("div#inMember").html("");     		
			// ????????? ?????????
			$("div#in").html("");  
			$("td#jungong_mon").html("");  
			$("td#jungong_tue").html("");
			$("td#jungong_wed").html("");
			$("td#jungong_thu").html("");
			$("td#jungong_fri").html("");
			
			// ????????? ?????? ?????????
			$("input#submit_hakbun").val("");
			$("input#submit_code").val("");
			
			// ?????? 2?????? ????????? ?????? ?????????
			cnt1 = 0;
			cnt2 = 0;
			cnt3 = 0;
			cnt4 = 0;
			cnt5 = 0;			
					
		});//end of $("button#save").click(function(){------------------------------------------
		
		////////////////////////////////////////////////////////////////////////////////////////
		
		// ??????????????? ????????? ????????????
		
		$("select#jungong_yesmember").click(function(){
		
			if($("select#jungong_deptCode").val() != "no" && $(this).val() != ""){
				$("button#update").show();
			}
			
			$("button#save").hide();
			
			// ????????? ??? ????????????
			$("input#update_hakbun").val($(this).val());
			
			// ????????? ?????? ????????? ??????
			if($("select#jungong_yesmember").val() != ""){
			
				// ??? ????????????
				// ???????????? ?????????
				$("div#inMember").html("");     		
				// ????????? ?????????
				$("div#in").html("");  
				$("td#jungong_mon").html("");  
				$("td#jungong_tue").html("");
				$("td#jungong_wed").html("");
				$("td#jungong_thu").html("");
				$("td#jungong_fri").html("");
				
				// ????????? ?????? ?????????
				$("input#submit_hakbun").val("");
				$("input#submit_code").val("");
				
				// ?????? 2?????? ????????? ?????? ?????????
				cnt1 = 0;
				cnt2 = 0;
				cnt3 = 0;
				cnt4 = 0;
				cnt5 = 0;	
				
				// ????????? ??? ?????? ????????????	 ( ??? ???????????? ?????? ????????? ?????? ???????????? )	
				$.ajax({
					url:"<%= request.getContextPath()%>/SelectSugangMember.univ",
					type:"POST",
					data:{"hakbun":$("select#jungong_yesmember").val()},
					dataType:"JSON",
					success:function(json){
						
						var html = ""; // ????????????
						
						$.each(json, function(index, item){
	
							html = "<button class='memberBtn' value='"+item.hakbun+"'>"+item.name+"&nbsp;&nbsp;X</button>";
							
							// ????????? ????????? ??????????????????
							if(item.classDate == '1'){						
								cnt1++;
								if(cnt1 !=3){
									$("td#jungong_mon").append("<div class='x'>x</div><div class='weekdiv'>"+item.subject+"</div><input type='hidden' value='"+item.classDate+"' /><input type='hidden' value='"+item.code+"' />");				
				  					$("input#submit_code").val($("input#submit_code").val() + item.code + ","); // ???????????? ?????? ??? ????????????
								}
							}
							if(cnt1 == 3){
								alert("?????? ?????? 2??????????????? ?????? ???????????????.");
								cnt1=2;
							}
						
							if(item.classDate == '2'){						
								cnt2++;
								if(cnt2 !=3){
									$("td#jungong_tue").append("<div class='x'>x</div><div class='weekdiv'>"+item.subject+"</div><input type='hidden' value='"+item.classDate+"' /><input type='hidden' value='"+item.code+"' />");				
									$("input#submit_code").val($("input#submit_code").val() + item.code + ","); // ???????????? ?????? ??? ????????????
								}
							}
							if(cnt2 == 3){
								alert("?????? ?????? 2??????????????? ?????? ???????????????.");
								cnt2=2;
							}
							
							if(item.classDate == '3'){						
								cnt3++;
								if(cnt3 !=3){
									$("td#jungong_wed").append("<div class='x'>x</div><div class='weekdiv'>"+item.subject+"</div><input type='hidden' value='"+item.classDate+"' /><input type='hidden' value='"+item.code+"' />");				
									$("input#submit_code").val($("input#submit_code").val() + item.code + ","); // ???????????? ?????? ??? ????????????
								}
							}
							if(cnt3 == 3){
								alert("?????? ?????? 2??????????????? ?????? ???????????????.");
								cnt3=2;
							}
							
							if(item.classDate == '4'){						
								cnt4++;
								if(cnt4 !=3){
									$("td#jungong_thu").append("<div class='x'>x</div><div class='weekdiv'>"+item.subject+"</div><input type='hidden' value='"+item.classDate+"' /><input type='hidden' value='"+item.code+"' />");				
									$("input#submit_code").val($("input#submit_code").val() + item.code + ","); // ???????????? ?????? ??? ????????????
								}
							}
							if(cnt4 == 3){
								alert("?????? ?????? 2??????????????? ?????? ???????????????.");
								cnt4=2;
							}
							
							if(item.classDate == '5'){						
								cnt5++;
								if(cnt5 !=3){
									$("td#jungong_fri").append("<div class='x'>x</div><div class='weekdiv'>"+item.subject+"</div><input type='hidden' value='"+item.classDate+"' /><input type='hidden' value='"+item.code+"' />");				
									$("input#submit_code").val($("input#submit_code").val() + item.code + ","); // ???????????? ?????? ??? ????????????
								}
							}
							if(cnt5 == 3){
								alert("?????? ?????? 2??????????????? ?????? ???????????????.");
								cnt5=2;
							}
							
							// ???????????? ?????? ??? ????????????
		  					$("input#submit_hakbun").val(item.hakbun + ",");
		  					// ????????????
		  					$("div#inMember").html(html);
							
	  					});//end of $.each(json, function(index, item){--------------------------------------				
		
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({------------------------------------------------------------
					
				// ???????????? ?????? ?????? ???????????? ??? ????????????
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
		
		// ???????????? ??????
		
		$("button#update").click(function(){
			
			$.ajax({
				url:"<%= request.getContextPath()%>/UpdateSugang.univ",
				type:"POST",
				data:{"hakbun":$("input#update_hakbun").val()
					 ,"code":$("input#submit_code").val()},	 
				dataType:"JSON",
				success:function(json){				
					alert("?????? ???????????? ??????");					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
				
			});//end of $.ajax({----------------------------------------------------
				
			// ???????????? ????????? ??? ????????????
			
			// ???????????? ?????????
			$("div#inMember").html("");     		
			// ????????? ?????????
			$("div#in").html("");  
			$("td#jungong_mon").html("");  
			$("td#jungong_tue").html("");
			$("td#jungong_wed").html("");
			$("td#jungong_thu").html("");
			$("td#jungong_fri").html("");
			
			// ????????? ?????? ?????????
			$("input#submit_hakbun").val("");
			$("input#update_hakbun").val("");
			$("input#submit_code").val("");
			
			// ?????? 2?????? ????????? ?????? ?????????
			cnt1 = 0;
			cnt2 = 0;
			cnt3 = 0;
			cnt4 = 0;
			cnt5 = 0;		
			
			$(this).hide();
					
		});//end of $(document).on("click", "#update", function(){
			
		////////////////////////////////////////////////////////////////////////////////////////
		
		// ?????? ?????? ??????
		
		// ?????? ????????? ?????? ?????????
		$(document).on("click", "#Input_subject", function(){
			
			if($(this).next().val() == "update"){
				
				$("h5#staticBackdropLabel").text("????????????");
				var code = $(this).next().next().val();
				var subject = $(this).next().next().next().val();
				
				$("input#subject_code").val(code);
				$("input#subject_subject").val(subject);
				
				$("input#checkUpdate").val("update");
				
			}//end of if($(this).next().val() == "update"){------------------------------------
			
		});//end of $(document).on("click", "#Input_subject", function(){----------------------
		
		///////////////////////////////////////////////////////////////////////////////////////	
			
		// ???????????? ????????????	
			
		$("button#servey").click(function(){
			
			var confrimflag = confirm("???????????? ???????????? ?????????????????????????");
			
			if(confrimflag){
				
				var frm = document.no;
				
				frm.method = "POST";
				frm.action = "<%= ctxPath%>/adminChart.univ";
				frm.submit();
				 
			}
			
		});//end of $("button#servey").click(function(){---------------------------------------	
			
		///////////////////////////////////////////////////////////////////////////////////////	
		
		// ????????? ????????????	
			
		$("button#jjokji").click(function(){
			
			var confrimflag = confirm("????????? ???????????? ?????????????????????????");
			
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
  		<%-- ?????? ????????? --%>
  		<nav>
  			<form name="no">
			  	<div class="nav nav-tabs" id="nav-tab" role="tablist" style="border:solid 1px #ffb84d;">
			    	<button style="color:#ffb84d;" class="nav-link active" id="student" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">????????????</button>
			    	<button style="color:#ffb84d;" class="nav-link" id="teacher" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">????????????</button>
			    	<button style="color:#ffb84d;" class="nav-link" id="subject" data-bs-toggle="tab" data-bs-target="#nav-contact" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">????????????</button>
			    	<button style="color:#ffb84d;" class="nav-link" id="sugang" data-bs-toggle="tab" data-bs-target="#nav-contact2" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">????????????</button>
			    	<button style="color:#ffb84d;" class="nav-link" id="servey" data-bs-toggle="tab" data-bs-target="#nav-contact3" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">????????????</button>
			    	<button style="color:#ffb84d;" class="nav-link" id="jjokji" data-bs-toggle="tab" data-bs-target="#nav-contact4" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">?????????</button>
				</div>
			</form>
		</nav>
		
		<%-- ?????? ?????? --%>
		<div class="tab-content" id="nav-tabContent">
		  	<%-- ???????????? --%>
		  	<div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
		  		<table class="tbl">
		  			<tr>
		  				<td class="top_td">
		  					<select class="inp" id="studentStatus">
		  						<option value="no">???????????? (??????)</option>
		  						<option value="0">?????????</option>
		  						<option value="1">??????</option>
		  						<option value="2">??????</option>
		  						<option value="3">??????</option>
		  						<option value="4">??????</option>
		  					</select>		  					
		  					<select class="inp" id="studentFk_deptCode">
		  						<option value="no">?????? (??????)</option>
		  						
		  						<%-- ??? ???????????? --%>
		  						<c:forEach var="deptvo" items="${requestScope.deptList}">
		  							<option value="${deptvo.deptCode}">${deptvo.deptName}</option>
		  						</c:forEach>
		  						
		  					</select>		  					
		  					<select class="inp" id="studentSearchType">
		  						<option value="no">????????? (??????)</option>
		  						<option value="hakbun">????????????</option>
		  						<option value="name">????????????</option>
		  						<option value="phone">???????????????</option>
		  					</select>		  					
		  					<input class="inp" type="text" id="studentSearchWord" autocomplete="off"/>		  					
		  					<button class="search" id="Search_student">??????</button>				
		  					<button type="button" class="modalbtn2" id="Input_member" data-bs-toggle="modal" data-bs-target="#Input_memberList">??????</button>
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
		  			  	
		  	<%-- ???????????? --%>
		  	<div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
		  		<table class="tbl">
		  			<tr>
		  				<td class="top_td">
		  					<select class="inp" id="teacherStatus">
		  						<option value="no">???????????? (??????)</option>
		  						<option value="1">??????</option>
		  						<option value="2">??????</option>
		  						<option value="4">??????</option>
		  					</select>		  					
		  					<select class="inp" id="teacherFk_deptCode">
		  						<option value="no">?????? (??????)</option>
		  						
		  						<%-- ??? ???????????? --%>
		  						<c:forEach var="deptvo" items="${requestScope.deptList}">
		  							<option value="${deptvo.deptCode}">${deptvo.deptName}</option>
		  						</c:forEach>
		  						
		  					</select>		  					
		  					<select class="inp" id="teacherSearchType">
		  						<option value="no">????????? (??????)</option>
		  						<option value="hakbun">????????????</option>
		  						<option value="name">????????????</option>
		  						<option value="phone">???????????????</option>
		  					</select>		  					
		  					<input class="inp" type="text" id="teacherSearchWord" autocomplete="off"/>		  					
		  					<button class="search" id="Search_teacher">??????</button>
		  					<button type="button" class="modalbtn2" id="Input_teacher" data-bs-toggle="modal" data-bs-target="#Input_teacherList">??????</button>
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
		  			  	
		  	<%-- ???????????? --%>
			<div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
				<table class="tbl">
		  			<tr>
		  				<td class="top_td">
		  					<select class="inp" id="classDate">
		  						<option value="no">?????? (??????)</option>
		  						<option value="1">???</option>
		  						<option value="2">???</option>
		  						<option value="3">???</option>
		  						<option value="4">???</option>
		  						<option value="5">???</option>
		  					</select>		  					
		  					<select class="inp" id="subjectFk_deptCode">
		  						<option value="no">?????? (??????)</option>
		  						
		  						<%-- ??? ???????????? --%>
		  						<c:forEach var="deptvo" items="${requestScope.deptList}">
		  							<option value="${deptvo.deptCode}">${deptvo.deptName}</option>
		  						</c:forEach>
		  						
		  					</select>		  					
		  					<select class="inp" id="subjectSearchType">
		  						<option value="no">????????? (??????)</option>
		  						<option value="fk_hakbun">???????????????</option>
		  						<option value="subject">?????????</option>
		  					</select>		  					
		  					<input class="inp" type="text" id="subjectSearchWord" autocomplete="off"/>	
		  					<button class="search" id="Search_subject">??????</button>		  					
							<button type="button" class="modalbtn2" id="Input_subject" data-bs-toggle="modal" data-bs-target="#Input_subjectList">??????</button>
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
			
			<%-- ???????????? --%>
		  	<div class="tab-pane fade" id="nav-contact2" role="tabpanel" aria-labelledby="nav-contact-tab">
		  		<table class="tbl">
		  			<tr>
		  				<td  colspan="2" class="top_td">		  					
		  					<select class="inp" id="jungong_deptCode">
		  						<option value="no">?????? (??????)</option>
		  						
		  						<%-- ??? ???????????? --%>
		  						<c:forEach var="deptvo" items="${requestScope.deptList}">
		  							<option value="${deptvo.deptCode}">${deptvo.deptName}</option>
		  						</c:forEach>
		  						
		  					</select>
		  					<select class="inp" id="jungong_nomember">		  						
		  						<option value="">??????????????? ??????</option>
		  					</select>
		  					<button class="jungongBtn" id="memberAdd">????????????</button>
		  					<button class="jungongBtn" id="allmemberAdd">??????????????????</button>
		  					<button class="jungongBtn" id="memberDelete">????????????</button>
		  					<select class="inp" id="jungong_yesmember">		  						
		  						<option value="">?????????????????? ??????</option>
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
									<td class="jungongSchedule" style="background-color:#ff5c33;">???</td>
									<td class="jungongSchedule" style="background-color:#ffc266;">???</td>
									<td class="jungongSchedule" style="background-color:#ffff99;">???</td>
									<td class="jungongSchedule" style="background-color:#b3ff99;">???</td>
									<td class="jungongSchedule" style="background-color:#99ffdd;">???</td>
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
											<li>?????? ???????????? ?????? ????????? ????????? ??? ????????????.</li>
											<li>??? ????????? ???????????? ?????? ?????????.</li>
											<li>?????? ?????? 2?????? ????????? ???????????? ???????????????</li>
											<li>???????????? ??? ????????? ????????? ?????? ????????????</li>
											<li>???????????? ????????? ?????? ??? ????????? ????????? ???????????????.</li>
										</ul>
									</td>
								</tr>	        					
        					</table>
		  				</td>
		  				<td class="jungongBottom">
		  					<form>
			  					<button id="save" class="jgbtn" style="background-color:#f0f5f5">??????</button>
			  					<button id="update" class="jgbtn" style="background-color:#d0e1e1">??????</button>
		  					</form>	
		  					<%-- ?????? ??? ?????? ???????????? ??? --%>
		  					<div id="in" style="height:305px; width:500px; margin:10px 0px 0px 23px; border:solid 1px gray; overflow:auto;">
		  						
		  					</div>
		  				</td>
		  			</tr>
		  		</table>
		  	</div>
		</div>
	</div>
</div>

<%-- ????????? ???????????? --%>
<input type="hidden" value="" id="submit_hakbun"/>
<input type="hidden" value="" id="submit_code"/>

<input type="hidden" value="" id="update_hakbun"/>

<%-- ======================================= ?????? ?????? ======================================= --%>


<%-- ??????, ?????? ????????? ?????? --%>		
<div class="modal fade" id="information" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    	<div class="modal-content" style="width:1000px; margin-left:-250px;">
      		<div class="modal-header">
        		<h5 class="modal-title" id="exampleModalLabel">????????????</h5>
        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      		</div>
      		<div class="modal-body">
        		<table style="border:solid 1px gray; width:960px; text-align:center; font-size:10pt; margin-left:3px;">
        			<tr>
        				<td colspan="4" style="background-color:#ccefff; height:40px;">
        					????????????
        				</td>
        			</tr>
        			<tr>
        				<td id="picture" class="modaltd" rowspan="6">
        					 
        				</td>
        				<td class="modaltd" style="background-color:#e6ffff;">??????</td>
        				<td class="modaltd" style="background-color:#e6ffff;">????????????</td>
        				<td class="modaltd" style="background-color:#e6ffff;">?????????</td>
        			</tr>
        			<tr>
        				<td id="name" class="modaltd"></td>
        				<td id="birth" class="modaltd"></td>
        				<td id="phone" class="modaltd"></td>
        			</tr>
        			<tr>
        				<td class="modaltd" style="background-color:#e6ffff;">?????????</td>
        				<td class="modaltd" style="background-color:#e6ffff;">??????</td>
        				<td class="modaltd" style="background-color:#e6ffff;">??????</td>
        			</tr>
        			<tr>	
        				<td id="email" class="modaltd"></td>
        				<td id="hakbun" class="modaltd"></td>
        				<td id="deptname" class="modaltd"></td>
        			</tr>
        			<tr>	
        				<td class="modaltd" colspan="2" style="background-color:#e6ffff;">??????</td>
        				<td class="modaltd" style="background-color:#e6ffff;">???????????? ??????</td>
        			</tr>
        			<tr>  				
        				<td id="address" class="modaltd" colspan="2"></td>
        				<td class="modaltd">
        					<select id="status" style="width:150px;">

        					</select>
        					<button id="updateStatus" style="margin-left:10px; width:50px; border:solid 1px gray; background-color:#e6ffff;">??????</button>
        					<input type="hidden" id="hiddenHakbun"/>
        				</td>
        			</tr>
        		</table>
      		</div>
    	</div>
  	</div>
</div>

<%-- ?????? ?????? --%>	
<div class="modal fade" id="Input_memberList" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
    	<div class="modal-content" style="width:500px; margin-left:0px;">
      		<div class="modal-header">
        		<h5 class="modal-title" id="staticBackdropLabel">????????????</h5>
        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      		</div>
      		<div class="modal-body">     		
        		<table style="border:solid 1px gray; width:460px; text-align:center; font-size:11pt; margin-left:3px;">
        			<tr>
        				<td colspan="2" style="background-color:#ccefff; height:40px;">?????? ????????????</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">??????</td>
        				<td style="width:330px; border:solid 1px gray;">
        					<input class="madal_input" type="text" style="width:230px;" id="student_hakbun" autocomplete="off"/>
        					<button id="CheckStudentHakbun" class="modal_button">??????</button>
        					<span id="stdv" class="v"></span>
        				</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">??????</td>
        				<td style="width:330px; border:solid 1px gray;">
        				<%-- ??? ???????????? --%>
		  					<select style="width:280px;" id="student_fk_deptCode">	
		  						<c:forEach var="deptvo" items="${requestScope.deptList}">
		  							<option>??????(??????)</option>
		  							<option value="${deptvo.deptCode}">${deptvo.deptName}</option>
		  						</c:forEach>
		  					</select>	
        				</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">??????</td>
        				<td style="width:300px; border:solid 1px gray;"><input class="madal_input" type="text" id="student_name" autocomplete="off"/></td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">?????????</td>
        				<td style="width:300px; border:solid 1px gray;"><input class="madal_input" type="text" id="student_email" autocomplete="off"/></td>
        			</tr>
        			<tr>
        				<td colspan="2" id="stderrmsg" style="width:560px; height:40px; border:solid 1px gray; color:red; font-size:11pt;">
        					
        				</td>
        			</tr>
        		</table>
      		</div>
      		<div class="modal-footer">
        		<button type="button" class="submitbtn" id="membersubmit">??????</button>
      		</div>
    	</div>
  	</div>
</div>

<%-- ?????? ?????? --%>	
<div class="modal fade" id="Input_teacherList" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
    	<div class="modal-content" style="width:500px; margin-left:-0px;">
      		<div class="modal-header">
        		<h5 class="modal-title" id="staticBackdropLabel">?????? ??????</h5>
        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      		</div>
      		<div class="modal-body">
        		<table style="border:solid 1px gray; width:460px; text-align:center; font-size:11pt; margin-left:3px;">
        			<tr>
        				<td colspan="2" style="background-color:#ccefff; height:40px;">?????? ????????????</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">??????</td>
        				<td style="width:330px; border:solid 1px gray;">
        					<input class="madal_input" type="text" style="width:230px;" id="teacher_hakbun" autocomplete="off"/>
        					<button id="CheckTeacherHakbun" class="modal_button">??????</button>
        					<span id="teav" class="v"></span>
        				</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">??????</td>
        				<td style="width:330px; border:solid 1px gray;">
        				<%-- ??? ???????????? --%>
		  					<select style="width:280px;" id="teacher_fk_deptCode">	
		  						<c:forEach var="deptvo" items="${requestScope.deptList}">
		  							<option value="${deptvo.deptCode}">${deptvo.deptName}</option>
		  						</c:forEach>
		  					</select>	
        				</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">??????</td>
        				<td style="width:300px; border:solid 1px gray;"><input class="madal_input" type="text" id="teacher_name" autocomplete="off"/></td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">?????????</td>
        				<td style="width:300px; border:solid 1px gray;"><input class="madal_input" type="text" id="teacher_email" autocomplete="off"/></td>
        			</tr>
        			<tr>
        				<td colspan="2" id="teaerrmsg" style="width:560px; height:40px; border:solid 1px gray; color:red; font-size:11pt;">
        					
        				</td>
        			</tr>
        		</table>
      		</div>
      		<div class="modal-footer">
        		<button type="button" class="submitbtn" id="teachersubmit">??????</button>
      		</div>
    	</div>
  	</div>
</div>

<%-- ?????? ?????? --%>	
<div class="modal fade" id="Input_subjectList" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
    	<div class="modal-content" style="width:500; margin-left:-0px;">
      		<div class="modal-header">
        		<h5 class="modal-title" id="staticBackdropLabel">????????????</h5>
        		<button type="button" id="closeBtn" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      		</div>
      		<div class="modal-body">
        		<table style="border:solid 1px gray; width:460px; text-align:center; font-size:11pt; margin-left:3px;">
        			<tr>
        				<td colspan="2" style="background-color:#ccefff; height:40px;">?????? ????????????</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">????????????</td>
        				<td style="width:330px; border:solid 1px gray;">
        					<input class="madal_input" type="text" style="width:230px;" id="subject_code" autocomplete="off"/>
        					<button id="CheckSubjectCode" class="modal_button">??????</button>
        					<span id="subv1" class="v"></span>
        				</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">?????????</td>
        				<td style="width:330px; border:solid 1px gray;">
        					<input class="madal_input" type="text" style="width:230px;" id="subject_subject" autocomplete="off"/>
        					<button id="CheckSubjectSubject" class="modal_button">??????</button>
        					<span id="subv2" class="v"></span>
        				</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">??????</td>
        				<td style="width:330px; border:solid 1px gray;">
        				<%-- ??? ???????????? --%>
		  					<select style="width:280px;" id="subject_fk_deptCode">	
		  						<c:forEach var="deptvo" items="${requestScope.deptList}">
		  							<option value="${deptvo.deptCode}">${deptvo.deptName}</option>
		  						</c:forEach>
		  					</select>	
        				</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">????????????</td>
        				<td style="width:330px; border:solid 1px gray;">
        				<%-- ???????????? ???????????? --%>
		  					<select style="width:230px;" id="subjectTeacher_fk_hakbun">	

		  					</select>
		  					<button id="CheckSubjectTeacher" class="modal_button">??????</button>
        					<span id="subv3" class="v"></span>	
        				</td>
        			</tr>
        			<tr>
        				<td style="width:130px; height:40px; border:solid 1px gray;">????????????</td>
        				<td style="width:330px; border:solid 1px gray;">
		  					<select style="width:124px; margin-left:10px;" id="subject_hakjum">	
								<option value="">??????</option>
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
									<td class="scheduleWeek" style="background-color:#ff5c33;">???</td>
									<td class="scheduleWeek" style="background-color:#ffc266;">???</td>
									<td class="scheduleWeek" style="background-color:#ffff99;">???</td>
									<td class="scheduleWeek" style="background-color:#b3ff99;">???</td>
									<td class="scheduleWeek" style="background-color:#99ffdd;">???</td>
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
        		<button type="button" class="submitbtn" id="subjectsubmit">??????</button>
        		<input type="hidden" value="" id="checkUpdate" />
      		</div>
    	</div>
  	</div>
</div>