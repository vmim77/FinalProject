<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%  String ctxPath = request.getContextPath();  %>
    
    
 <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>   
 
 
 <script type="text/javascript">
 
 $(document).ready(function(){
	
	 var subject = [];
	 var classDate = [];
	 
	 var subject = "${requestScope.subject}";
	 var classDate = "${requestScope.classDate}";
	 
	 subject = subject.substr(0,subject.lastIndexOf(","));
	 classDate = classDate.substr(0,classDate.lastIndexOf(","));
	 console.log("subject"+subject);
	 console.log("classDate"+classDate);
	 
	 
	 var subArr = [];
	 subArr = subject.split(",");
	 
	 var clrArr = [];
	 clsArr = classDate.split(",");
	 
	 var monhtml = "";
	 var tuehtml = "";
	 var wedhtml = "";
	 var thuhtml = "";
	 var frihtml = "";
	 
	 for(var i=0; i<clsArr.length; i++){
		 console.log("classDate"+clsArr[i]);
		 
		 if(clsArr[i] == "1"){
			 monhtml += "<div>"+subArr[i]+"</div>";
		 }
		 if(clsArr[i] == "2"){
			 tuehtml += "<div>"+subArr[i]+"</div>";
		 }
		 if(clsArr[i] == "3"){
			 wedhtml += "<div>"+subArr[i]+"</div>";
		 }
		 if(clsArr[i] == "4"){
			 thuhtml += "<div>"+subArr[i]+"</div>";
		 }
		 if(clsArr[i] == "5"){
			 frihtml += "<div>"+subArr[i]+"</div>";
		 }
		 
	 }
	 
	 $("td#mon").html(monhtml);
	 $("td#tue").html(tuehtml);
	 $("td#wed").html(wedhtml);
	 $("td#thu").html(thuhtml);
	 $("td#fri").html(frihtml);
	 
 });
 </script>
 
 <style>
 table, th, td {
     border: 1px solid black;
     border-collapse: collapse;
     text-align: center;
     width : 100px;
     height: 40px;
 }
 th, td {
     padding: 20px;
 }
 th {
     text-align: center;
 }
 </style>
 
 
 <div style="margin-left: 250px;">
 <table  class="scheduleTable" style="width: 70%;">
 	<tr>
		<th>이름</th> 	
		<th>학번</th>
		<th rowspan="2" style="width: 500px;">2021년도 2학기 수강신청 현황</th>
		
 	</tr>
	 <tr>
	 	<td>${sessionScope.loginuser.name}</td>
 		<td>${sessionScope.loginuser.hakbun}</td>
 	</tr>
 </table>
 

<table class="scheduleTable" style="width: 70%;">
    <tr>
       <td class="scheduleWeek" style="background-color:#ff5c33;">월</td>
       <td class="scheduleWeek" style="background-color:#ffc266;">화</td>
       <td class="scheduleWeek" style="background-color:#ffff99;">수</td>
       <td class="scheduleWeek" style="background-color:#b3ff99;">목</td>
       <td class="scheduleWeek" style="background-color:#99ffdd;">금</td>
    </tr>
    <tr>
       <td id="mon" class="scheduleTd"></td>
       <td id="tue" class="scheduleTd"></td>
       <td id="wed" class="scheduleTd"></td>
       <td id="thu" class="scheduleTd"></td>
       <td id="fri" class="scheduleTd"></td>
    </tr>                          
   </table>
   
   
   <table class="scheduleTable" style="width: 70%;">
  <tr>
    <th>2021년 2학기 수강신청 관련된 사항을 아래와 같이 안내 드립니다.</th>
  </tr>
  <tr>
  	<td>1.수강신청에 이상이 있거나, 원하는 수강신청이 아닌경우 교학1팀 (031-280-3410 ~ 3) 으로 문의주시면 자세하게  <br>안내 도와드리겠습니다.
  	<br>
  		2.수강신청 철회기간은 11월13일 수업기준 7일까지 철회가 가능하며, 학부사무실을 통해 진행해주시면 되겠습니다.</td>
  </tr>
</table>
 </div>
   
     		
   
