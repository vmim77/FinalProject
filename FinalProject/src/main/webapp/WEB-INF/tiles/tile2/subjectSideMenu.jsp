<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<div style="font-size: 9pt; color: gray; margin-top: 20px; width:100%;">2021년 <span style="font-style: italic;">2</span>&nbsp;학기</div>
<ul id="sideMenuList" style="list-style: none; padding: 0;">
	<li class="sideMenu" onclick="javascript:location.href='<%= ctxPath%>/subject.univ?code=${requestScope.code}'">홈</li>
	<li class="sideMenu" onclick="javascript:location.href='<%= ctxPath%>/lesson.univ?code=${requestScope.code}'">강의자료실</li>
	<li class="sideMenu">열린게시판</li>
	<li class="sideMenu">문의게시판</li>
	<li class="sideMenu" onclick="javascript:location.href='<%= ctxPath%>/homework.univ?code=${requestScope.code}'">과제 및 평가</li>
	<li class="sideMenu">토론</li>
	<li class="sideMenu">강의콘텐츠</li>
	<li class="sideMenu">ClassMix</li>
	<li class="sideMenu">사용자 및 그룹</li>
	<li class="sideMenu">성적</li>
	<li class="sideMenu">출결/학습 현황</li>
</ul>
