<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">


/* 부트스트랩 버튼 색 변경    */

/* .btn-light {
    background-color: #ffcc80; 
    border-color: #ffcc80;
    color:  #FFF;}
.btn-light:hover,
.btn-light:focus {
    border-color: #ffcc80;
    background-color: #ffcc80;
    color: #FFF; }
    
    
   .btn-secondary {
    background-color: #ffb84d;
    border-color: #ffb84d;
    color: #FFF; 
    }    
    
	.btn-secondary:hover,
	.btn-secondary:focus {
    border-color: #ffcc80;
    background-color: #ffcc80;
    color: #FFF; }   
 */


/* 부트스트랩 버튼 색 변경    */

.btn-light {
    background-color: #ffffff;
    border-color: #ff9900;
    color:  #ff8c00;}
.btn-light:hover,
.btn-light:focus {
    border-color: #ffcc80;
    background-color: #ffcc80;
    color: #FFF; }
    
    
   .btn-secondary {
    background-color: #ffb84d;
    border-color: #ffb84d;
    color: #FFF; 
    }    
    
	.btn-secondary:hover,
	.btn-secondary:focus {
    border-color: #ffcc80;
    background-color: #ffcc80;
    color: #FFF; }  
    


/* 게시판 정렬 , 글자색, 글자크기*/
table td {
	text-align: center;
	color:#616161; 
	font-size: 15px;
}



.subjectStyle {font-weight: bold; 
			   cursor: pointer;} 
			   
 

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		$("ul#sideMenuList > li:nth-child(5)").addClass("hoverdEffect");
		
		$("ul#sideMenuList").hover(function(){
			$("ul#sideMenuList > li:nth-child(5)").removeClass("hoverdEffect");
		}, function(){
			$("ul#sideMenuList > li:nth-child(5)").addClass("hoverdEffect");
		});
		
		
		$("span.subject").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("subjectStyle");
		});
				
		$("span.subject").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("subjectStyle");
		});
		
		$("input#searchWord").keyup(function(event){
			if(event.keyCode == 13) {
				// 엔터를 했을 경우
				goSearch();
			}
		});
		
		// 검색시 검색조건 및 검색어 값 유지시키기
		if( ${not empty requestScope.paraMap} ) {
			$("select#searchType").val("${requestScope.paraMap.searchType}");
			$("input#searchWord").val("${requestScope.paraMap.searchWord}");
		}
		
		<%-- === #107. 검색어 입력시 자동글 완성하기 2 === --%>
		$("div#displayList").hide();
		
		$("input#searchWord").keyup(function(){
			
			var wordLength = $(this).val().trim().length;
			// 검색어의 길이를 알아온다.
			
			if(wordLength == 0) {
				$("div#displayList").hide();
				// 검색어가 공백이거나 검색어 입력후 백스페이스키를 눌러서 검색어를 모두 지우면 검색된 내용이 안 나오도록 해야 한다. 
			}
			else {
			
				$.ajax({
					url:"<%= request.getContextPath()%>/QnAWordSearchShow.univ",
					type:"GET",
					data:{"searchType":$("select#searchType").val()
						 ,"searchWord":$("input#searchWord").val()},
					dataType:"JSON",
					success:function(json){
						
						<%-- === #112. 검색어 입력시 자동글 완성하기 7 === --%>
						if(json.length > 0) {
							// 검색된 데이터가 있는 경우
							
							var html = "";
							
							$.each(json, function(index, item){
								// 입력한 내용
								var word = item.word;
								// 입력한 내용 시작하는 숫자
								var index = word.toLowerCase().indexOf( $("input#searchWord").val().toLowerCase() ); 
								// 입력한 내용 길이
								var len = $("input#searchWord").val().length;
								// 결과값넣기
								var result = word.substr(0, index) + "<span style='color:blue;'>"+word.substr(index,len)+"</span>" + word.substr(index+len); 
								
								html += "<span style='cursor:pointer' class='result'>"+result+"</span><br>";
							
							});//end of $.each(json, function(index, item){--------------------------------------
							
							// 검색어 input 태그 width 알아오기
							var input_width = $("input#searchWord").css("width"); 
							// 검색결과 div의 width 크기를 검색어 input 태그 width 와 일치시키기 
							$("div#displayList").css({"width":input_width}); 
							// 넣기
							$("div#displayList").html(html);
							$("div#displayList").show();
						
						}//end of if(json.length > 0) {----------------------------------------------------------
						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
					
				});//end of $.ajax({-----------------------------------------------------------------------------
					
			}//end of if(wordLength == 0) {----------------------------------------------------------------------
			
		}); // end of $("input#searchWord").keyup(function(){----------------------------------------------------
		
		<%-- === #113. 검색어 입력시 자동글 완성하기 8 === --%>
		$(document).on("click",".result",function(){
			
			var word = $(this).text();
			// 텍스트박스에 검색된 결과의 문자열을 입력해준다.
			$("input#searchWord").val(word);  
			$("div#displayList").hide();
			goSearch();
			
		});//end of $(document).on("click",".result",function(){-------------------------------------------------
		
	});// end of $(document).ready(function(){})-----------------------------------------------------------------
	
	//////////////////////////////////////////////////////////////////
	
	function goView(seq) {
		
	<%--location.href="<%= ctxPath%>/view.action?seq="+seq;--%>
		
		// === #125. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후 === //
		//           사용자가 목록보기 버튼을 클릭했을 떄 돌아갈 페이지를 알려주기위해
		//			  현재 페이지 주소를 뷰단에 넘겨준다
		var frm = document.goViewFrm;
		frm.seq.value = seq;
		frm.gobackURL.value = "${requestScope.gobackURL}"
		frm.searchType.value = "${requestScope.paraMap.searchType}"; //이전글, 다음글 추가
		frm.searchWord.value = "${requestScope.paraMap.searchWord}";
		
		frm.method = "GET";
		frm.action = "<%= request.getContextPath()%>/QnAView.univ";
		frm.submit();
		
	}// end of function goView(seq) {}--------------------------------

	function goSearch() {
		var frm = document.searchFrm;
		frm.method = "GET";
		frm.action = "<%= request.getContextPath()%>/QnA.univ";
		
		//code를 추가했는데 맞게 한건지 다시 빼야하는지 모르겠다
		frm.submit();
	}// end of function goSearch() {}---------------------------------
	
