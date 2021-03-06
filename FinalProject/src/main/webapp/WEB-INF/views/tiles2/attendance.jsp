<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

.tg1  {border:none;border-collapse:collapse;border-spacing:0;}
.tg1 td {border-style:solid;border-width:0px;font-family:Arial, sans-serif;font-size:14px;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg1 th { border-style:solid;border-width:0px;font-family:Arial, sans-serif;font-size:14px;font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg1 .tg-0pky { border-color:inherit;text-align:left;vertical-align:top}

.tg {border-collapse:collapse;border-spacing:0;}
.tg td {border-color:#ffcc80;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th {border-color:#ffcc80;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-1jqf {background-color:#efefef;border-color:#ffcc80;color:#9b9b9b;font-weight:bold;text-align:center;vertical-align:top}
.tg .tg-r1ml { background-color:#f0fbec;border-color:#ffcc80;color:#00b33c;font-weight:bold;text-align:center;vertical-align:top}
.tg .tg-dcw3 {background-color:#f0fbec;border-color:#ffcc80;color:#05af06;font-weight:bold;text-align:center;vertical-align:middle}
.tg .tg-ougll { background-color: #ffb84d; border-color:#ffcc80;color:#fff;font-weight:bold;text-align:center;vertical-align:top;}
.tg .tg-ougl { background-color: #ffb84d; border-color:#ffcc80;color:#fff;font-weight:bold;text-align:center;vertical-align:top; border-left: hidden; border-right: hidden;}
.tg .tg-fzdr { border-color:#ffcc80;text-align:center;vertical-align:center;}
.tg .tg-wo29 { border-color:#ffcc80;text-align:left;vertical-align:top}
.tg .tg-377c {background-color:#e1f0fb;border-color:#ffcc80;color:#3a68eb;font-weight:bold;text-align:center;vertical-align:top}

.tg3  {border-collapse:collapse;border-spacing:0;}
.tg3 td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg3 th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg3 .tg-tjwp{background-color:#efefef;font-size:13px;font-weight:bold;border-color:#c0c0c0;text-align:center;vertical-align:top}
.tg3 .tg-fzdr{border-color:#c0c0c0;font-size:13px;text-align:center;vertical-align:top}

.button{border-radius: 12%; background-color: #fff; color: #808080; border: solid 1px #bfbfbf;"}

</style>

<script type="text/javascript">

   $(document).ready(function(){
	   
		$("ul#sideMenuList > li:nth-child(8)").addClass("hoverdEffect");
		
		$("ul#sideMenuList").hover(function(){
			$("ul#sideMenuList > li:nth-child(8)").removeClass("hoverdEffect");
		}, function(){
			$("ul#sideMenuList > li:nth-child(8)").addClass("hoverdEffect");
		});

      
   
   });

</script>


<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left;">${requestScope.subjectMap.subject} 강의실(${requestScope.subjectMap.name}) > <span style="color: #0099ff; text-decoration: underline;">강의콘텐츠</span></h3>
<hr style="clear: both;">

<div style="display: flex;">
<div style="margin: auto;">

<table class="tg1" style="margin-bottom: 10px; ">
<thead>
  <tr>
    <th class="tg-0pky">출석 <span style="font-weight:bold;color:#3531FF">${requestScope.paraMap4.totalAttendCnt }</span><span style="font-weight:bold"> </span><span style="color:#9B9B9B">&nbsp;|</span></th>
    <th class="tg-0pky">지각 <span style="font-weight:bold;color:#FE0000">${requestScope.paraMap4.totalLateCnt }</span><span style="color:#9B9B9B">&nbsp;&nbsp;|</span></th>
    <th class="tg-0pky">지각 출석 <span style="font-weight:bold;color:#FE0000">${requestScope.paraMap4.totalLateAttendCnt }</span><span style="color:#9B9B9B">&nbsp;&nbsp;|</span></th>
    <th class="tg-0pky">결석 <span style="font-weight:bold;color:#FE0000">${requestScope.paraMap4.totalNotAttendCnt }</span> <span style="color:#9B9B9B">&nbsp;|</span></th>
    <th class="tg-0pky">미결 <span style="font-weight:bold">${requestScope.paraMap4.totalmigual }</span></th>
  </tr>
</thead>
<tbody>
   <tr>
    <td class="tg-0pky" colspan="2">학습 완료 상태&nbsp; &nbsp;:</td>
    <td class="tg-0pky" style="text-align:center;">완료 <span style="font-weight:bold;color:#3531FF">${requestScope.paraMap4.totalCommentCnt }</span> <span style="color:#9B9B9B">&nbsp;&nbsp;&nbsp;&nbsp;|</span></td>
    <td class="tg-0pky">미완료 <span style="font-weight:bold">${requestScope.paraMap4.totalNotCommentCnt}</span></td>
  </tr> 
</tbody>
</table>
	
<table class="tg" style="width:100%; overflow: auto;" class="table table-bordered">
<thead>
  <tr>
    <th class="tg-ougll" style="width: 150px; text-align: center;">주차</th>
    <th class="tg-ougl" style="width: 100px; text-align: center;">차시</th>
    <th class="tg-ougl" style="width: 380px; text-align: center;">학습 제목</th>
    <th class="tg-ougl" style="width: 100px; text-align: center;">학습 유형</th>
    <th class="tg-ougl" style="width: 110px; text-align: center;">학습 현황</th>
    <th class="tg-ougl" style="width: 110px; text-align: center;">출결 현황</th>
    <!-- <th class="tg-ougll" style="width: 100px; text-align: center;">상세이력</th> -->
  </tr>
</thead>
<tbody>

<c:forEach var="weekvo" items="${requestScope.getWeek}" varStatus="statusWeek">
	<c:forEach var="cnt" items="${requestScope.lessonCntList[statusWeek.index]}">	
		<c:forEach var ="classmap" items="${requestScope.classList}" varStatus="statusClass">
		<c:if test="${weekvo.week==classmap.week}">
		  <tr>
		    <c:if test="${classmap.lesson ==1 }"><td class="tg-fzdr" rowspan="${cnt*2}">0${classmap.week} ${classmap.week}주차</td></c:if>
		    <td class="tg-fzdr" rowspan="2">${classmap.lesson}차시</td>
		    <td class="tg-wo29">${classmap.subject} ${classmap.week}주차-${classmap.lesson}교시</td>
		    <td class="tg-fzdr">동영상</td>
		    
		    <c:forEach var="lessonCheckCnt" items="${requestScope.lessonCheckList[statusClass.index]}">
			    <c:if test="${lessonCheckCnt==1 }">
			    	<!-- 완료 --><td class="tg-r1ml" ><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512'%3e%3cpath fill='%23429e52' d='M504 256c0 136.967-111.033 248-248 248S8 392.967 8 256 119.033 8 256 8s248 111.033 248 248zM227.314 387.314l184-184c6.248-6.248 6.248-16.379 0-22.627l-22.627-22.627c-6.248-6.249-16.379-6.249-22.628 0L216 308.118l-70.059-70.059c-6.248-6.248-16.379-6.248-22.628 0l-22.627 22.627c-6.248 6.248-6.248 16.379 0 22.627l104 104c6.249 6.249 16.379 6.249 22.628.001z'/%3e%3c/svg%3e" width="13" height="13">&nbsp;&nbsp;완료</td>
			    </c:if>
			    <c:if test="${lessonCheckCnt==0}">
					<!-- 미수강 --><td class="tg-377c" style="background-color:#cccccc; color:black;"><img src="/univ/resources/images/검은색 체크3.png" width="13" height="13">&nbsp;&nbsp;미수강</td>    	
			    </c:if>
			    <c:if test="${lessonCheckCnt==2}">
			    	<td class="tg-377c" style="background-color:#ffe6b3; color:#ff8c1a;"><img src="/univ/resources/images/노란색 체크.png" width="13" height="13">&nbsp;&nbsp;지각</td>
			    </c:if>
			    <c:if test="${lessonCheckCnt==3}">
			    	<td class="tg-377c" style="background-color:#ffe6b3; color:#ff8c1a;"><img src="/univ/resources/images/노란색 체크.png" width="13" height="13">&nbsp;&nbsp;지각출석</td>
			    </c:if>
			    <c:if test="${lessonCheckCnt==4}">
			    	<td class="tg-377c" style="background-color:#ffc2b3; color:#ff3300;"><img src="/univ/resources/images/빨간색 체크.png" width="13" height="13">&nbsp;&nbsp;결석</td>
			    </c:if>
		    </c:forEach>
		    
		    
		    <c:forEach var="lessonCheckCnt" items="${requestScope.lessonCheckList[statusClass.index]}">
			    <c:if test="${lessonCheckCnt==1 }">
			    	<!-- 출석 --><td class="tg-377c"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512'%3e%3cpath fill='%23235ce1' d='M504 256c0 136.967-111.033 248-248 248S8 392.967 8 256 119.033 8 256 8s248 111.033 248 248zM227.314 387.314l184-184c6.248-6.248 6.248-16.379 0-22.627l-22.627-22.627c-6.248-6.249-16.379-6.249-22.628 0L216 308.118l-70.059-70.059c-6.248-6.248-16.379-6.248-22.628 0l-22.627 22.627c-6.248 6.248-6.248 16.379 0 22.627l104 104c6.249 6.249 16.379 6.249 22.628.001z'/%3e%3c/svg%3e" width="13" height="13">&nbsp;&nbsp;출석</td>
			    </c:if>
			    <c:if test="${lessonCheckCnt==0}">
					<!-- 미결 --><td class="tg-377c" style="background-color:#cccccc; color:black;"><img src="/univ/resources/images/검은색 체크3.png" width="13" height="13">&nbsp;&nbsp;미결</td>    	
			    </c:if>
			    <c:if test="${lessonCheckCnt==2}">
			    	<td class="tg-377c" style="background-color:#ffe6b3; color:#ff8c1a;"><img src="/univ/resources/images/노란색 체크.png" width="13" height="13">&nbsp;&nbsp;지각</td>
			    </c:if>
			    <c:if test="${lessonCheckCnt==3}">
			    	<td class="tg-377c" style="background-color:#ffe6b3; color:#ff8c1a;"><img src="/univ/resources/images/노란색 체크.png" width="13" height="13">&nbsp;&nbsp;지각출석</td>
			    </c:if>
			    <c:if test="${lessonCheckCnt==4}">
			    	<td class="tg-377c" style="background-color:#ffc2b3; color:#ff3300;"><img src="/univ/resources/images/빨간색 체크.png" width="13" height="13">&nbsp;&nbsp;결석</td>
			    </c:if>
		    </c:forEach>
		    
		    <!-- <td class="tg-fzdr"><button type="button" class="button" data-toggle="modal" data-target="#myModal"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 576 512'%3e%3cpath fill='%23c9c9c9' d='M572.52 241.4C518.29 135.59 410.93 64 288 64S57.68 135.64 3.48 241.41a32.35 32.35 0 0 0 0 29.19C57.71 376.41 165.07 448 288 448s230.32-71.64 284.52-177.41a32.35 32.35 0 0 0 0-29.19zM288 400a144 144 0 1 1 144-144 143.93 143.93 0 0 1-144 144zm0-240a95.31 95.31 0 0 0-25.31 3.79 47.85 47.85 0 0 1-66.9 66.9A95.78 95.78 0 1 0 288 160z'/%3e%3c/svg%3e" width="15" height="15">&nbsp;보기</button></td> -->
		  </tr>
		  <tr>
		    <td class="tg-wo29">${classmap.subject} ${classmap.week}주차-${classmap.lesson}교시_요약정리</td>
		    <td class="tg-fzdr">토론</td>
		    
		    <c:forEach var="lessonCommentListCnt" items="${requestScope.lessonCommentList[statusClass.index]}">
		    <fmt:formatNumber value="${lessonCommentListCnt}" type="number" var="lessonCommentListCntNum" />		    
			    <c:if test="${lessonCommentListCntNum>0}">
			    	<!-- 완료 --><td class="tg-r1ml" ><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512'%3e%3cpath fill='%23429e52' d='M504 256c0 136.967-111.033 248-248 248S8 392.967 8 256 119.033 8 256 8s248 111.033 248 248zM227.314 387.314l184-184c6.248-6.248 6.248-16.379 0-22.627l-22.627-22.627c-6.248-6.249-16.379-6.249-22.628 0L216 308.118l-70.059-70.059c-6.248-6.248-16.379-6.248-22.628 0l-22.627 22.627c-6.248 6.248-6.248 16.379 0 22.627l104 104c6.249 6.249 16.379 6.249 22.628.001z'/%3e%3c/svg%3e" width="13" height="13">&nbsp;&nbsp;완료</td>
			    </c:if>
			    <c:if test="${lessonCommentListCnt==0}">
					<!-- 미완료 --><td class="tg-377c"style="background-color:#cccccc; color:black;"><img src="/univ/resources/images/검은색 체크3.png" width="13" height="13">&nbsp;&nbsp;미완료</td>    	
			    </c:if>
		    </c:forEach>
		    
		   
		    
		    <td class="tg-1jqf">출결대상아님</td>
		    <!-- <td class="tg-fzdr"><button type="button" class="button" data-toggle="modal" data-target="#myModal"><img src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 576 512'%3e%3cpath fill='%23c9c9c9' d='M572.52 241.4C518.29 135.59 410.93 64 288 64S57.68 135.64 3.48 241.41a32.35 32.35 0 0 0 0 29.19C57.71 376.41 165.07 448 288 448s230.32-71.64 284.52-177.41a32.35 32.35 0 0 0 0-29.19zM288 400a144 144 0 1 1 144-144 143.93 143.93 0 0 1-144 144zm0-240a95.31 95.31 0 0 0-25.31 3.79 47.85 47.85 0 0 1-66.9 66.9A95.78 95.78 0 1 0 288 160z'/%3e%3c/svg%3e" width="15" height="15">&nbsp;보기</button></td> -->
		  </tr>
		  </c:if>
    	</c:forEach>      	
 	 </c:forEach>
</c:forEach>

</tbody>
</table>

<c:forEach var="map" items="${requestScope.classList}" varStatus="status">
<!-- The Modal -->
    <div class="modal" id="myModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content ">
        
                <!-- Modal Header -->
                <div class="modal-header" style="background-color: #e6e6e6;">
                    <h6 class="modal-title" align="center" style="font-weight: bold;">${map.fk_hakbun} 출결 상세 이력</h6>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
            
                <!-- Modal body -->
               
                   <h6 class="modal-body" align="left" style="font-size: 10pt; font-weight: bold;">${map.subject} ${map.week}주차-${map.lesson}교시_요약정리 </h6>
                   <p align="left" style="margin-left: 20px; font-size: 9pt; color: #8c8c8c;">${map.week}주차|토론<span style="float: right; margin-right: 10px;">마감일시 : 9월 19일 오후 11:59</span> </p>
               
	            	<table class="tg3" style="width: 780px; margin-left: 10px;">
						<thead>
						  <tr>
						    <th class="tg-tjwp">학습 일시</th>
						    <th class="tg-tjwp">학습 현황</th>
						  </tr>
						</thead>
						<tbody>
						  <tr>
						    <td class="tg-fzdr">9월 16일 오후 3:20</td>
						    <td class="tg-fzdr">참여 완료</td>
						  </tr>
						</tbody>
					</table>
					
					<h6 class="modal-body" align="left" style="font-size: 10pt; font-weight: bold;">상세이력</h6>
					
					<table class="tg3" style="width: 780px; margin-left: 10px;">
						<thead>
						  <tr>
						    <th class="tg-tjwp">학습 일시</th>
						    <th class="tg-tjwp">활동 유형</th>
						  </tr>
						</thead>
						<tbody>
						  <tr>
						    <td class="tg-fzdr">9월 16일 오후 3:20</td>
						    <td class="tg-fzdr">참여 완료</td>
						  </tr>
						</tbody>
					</table>
					
				<!-- Modal footer -->
                <div class="modal-footer">
			      
			    </div>
				
					

            </div>   
        </div>
    </div>
    </c:forEach>
	
</div>
</div>	