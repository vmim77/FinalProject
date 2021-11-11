<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
%>    


<!DOCTYPE html>
<html lang="en">

<head>
<title>마이페이지</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href="http://lms.atosoft.kr/worknet/assets/plugins/jquery-ui/themes/base/minified/jquery-ui.min.css" rel="stylesheet" />
<link href="http://lms.atosoft.kr/worknet/assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script src='https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.2.61/jspdf.min.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.js"> </script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://cdn.ckeditor.com/4.16.0/basic/ckeditor.js"></script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>


<script type="text/javascript">


$(document).ready(function(){
	
	$("input#update").click(function(){
		console.log($("input#phone").val());
		
		$.ajax({
            url:"<%= request.getContextPath()%>/myedit.univ",
            type:"GET",
            data:{"hakbun":$("input#hakbun").val(),
            	  "phone":$("input#phone").val(),
            	  "email":$("input#email").val(),
            	  "address":$("input#address").val()},
            dataType:"JSON",
            success:function(json){
               
              if(json.n == 1 ){
            	  alert("성공");
              }
                    
            },
            error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
             }
            
         });//end of $.ajax({--------------------------------------------------------
		
		
	}); //end of $("button#update").click(function(){
	
	
	
});// end of $(document).ready(function(){




$(function(){
    $("#popbutton").click(function(){
        $('div.modal').modal();
    })
})







</script>

<style>
body {
/*    border: solid 1px gray; */
      margin: 0;
      padding: 0; 
      font-family: Arial, "MS Trebuchet", sans-serif;
      word-break: break-all; /* 공백없이 영어로만 되어질 경우 해당구역을 빠져나가므로 이것을 막기위해서 사용한다. */
   }
	
	div#container {
		
		width:80%;
		margin:0 auto;
	}
	
	form {
	 	margin-top: 50px;
	}
	
	legend	{
		font-size: 20pt;
	}
	
	ul {
		list-style-type: none;
		padding:0;
	}
	
	label.title {
		display: inline-block;
		width:100px;
		color: navy;
		font-weight: bold;
	}
	
	ul > li { /* ul 자식 li  */
		line-height: 30px; /* 위아래 간격 조정  */
	}
	
	input.myinput {
		height: 25px;
	}
	
	select {
		width: 200px;
	}
	
	select.myselect {
		height: 20px;
		width:200px;
	}
	
	input[type=submit] , input[type=reset] {
		width: 80px;
		height: 40px;
		background-color: #000;
		color: #fff;
		font-size: 16pt;
		margin: 20px 0 0 40px;
		border:none;
	}




</style>




</head>
<body class="gray-bg">

      <ul class="nav navbar-nav navbar-right">
         <li><a href="<%= ctxPath%>/MemberLogin.univ" >로그아웃</a></li>
      </ul>
<div class="text-center">
                     <table class="table">
               	<thead>
                        <tr>
                          <td width="210" rowspan="3" align="center">
					            <img src="<%= ctxPath%>/resources/images/gill.png" style="width: 80%; margin: auto;"/>
                          </td>
                          <td>성명</td>
                          <td>${sessionScope.loginuser.name}</td>  
                        </tr>
                        <tr>
                           <td>학번</td>
                           <td>${sessionScope.loginuser.hakbun}</td>  
                        </tr>
                        <tr>
                          <td>연락처</td>
                          <td>${sessionScope.loginuser.phone}</td>             
                        </tr>
                        <tr>
                        <td rowspan="2" ><a type="button" href="<%= ctxPath %>/EditPhoto.univ" class="btn btn-primary" class="btn btn-gray" style="border: solid 1px gray; margin-top: 30%">사진변경</a></td>
                          <td>이메일</td>
                          <td>${sessionScope.loginuser.email}</td>             
                        </tr>
                        <tr>
                          <td>주소</td>
                          <td>${sessionScope.loginuser.address}</td>             
                        </tr>
                       </tbody>
                     </table>

                      <div class="">
                        <div class="col-md-12" style="width:100%;text-align:center">
                           <button class="btn btn-primary" data-target="#layerpop" data-toggle="modal">개인정보수정</button>
                           <button class="btn btn-primary" data-target="#schedule" data-toggle="modal">시간표</button>
                           <button class="btn btn-danger" data-target="#plan" data-toggle="modal">학습안내서/교수계획서</button>
                           <a type="button" onclick="" class="btn btn-danger">성적표</a>
                           <a type="button" onclick="" class="btn btn-success">설문관리</a>
                           <a type="button" onclick="" class="btn btn-success">강의평가</a>
                           <a type="button" onclick="" class="btn btn-warning">1 : 1 문의</a>
                           
                        </div>
                     </div>
                  </div>
