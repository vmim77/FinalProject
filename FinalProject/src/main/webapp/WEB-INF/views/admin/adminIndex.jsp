<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	table#totalBar{
		width:2000px;
		height:700px;
		margin:30px 25px;
	}
	
	td#menuBar{
		width:300px;
		height:700px;
		vertical-align:top;
		border:solid 1px gray;
	}
	
	td#objectBar{
		width:1700px;
		height:700px;
	}
	
	#parentMenu{
		border-bottom:solid 1px gray;
		width:300px;
		height:30px;
		text-align:left;
		padding:10px 0px 0px 10px;
		background-color:#f5f5ef;
		font-weight:bold;
		font-size:13pt;
	}
	
	#kidMenu1, #kidMenu2, #kidMenu3, #kidMenu4, #kidMenu5, #kidMenu6{
		border-bottom:solid 1px gray;
		width:300px;
		height:40px;
		text-align:left;
		padding:15px 0px 0px 10px;
		background-color:white;
	}

	table#container{
		width:1200px;
		height:700px;
		margin-left:10px;
		border:solid 1px gray;
		background-color:#f5f5ef;
	}

	 td#menuName{
	 	height:40px;
	 	text-align:left;
	 	font-weight:bold;
	 	font-size:13pt;
	 	border-bottom:solid 1px gray;
	 	padding-left:15px;
	 }

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
	});
	
</script>

<div style="display:flex;">
	<table id="totalBar">
		<tr>
			<%-- 메뉴바 --%>
			<td id="menuBar">
				<div id="parentMenu">학생관리</div>
				<div id="kidMenu1">학생신상정보관리</div>
				<div id="kidMenu2">학생종합정보관리</div>
				
				<div id="parentMenu">교수관리</div>
				<div id="kidMenu3">교수신상정보관리</div>
				<div id="kidMenu4">교수종합정보관리</div>
				
				<div id="parentMenu">수업관리</div>
				<div id="kidMenu5">전공정보관리</div>
				<div id="kidMenu6">전공등록관리</div>
			</td>
			<%-- 기능 바 --%>
			<td id="objectBar">
				<table id="container">
					<tr>
						<td id="menuName">
							dd
						</td>
					</tr>
					<tr>
						<td id="menuObject">
							dd
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>	