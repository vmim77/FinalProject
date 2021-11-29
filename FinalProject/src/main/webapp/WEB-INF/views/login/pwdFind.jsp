<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
%>  




<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="sweetalert2.min.js"></script>
<link rel="stylesheet" href="sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>


<style>



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
  background: rgba(0, 0, 0, 0.1);
}

.login {
  margin-left: 530px;
  width: 30%;
  height: 800px;
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


   table#loginTbl , table#snsloginTbl{
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
		
		$("button#btnFind").click(function(){
			
			$.ajax({
	            url:"<%= request.getContextPath()%>/pwdFindEnd.univ",
	            type:"GET",
	            data:{"hakbun":$("input#hakbun").val(),
	            	  "name":$("input#name").val()},
	            dataType:"JSON",
	            success:function(json){
	               
	              if(json.n == 1 ){
	            	  swal.fire('찾으시는 비밀번호는  ' + json.pwd + ' 입니다');
	            	  href.location = "<%= ctxPath%>/pwdFind.univ";
	              }
	              else {
	            	  swal.fire('학번과 이름을 정확히 입력해주세요.');
	              }
	                    
	            },
	            error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
	            
	         });//end of $.ajax({--------------------------------------------------------
        	 
        
         });
 		 
	});// end of $(document).ready(function(){})-----------------------------

</script>


<a href="<%= ctxPath %>/MemberLogin.univ" class="btn btn-dark">돌아가기</a>

<form name="pwdFindFrm">

       <table id="loginTbl">
         <tbody>
        <div class="login">
            <h2 style="color: black;">비밀번호찾기</h2>
            
            
            <div class="login_id">
                <input type="text" name="hakbun" id="hakbun" placeholder="학번" autocomplete="off" maxlength="7" required>
            </div>
            <div class="login_pw">
                <input type="text" name="name" id="name" placeholder="이름" autocomplete="off" required>
            </div>
            <div class="login_etc" id="div_btnFind">
            </div>
              <button type="button" id="btnFind" class="btn btn-dark">찾기</button>
        	</div>
     
         </tbody>
       </table>
       
     
      
  </form>
   


