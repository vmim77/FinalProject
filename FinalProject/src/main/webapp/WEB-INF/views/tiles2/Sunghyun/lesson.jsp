<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script>
	$(document).ready(function(){
		
		$("ul#sideMenuList > li:nth-child(2)").addClass("hoverdEffect");
		
	});

</script>

<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left; color: #0099ff;">${requestScope.subjectMap.subject}_${requestScope.subjectMap.ban}반(${requestScope.subjectMap.teacher}) 강의실 > 강의자료실</h3>
<hr style="clear: both;">
    
<img src="<%= request.getContextPath()%>/resources/images/nolesson.png" style="width: 100%; padding: 10px;" />