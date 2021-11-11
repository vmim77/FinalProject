<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%  String ctxPath = request.getContextPath();  %>

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css"
	href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU"
	crossorigin="anonymous">
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>




<style>

body { background-color: #f5a100;
	   background-image: url("<%= request.getContextPath()%>/resources/images/background.jpg");
	    }

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: "Noto Sans KR", sans-serif;
}

a {
	text-decoration: none;
	color: black;
}

li {
	list-style: none;
}

.wrap {
	width: 100%;
	height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	/* background: rgba(0, 0, 0, 0.1); */
}

.login {
	width: 30%;
	height: 600px;
	background: white;
	border-radius: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
}

h2 {
	color: tomato;
	font-size: 2em;
}

.login_id {
	margin-top: 20px;
	width: 80%;
}

.login_id input {
	width: 100%;
	height: 50px;
	border-radius: 30px;
	margin-top: 10px;
	padding: 0px 20px;
	border: 1px solid lightgray;
	outline: none;
}

.login_pw {
	margin-top: 20px;
	width: 80%;
}

.login_pw input {
	width: 100%;
	height: 50px;
	border-radius: 30px;
	margin-top: 10px;
	padding: 0px 20px;
	border: 1px solid lightgray;
	outline: none;
}

.login_etc {
	padding: 10px;
	width: 80%;
	font-size: 14px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-weight: bold;
}

.submit {
	margin-top: 50px;
	width: 80%;
}

.submit input {
	width: 100%;
	height: 50px;
	border: 0;
	outline: none;
	border-radius: 40px;
	background: linear-gradient(to left, rgb(255, 77, 46), rgb(255, 155, 47));
	color: white;
	font-size: 1.2em;
	letter-spacing: 2px;
}

table#loginTbl, table#snsloginTbl {
	width: 40%;
	border: solid 1px gray;
	border-collapse: collapse;
	margin-top: 20px;
}

table#loginTbl #th {
	background-color: silver;
	font-size: 14pt;
	text-align: center;
	height: 30px;
}

table#loginTbl td {
	border: solid 1px gray;
	line-height: 30px;
}
</style>

<script type="text/javascript">

$(document).ready(function(){
	
	 $("button#btnSubmit").click(function(){
			func_login();
	}); 
	
	$("input#pwd").keydown(function(event){
		if(event.keyCode == 13){ // 앤터를 했을 경우
			func_login();
		}
		
	});
	
})// end of $(document).ready(fucntion()-----------------------------------------

// Function Declaration
function func_login(){
	
	var hakbun = $("input#hakbun").val();
	var pwd = $("input#pwd").val();
	
	if( hakbun.trim() == ""){
		alert("학번을 입력하세요!!");
		$("input#hakbun").val(""); // 값비우기
		$("input#hakbun").focus();
		return; // 종료
		
	}
	
	if( pwd.trim() == ""){
		alert("비밀번호를 입력하세요!!");
		$("input#pwd").val(""); // 값비우기
		$("input#pwd").focus();
		return; // 종료
		
	}

	var frm = document.loginFrm;
	frm.action = "<%= ctxPath%>/login.univ";
	frm.method = "POST";
	frm.submit();
	
}// end of function func_login()

</script>

<%-- *** 로그인을 하기 위한 폼을 생성 *** --%>
<p class="h5" style="margin: auto">
	<marquee style="color: #fff;"> [공지사항] 이번 파이널프로젝트 1등은 2조입니다.</marquee>
</p>
<form name="loginFrm">
	<table id="loginTbl">
		<tbody>
			<div class="wrap">
				<div class="login">
					<h2 style="color: black;">대학행정정보시스템</h2>
					<div class="login_id">
						<h4>학번</h4>
						<input type="text" name="hakbun" id="hakbun" placeholder="학번"
							maxlength="7">
					</div>
					<div class="login_pw">
						<h4>비밀번호</h4>
						<input type="password" name="pwd" id="pwd" placeholder="비밀번호">
					</div>
					<div class="login_etc">
						<div class="checkbox"></div>
						<div style="display: flex; width: 100%;">
							<div class="forgot_pw" style="margin: auto; padding-top: 10px;">
								<button type="button" id="passwdfind" class="btn btn-light mx-2">비밀번호찾기</button>
								<button type="button" id="btnSubmit" class="btn btn-dark mx-2">로그인</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</tbody>
	</table>
</form>

