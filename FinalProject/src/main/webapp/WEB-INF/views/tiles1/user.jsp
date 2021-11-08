<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>

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

<nav class="navbar navbar-light bg-light">
  <div class="container-fluid">
    <form class="d-flex">
      <input class="form-control me-2" type="search" placeholder="사용자 검색" id="Search">
    	<select id="">
		    <option value="" style="padding: 30px;">모든 역할</option>
		    <option value="교수">교수</option>
		    <option value="학생">학생</option>
	   </select>
    </form>
  </div>
</nav>

<table class="tg" style="undefined;table-layout: fixed; width: 1113px">
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
  <tr>
    <td class="tg-jd8a"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
    <td class="tg-ggm3">금길영(21##01)</td>
    <td class="tg-bwpp">자바프로그래머_256033_001분반</td>
    <td class="tg-fujv">교수</td>
  </tr>
  <tr>
    <td class="tg-7btt"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
    <td class="tg-3qbk">김민경(21##02)</td>
    <td class="tg-0pky">자바프로그래머_256033_002분반</td>
    <td class="tg-c3ow">교수</td>
  </tr>
  <tr>
    <td class="tg-jd8a"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
    <td class="tg-ggm3">박성현(21##03)</td>
    <td class="tg-bwpp">자바프로그래머_256033_003분반</td>
    <td class="tg-fujv">교수</td>
  </tr>
  <tr>
    <td class="tg-7btt"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
    <td class="tg-3qbk">이루리(21##04)</td>
    <td class="tg-0pky">자바프로그래머_256033_001분반</td>
    <td class="tg-c3ow">교수</td>
  </tr>
  <tr>
    <td class="tg-jd8a"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
    <td class="tg-ggm3">송동준(21##05)</td>
    <td class="tg-bwpp">자바프로그래머_256033_002분반</td>
    <td class="tg-fujv">교수</td>
  </tr>
  <tr>
    <td class="tg-7btt"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
    <td class="tg-3qbk">장현걸(21##06)</td>
    <td class="tg-0pky">자바프로그래머_256033_003분반</td>
    <td class="tg-c3ow">교수</td>
  </tr>
  <tr>
    <td class="tg-jd8a"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
    <td class="tg-ggm3">이재성(21##07)</td>
    <td class="tg-bwpp">자바프로그래머_256033_001분반</td>
    <td class="tg-fujv">교수</td>
  </tr>
  <tr>
    <td class="tg-7btt"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
    <td class="tg-3qbk">김철수(21##08)</td>
    <td class="tg-0pky">자바프로그래머_256033_002분반</td>
    <td class="tg-c3ow">학생</td>
  </tr>
  <tr>
    <td class="tg-jd8a"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
    <td class="tg-ggm3">엄정화(21##09)</td>
    <td class="tg-bwpp">자바프로그래머_256033_003분반</td>
    <td class="tg-fujv">학생</td>
  </tr>
  <tr>
    <td class="tg-7btt"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
    <td class="tg-3qbk">김태희(21##10)</td>
    <td class="tg-0pky">자바프로그래머_256033_001분반</td>
    <td class="tg-c3ow">학생</td>
  </tr>
  <tr>
    <td class="tg-jd8a"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
    <td class="tg-ggm3">전지현(21##11)</td>
    <td class="tg-bwpp">자바프로그래머_256033_002분반</td>
    <td class="tg-fujv">학생</td>
  </tr>
  <tr>
    <td class="tg-7btt"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
    <td class="tg-3qbk">오연서(21##12)</td>
    <td class="tg-0pky">자바프로그래머_256033_003분반</td>
    <td class="tg-c3ow">학생</td>
  </tr>
  <tr>
    <td class="tg-jd8a"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
    <td class="tg-ggm3">남주혁(21##13)</td>
    <td class="tg-bwpp">자바프로그래머_256033_001분반</td>
    <td class="tg-fujv">학생</td>
  </tr>
  <tr>
    <td class="tg-7btt"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
    <td class="tg-3qbk">송강(21##14)</td>
    <td class="tg-0pky">자바프로그래머_256033_002분반</td>
    <td class="tg-c3ow">학생</td>
  </tr>
  <tr>
    <td class="tg-jd8a"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
    <td class="tg-ggm3">다니엘(21##15)</td>
    <td class="tg-bwpp">자바프로그래머_256033_003분반</td>
    <td class="tg-fujv">학생</td>
  </tr>
  <tr>
    <td class="tg-7btt"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
    <td class="tg-3qbk">구준표(21##16)</td>
    <td class="tg-0pky">자바프로그래머_256033_001분반</td>
    <td class="tg-c3ow">학생</td>
  </tr>
  <tr>
    <td class="tg-jd8a"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
    <td class="tg-ggm3">서영학(21##17)</td>
    <td class="tg-bwpp">자바프로그래머_256033_002분반</td>
    <td class="tg-fujv">학생</td>
  </tr>
  <tr>
    <td class="tg-7btt"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 496 512'%3e%3cpath fill='%23c9c0c0' d='M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z'/%3e%3c/svg%3e" alt="Image" width="30" height="30"></td>
    <td class="tg-3qbk">장보고(21##18)</td>
    <td class="tg-0pky">자바프로그래머_256033_003분반</td>
    <td class="tg-c3ow">학생</td>
  </tr>
</tbody>
</table>

 
 