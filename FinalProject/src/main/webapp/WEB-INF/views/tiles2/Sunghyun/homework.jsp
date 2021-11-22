<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>

 .card {margin-left: 10px;}
 
 .card-text {color: gray; font-size: 10pt;}
 
 .title{font-size: 10pt; color:gray;}
 
 .badge{margin-left: 10px;}
 
 #homeworkTbl th { background-color: #ffb84d; width: 15%; }
 
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("ul#sideMenuList > li:nth-child(5)").addClass("hoverdEffect");
		
		$("ul#sideMenuList").hover(function(){
			$("ul#sideMenuList > li:nth-child(5)").removeClass("hoverdEffect");
		}, function(){
			$("ul#sideMenuList > li:nth-child(5)").addClass("hoverdEffect");
		});
		
		/////////////////////////////////////////////////////////////////////////
		var list = new Array();
		
		<c:forEach var="homeworkvo" items="${requestScope.homeworkList}">
			list.push("${homeworkvo.seq}");
		</c:forEach>
		
		for(var i=0; i<list.length; i++){
			getCommentList(list[i]);
		}
		/////////////////////////////////////////////////////////////////////////
		
		$("ul#sideMenuList > li:nth-child(5)").addClass("hoverdEffect");
		
		$("ul#sideMenuList").hover(function(){
			$("ul#sideMenuList > li:nth-child(5)").removeClass("hoverdEffect");
		}, function(){
			$("ul#sideMenuList > li:nth-child(5)").addClass("hoverdEffect");
		});
		

	});
	
	//Function Declaration
	function getCommentList(parentSeq){
		
		$.ajax({
			url:"<%= request.getContextPath()%>/getHomeworkComment.univ",
			data:{"code":"${sessionScope.code}"},
			type:"GET",
			dataType:"JSON",
			success:function(json) {
				
				$("table#commentList"+parentSeq).empty();
				
				$.each(json, function(index, item){
					
					if(item.parentSeq == parentSeq) {
						
						var html = "";
						
						html += "<tr style='vertical-align: middle;'>";
						html += "<td style='width: 10%; text-align: center; font-weight: bold;'><img src='<%= request.getContextPath()%>/resources/images/personimg.png' />"+item.name+"("+item.fk_hakbun+")</td>";
						html += "<td style='width: 40%;'>"+item.content;
						html += "<br /><br /><a href='<%= request.getContextPath()%>/homeworkCommentFileDownload.univ?seq="+item.seq+"'>"+item.orgFilename+"</a>&nbsp;&nbsp;("+Number(item.fileSize).toLocaleString('en')+" Bytes)"+"</td>";
						html += "<td style='width: 10%; text-align: center;'>"+item.regDate +"</td>";
						html += "<td style='width: 1%; font-size: 20pt; text-align: center;'><span onclick='deleteComment("+item.seq+","+item.parentSeq+","+item.fk_hakbun+")' style='cursor: pointer;'>&times;</span></td>";
						html += "</tr>";
						
						$("table#commentList"+item.parentSeq).append(html);
						$("span#commentCount"+parentSeq).html(item.commentCount);
					}
					
				});
				
				if(json.length == 0){
					$("span#commentCount"+parentSeq).text("0");
				}
				
			},
	        error: function(request, status, error){
	              alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
			
		});
	}// end of function getCommentList(){}------------------------------------------
	
	
	// Function Declaration
	function goWrite(parentSeq) {
		
		  if($("input#content"+parentSeq).val().trim() == "") {
			  alert("댓글 내용을 작성해야 합니다.");
			  return;
		  }
		  
		  if($("input#file"+parentSeq).val() == "") {
			  alert("파일을 첨부해야 합니다.");
			  return;
		  }
		
		  var form_date = $("form[name=homeworkFrm"+parentSeq+"]").serialize();
		  
		  var frm = "homeworkFrm"+parentSeq;
		  
		   $("form[name=homeworkFrm"+parentSeq+"]").ajaxForm({
		         url:"<%= request.getContextPath()%>/writeHomeworkComment.univ",
		         data:form_date,
		         type:"POST",
		         enctype:"multipart/form-data",
		         dataType:"JSON",
		         success:function(json){ 
					
		        	 if(json.n==1){
		        		 getCommentList(parentSeq);
		        		 alert("댓글작성 성공");
		        		 
		        		 $("input#content"+parentSeq).val("");
		        		 $("input#file"+parentSeq).val("");
		        		 
		        	 }
		            
		         },
		         error: function(request, status, error){
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		         }
		      });
	      
		   $("form[name=homeworkFrm"+parentSeq+"]").submit();
		
		
	}// end of function goWrite(seq) {}-------------------------------------
	
	// Function Declaration
	function goHomeworkWrite() {
		
		if(${sessionScope.loginuser.authority==0}){
			alert("교수만 접근이 가능합니다!!");
			return;
		}
		
		location.href="<%= request.getContextPath()%>/homeworkWrite.univ";
		
	}// end of function goHomeworkWrite()-----------------------
	
	// Function Declaration
	function deleteComment(seq, parentSeq, fk_hakbun) {
		
		var hakbun = "${sessionScope.loginuser.hakbun}";
		
		if(hakbun != fk_hakbun){
			alert("타인의 댓글은 삭제할 수 없습니다.");
			return;
		}
		
		
		$.ajax({
			url:"<%= request.getContextPath()%>/deleteHomeworkComment.univ",
			type:"POST",
			data:{"seq":seq, "parentSeq":parentSeq},
			dataType:"JSON",
			success:function(json) {
				
				if(json.n==1){
					alert("댓글삭제 성공");
					getCommentList(parentSeq);
				}
				else{
					alert("댓글삭제 실패");
				}
				
			},
	        error: function(request, status, error){
	              alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
			
		});
		
		
	} // end of function deleteComment(seq)----------------------------------
	
	
	
</script>

<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left;">${requestScope.subjectMap.subject} 강의실(${requestScope.subjectMap.name}) > <span style="color: #0099ff; text-decoration: underline;">과제 및 평가</span></h3>
<hr style="clear: both;">

<div id="homeworkContainer" style="width: 100%;">

	<div class="container-fluid my-3 p-3" style="background-color: #ffb84d;">
		<c:if test="${not empty requestScope.homeworkList}">
			<c:forEach var="homeworkvo" items="${requestScope.homeworkList}" varStatus="status">
				<div class="accordion" id="accordion${status.count}">
					<div class="card">
						<div class="card-header" id="heading${status.count}" style="background-color: #fff">
							<h2 class="mb-0">
								<button class="btn btn-link btn-block text-left" type="button"
									data-toggle="collapse" data-target="#collapse${status.count}"
									aria-expanded="false" aria-controls="collapse${status.count}">
									${homeworkvo.subject}
									<div class="title">작성자: ${homeworkvo.name} | 작성시간: ${homeworkvo.regDate} | 마감기간: ${fn:substring(homeworkvo.deadline, 0, 10)}
										<c:if test="${homeworkvo.status == 0}"><span class="badge badge-success">제출 가능</span></c:if>
										<c:if test="${homeworkvo.status == 1}"><span class="badge badge-danger">제출 마감</span></c:if>
									</div>
								</button>
							</h2>
						</div>
			
						<div id="collapse${status.count}"class="collapse"
							aria-labelledby="heading${status.count}" data-parent="#accordion${status.count}">
							<div class="card-body d-flex justify-content-center">
							
								<table id="homeworkTbl" class="table table-bordered" style="width: 100%;">
									<tr><th colspan="2"></th></tr>		 
									<tr>
										<td colspan="2"><h2>${homeworkvo.subject}</h2></td>
									</tr>
									<tr>
										<td colspan="2">작성자: ${homeworkvo.name}<img src="<%= request.getContextPath()%>/resources/images/personimg.png" /></td>
									</tr>
									<tr>
										<td colspan="2">작성일: ${homeworkvo.regDate}</td>
									</tr>
									<tr>
										<td colspan="2"><span>${homeworkvo.content}</span></td>
									</tr>
									<tr>
										<th>첨부파일</th>
										<td><a href="<%= request.getContextPath()%>/homeworkFileDownload.univ?seq=${homeworkvo.seq}">${homeworkvo.orgFilename}</a></td>
									</tr>
									<tr>
										<th>파일용량(Bytes)</th>
										<td><fmt:formatNumber value="${homeworkvo.fileSize}" pattern="#,###" /></td>
									</tr>
								</table>
								
								
								
							</div>
								<c:if test="${sessionScope.loginuser != null and homeworkvo.status == 0}">
									<form name="homeworkFrm${homeworkvo.seq}" style="margin-top: 30px;">
										<table class="table">
											<tr>
												<th style="width: 10%;">작성자</th>
												<td><input type="text"  value="${sessionScope.loginuser.name}" readonly /></td>
												<td><input type="hidden" name="fk_hakbun" value="${sessionScope.loginuser.hakbun}" /></td>
												<td><input type="hidden" name="fk_code" value="${sessionScope.code}" /></td>
											</tr>
											<tr>
												<th>댓글내용</th>
												<td><input id="content${homeworkvo.seq}" type="text" name="content" size="100"  /></td>
												<td colspan="2"><input type="hidden" name="parentSeq" value="${homeworkvo.seq}" /></td>
											</tr>
											<tr>
												<th>파일첨부</th>
												<td colspan="3"><input id="file${homeworkvo.seq}" type="file" name="attach" /></td>
											</tr>
											<tr>
												<th colspan="4">
													<button type="button" class="btn" style="background-color:#ffb84d; margin-right: 20px;" onclick="goWrite('${homeworkvo.seq}')">댓글쓰기</button>
													<button type="reset"  class="btn" style="background-color:#ffb84d;">취소</button>
												</th>
											</tr>
										</table>
									</form>
								</c:if>
								
								<div style="margin: 0 10px; padding: 10px; color: #fff; text-align:center; font-size: 20pt; background-color: #ffb84d">제출인원 : <span id="commentCount${homeworkvo.seq}"></span> 명</div>
								
								<table id="commentList${homeworkvo.seq}" class="table" style="margin-top: 30px;">
								
								</table>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
		
		
		<c:if test="${empty requestScope.homeworkList}">
			등록된 게시물이 없습니다.
		</c:if>
	</div>
	
	<c:if test="${sessionScope.loginuser.authority == 1}">
		<div class="text-right">
			<button type="button" class="btn btn-md" onclick="goHomeworkWrite()" style="background-color: #ffb84d; color:#fff; border: none;">글쓰기</button>
		</div>
	</c:if>
</div>