<!--  개인정보 수정 -->                 
<div class="modal fade" id="layerpop" >
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- header -->
      <div class="modal-header">
        <!-- 닫기(x) 버튼 -->
        <button type="button" class="close" data-dismiss="modal">×</button>
        <!-- header title -->
        <h4 class="modal-title">개인 정보 수정</h4>
      </div>
      <!-- body -->
      <div class="modal-body">
            	<ul style="text-align: center; margin-top: 10%;">
				<li>
					<label class=title for="name">성명</label>
					<input type="text"  id="name" value="${sessionScope.loginuser.name}" size="40" class="requiredInfo" readonly/> 
				</li>
		
				<li>
					<label class=title for="hakbun">학번</label>
					<input type="text" id="hakbun" value="${sessionScope.loginuser.hakbun}" size="40" class="requiredInfo" readonly /> 
				</li> 
			
				<li>
					<label class=title for="phone">연락처</label>
					<input type="text"  id="phone" value="${sessionScope.loginuser.phone}" size="40" class="requiredInfo" required/> 
				</li>
				
				<li>
					<label class=title for="email">이메일 주소</label>
					<input type="text"  id="email" value="${sessionScope.loginuser.email}" size="40" class="requiredInfo" required/> 
				</li>
				
				<li>
					<label class=title for="address">주소</label><!-- 이메일은 타입 꼭 이메일로 -->
					<input type="text"  id="address" value="${sessionScope.loginuser.address}" size="40" class="requiredInfo" required/> 
				</li>
				
			
				<li>
					<input type="submit" id="update" value="확인" onclick="goUpdate()"/>
				</li>
			</ul>
      </div>
    </div>
  </div>
</div>


