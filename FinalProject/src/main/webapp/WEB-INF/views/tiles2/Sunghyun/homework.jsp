<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>

 .card {margin-left: 10px;}
 
 .card-text {color: gray; font-size: 10pt;}
 
 .title{font-size: 10pt; color:gray;}
 
 .badge{margin-left: 10px;}
 
 #homeworkTbl th { background-color: #ffb84d; width: 15%; }
 
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		/////////////////////////////////////////////////////////////////////////
		var list = new Array();
		
		<c:forEach var="homeworkvo" items="${requestScope.homeworkList}">
			list.push("${homeworkvo.seq}");
		</c:forEach>
		
		console.log(list);
		
		for(var i=0; i<list.length; i++){
			console.log(list[i]);
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
				
				
				$.each(json, function(index, item){
					
					if(item.parentSeq == parentSeq) {
						
						if(index==0){
							$("table#commentList"+item.parentSeq).empty();
						}
						
						var html = "";
						
						html += "<tr>";
						html += "<td style='width: 10%; text-align: center; font-weight: bold;'><img src='<%= request.getContextPath()%>/resources/images/personimg.png' />"+item.name+"("+item.fk_hakbun+")</td>";
						html += "<td style='width: 40%;'>"+item.content;
						html += "<br /><br />"+item.orgFilename+"("+Number(item.fileSize).toLocaleString('en')+" bytes)"+"</td>";
						html += "<td style='width: 10%; text-align: center;'>"+item.regDate +"</td>";
						html += "</tr>";
						
						$("table#commentList"+item.parentSeq).append(html);
						
					}
					
					
				});
				
				
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
</script>

<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left;">${requestScope.subjectMap.subject} 강의실(${requestScope.subjectMap.name}) > <span style="color: #0099ff; text-decoration: underline;">과제및평가</span></h3>
<hr style="clear: both;">

<div id="homeworkContainer" style="width: 100%;">

	<div style="display: flex;">
		<input type="text" placeholder="과제 검색" style="margin-left: 10px;" />
		<div style="margin-left: auto;">
			<button type="button" class="btn btn-secondary">날짜로 보기</button>
			<button type="button" class="btn btn-secondary">유형별 보기</button>
		</div>
	</div>
	
	<div class="container-fluid my-3 p-3" style="background-color: #ddd;">
		<c:if test="${not empty requestScope.homeworkList}">
			<c:forEach var="homeworkvo" items="${requestScope.homeworkList}" varStatus="status">
				<div class="accordion" id="accordion${status.count}">
					<div class="card">
						<div class="card-header" id="heading${status.count}">
							<h2 class="mb-0">
								<button class="btn btn-link btn-block text-left" type="button"
									data-toggle="collapse" data-target="#collapse${status.count}"
									aria-expanded="false" aria-controls="collapse${status.count}">
									${homeworkvo.subject}
									<div class="title">${homeworkvo.regDate} | 작성자: ${homeworkvo.name}
										<c:if test="${homeworkvo.status == 0}"><span class="badge badge-success">과제 진행중</span></c:if>
										<c:if test="${homeworkvo.status == 1}"><span class="badge badge-danger">과제 마감</span></c:if>
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
										<td>${homeworkvo.fileName}</td>
									</tr>
									<tr>
										<th>파일용량(KB)</th>
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
</div>
