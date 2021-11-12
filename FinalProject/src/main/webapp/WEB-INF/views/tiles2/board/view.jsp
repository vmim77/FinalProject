<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
    
<style type="text/css">

	.move {cursor: pointer; color: navy;}
	.moveColor {color: #660029; font-weight: bold; background-color: #ffffe6;}

    td.comment {text-align: center;}
    
    
    /* 부트스트랩 버튼 색 변경    */

.btn-light {
    background-color: #ffffff;
    border-color: #778899;
    color:  #616161;}
.btn-light:hover,
.btn-light:focus {
    border-color: #cccccc;
    background-color: #cccccc;
    color: #FFF; }
    
    
   .btn-secondary {
    background-color: #7e7f80;
    border-color: #7e7f80;
    color: #FFF; 
    }    
    
	.btn-secondary:hover,
	.btn-secondary:focus {
    border-color: #cccccc;
    background-color: #cccccc;
    color: #FFF; }   
    
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
	//	goReadComment();  // 페이징처리 안한 댓글 읽어오기 
		goViewComment(1); // 페이징처리 한 댓글 읽어오기 
		
		$("span.move").hover(function(){
			                   $(this).addClass("moveColor");
		                     }
		                   , function(){
		                	   $(this).removeClass("moveColor");
		                   });
		
	});// end of $(document).ready(function(){})------------------------------
	
	
	// Function Declration
	function goAddWrite() {
		
		var contentVal = $("input#commentContent").val().trim();
		if(contentVal == "") {
			alert("댓글 내용을 입력하세요!!");
			return; // 종료
		}
		else {
			goAddWrite_noAttach(); // 첨부파일이 없는 댓글쓰기 
		}
		
	}// end of function goAddWrite()------------------------------------------
	
	
	// 첨부파일이 없는 댓글쓰기 
	function goAddWrite_noAttach() {
		
		$.ajax({
			url:"<%= request.getContextPath()%>/addComment.univ",
			data:{"fk_hakbun":$("input#fk_hakbun").val()
				 ,"name":$("input#name").val()
				 ,"fk_code":$("input#fk_code").val()
				 ,"content":$("input#commentContent").val()
				 ,"parentSeq":$("input#parentSeq").val()},
			type:"POST",
			dataType:"JSON",
			success:function(json){  //      {"n":1, "name":"이순신"}
			                         // 또는    {"n":0, "name":"이순신"}
			    var n = json.n; 
			    
			    if(n==0) {
			    	alert(json.name+"님의 포인트는 300점을 초과할 수 없으므로 댓글쓰기가 불가합니다.");
			    }
			    else {
			    //	goReadComment();  // 페이징처리 안한 댓글 읽어오기
			    	goViewComment(1); // 페이징처리 한 댓글 읽어오기
			    }
			    
			    $("input#commentContent").val("");
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
		
	}// end of function goAddWrite_noAttach() {}------------------------------
	

	// === 페이징처리 안한 댓글 읽어오기 === //
	function goReadComment() {
		
		$.ajax({
			url:"<%= request.getContextPath()%>/readComment.univ",
			data:{"parentSeq":"${freeboardvo.seq}"},
			dataType:"JSON",
			success:function(json){
				var html = "";
				if(json.length > 0) {
					$.each(json, function(index, item){
						html += "<tr>";
						html += "<td class='comment'>"+(index+1)+"</td>";
						html += "<td>"+item.content+"</td>";
						html += "<td class='comment'>"+item.name+"</td>";
						html += "<td class='comment'>"+item.regDate+"</td>";
						html += "</tr>";
					});
				}
				else {
					html += "<tr>";
					html += "<td colspan='4' class='comment'>댓글이 없습니다</td>";
					html += "</tr>";
				}
				
				$("tbody#commentDisplay").html(html);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		}); 
		
	}// end of function goReadComment() {}----------------------------------
	
	
	// === #127. Ajax로 불러온 댓글내용을 페이징처리 하기 === //
	function goViewComment(currentShowPageNo) {
		
		$.ajax({
			url:"<%= request.getContextPath()%>/commentList.univ",
			data:{"parentSeq":"${freeboardvo.seq}"
				 ,"currentShowPageNo":currentShowPageNo},
			dataType:"JSON",
			success:function(json){
				var html = "";
				if(json.length > 0) {
					$.each(json, function(index, item){
						html += "<tr>";
						html += "<td class='comment'>"+(index+1)+"</td>";
						html += "<td>"+item.content+"</td>";
						html += "<td class='comment'>"+item.name+"</td>";
						html += "<td class='comment'>"+item.regDate+"</td>";
						html += "</tr>";
					});
				}
				else {
					html += "<tr>";
					html += "<td colspan='4' class='comment'>댓글이 없습니다</td>";
					html += "</tr>";
				}
				
				$("tbody#commentDisplay").html(html);
				
				// 페이지바 함수 호출
				makeCommentPageBar(currentShowPageNo);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		}); 
		
	}// end of function goViewComment() {}----------------------------------
	
	
	// ===== 댓글내용 페이지바 Ajax로 만들기 ===== //
	function makeCommentPageBar(currentShowPageNo) {
		
		<%-- === 원글에 대한 댓글의 totalPage 수를 알아오려고 한다.=== --%>
		$.ajax({
			url:"<%= request.getContextPath()%>/getCommentTotalPage.univ", 
			data:{"parentSeq":"${freeboardvo.seq}"
				 ,"sizePerPage":"5"},
			type:"GET",
			dataType:"JSON",
			success:function(json){
			//	console.log("확인용 전체 페이지수 =>" + json.totalPage);
			     
		        if(json.totalPage > 0) {
		        	// 댓글이 있는 경우 
		        	
		        	var totalPage = json.totalPage;
		        	
		        	var pageBarHTML = "<ul style='list-style: none;' >";
		        	
		        //	var blockSize = 10;
		        	var blockSize = 4;
		        
		            // blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수 이다.
					/*
					      1 2 3 4 5 6 7 8 9 10  다음                   -- 1개블럭
					   이전  11 12 13 14 15 16 17 18 19 20  다음   -- 1개블럭
					   이전  21 22 23
					*/
					
					var loop = 1;
					/*
				    	loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
				    */
				    
				    if(typeof currentShowPageNo == "string") {
				    	currentShowPageNo = Number(currentShowPageNo);
				    }
				    
				 // *** !! 다음은 currentShowPageNo 를 얻어와서 pageNo 를 구하는 공식이다. !! *** //
				    var pageNo = Math.floor( (currentShowPageNo - 1)/blockSize ) * blockSize + 1;
				 /*
				    1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은 1 이다.
				    11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.
				    21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.
				    
				    currentShowPageNo         pageNo
				   ----------------------------------
				         1                      1 = ((1 - 1)/10) * 10 + 1
				         2                      1 = ((2 - 1)/10) * 10 + 1
				         3                      1 = ((3 - 1)/10) * 10 + 1
				         4                      1
				         5                      1
				         6                      1
				         7                      1 
				         8                      1
				         9                      1
				         10                     1 = ((10 - 1)/10) * 10 + 1
				        
				         11                    11 = ((11 - 1)/10) * 10 + 1
				         12                    11 = ((12 - 1)/10) * 10 + 1
				         13                    11 = ((13 - 1)/10) * 10 + 1
				         14                    11
				         15                    11
				         16                    11
				         17                    11
				         18                    11 
				         19                    11 
				         20                    11 = ((20 - 1)/10) * 10 + 1
				         
				         21                    21 = ((21 - 1)/10) * 10 + 1
				         22                    21 = ((22 - 1)/10) * 10 + 1
				         23                    21 = ((23 - 1)/10) * 10 + 1
				         ..                    ..
				         29                    21
				         30                    21 = ((30 - 1)/10) * 10 + 1
				
			            currentShowPageNo 가 2페이지 이라면 pageNo 는 1이 되어야 한다.
					    Math.floor((2 - 1)/10)*10 + 1 
					    ==>  Math.floor((1)/10)*10 + 1  
					    ==>  Math.floor(0.1)*10 + 1   // 소수부가 있을시 Math.floor(0.1) 은  0.1 보다 작은 최대의 정수인 0을 나타낸다.  
					    ==>   0*10+1  
					    ==>   1
					    
					    currentShowPageNo 가 11페이지 이라면 pageNo 는 11이 되어야 한다.
					    Math.floor((11 - 1)/10)*10 + 1 
					    ==>  Math.floor((10)/10)*10 + 1  
					    ==>  Math.floor(1)*10 + 1   // 소수부가 없을시 Math.floor(1) 은  그대로 1 이 된다.  
					    ==>   1*10+1  
					    ==>   11
					    
					    currentShowPageNo 가 20페이지 이라면 pageNo 는 11이 되어야 한다.
					    Math.floor((20 - 1)/10)*10 + 1 
					    ==>  Math.floor((19)/10)*10 + 1  
					    ==>  Math.floor(1.9)*10 + 1   // 소수부가 있을시 Math.floor(1.9) 은  1.9 보다 작은 최대의 정수인 1을 나타낸다.  
					    ==>   1*10+1  
					    ==>   11  
				         
				*/
				 
				    // === [맨처음][이전] 만들기 === 
					if(pageNo != 1) {
						pageBarHTML += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='javascript:goViewComment(\"1\")'> « </a></li>"; 
						pageBarHTML += "<li style='display:inline-block; width:30px; font-size:11pt;'><a href='javascript:goViewComment(\""+(pageNo-1)+"\")'> ‹ </a></li>";
					}
						
					while( !(loop > blockSize || pageNo > totalPage) ) {
						
						if(pageNo == currentShowPageNo) {
							pageBarHTML += "<li style='display:inline-block; width:30px; font-size:11pt; color:red; padding:2px 4px;'>"+pageNo+"</li>";
						}
						else {
							pageBarHTML += "<li style='display:inline-block; width:30px; font-size:11pt;'><a href='javascript:goViewComment(\""+pageNo+"\")'>"+pageNo+"</a></li>";
						}
						
						loop++;
						pageNo++;
						
					}// end of while------------------------------
						
						
					// === [다음][마지막] 만들기 ===
					if( pageNo <= totalPage ) {
						pageBarHTML += "<li style='display:inline-block; width:30px; font-size:11pt;'><a href='javascript:goViewComment(\""+pageNo+"\")'> › </a></li>";
						pageBarHTML += "<li style='display:inline-block; width:30px; font-size:11pt;'><a href='javascript:goViewComment(\""+totalPage+"\")'> » </a></li>";
					}
		        	
		        	pageBarHTML += "</ul>";
		        	
		        	$("div#pageBar").html(pageBarHTML);
		        	
		        }// end of if------------------------	
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
		
	}// end of function makeCommentPageBar(currentShowPageNo) {}-------------
	
	
</script>    



<%-- 게시판 글내용보기 --%>
<div class="pt-4 pb-5">	
 <div style="margin: 20px 20px 20px 70px; width: 80%;">
 
 	<div class="card-body" style="display: flex; height: 13%;   background-color:#f2f2f2;  border: solid 1px gray; padding: 15px 15px 15px 15px;  ">
	  		<button type="button" style="height: 36px; margin-left: 2.5%;"  class="btn btn-secondary" onclick="javascript:location.href='<%= request.getContextPath()%>/list.univ'">전체목록보기</button>
	  		&nbsp;&nbsp;
	  		<button type="button" style="height: 36px;"  class="btn btn-secondary" onclick="javascript:location.href='<%= request.getContextPath()%>${requestScope.gobackURL}'">검색된 결과목록보기</button>
	  		
	  		<button type="button"  onclick="javascript:location.href='<%= request.getContextPath()%>/edit.univ?seq=${freeboardvo.seq}'" class="btn btn-light" style="height: 36px; margin-left: 47%;font-weight:bold; font-size: 10pt; padding: 7px 12px; text-align: right; "><i class="far fa-edit"></i>&nbsp;수정</button>
	  		&nbsp;&nbsp;
	  		<button type="button"  onclick="javascript:location.href='<%= request.getContextPath()%>/del.univ?seq=${freeboardvo.seq}'" class="btn btn-light" style="height: 36px; font-weight:bold; font-size: 10pt; padding: 7px 12px;"><i class="far fa-trash-alt"></i>&nbsp;삭제</button>&nbsp;	
	   		
	</div>
	
	<c:if test="${not empty requestScope.freeboardvo}">
		
			<tr>
				<th style="width: 15%;">글번호</th>
				<td>${freeboardvo.seq}</td>
			</tr>
			<tr>	
				<th>글쓴이</th>
				<td>${freeboardvo.name}&nbsp;&nbsp;(${freeboardvo.fk_hakbun})</td>
			</tr>
			<tr>	
				<th>제목</th>
				<td>${freeboardvo.subject}</td>
			</tr>
			<tr>	
				<th>내용</th>
				<td>
				  <p style="word-break: break-all;">${freeboardvo.content}</p>
				  <%-- 
				      style="word-break: break-all; 은 공백없는 긴영문일 경우 width 크기를 뚫고 나오는 것을 막는 것임. 
				           그런데 style="word-break: break-all; 나 style="word-wrap: break-word; 은
				           테이블태그의 <td>태그에는 안되고 <p> 나 <div> 태그안에서 적용되어지므로 <td>태그에서 적용하려면
				      <table>태그속에 style="word-wrap: break-word; table-layout: fixed;" 을 주면 된다.
				 --%>
				</td>
			</tr>
			<tr>	
				<th>조회수</th>
				<td>${freeboardvo.readCount}</td>
			</tr>	
			<tr>	
				<th>작성일</th>
				<td>${freeboardvo.regDate}</td>
			</tr>
		
		
		<br/>
		
		<c:set var="v_gobackURL" value='${ fn:replace(requestScope.gobackURL, "&", " ") }' />
		
		<%-- 
		<div style="margin-bottom: 1%;">이전글제목&nbsp;:&nbsp;<span class="move" onclick="javascript:location.href='view.univ?seq=${freeboardvo.previousseq}'">${freeboardvo.previoussubject}</span></div>
		<div style="margin-bottom: 1%;">다음글제목&nbsp;:&nbsp;<span class="move" onclick="javascript:location.href='view.univ?seq=${freeboardvo.nextseq}'">${freeboardvo.nextsubject}</span></div>
		 --%>
		
		 
		<br>    
	    <br>
	    <hr>
	    
	    <button type="button"  onclick="javascript:location.href='view.univ?seq=${requestScope.freeboardvo.previousseq}&searchType=${requestScope.searchType}&searchWord=${requestScope.searchWord}&gobackURL=${v_gobackURL}'" class="btn btn-light" style="font-weight:bold; font-size: 10pt; padding: 7px 12px; text-align: right; height: 36px;"> ‹ 이전글 </button>&nbsp;
	    <button type="button"  onclick="javascript:location.href='view.univ?seq=${requestScope.freeboardvo.nextseq}&searchType=${requestScope.searchType}&searchWord=${requestScope.searchWord}&gobackURL=${v_gobackURL}'" class="btn btn-light float-right" style="font-weight:bold; font-size: 10pt; padding: 7px 12px; text-align: right; height: 36px;"> › 다음글 </button>&nbsp;
	  
	  <br>
	  <br>
<%-- 글내용보기 끝 === --%>	

	
		
		<%-- === #83. 댓글쓰기 폼 추가 === --%>
		
		<c:if test="${not empty sessionScope.loginuser}">
			<h3 style="margin-top: 50px;">댓글쓰기</h3>
			
			<form name="addWriteFrm" id="addWriteFrm" style="margin-top: 20px;"> 
				<table class="table" style="width: 1024px">
					<tr style="height: 30px;">
					   <th width="10%">성명</th>
					   <td>
					   	  <input type="hidden" id="fk_hakbun" value="${sessionScope.loginuser.hakbun}" /> <%-- fk_userid => fk_hakbun --%>
					   	  <input type="text" id="name" value="${sessionScope.loginuser.name}" readonly />
					   </td>
					</tr>
					<tr style="height: 30px;">
					   <th>학과코드</th>
					   <td>
					   	  <input type="text" id="fk_code" size="100" />
					   	  <input type="hidden" id="fk_code" value="${freeboardvo.fk_code}" readonly />
					   </td>
					</tr>
					<tr style="height: 30px;">
					   <th>댓글내용</th>
					   <td>
					   	  <input type="text" id="commentContent" size="100" />
					   	  <input type="hidden" id="parentSeq" value="${freeboardvo.seq}" readonly />
					   </td>
					</tr>
					<tr>
					   <th colspan="2">
					   	  <button type="button" class="btn btn-success btn-sm mr-3" onclick="goAddWrite()">댓글쓰기 확인</button>
					   	  <button type="reset" class="btn btn-success btn-sm">댓글쓰기 취소</button>
					   </th>
					</tr>
				</table>
			</form>
		</c:if>
		
		<%-- ==== #94. 댓글 내용 보여주기 ==== --%>
		<h3 style="margin-top: 50px;">댓글내용</h3>
		<table class="table" style="width: 1024px; margin-top: 2%; margin-bottom: 3%;">
			<thead>
			<tr>
			   <th style="width: 6%; text-align: center;">번호</th>
			   <th style="text-align: center;">내용</th>
			   
			   <%-- 첨부파일이 있는 경우 시작 --%>
			  
			   <%-- 첨부파일이 있는 경우 끝 --%>
			   
			   <th style="width: 8%; text-align: center;">작성자</th>
			   <th style="width: 17%; text-align: center;">작성일자</th>
			</tr>
			</thead>
			<tbody id="commentDisplay"></tbody>
		</table>
		
		<%-- === 댓글 페이지바 === --%>
		<div style="display: flex; margin-bottom: 50px;">
			<div id="pageBar" style="margin: auto; text-align: center;"></div>
		</div>
		
	</c:if>
	
	<c:if test="${empty requestScope.freeboardvo}">
		<div style="padding: 50px 0; font-size: 16pt; color: red;">존재하지 않습니다</div>
	</c:if>

 </div>


</div>