<!--  시간표 -->                 
<div class="modal fade" id="schedule" >
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- header -->
      <div class="modal-header">
        <!-- 닫기(x) 버튼 -->
        <button type="button" class="close" data-dismiss="modal">×</button>
        <!-- header title -->
        <h4 class="modal-title">시간표</h4>
      </div>
      <!-- body -->
      <div class="modal-body">
     <table cellspacing="5" align="center" border="1" bordercolor="#b3e6ff" width="450" height="600">
		<caption>
		<tr align="center"> <td width="50"></td>
		 <td width="100" bgcolor="#ffe6e6">월</td>
		 <td width="100" bgcolor="#ffe0cc">화</td>
		 <td width="100" bgcolor="#ffffcc">수</td> 
		<td width="100" bgcolor="#e6ffb3">목</td> 
		<td width="100" bgcolor="#b3e6ff">금</td>
		 </tr> <tr align="center"> <td bgcolor="#ffe6e6">1</td>
		 <td></td> 
		<td bgcolor="#ff4d4d">실전무술<br>김민경</td> 
		<td></td> 
		<td></td> 
		<td></td>
		 </tr> <tr align="center"> <td bgcolor="#ffe6e6">2</td>
		 <td></td>
		 <td bgcolor="#ffe0cc">보컬의기초<br>장현걸</td> 
		<td></td>
		 <td></td> 
		<td></td> 
		</tr> <tr align="center"> <td bgcolor="#ffe6e6">3</td> 
		<td bgcolor="#ffe6e6">소녀미용학개론<br>이재성</td>
		<td bgcolor="#ffe6e6">소녀미용학개론<br>이재성</td>
		<td></td> 
		<td></td> <td bgcolor="#e6ffb3">다이어트비법<br>금길영</td>
		</tr> <tr align="center"> <td bgcolor="#ffe6e6">4</td> 
		<td bgcolor="#ffe6e6">소녀미용학개론<br>이재성</td>
		 <td></td>
		 <td></td>
		 <td bgcolor="#ff4d4d">실전무술<br>김민경</td> 
		 <td bgcolor="#ffe0cc">보컬의기초<br>장현걸</td> 
		 </tr> <tr align="center"> <td bgcolor="#ffe6e6">5</td>
		 <td bgcolor="#ffe0cc">보컬의기초<br>장현걸</td> 
		 <td></td>
		 <td></td>
		 <td></td>
		 <td bgcolor="#ffe0cc">보컬의기초<br>장현걸</td> 
		 </tr> <tr align="center"> <td bgcolor="#ffe6e6">6</td>
		 <td></td> <td bgcolor="#e6ffb3">다이어트비법<br>금길영</td>
		 <td></td> <td bgcolor="#e6ffb3">다이어트비법<br>금길영</td>
		 <td bgcolor="#ff4d4d">실전무술<br>김민경</td> 
		 </tr><tr align="center"> <td bgcolor="#ffe6e6">7</td> 
		 <td></td> <td bgcolor="#e6ffb3">다이어트비법<br>금길영</td>
		 <td bgcolor="#ff4d4d">실전무술<br>김민경</td>  
		 <td bgcolor="#ffe6e6">소녀미용학개론<br>이재성</td>
		 <td></td> 
		 </tr><tr align="center"><td bgcolor="#ffe6e6">8</td> 
		 <td></td>
		 <td></td> 
		 <td></td> 
		 <td bgcolor="#ffe6e6">소녀미용학개론<br>이재성</td> 
		 <td></td> 
		</table> 
      </div>
    </div>
  </div>
</div>
        
        
   <!--  학습안내서/교수계획서 -->                 
<div class="modal fade" id="plan" >
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- header -->
      <div class="modal-header">
        <!-- 닫기(x) 버튼 -->
        <button type="button" class="close" data-dismiss="modal">×</button>
        <!-- header title -->
        <h4 class="modal-title">학습안내서/교수계획서 </h4>
      </div>
      <!-- body -->
      <div class="modal-body">
    <div class="panel panel-inverse">
<div class="panel-heading">
	<div class="panel-heading-btn">
        <div class="panel-heading-btn"> <a href="javascript:;" onclick="hidePageModal()" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove" data-original-title="" title=""><i class="fa fa-times"></i></a> </div>
    </div>
    <h4 class="panel-title">교수계획서 및 학습안내서</h4>
</div>
<div class="panel-body">
	<div class="row"> 
		<table class="table table-bordered">
			<colgroup>
                <col width="40%">
				<col width="60%">
			</colgroup>
			<tbody>
				<tr>
					<td colspan="2" style="text-align:center !important;font-weight:bold">AMY UNIVERCITY</td>
				</tr>
				<tr>
					<th>교수계획서</th><td align="center" style="text-align:center !important;"></td>
				</tr>
				<tr>
					<th>학습안내서</th><td align="center" style="text-align:center !important;"></td>
				</tr>
				<tr>
					<th>학사규정</th><td align="center" style="text-align:center !important;"></td>
				</tr>
				<tr>
					<th>기타</th><td align="center" style="text-align:center !important;"></td>
				</tr>
			</tbody>
		</table>	
	</div>
    <div class="popbtmbtn_section">
		<div class="col-md-12" style="width:100%;text-align:center">
              <a type="button" href="<%=ctxPath %>/Myinfo.univ" class="btn btn-default">취 소</a>
		</div>
      		</div>
 		</div>
		</div>
      </div>
    </div>
  </div>
</div>
        




</body>
</html>
