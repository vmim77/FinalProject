<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style type="text/css">
	
	.move {
		cursor: pointer;
		color: navy;
	}
	
	.moveColor {
		color: #660029;
		font-weight: bold;
		background-color: #ffffe6;
	}
	
	td.comment {
		text-align: center;
	}
	
	#commentDisplay > tr:nth-child(1) > td:nth-child(1) {
		width: 5%;
	}
	
	#commentDisplay > tr:nth-child(1) > td:nth-child(3) {
		width: 9%;
	}
	
	#commentDisplay > tr:nth-child(1) > td:nth-child(4) {
		width: 19%;
	}
	
	.btn-light {
		background-color: #ffffff;
		border-color: #ff9900;
		color:  #ff8c00;
	}
	
	.btn-light:hover, .btn-light:focus {
		border-color: #ffcc80;
		background-color: #ffcc80;
		color: #FFF;
	}
	
	.btn-secondary {
		background-color: #ffb84d;
		border-color: #ffb84d;
		color: #FFF;
	}
	
	.btn-secondary:hover, .btn-secondary:focus {
		border-color: #ffcc80;
		background-color: #ffcc80;
		color: #FFF;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("ul#sideMenuList > li:nth-child(5)").addClass("hoverdEffect");
		
		$("ul#sideMenuList").hover(function(){
			$("ul#sideMenuList > li:nth-child(5)").removeClass("hoverdEffect");
		}, function(){
			$("ul#sideMenuList > li:nth-child(5)").addClass("hoverdEffect");
		});
		
		$("span.move").hover(function(){
			                   $(this).addClass("moveColor");
		                     }
		                   , function(){
		                	   $(this).removeClass("moveColor");
		                   });
		
	});// end of $(document).ready(function(){})------------------------------
	
	
</script>    

<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left;"><span style="color: #0099ff; text-decoration: underline;">???????????????</span></h3>
<hr style="clear: both;">

