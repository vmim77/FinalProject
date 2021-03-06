<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%  String ctxPath = request.getContextPath();  %>

<!-- Bootstrap CSS -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>





<style>

body { background-color: #ffb84d;
	   background-image: url("<%= request.getContextPath()%>/resources/images/background.jpg"); }

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
  font-size: 12px;
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


   table#loginTbl , table#snsloginTbl{
      width: 40%;
      border: solid 1px gray;
      border-collapse: collapse;
      margin-top: 20px;
      
   }
   
   table#loginTbl #th {
      background-color: silver;
      font-size: 12pt;
      text-align: center;
      height: 30px;
   }
   
   table#loginTbl td {
      border: solid 1px gray;
      line-height: 30px;
   }
   
   .swal2-title {
   
   font-size: 1.3em;
   }
</style>

<script type="text/javascript">

$(document).ready(function(){
	
	var hakbun = localStorage.getItem('hakbun');
    
  	if(hakbun != null) {
     $("input#hakbun").val(hakbun);
     $("input:checkbox[id=saveid]").prop("checked", true);
  	}
  	
	
	 $("button#btnSubmit").click(function(){
			func_login();
	}); 
	
	$("input#pwd").keydown(function(event){
		if(event.keyCode == 13){ // ????????? ?????? ??????
			func_login();
		}
		
	});
	
	$("button#passwdfind").click(function(){
 		goPasswdFind();
 		
 	});
	
	
})// end of $(document).ready(fucntion()-----------------------------------------

// Function Declaration
function func_login(){
	
	var hakbun = $("input#hakbun").val();
	var pwd = $("input#pwd").val();
	
	if( hakbun.trim() == ""){
		 swal.fire("????????? ???????????????!!");
		$("input#hakbun").val(""); // ????????????
		$("input#hakbun").focus();
		return; // ??????
		
	}
	
	if( pwd.trim() == ""){
		 swal.fire("??????????????? ???????????????!!");
		$("input#pwd").val(""); // ????????????
		$("input#pwd").focus();
		return; // ??????
	}
	
	  if( $("input:checkbox[id=saveid]").prop("checked") ) {
	    	 
	    	  localStorage.setItem('hakbun',$("input#hakbun").val());
	    	 
	      }
	      else {
	    	 
	    	  localStorage.removeItem('saveid');
	      }
	      
	
 

	var frm = document.loginFrm;
	frm.action = "<%= ctxPath%>/dashboard.univ";
	frm.method = "POST";
	frm.submit();
	
}// end of function func_login()

//====================================================================================================================
// ???????????? ??????
function goPasswdFind(){
 	location.href="<%= request.getContextPath()%>/pwdFind.univ";

}
//====================================================================================================================

</script>

 <%-- *** ???????????? ?????? ?????? ?????? ?????? *** --%>
 
<p class="h5" style="margin: auto">
   <marquee style="color: #fff;"> [????????????] ??????????????? ???????????? ???????????? ????????? ???????????????.</marquee>
</p>
       <form name="loginFrm">
       <table id="loginTbl">
         <tbody>
           <div class="wrap">
        <div class="login">
            <h2 style="color: black;">???????????????????????????</h2>
            <div class="login_id">
                <h4>??????</h4>
                <input type="text" name="hakbun" id="hakbun" placeholder="??????" maxlength="7">
            </div>
            <div class="login_pw">
                <h4>????????????</h4>
                <input type="password" name="pwd" id="pwd" placeholder="????????????">
            </div>
            <div class="login_etc">
                <div class="checkbox">
                <input type="checkbox" name="saveid" id="saveid"> <label for="saveid">???????????????</label>
                </div>
                <div class="forgot_pw" style="margin-right: 5px;">
	               <button type="button" id="btnSubmit" class="btn btn-dark">?????????</button>
	               <button type="button" id="passwdfind" class="btn btn-light">??????????????????</button>
           </div>
          </div>
		</div>
      </tbody>
    </table>
 </form>