</script>
<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left;"><span style="color: #0099ff; text-decoration: underline;">문의게시판</span></h3>
<hr style="clear: both;">

<div class="container p-5" >
	<%-- === #101. 글검색 폼 추가하기 : 글제목, 글쓴이로 검색을 하도록 한다. === --%>
	<div class="pt-5 pb-5">	
		<form name="searchFrm" style="margin-top: 20px; margin-bottom: 15px;">
			<select name="searchType" id="searchType" style="height: 30px;">
				<option value="subject">글제목</option>
				<option value="name">글쓴이</option>
			</select> &nbsp;
			<input type="text" name="searchWord" id="searchWord" size="110" style="height: 30px; width: 250px; font-size: 12pt;  autocomplete="off" />
			<input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%>&nbsp;
			<button type="button" class="btn btn-light btn-sm" onclick="goSearch()">검색</button>
			<button type="button"  onclick="javascript:location.href='<%= request.getContextPath()%>/QnAAdd.univ'" class="btn btn-secondary float-right" style="font-size: 10pt; padding: 5px 12px; text-align: right;">+ 글쓰기</button>&nbsp;
		</form>
		<%-- === #106. 검색어 입력시 자동글 완성하기 1 === --%>
		<div id="displayList" style="border: solid 1px gray; height: 100px; overflow: auto; margin-left: 77px; margin-top: -1px; border-top: 0px; "></div>
	</div>
	
	<table class="table table-hover">
		<thead>
			<tr>
				<th style="width: 70px; text-align: center;">글번호</th>
				<th style="width: 360px;text-align: center;">제목</th>
				<th style="width: 150px; text-align: center;">글쓴이</th>
				<th style="width: 150px; text-align: center;">작성일</th>
				<th style="width: 70px; text-align: center;">조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="QnAvo" items="${requestScope.QnAList}">
				<tr>
					<td align="center">${QnAvo.seq}</td>
					<td align="left">
						<%-- === 댓글쓰기 및 답변형 및 파일첨부가 있는 게시판 시작 === --%>
						<%-- 답변글이 아닌 원글인 경우 --%>
						<c:if test="${QnAvo.depthno == 0}">
							<span class="subject" onclick="goView('${QnAvo.seq}')">${QnAvo.subject}</span>
						</c:if>
						<%-- 답변글인 경우 --%>
						<c:if test="${QnAvo.depthno > 0}">
							<span class="subject" onclick="goView('${QnAvo.seq}')"><span style="color: orange; font-style: italic; padding-left:${QnAvo.depthno * 20}px;">└Re&nbsp;</span>${QnAvo.subject}</span>
						</c:if>
						<%-- 첨부파일이 없는 경우 끝 --%>
					</td>
					<td align="center">${QnAvo.name}</td>
					<td align="center">${QnAvo.regDate}</td>
					<td align="center">${QnAvo.readCount}</td>
				</tr>
			</c:forEach>	
		</tbody>
	</table>
	
	<%-- === #122. 페이지바 보여주기 === --%>
	<div align="center" style="margin:20px auto; width:70%; padding-top: 4%;">
		${requestScope.pageBar}
	</div>
	
	<%-- === #124. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후 === //
	  사용자가 목록보기 버튼을 클릭했을 떄 돌아갈 페이지를 알려주기위해 현재 페이지 주소를 뷰단에 넘겨준다 --%>
	<form name="goViewFrm"> <%-- 폼태그에 담아서 view.jsp에 전송할 것이다. --%>
		<input type="hidden" name="seq" />
		<input type="hidden" name="gobackURL" />
		<input type="hidden" name="searchType" /> 
		<input type="hidden" name="searchWord" />
	</form>
</div>