<%-- ????????? ??????????????? --%>
<div style="display: flex;">
	<div style="margin: auto; padding-left: 3%; padding-top: 4%;">
		<c:if test="${not empty requestScope.QnAvo}">
			<div class="card-body" style="display: flex; height: 13%;   background-color:#ffd699;  border: solid 1px #ffd699; padding: 1.4%  0% 1.4% 0% ; margin-left: 0%; ">
				
				<%-- === #141. ???????????? ?????? ?????????????????? ????????? ????????? ????????? autority ????????? ?????? 1??? ???????????? ?????????????????? ????????????. --%>
				<c:if test="${sessionScope.loginuser.authority == 0}">
					<button type="button" style="height: 36px; width: 170px; margin-left: 1%;"  class="btn btn-secondary" onclick="javascript:location.href='<%= request.getContextPath()%>/QnA.univ'">??????????????????</button>
					&nbsp;&nbsp;
					<button type="button" style="height: 36px; width: 250px;"  class="btn btn-secondary" onclick="javascript:location.href='<%= request.getContextPath()%>${requestScope.gobackURL}'">????????? ??????????????????</button>
				
					<button type="button"  onclick="javascript:location.href='<%= request.getContextPath()%>/QnAEdit.univ?fk_code=${sessionScope.code}&seq=${requestScope.QnAvo.seq}'" class="btn btn-light" style="height: 36px; width: 105px; margin-left: 46%; font-weight:bold; font-size: 10pt; padding: 7px 12px;"><i class="far fa-edit"></i>&nbsp;??????</button> <%-- fk_code????????? --%>
					&nbsp;&nbsp;
					<button type="button"  onclick="javascript:location.href='<%= request.getContextPath()%>/QnADel.univ?fk_code=${sessionScope.code}&seq=${requestScope.QnAvo.seq}'" class="btn btn-light" style="height: 36px; width: 105px; font-weight:bold; font-size: 10pt; padding: 7px 12px;"><i class="far fa-trash-alt"></i>&nbsp;??????</button>&nbsp;
				</c:if>
         		
				<c:if test="${sessionScope.loginuser.authority == 1}">
					<button type="button" style="height: 36px; width: 180px; margin-left: 1%;"  class="btn btn-secondary" onclick="javascript:location.href='<%= request.getContextPath()%>/QnA.univ'">??????????????????</button>
					&nbsp;&nbsp;
					<button type="button" style="height: 36px; width: 260px;"  class="btn btn-secondary" onclick="javascript:location.href='<%= request.getContextPath()%>${requestScope.gobackURL}'">????????? ??????????????????</button>
				
					<button type="button" class="btn btn-light" style="margin-left: 32%; height: 36px; width: 190px; " onclick="javascript:location.href='<%= request.getContextPath()%>/QnAAdd.univ?fk_seq=${QnAvo.seq}&groupno=${requestScope.QnAvo.groupno}&depthno=${requestScope.QnAvo.depthno}&subject=${QnAvo.subject}'"><i class="far fa-edit"></i>&nbsp;???????????????</button>
					&nbsp;&nbsp;
					<button type="button"  onclick="javascript:location.href='<%= request.getContextPath()%>/QnAEdit.univ?fk_code=${sessionScope.code}&seq=${requestScope.QnAvo.seq}'" class="btn btn-light" style="height: 36px; width: 105px; font-weight:bold; font-size: 10pt; padding: 7px 12px;"><i class="far fa-edit"></i>&nbsp;??????</button> <%-- fk_code????????? --%>
					&nbsp;&nbsp;
					<button type="button"  onclick="javascript:location.href='<%= request.getContextPath()%>/QnADel.univ?fk_code=${sessionScope.code}&seq=${requestScope.QnAvo.seq}'" class="btn btn-light" style="height: 36px; width: 105px; font-weight:bold; font-size: 10pt; padding: 7px 12px;"><i class="far fa-trash-alt"></i>&nbsp;??????</button>&nbsp;
				</c:if>
			</div>

			<%-- ???????????????  --%>
			<div class="pl-4">
				<br>
				<br>
				<div style="font-weight: bold; font-size: 20px; word-break: break-all;">${QnAvo.subject}</div>
				<br>
				<span>????????? :&ensp;${QnAvo.name} &ensp;|&ensp;????????? :&ensp;${QnAvo.regDate}&ensp;</span>
				<span style="margin-left: 480px;"> ?????????: ${QnAvo.readCount}</span>
				<br>
				<br>
				<div style="word-break: break-all;">${QnAvo.content}</div>
    		</div>
    		
			<c:set var="v_gobackURL" value='${ fn:replace(requestScope.gobackURL, "&", " ") }' />
			<br>
			<br>
			<hr>
			
			<c:if test="${empty requestScope.QnAvo.previousseq}">
				<button type="button"  onclick="javascript:location.href='QnAView.univ?seq=${requestScope.QnAvo.nextseq}&searchType=${requestScope.searchType}&searchWord=${requestScope.searchWord}&gobackURL=${v_gobackURL}'" class="btn btn-light float-right" style="font-weight:bold; font-size: 10pt; padding: 7px 12px; text-align: right; height: 36px;"> ??? ????????? </button>&nbsp;
			</c:if>
			
			<c:if test="${empty requestScope.QnAvo.nextseq}">
				<button type="button"  onclick="javascript:location.href='QnAView.univ?seq=${requestScope.QnAvo.previousseq}&searchType=${requestScope.searchType}&searchWord=${requestScope.searchWord}&gobackURL=${v_gobackURL}'" class="btn btn-light" style="font-weight:bold; font-size: 10pt; padding: 7px 12px; text-align: right; height: 36px;"> ??? ????????? </button>&nbsp;
			</c:if>
			
			<c:if test="${not empty requestScope.QnAvo.previousseq and not empty requestScope.QnAvo.nextseq }">
				<button type="button"  onclick="javascript:location.href='QnAView.univ?seq=${requestScope.QnAvo.previousseq}&searchType=${requestScope.searchType}&searchWord=${requestScope.searchWord}&gobackURL=${v_gobackURL}'" class="btn btn-light" style="font-weight:bold; font-size: 10pt; padding: 7px 12px; text-align: right; height: 36px;"> ??? ????????? </button>&nbsp;
				<button type="button"  onclick="javascript:location.href='QnAView.univ?seq=${requestScope.QnAvo.nextseq}&searchType=${requestScope.searchType}&searchWord=${requestScope.searchWord}&gobackURL=${v_gobackURL}'" class="btn btn-light float-right" style="font-weight:bold; font-size: 10pt; padding: 7px 12px; text-align: right; height: 36px;"> ??? ????????? </button>&nbsp;
			</c:if>
			<br>
			<br>
			<%-- ??????????????? ??? === --%>	
		</c:if>

		<c:if test="${empty requestScope.QnAvo}">
			<div style="padding: 100px 0; font-weight: bold; font-size: 16pt; color: red;">???????????? ????????????</div>
		</c:if>
	</div>
</div>




