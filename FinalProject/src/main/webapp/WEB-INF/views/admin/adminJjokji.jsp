<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


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
		margin-left:20px;
		border:solid 1px #ffb84d;
		background-color:white;
		font-size:10pt; 
		height:30px;
	}
	
	.subjectStyle {
		background-color:#ffd699;
		font-weight:bold;
		color:#995c00;
		cursor:pointer;
	}

	.chkbox{
		margin:5px 0px 0px 5px;
	}
	
	.acdtable{
		margin:15px 0px 15px 100px;
		border:solid 4px #b3e0ff;
		width:850px;
		text-align:center;
		fontsize:12pt;
	}

	.acdtd{
		height:50px;
		background-color:#e6f5ff;
		border:solid 3px #b3e0ff;
	}
	
	.acdtd2{
		background-color:white;
		border:solid 4px #b3e0ff;
		text-align:left;
		padding-left:10px;
	}
	
	.Chktop{
		background-color:#ffd699;
		text-align:right;
		height:45px;
		padding:8px 15px 0px 0px;
	}
	
	.spantop{
		font-size:9pt;
		margin-right:5px;
	}

</style>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery.form.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		if("${requestScope.n}" == 1){
			alert("????????? ?????????????????????.");
		}
		
		//////////////////////////////////////////////////////////////////////////////
		
		// ?????? ????????? ??????
		
		$("button.accordion-button").bind("mouseover", function(event){
			$(this).addClass("subjectStyle");
			$(this).children('table').addClass("subjectStyle");
		});
		
		$("button.accordion-button").bind("mouseout", function(){
			$(this).removeClass("subjectStyle");
			$(this).children('table').removeClass("subjectStyle");
		});
		
		///////////////////////////////////////////////////////////////////////////////
		
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
		
		// ?????? ?????? ???????????? ????????? ????????????
		
		$("button#senderSearch").click(function(){
			
			if($("select#senderType").val() == ""){
				console.log($("select#senderType").val());
				alert("???????????? ???????????????.");
				$("select#senderType").focus();
				
			}
			else{
				
				$("select#receiveType").val("");
				$("select#starType").val("");
				
				var frm = document.sender_orderBy;
				frm.method = "POST";
				frm.action = "<%= ctxPath%>/adminJjokji.univ";
				frm.submit();
				
			}
			
		});//end of $("button#senderSearch").click(function(){--------------------------
		
		////////////////////////////////////////////////////////////////////////////////	
		
		// ?????? ?????? ???????????? ????????? ????????????
		
		$("button#receiveSearch").click(function(){
			
			if($("select#receiveType").val() == ""){
				
				alert("???????????? ???????????????.");
				$("select#receiveType").focus();
				
			}
			else{
			
				$("select#senderType").val("");
				$("select#starType").val("");
				
				var frm = document.receive_orderBy;
				frm.method = "POST";
				frm.action = "<%= ctxPath%>/adminJjokji.univ";
				frm.submit();
			
			}
			
		});//end of $("button#senderSearch").click(function(){--------------------------
			
		////////////////////////////////////////////////////////////////////////////////	
		
		// ???????????? ?????? ???????????? ????????? ????????????
		
		$("button#starSearch").click(function(){
			
			if($("select#starType").val() == ""){
				
				alert("???????????? ???????????????.");
				$("select#starType").focus();
				
			}
			else{
			
				$("select#receiveType").val("");
				$("select#senderType").val("");
				
				var frm = document.star_orderBy;
				frm.method = "POST";
				frm.action = "<%= ctxPath%>/adminJjokji.univ";
				frm.submit();
			
			}
			
		});//end of $("button#senderSearch").click(function(){--------------------------	

		////////////////////////////////////////////////////////////////////////////////
			
		// ??????????????????
		
		$("button#reset").click(function(){
			
			var frm = document.no;
			
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/adminJjokji.univ";
			frm.submit();
		
		});//end of $("button#reset").click(function(){---------------------------------
		
		////////////////////////////////////////////////////////////////////////////////
		
		// ?????? ?????????
		$("div#senderChk").hide();
		
		// ????????? ???????????? ?????????
		$("input.schkbox").click(function(){
			
			$("input:checkbox[name=schk]").each(function(){
				
				if($(this).is(":checked")){
					$("div#senderChk").show();
					return false;
				}
				else{
					$("div#senderChk").hide();
				}
				
			});//end of $("input:checkbox[name=chk]").each(function(){-----------------
			
		});//end of $("input.schkbox").click(function(){-------------------------------
		
		///////////////////////////////////////////////////////////////////////////////
		
		// ?????? ?????????
		$("div#receiveChk").hide();
			
		// ????????? ???????????? ?????????
		$("input.rchkbox").click(function(){
			
			$("input:checkbox[name=rchk]").each(function(){
				
				if($(this).is(":checked")){
					$("div#receiveChk").show();
					return false;
				}
				else{
					$("div#receiveChk").hide();
				}
				
			});//end of $("input:checkbox[name=chk]").each(function(){-----------------
			
		});//end of $("input.schkbox").click(function(){-------------------------------
			
		///////////////////////////////////////////////////////////////////////////////
		
		// ?????? ?????????
		$("div#starChk").hide();
			
		// ????????? ???????????? ?????????
		$("input.tchkbox").click(function(){
			
			$("input:checkbox[name=tchk]").each(function(){
				
				if($(this).is(":checked")){
					$("div#starChk").show();
					return false;
				}
				else{
					$("div#starChk").hide();
				}
				
			});//end of $("input:checkbox[name=chk]").each(function(){-----------------
			
		});//end of $("input.schkbox").click(function(){-------------------------------	
			
		////////////////////////////////////////////////////////////////////////////////
		
		// ????????? ???????????????
		$("input#senderAll").click(function(){
			
			if($(this).is(":checked")){

				$("input:checkbox[name=schk]").prop("checked", true);
				$("span#senderSpan").text("???????????? ??????");
				
			}
			else{

				$("input:checkbox[name=schk]").prop("checked", false);
				$("span#senderSpan").text("????????????");
				
			}
			
		});//end of $("checkbox#senderAll").click(function(){---------------------------
		
		////////////////////////////////////////////////////////////////////////////////	
			
		// ????????? ???????????????
		$("input#receiveAll").click(function(){
			
			if($(this).is(":checked")){

				$("input:checkbox[name=rchk]").prop("checked", true);
				$("span#receiveSpan").text("???????????? ??????");
				
			}
			else{

				$("input:checkbox[name=rchk]").prop("checked", false);
				$("span#receiveSpan").text("????????????");
				
			}
			
		});//end of $("checkbox#senderAll").click(function(){---------------------------	
		
		////////////////////////////////////////////////////////////////////////////////

		// ????????? ???????????????
		$("input#starAll").click(function(){
			
			if($(this).is(":checked")){

				$("input:checkbox[name=tchk]").prop("checked", true);
				$("span#starSpan").text("???????????? ??????");
				
			}
			else{

				$("input:checkbox[name=tchk]").prop("checked", false);
				$("span#starSpan").text("????????????");
				
			}
			
		});//end of $("checkbox#senderAll").click(function(){---------------------------	
		
		////////////////////////////////////////////////////////////////////////////////
		
		// ????????? ???????????? ??????
		$("button#senderDel").click(function(){
			
			var jseq = "";
			var cnt = 0;
			
			$("input:checkbox[name=schk]").each(function(){
				
				if($(this).is(":checked")){
					
					jseq += $(this).next().val() + ",";
					cnt++;
					
				}//end of if($(this).is(":checked")){-----------------------------------
			
			});//end of $("input:checkbox[name=schk]").each(function(){-----------------
			
			if(cnt == 0){
				alert("????????? ????????? ????????????.");	
			}
			else{
				
				$.ajax({
					url:"<%= request.getContextPath()%>/jjokjiDel.univ",
					type:"POST",
					data:{"jseq":jseq},
					dataType:"JSON",
					success:function(json){

						if(json.n > 0){
							alert(json.n+"?????? ????????? ?????????????????????.");
							window.location.reload();
						}
						// ?????????
						$("div#senderChk").hide();
	  						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({--------------------------------------------------------
				
			}//end of if(cnt == 0){-----------------------------------------------------
			
			// ???????????? ??????
			$("input:checkbox[name=schk]").prop("checked", false);
			
		});//end of $("button#senderDel").click(function(){-----------------------------
	
		////////////////////////////////////////////////////////////////////////////////	
			
		// ????????? ???????????? ??????
		$("button#receiveDel").click(function(){
			
			var jseq = "";
			var cnt = 0;
			
			$("input:checkbox[name=rchk]").each(function(){
				
				if($(this).is(":checked")){
					
					jseq += $(this).next().val() + ",";
					cnt++;
					
				}//end of if($(this).is(":checked")){-----------------------------------
			
			});//end of $("input:checkbox[name=schk]").each(function(){-----------------
			
			if(cnt == 0){
				alert("????????? ????????? ????????????.");	
			}
			else{
				
				$.ajax({
					url:"<%= request.getContextPath()%>/jjokjiDel.univ",
					type:"POST",
					data:{"jseq":jseq},
					dataType:"JSON",
					success:function(json){

						if(json.n > 0){
							alert(json.n+"?????? ????????? ?????????????????????.");
							window.location.reload();
						}
						// ?????????
						$("div#receiveChk").hide();
	  						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({--------------------------------------------------------
				
			}//end of if(cnt == 0){-----------------------------------------------------
			
			// ???????????? ??????
			$("input:checkbox[name=rchk]").prop("checked", false);
			
		});//end of $("button#senderDel").click(function(){-----------------------------	
			
		////////////////////////////////////////////////////////////////////////////////

		// ????????? ???????????? ??????
		$("button#senderStar").click(function(){
			
			var jseq = "";
			var cnt = 0;
			
			$("input:checkbox[name=schk]").each(function(){
				
				if($(this).is(":checked")){
					
					jseq += $(this).next().val() + ",";
					cnt++;
					
				}//end of if($(this).is(":checked")){-----------------------------------
			
			});//end of $("input:checkbox[name=schk]").each(function(){-----------------
			
			if(cnt == 0){
				alert("????????? ????????? ????????????.");	
			}
			else{
				
				$.ajax({
					url:"<%= request.getContextPath()%>/jjokjiStar.univ",
					type:"POST",
					data:{"jseq":jseq},
					dataType:"JSON",
					success:function(json){

						if(json.n > 0){
							alert(json.n+"?????? ????????? ??????????????? ?????? ???????????????.");
						}
						// ?????????
						$("div#senderChk").hide();
	  						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({----------------------------------------------------
				
			}//end of if(cnt == 0){-----------------------------------------------------
			
			// ???????????? ??????
			$("input:checkbox[name=schk]").prop("checked", false);
			
		});//end of $("button#senderStar").click(function(){----------------------------
		
		////////////////////////////////////////////////////////////////////////////////
		
		// ????????? ???????????? ??????
		$("button#receiveStar").click(function(){
			
			var jseq = "";
			var cnt = 0;
			
			$("input:checkbox[name=rchk]").each(function(){
				
				if($(this).is(":checked")){
					
					jseq += $(this).next().val() + ",";
					cnt++;
					
				}//end of if($(this).is(":checked")){-----------------------------------
			
			});//end of $("input:checkbox[name=schk]").each(function(){-----------------
			
			if(cnt == 0){
				alert("????????? ????????? ????????????.");	
			}
			else{
				
				$.ajax({
					url:"<%= request.getContextPath()%>/jjokjiStar.univ",
					type:"POST",
					data:{"jseq":jseq},
					dataType:"JSON",
					success:function(json){

						if(json.n > 0){
							alert(json.n+"?????? ????????? ??????????????? ?????? ???????????????.");
						}
						// ?????????
						$("div#receiveChk").hide();
	  						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({----------------------------------------------------
				
			}//end of if(cnt == 0){-----------------------------------------------------
			
			// ???????????? ??????
			$("input:checkbox[name=rchk]").prop("checked", false);
			
		});//end of $("button#senderStar").click(function(){----------------------------
		
		////////////////////////////////////////////////////////////////////////////////
		
		// ???????????? ?????? ??????
		$("button#starUpdate").click(function(){
			
			var jseq = "";
			var cnt = 0;
			
			$("input:checkbox[name=tchk]").each(function(){
				
				if($(this).is(":checked")){
					
					jseq += $(this).next().val() + ",";
					cnt++;
					
				}//end of if($(this).is(":checked")){-----------------------------------
			
			});//end of $("input:checkbox[name=schk]").each(function(){-----------------
			
			if(cnt == 0){
				alert("????????? ????????? ????????????.");	
			}
			else{
				
				$.ajax({
					url:"<%= request.getContextPath()%>/jjokjiStarNo.univ",
					type:"POST",
					data:{"jseq":jseq},
					dataType:"JSON",
					success:function(json){

						if(json.n > 0){
							alert(json.n+"?????? ?????? ?????? ??????");
						}
						// ?????????
						$("div#starChk").hide();
	  						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({----------------------------------------------------
				
			}//end of if(cnt == 0){-----------------------------------------------------
			
			// ???????????? ??????
			$("input:checkbox[name=tchk]").prop("checked", false);
			
		});//end of $("button#starUpdate").click(function(){----------------------------
		
		// ????????????
		
		$("button#main").click(function(){
			
			var confrimflag = confirm("????????? ?????? ???????????? ?????????????????????????");
			
			if(confrimflag){
				location.href = "<%= ctxPath%>/adminIndex.univ";
			}
			
		});//end of $("button#main").click(function(){----------------------------------
		
		////////////////////////////////////////////////////////////////////////////////
			
		// ????????????
		$("button#write").click(function(){

			if($("select#receive_hakbun").val() == ""){
				alert("??????????????? ???????????????.");
			}
			else{

				if($("input#attach").text() != ""){
				
					var form_data = $("form[name=writeFrm]").serialize();
					
					$("form[name=writeFrm]").ajaxForm({
						url:"<%= request.getContextPath()%>/adminSendJjokjiFile.univ",
						data:form_data,
						type:"POST",
						enctype:"multipart/form-data",
						dataType:"JSON",
						success:function(json){  
						              
							if(json.n == 1){
								alert("????????? ?????? ???????????????.");
								window.location.reload();
							}
						   
						},
						error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					 	}
						
					});//end of $("form[name=writeFrm]").ajaxForm({---------------------
					
				}
				else{
					
					$.ajax({
						url:"<%= request.getContextPath()%>/adminSendJjokjiNoFile.univ",
						type:"POST",
						data:{"receive_hakbun":$("select#receive_hakbun").val(),
							  "jjokjiContent":$("textarea#jjokjiContent").val()},
						dataType:"JSON",
						success:function(json){

							if(json.n == 1){
								alert("????????? ?????? ???????????????.");
								window.location.reload();
							}
		  						
						},
						error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					 	}
						
					});//end of $.ajax({------------------------------------------------
					
				}//end of if($("input#attach").val() == ""){----------------------------

			}//end of if($("select#receive_hakbun").val() == ""){-----------------------
	        
		});// end of $("button#btnWrite").click(function(){})---------------------------
		
	});//end of $(document).ready(function(){-------------------------------------------

		
</script>

<div style="flex">
	<div id="container">
  		<%-- ?????? ????????? --%>
  		<nav>
  			<form name="no">
			  	<div class="nav nav-tabs" id="nav-tab" role="tablist" style="border:solid 1px #ffb84d;">
			    	<button style="color:#ffb84d;" class="nav-link active" id="student" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">?????? ?????????</button>
			    	<button style="color:#ffb84d;" class="nav-link" id="teacher" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">?????? ?????????</button>
			    	<button style="color:#ffb84d;" class="nav-link" id="savejjokji" data-bs-toggle="tab" data-bs-target="#nav-contact1" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">?????? ?????????</button>
			    	<button style="color:#ffb84d;" class="nav-link" id="reset" data-bs-toggle="tab" data-bs-target="#nav-contact3" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">????????????</button>
			    	<button style="color:#ffb84d;" class="nav-link" id="main" data-bs-toggle="tab" data-bs-target="#nav-contact4" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">????????????</button>
			    	<button style="background-color:#ffd699; border:solid 1px #ffd699;" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">?????? ?????????</button>
				</div>
			</form>
		</nav>
		
		<%-- ?????? ?????? --%>
		<div class="tab-content" id="nav-tabContent">
		  	<%-- ?????? ????????? --%>
		  	<div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
		  		<form name="sender_orderBy" method="POST">
			  		<table class="tbl">
			  			<tr>
			  				<td class="top_td">	  						  						  					
		  						<select class="inp" id="senderType" name="go_receive_hakbun" style="width:200px;">
			  						<option value="">?????????</option>
	
									<%-- ????????? ???????????? --%>
		  							<c:forEach var="contact" items="${requestScope.contactList}">
		  								<option value="${contact.receive_hakbun}">${contact.name}&nbsp;(${contact.deptname})</option>
		  							</c:forEach>
	
			  					</select> 					
			  					<button class="search" id="senderSearch">??????</button>						  					
			  				</td>
			  			</tr>
			  			<tr>
			  				<td class="bottom_td">
			  					<div style="height:500px; overflow:auto;">
				  					<div id="senderChk" class="Chktop">
				  						<span id="senderSpan" class="spantop">????????????</span><input id="senderAll" type="checkbox"/>
				  						<button style="margin-left:10px;" class="search" id="senderDel">???????????? ??????</button>
				  						<button style="margin-left:10px;" class="search" id="senderStar">???????????? ??????</button>
				  					</div>
				  					<div class="accordion" id="accordionExample">
										<c:if test="${empty requestScope.senderList}">
											<div style="text-align:center; font-size:15pt; line-height:500px;">??????????????????</div>
										</c:if>
										<c:forEach var="sender" items="${requestScope.senderList}" varStatus="status">
											<div class="accordion-item">
									    		<h3 class="accordion-header" id="id1${status.index}">
									    		<input class="schkbox" type="checkbox" name="schk"/>
									    		<input type="hidden" value="${sender.jseq}" />
									      			<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#id2${status.index}" aria-expanded="false" aria-controls="id2${status.index}">
									        			<table>
									        				<tr>
									        					<td style="width:300px;">????????? : ${sender.name}&nbsp;(${sender.deptname})</td>
									        					<td style="width:200px;">???????????? : ${sender.jjokjitime}</td>
											        			<c:choose>
												        			<c:when test="${fn:length(sender.jjokjicontent) > 25}">
										        						<td style="width:550px;">?????? : ${fn:substring(sender.jjokjicontent,0,25)}...</td>
										        					</c:when>
											        				<c:otherwise>
											        					<td style="width:550px;">?????? : ${sender.jjokjicontent}</td>
											        				</c:otherwise>
									        					</c:choose>
									        				</tr>
									        			</table>
									      			</button>
									    		</h3>
									    		<div id="id2${status.index}" class="accordion-collapse collapse" aria-labelledby="id1${status.index}" data-bs-parent="#accordionExample">
									      			<div class="accordion-body">
									       				<table class="acdtable">
									       					<tr>
									       						<td class="acdtd" colspan="4">???????????????</td>								       						
									       					</tr>
									       					<tr>
									       						<td class="acdtd2" colspan="4">
									       							<div style="overflow:auto; height:300px; line-height:300px;">
									       								<c:choose>
														        			<c:when test="${sender.jjokjicontent == ''}">
														        				????????? ????????????.
														        			</c:when>
														        			<c:otherwise>
														        				?????? : ${sender.jjokjicontent}
														        			</c:otherwise>
													        			</c:choose>
									       							</div>
									       						</td>								       						
									       					</tr>
									       					<tr>
									       						<td style="height:40px; width:40px; border-right:solid 4px #b3e0ff; background-color:#e6f5ff;" colspan="2">???????????????</td>
									       						<td colspan="2">
									       							<c:choose>
													        			<c:when test="${sender.orgfilename == null}">
													        				????????? ????????? ????????????.
													        			</c:when>
													        			<c:otherwise>
													        				<a href="<%= request.getContextPath()%>/FileDownload.univ?jseq=${sender.jseq}">${sender.orgfilename}</a>
													        			</c:otherwise>
												        			</c:choose>
									       						</td>								       						
									       					</tr>
									       				</table>
									      			</div>
									    		</div>
									  		</div>
										</c:forEach>
				  					</div>
				  				</div>	
			  				</td>
			  			</tr>
			  		</table>
		  		</form>
		  	</div>
		  			  	
		  	<%-- ?????? ????????? --%>
		  	<div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
		  		<form name="receive_orderBy" method="POST">
			  		<table class="tbl">
			  			<tr>
			  				<td class="top_td">		  						  					
		  						<select class="inp" id="receiveType" name="go_sender_hakbun" style="width:200px;">
			  						<option value="">?????????</option>

									<%-- ????????? ???????????? --%>
		  							<c:forEach var="contact" items="${requestScope.contactList}">
		  								<option value="${contact.receive_hakbun}">${contact.name}&nbsp;(${contact.deptname})</option>
		  							</c:forEach>

			  					</select>  					  						  						
			  					<button class="search" id="receiveSearch">??????</button>			  					
			  				</td>
			  			</tr>
			  			<tr>
			  				<td class="bottom_td">
			  					<div style="height:500px; overflow:auto;">
				  					<div id="receiveChk" class="Chktop">
				  						<span id="receiveSpan" class="spantop">????????????</span><input id="receiveAll" type="checkbox"/>
				  						<button style="margin-left:10px;" class="search" id="receiveDel">???????????? ??????</button>
				  						<button style="margin-left:10px;" class="search" id="receiveStar">???????????? ??????</button>
				  					</div>
				  					<div class="accordion" id="accordionExample">
				  						<c:if test="${empty requestScope.receiveList}">
											<div style="text-align:center; font-size:15pt; line-height:500px;">??????????????????</div>
										</c:if>
										<c:forEach var="receive" items="${requestScope.receiveList}" varStatus="status">
											<div class="accordion-item">
									    		<h3 class="accordion-header" id="id1${status.index+100000000}">
									    		<input class="rchkbox" type="checkbox" name="rchk"/>
									    		<input type="hidden" value="${receive.jseq}" />
									      			<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#id2${status.index+100000000}" aria-expanded="false" aria-controls="id2${status.index+100000000}">
									        			<table>
									        				<tr>
									        					<td style="width:300px;">????????? : ${receive.name}&nbsp;(${receive.deptname})</td>
									        					<td style="width:200px;">???????????? : ${receive.jjokjitime}</td>
											        			<c:choose>
												        			<c:when test="${fn:length(receive.jjokjicontent) > 25}">
										        						<td style="width:550px;">?????? : ${fn:substring(receive.jjokjicontent,0,25)}...</td>
										        					</c:when>
											        				<c:otherwise>
											        					<td style="width:550px;">?????? : ${receive.jjokjicontent}</td>
											        				</c:otherwise>
									        					</c:choose>
									        				</tr>
									        			</table>
									      			</button>									      			
									    		</h3>
									    		<div id="id2${status.index+100000000}" class="accordion-collapse collapse" aria-labelledby="id1${status.index+100000000}" data-bs-parent="#accordionExample">
									      			<div class="accordion-body">
									       				<table class="acdtable">
									       					<tr>
									       						<td class="acdtd" colspan="4">???????????????</td>								       						
									       					</tr>
									       					<tr>
									       						<td class="acdtd2" colspan="4">
									       							<div style="overflow:auto; height:300px; line-height:300px;">
									       								<c:choose>
														        			<c:when test="${receive.jjokjicontent == null}">
														        				????????? ????????????.
														        			</c:when>
														        			<c:otherwise>
														        				?????? : ${receive.jjokjicontent}
														        			</c:otherwise>
													        			</c:choose>
									       							</div>
									       						</td>								       						
									       					</tr>
									       					<tr>
									       						<td style="height:40px; width:40px; border-right:solid 4px #b3e0ff; background-color:#e6f5ff;" colspan="2">???????????????</td>
									       						<td colspan="2">
									       							<c:choose>
													        			<c:when test="${receive.orgfilename == null}">
													        				????????? ????????? ????????????.
													        			</c:when>
													        			<c:otherwise>
													        				<a href="<%= request.getContextPath()%>/filedownload.univ?jseq=${receive.jseq}">${receive.orgfilename}</a>
													        			</c:otherwise>
												        			</c:choose>
									       						</td>								       						
									       					</tr>
									       				</table>
									      			</div>
									    		</div>
									  		</div>
										</c:forEach>
				  					</div>
				  				</div>	
			  				</td>
			  			</tr>
			  		</table>
		  		</form>		  	
		  	</div>
		  			 
		  	<%-- ?????? ????????? --%>
		  	<div class="tab-pane fade" id="nav-contact1" role="tabpanel" aria-labelledby="nav-contact-tab">
		  		<form name="star_orderBy" method="POST">
			  		<table class="tbl">
			  			<tr>
			  				<td class="top_td">	  							  						  					
		  						<select class="inp" id="starType" name="go_star_hakbun" style="width:200px;">
			  						<option value="">?????????</option>
	
									<%-- ????????? ???????????? --%>
		  							<c:forEach var="contact" items="${requestScope.contactList}">
		  								<option value="${contact.receive_hakbun}">${contact.name}&nbsp;(${contact.deptname})</option>
		  							</c:forEach>
	
			  					</select>				
			  					<button class="search" id="starSearch">??????</button>						  					
			  				</td>
			  			</tr>
			  			<tr>
			  				<td class="bottom_td">
			  					<div style="height:500px; overflow:auto;">
				  					<div id="starChk" class="Chktop">
				  						<span id="starSpan" class="spantop">????????????</span><input id="starAll" type="checkbox"/>
				  						<button style="margin-left:10px;" class="search" id="starUpdate">??????????????????</button>
				  					</div>
				  					<div class="accordion" id="accordionExample">
				  						<c:if test="${empty requestScope.starList}">
											<div style="text-align:center; font-size:15pt; line-height:500px;">??????????????????</div>
										</c:if>
										<c:forEach var="star" items="${requestScope.starList}" varStatus="status">
											<div class="accordion-item">
									    		<h3 class="accordion-header" id="id1${status.index}">
									    		<input class="tchkbox" type="checkbox" name="tchk"/>
									    		<input type="hidden" value="${star.jseq}" />
									      			<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#id2${status.index}" aria-expanded="false" aria-controls="id2${status.index}">
									        			<table>
									        				<tr>
									        					<c:choose>
												        			<c:when test="${star.name1 == '?????????'}">
									        							<td style="width:300px;">????????? : ${star.name2}&nbsp;(${star.deptname2})</td>
									        						</c:when>
												        			<c:otherwise>
									        							<td style="width:300px;">????????? : ${star.name1}&nbsp;(${star.deptname1})</td>
											        				</c:otherwise>
											        			</c:choose>
											        			<td style="width:200px;">???????????? : ${star.jjokjitime}</td>	
											        			<c:choose> 
											        				<c:when test="${fn:length(star.jjokjicontent) > 25}">
													        			<td style="width:550px;">?????? : ${fn:substring(star.jjokjicontent,0,25)}...</td>
												        			</c:when>
												        			<c:otherwise>
												        				<td style="width:550px;">?????? : ${star.jjokjicontent}</td>
												        			</c:otherwise>
									        					</c:choose>
									        				</tr>
									        			</table>
									      			</button>
									    		</h3>
									    		<div id="id2${status.index}" class="accordion-collapse collapse" aria-labelledby="id1${status.index}" data-bs-parent="#accordionExample">
									      			<div class="accordion-body">
									       				<table class="acdtable">
									       					<tr>
									       						<td class="acdtd" colspan="4">???????????????</td>								       						
									       					</tr>
									       					<tr>
									       						<td class="acdtd2" colspan="4">
									       							<div style="overflow:auto; height:300px; line-height:300px;">
									       								<c:choose>
														        			<c:when test="${star.jjokjicontent == ''}">
														        				????????? ????????????.
														        			</c:when>
														        			<c:otherwise>
														        				?????? : ${star.jjokjicontent}
														        			</c:otherwise>
													        			</c:choose>
									       							</div>
									       						</td>								       						
									       					</tr>
									       					<tr>
									       						<td style="height:40px; width:40px; border-right:solid 4px #b3e0ff; background-color:#e6f5ff;" colspan="2">???????????????</td>
									       						<td colspan="2">
									       							<c:choose>
													        			<c:when test="${star.orgfilename == null}">
													        				????????? ????????? ????????????.
													        			</c:when>
													        			<c:otherwise>
													        				<a href="<%= request.getContextPath()%>/filedownload.univ?jseq=${star.jseq}">${star.orgfilename}</a>
													        			</c:otherwise>
												        			</c:choose>
									       						</td>								       						
									       					</tr>
									       				</table>
									      			</div>
									    		</div>
									  		</div>
										</c:forEach>
				  					</div>
				  				</div>	
			  				</td>
			  			</tr>
			  		</table>
		  		</form>
		  	</div>		 
		</div>
	</div>
</div>

<%-- ?????? ????????? ????????? --%>
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    	<div style="width:600px; margin-left:-50px;" class="modal-content">
      		<div class="modal-header" style="background-color:#ffebcc; border-bottom:#ffebcc;">
        		<h6 class="modal-title" id="exampleModalLabel">?????? ?????????</h6>
        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      		</div>
      		<div class="modal-body">
        		<form name="writeFrm" method="POST">
					<input type="file" id="attach" name="attach" style="margin:15px 0px 0px 17px; font-size:10pt; border:solid 1px gray; width:200px;"/>
        			<select class="inp" id="receive_hakbun" name="receive_hakbun" style="width:200px; height:28px; margin-left:10px;">
						<option value="">?????????</option>
						
						<%-- ????????? ???????????? --%>
						<c:forEach var="contact" items="${requestScope.contactList}">
							<option value="${contact.receive_hakbun}">${contact.name}&nbsp;(${contact.deptname})</option>
						</c:forEach>

  					</select>
  					<button class="search" id="write" style="margin-left:10px; border:solid 1px #ffccff; background-color:#ffebcc;">?????? ?????????</button>
  					<textarea style="margin:20px 0px 9px 17px; width:94%; height:200px; resize: none;" name="jjokjiContent" id="jjokjiContent"></textarea>
        		</form>
      		</div>
    	</div>
  	</div>
</div>