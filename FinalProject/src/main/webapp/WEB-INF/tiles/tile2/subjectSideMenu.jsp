<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<div style="font-size: 9pt; color: gray; margin-top: 20px; width:100%;">2021년 <span style="font-style: italic;">2</span>&nbsp;학기</div>
<ul id="sideMenuList" style="list-style: none; padding: 0;">
	<li class="sideMenu" onclick="javascript:location.href='<%= ctxPath%>/subject.univ?code=${sessionScope.code}'">홈</li>
	<li class="sideMenu" onclick="javascript:location.href='<%= ctxPath%>/notice.univ'">공지사항</li>
	<li class="sideMenu" onclick="javascript:location.href='<%= ctxPath%>/lesson.univ'">강의자료실</li>
	<li class="sideMenu">자유게시판</li>
	<li class="sideMenu" onclick="javascript:location.href='<%= ctxPath%>/QnA.univ'">문의게시판</li>
	<li class="sideMenu" onclick="javascript:location.href='<%= ctxPath%>/homework.univ'">과제 및 평가</li>
	<li class="sideMenu" onclick="javascript:location.href='<%= ctxPath%>/classContents.univ'">강의콘텐츠</li>
	<li class="sideMenu">출결/학습 현황</li>
</ul>
