<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   


<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-3qbk{border-color:inherit;color:#3166ff;text-align:left;vertical-align:top}
.tg .tg-c3ow{border-color:inherit;text-align:center;vertical-align:top}
.tg .tg-2k8k{border-color:inherit;font-size:13px;font-weight:bold;text-align:center;vertical-align:top}
.tg .tg-fymr{border-color:inherit;font-weight:bold;text-align:left;vertical-align:top}
.tg .tg-7btt{border-color:inherit;font-weight:bold;text-align:center;vertical-align:top}
.tg .tg-jd8a{background-color:#e5dede;border-color:inherit;font-weight:bold;text-align:center;vertical-align:top}
.tg .tg-ggm3{background-color:#e5dede;border-color:inherit;color:#3166ff;text-align:left;vertical-align:top}
.tg .tg-bwpp{background-color:#e5dede;border-color:inherit;text-align:left;vertical-align:top}
.tg .tg-fujv{background-color:#e5dede;border-color:inherit;text-align:center;vertical-align:top}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
</style>

<script type="text/javascript">

$(document).ready(function(){
	
	$("span.subject").bind("mouseover", function(event){
		var $target = $(event.target);
		$target.addClass("subjectStyle");
	});
	
	$("span.subject").bind("mouseout", function(){
		var $target = $(event.target);
		$target.removeClass("subjectStyle");
	});
	
	$("input#searchWord").keyup(function(event){
		if(event.keyCode == 13){
			// 엔터를 했을 경우
			goSearch();
		}
	});
	
	// 검색시 검색조건 및 검색어 값 유지시키기
	// 무언가가 검색됐다면 paraMap에 넣어뒀다.
	if( ${not empty requestScope.paraMap} ) { 
		$("select#searchType").val("${requestScope.paraMap.searchType}");
		$("input#searchWord").val("${requestScope.paraMap.searchWord}");
	}
	
	<%-- === #107. 검색어 입력시 자동글 완성하기 2 === --%>
	$("div#displayList").hide();
	
	$("input#searchWord").keyup(function(){
		
		var wordLength = $(this).val().trim().length;
		// 검색어의 길이를 알아온다.
		
		if(wordLength == 0){
			$("div#displayList").hide();
			// 검색어가 공백이거나 검색어 입력후 백스페이스키를 눌러서 검색어를 모두 지우면 검색된 내용이 안 나오도록 해야 한다.
		}
		else{
			$.ajax({
				url:"<%= request.getContextPath()%>/wordSearchShow.action",
				type:"GET",
				data:{"searchType":$("select#searchType").val()
					 ,"searchWord":$("input#searchWord").val()},
				dataType:"JSON",
				success:function(json){
					if(json.length > 0) {
						// 검색된 데이터가 있는 경우
						var html = "";
						$.each(json, function(index, item){
							var word = item.word; // 검색된 결과
							
							var index = word.toLowerCase().indexOf( $("input#searchWord").val().toLowerCase() ); // 우리가 입력한 검색어의 위치값
							
							var len = $("input#searchWord").val().length; // 검색된 결과의 총 길이
							
							var result = word.substr(0, index) + "<span style='color: blue;'>" + word.substr(index, len) + "</span>" + word.substr(index+len);
							
							html += "<span style='cursor: pointer;' class='result'>"+result+"</span><br>";
							
						});
						
						
						var input_width = $("input#searchWord").css("width"); // 검색어 input 태그 width 알아오기
						
						$("div#displayList").css({"width":input_width}); // 검색결과 div의 width 크기를 검색어 input 태그 width 와 일치시키기
						
						$("div#displayList").html(html);
						$("div#displayList").show();
					}
					
				},
				error: function(request, status, error){
	                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
			});
		}
	}); // end of $("input#searchWord").keyup(function(){})--------------------------------------------------------------------
	
	
	$(document).on("click", ".result", function(){
		// 스크립트에서 기술된 코드이니깐 다음과 같이 잡아줘야한다.
		var word = $(this).text();
		$("input#searchWord").val(word); // 클릭한 자동완성 검색어를 검색어 input 태그에 넣어준다.
										 // 텍스트박스에 검색된 결과의 문자열을 입력해준다.
		$("div#displayList").hide(); // 원하는 것을 클릭했으니 검색결과를 숨겨준다.
		goSearch(); // 그리고 원하는 것으로 검색시켜준다.
	});// end of $(document).on("click", ".result", function(){})------------------------
		
	
}); // end of $(document).ready(function(){})----------------------------
	
	

// Function Declaration
function goSearch() {
	var frm = document.searchFrm;
	frm.method = "GET";
	frm.action = "<%= request.getContextPath()%>/user.univ";
	frm.submit();

	}// end of function goSearch()------------------------------
	
	
}	
		
		

</script>


<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link active" aria-current="page">전체</a>
  </li>
</ul>


<%-- ===글검색 폼 추가하기 : 글제목, 글쓴이로 검색을 하도록 한다. === --%>
<form name="searchFrm" style="margin-top: 20px;">
	<select name="searchType" id="searchType" style="height: 26px;">
		<option value="name">이름</option>
		<option value="hakbun">학번</option>
	</select>
	<input type="text" name="searchWord" id="searchWord" size="30" autocomplete="off" />
	<input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%>
	<button type="button" class="btn btn-secondary btn-sm" id="btnSearch">검색하기</button>
</form>

<table class="tg" style="undefined; table-layout: fixed;">
<colgroup>
<col style="width: 110px">
<col style="width: 120px">
<col style="width: 150px">
</colgroup>
<thead>
  <tr>
    <th class="">사진</th>
    <th class="">학번</th>
    <th class="">과목명</th>
    <th class="">이름</th>
  </tr>
</thead>
<tbody>
  <c:forEach var="TeacherList" items="${requestScope.TeacherList}">
	  <tr>
	    <td class=""><img src="<%= ctxPath%>/resources/files/${TeacherList.picture}" width="110px" height="90px"></td>
	    <td class="">${TeacherList.hakbun}</td>
	    <td class="">${TeacherList.subject }</td>
	    <td class="">${TeacherList.name }</td>
	  </tr>
   </c:forEach>
</tbody>
</table>


<form name="goViewFrm">
		<input type="hidden" name="name" />
		<input type="hidden" name="section" />
		<input type="hidden" name="hal" />
	</form>	  


 