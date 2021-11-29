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

// Function Declaration
function goView(seq) {
	
	<%--
	 location.href="<%= ctxPath%>/view.action?seq="+seq;
	--%> 
	
	// === #124. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후 
	//           사용자가 목록보기 버튼을 클릭했을 때 돌아갈 페이지를 알려주기 위해 
	//           현재 페이지 주소를 뷰단을 넘겨준다. 
	var frm = document.goViewFrm;   
	frm.seq.value = seq;
	frm.gobackURL.value = "${requestScope.gobackURL}";
	frm.searchType.value = "${requestScope.paraMap.searchType}";
	frm.searchWord.value = "${requestScope.paraMap.searchWord}";
	
	frm.method = "GET";
	frm.action = "<%= ctxPath%>/user.univ";
	frm.submit();
	
}// end of function goView(seq) {}--------------------------------

function goSearch() {
	var frm = document.searchFrm;
	frm.method = "GET";
	frm.action = "<%= request.getContextPath()%>/user.univ";
	frm.submit();
}// end of function goSearch() {}---------------------------------


</script>



 <div class="collapse" id="navbarToggleExternalContent">
  <div class="bg-primary p-4">
    <h5 class="text-white h4"></h5>
    <span class="text-muted"></span>
  </div>
</div>


<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="<%= ctxPath%>/user.univ">전체</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#">그룹</a>
  </li>
</ul>

<%-- === 글검색 폼 추가하기 : 글제목, 글쓴이로 검색을 하도록 한다. === --%>
<form name="searchFrm" style="margin-top: 20px;">
	<select name="searchType" id="searchType" style="height: 26px;">
		<option value="name">이름</option>
		<option value="section">섹션</option>
		<option value="hal">역할</option>
	</select>
	<input type="text" name="searchWord" id="searchWord" size="30" autocomplete="off" />
	<input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%>
	<button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
</form>

<table class="tg" style="undefined;table-layout: fixed; width: 1113px;">
<colgroup>
<col style="width: 86px">
<col style="width: 266px">
<col style="width: 482px">
<col style="width: 279px">
</colgroup>
<thead>
  <tr>
    <th class="tg-2k8k"></th>
    <th class="tg-fymr">이름</th>
    <th class="tg-fymr">섹션</th>
    <th class="tg-7btt">역할</th>
  </tr>
</thead>
<tbody>
  <c:forEach var="TeacherList" items="${requestScope.TeacherList}">
	  <tr>
	    <td class="tg-jd8a"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
	    <td class="">${TeacherList.teacher}</td>
	    <td class="tg-jd8a">${TeacherList.subject}</td>
	    <td class="">교수</td>
	  </tr>
   </c:forEach>
</tbody>
</table>

<form name="goViewFrm">
		<input type="hidden" name="name" />
		<input type="hidden" name="section" />
		<input type="hidden" name="hal" />
	</form>	  

 
 