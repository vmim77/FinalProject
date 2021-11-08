<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script>
	$(document).ready(function(){
		
		$("ul#sideMenuList > li:nth-child(2)").addClass("hoverdEffect");
		
	});

</script>

<h3>${requestScope.subjectMap.subject}_${requestScope.subjectMap.ban}반(${requestScope.subjectMap.teacher}) 강의실 > 강의자료실</h3>
<hr>
    
<img src="<%= request.getContextPath()%>/resources/images/nolesson.png" style="width: 100%; padding: 10px;" />