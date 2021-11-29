<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
%>    

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

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
<script src="sweetalert2.min.js"></script>
<link rel="stylesheet" href="sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>


<script type="text/javascript">


$(document).ready(function(){
	
	$("input#update").click(function(){
		swal.fire('수정 완료 되었습니다.');
         
        var frm = document.info; 
        frm.action = "<%= ctxPath%>/Myinfo.univ";
		frm.method="GET";
		frm.submit();
         
	}); //end of $("button#update").click(function(){
	
		
	$("button#btnWrite").click(function(){
		var frm = document.addFrm;
		frm.action = "<%= request.getContextPath() %>/EditPhotoEnd.univ";
		frm.method = "POST";
		frm.submit();	
	});//end of $("button#btnWrite").click(function(){------------
		
	  $("button#seolmoon").click(function(){
	         
	         $.ajax({
	               url:"<%= request.getContextPath()%>/seolmoon.univ",
	               type:"GET",
	               dataType:"JSON",
	               success:function(json){
	               
	                  var tblhtml = "<colgroup>"
	                           +"<col>"
	                           +"<col style='width: 190px;'>"
	                           +"<col style='width: 230px;'>"
	                          +"</colgroup>"
	                          +"<thead>"
	                             +"<tr>"
	                                +"<th scope='col' class='tg-uofs'>설문</th>"
	                               +"<th class='tg-uofs'>설문일시</th>"
	                               +"<th class='tg-uofs'>비고</th>"
	                            +"</tr>"
	                          +"</thead>";


	         
	                     tblhtml += "<tbody>"
	                                 +"<td scope='col' class='tg-o40d'>"+json.serveyTopic+"</td>"
	                               +"<td class='tg-o40d'>"+json.serveyDate+"</td>"
	                               +"<td class='tg-o40d'>"+json.html+"</td>";
	                               +"</tbody>";   

	                   
	                   $("table#seol").html(tblhtml);

	               },
	               error: function(request, status, error){
	                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	                }
	               
	            });//end of $.ajax({--------------------------------------------------------
	         
	      });//end of $("button#seolmoon").click(function(){------------------
	         
	      $(document).on("click", "#goSeolmoon", function(){

	         
	         var frm = document.GoSeolmoon;
	         frm.method="POST";
	         frm.action = "<%= ctxPath%>/Seolmoon.univ";
	         frm.submit();
	      });
	      
	      $("button#evaluation").click(function(){
	          
	          $.ajax({
	                url:"<%= request.getContextPath()%>/servey.univ",
	                type:"GET",
	                dataType:"JSON",
	                success:function(json){
	                
	                   var tblhtml = "<colgroup>"
	                            +"<col>"
	                            +"<col style='width: 130px;'>"
	                            +"<col style='width: 130px;'>"
	                            +"<col style='width: 160px;'>"
	                           +"</colgroup>"
	                           +"<thead>"
	                              +"<tr>"
	                                 +"<th scope='col' class='tg-uofs'>설문</th>"
	                                +"<th class='tg-uofs'>교수</th>"
	                                +"<th class='tg-uofs'>설문일시</th>"
	                                +"<th class='tg-uofs'>비고</th>"
	                             +"</tr>"
	                           +"</thead>";
	                         

	                   $.each(json, function(index, item){
	          
	                      tblhtml += "<tbody>"
	                                  +"<td scope='col' class='tg-o40d'>"+item.serveyTopic+"</td>"
	                                +"<td class='tg-o40d'>"+item.name+"</td>"
	                                +"<td class='tg-o40d'>"+item.serveyDate+"</td>"
	                                +"<td class='tg-o40d'>"+item.html+"</td>";
	                                +"</tbody>";   
	                    });//end of $.each(json, function(index, item){--------------------------------------
	                    
	                    $("table#inthis").html(tblhtml);

	                },
	                error: function(request, status, error){
	                   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	                 }
	                
	             });//end of $.ajax({--------------------------------------------------------
	          
	       });//end of $("button#evaluation").click(function(){------------------   
	       
	       $(document).on("click", "#goServey", function(){

	          var serveyCode = $(this).val();
	          
	          $("input#serveyCode").val(serveyCode);
	          
	          var frm = document.GoServey;
	          frm.method="POST";
	          frm.action = "<%= ctxPath%>/Teacherservey.univ";
	          frm.submit();
	       });
	       

	      

	
	
});// end of $(document).ready(function(){




$(function(){
    $("#popbutton").click(function(){
        $('div.modal').modal();
    })
})

function readURL(input){
	
	if(input.files && input.files[0]){
		var reader = new FileReader();
		reader.onload = function(e){
			document.getElementById('preview').src = e.target.result;
		};
		reader.readAsDataURL(input.files[0]);
	} else {
		document.getElementById('preview').src = "";
	}
	
}
 







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

   .tg  {border-collapse:collapse;border-spacing:0;}
   .tg td{border-color:#c0c0c0;border-style:solid 0.5px;border-width:0.5px;font-family:Arial, sans-serif;font-size:14px;
     overflow:hidden;padding:10px 5px;word-break:normal;}
   .tg th{border-color:#c0c0c0;border-style:solid;border-width:0.5px;font-family:Arial, sans-serif;font-size:14px;
     font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
   .tg .tg-uofs{background-color:#efefef;border-color:##c0c0c0;color:#000000;font-weight:bold;text-align:center;vertical-align:top;}
   .tg .tg-o40d{border-color:#c0c0c0;text-align:center;vertical-align:top}

   a#evaluationbutton {
      margin: auto;
      padding-top: 3px;
      border: 1px solid #cccccc;
      text-align: center;
      width: 80px;
      height: 26px;
      background-color: #cccccc;
      color: #fff;
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
					            <img src="<%= ctxPath%>/resources/files/${sessionScope.loginuser.picture}" style="width: 80%; margin: auto;"/>
                          </td>
                          <td>성명</td>
                          <td>${requestScope.name}</td>  
                        </tr>
                        <tr>
                           <td>학번</td>
                           <td>${requestScope.hakbun}</td>  
                        </tr>
                        <tr>
                          <td>연락처</td>
                          <td>${requestScope.phone}</td>             
                        </tr>
                        <tr>
                        <td rowspan="2" ><a type="button" href="<%=ctxPath%>/EditPhoto.univ" class="btn btn-primary" data-target="#photo" data-toggle="modal" class="btn btn-gray" style="border: solid 1px gray; margin-top: 30% ">사진변경</a></td>
                          <td>이메일</td>
                          <td>${requestScope.email}</td>             
                        </tr>
                        <tr>
                        
                          <td>주소</td>
                          
                          <td>${requestScope.address}</td>
                                     
                        </tr>
                       </tbody>
                     </table>
                      <div class="">
                        <div class="col-md-12" style="width:100%;text-align:center;">
                           <button class="btn btn-primary" data-target="#layerpop" data-toggle="modal">개인정보수정</button>
                           <a type="button" href="<%=ctxPath %>/Schedule.univ" class="btn btn-danger">시간표</a>
                           <button class="btn btn-danger" data-target="#plan" data-toggle="modal">학습안내서/교수계획서</button>
                           <button id="seolmoon" class="btn btn-success" data-target="#servey" data-toggle="modal">설문관리</button>
                           <button id="evaluation" class="btn btn-success" data-target="#servey2" data-toggle="modal">강의평가</button>
                        </div>
                     </div>
                  </div>
                  
 <!--  사진추가 -->                 
<div class="modal fade" id="photo" >
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- header -->
      <div class="modal-header">
        <!-- 닫기(x) 버튼 -->
        <button type="button" class="close" data-dismiss="modal">×</button>
        <!-- header title -->
        <h4 class="modal-title">사진추가</h4>
      </div>
      <!-- body -->
      <div class="modal-body">
     	<table>
			<tr>
				<th>미리보기</th>
				<td>
					<img id="preview" style="width: 300px; height: 300px;" >			
					<br>
					<input type="file" onchange="readURL(this);" />
				</td>	
			</tr>
	</table>
    
	<form name="addFrm"  enctype=multipart/form-data>
		<table style="width: 1024px;"  class="table table-bordered">
			
			<tr>
				<th style="width: 15%; background-color: #DDDDDD">파일첨부</th>
				<td>
					<input type="file" name="attach" /> 
					<input type="hidden" name="hakbun"/>
					<input type="hidden" name="checkNull" value="checkNull"/>
				</td>
			</tr>
			
		</table>
			
		<div style="margin: 20px;">
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">완료</button>
		</div>
	</form>
      </div>
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
      <form id="info" name="info">
	 <input type="hidden" name="checknull" value="checknull" />
            	<ul style="text-align: center;  margin-top: 10%;">
				<li>
					<label class=title for="name">성명</label>
					<input type="text" name="name" id="name" value="${requestScope.name}" size="40" class="requiredInfo" readonly/> 
				</li>
		
				<li>
					<label class=title for="hakbun">학번</label>
					<input type="text" name="hakbun" id="hakbun" value="${requestScope.hakbun}" size="40" class="requiredInfo" readonly /> 
				</li> 
				
				<li>
					<label class=title for="pwd">비밀번호</label>
					<input type="password" name="pwd" id="pwd" value="${sessionScope.loginuser.pwd}" size="40" class="requiredInfo" required/> 
				</li>
				
				<li>
					<label class=title for="phone">연락처</label>
					<input type="text" name="phone" id="phone" value="${requestScope.phone}" size="40" class="requiredInfo" required/> 
				</li>
				
				<li>
					<label class=title for="email">이메일 주소</label>
					<input type="text" name="email" id="email" value="${requestScope.email}" size="40" class="requiredInfo" required/> 
				</li>
				
				<li>
					<label class=title for="address">주소</label><!-- 이메일은 타입 꼭 이메일로 -->
					<input type="text" name="address" id="address" value="${requestScope.address}" size="40" class="requiredInfo" required/> 
				</li>
				
				<li>
					<input type="submit" id="update" value="확인" onclick="goUpdate()"/>
				</li>
			</ul>
      </form>
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
        <h4 class="modal-title">학습안내서/학사규정</h4>
      </div>
      <!-- body -->
      <div class="modal-body">
    <div class="panel panel-inverse">
<div class="panel-heading">
	<div class="panel-heading-btn">
        <div class="panel-heading-btn"> <a href="javascript:;" onclick="hidePageModal()" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove" data-original-title="" title=""><i class="fa fa-times"></i></a> </div>
    </div>
    <h4 class="panel-title">교수계획서 및 학사규정</h4>
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
					<td colspan="2" style="text-align:center !important;font-weight:bold">쌍용대학교</td>
				</tr>
				<tr>
					<th>교수계획서</th>
					<td><a href="<%=ctxPath%>/teacherPlan.univ">교수계획서</a></td>
				</tr>
				<tr>
					<th>학사규정</th>
					<td><a href="<%=ctxPath%>/rule.univ">학사규정</a></td>
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

<!-- 설문관리 -->                 
    <div class="modal" id="servey">
        <div class="modal-dialog modal-lg">
            <div class="modal-content ">
        
                <!-- Modal Header -->
                <div class="modal-header" style="background-color: #cce6ff;">
                    <h2 class="modal-title" style="font-weight: bold; font-size: 18pt; margin: auto;">${sessionScope.loginuser.name} 님의 설문조사 현황</h2>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
            
                <!-- Modal body -->
               <br> 
                  <table id="seol" class="tg" style="width: 740px; margin: auto;">
                  
                  </table>
                  
               
            <!-- Modal footer -->
                <div class="modal-footer" style="margin: auto;">            
               <button type="button" class="btn btn-secondary" id="noDelete" data-dismiss="modal">취소</button>      
             </div>
             <br>   
            </div>   
        </div>
    </div>
    
<form name="GoSeolmoon">
   <input type="hidden" id="serveyCode" name="serveyCode" value="">
</form>


<!--  강의평가 -->                 
    <div class="modal" id="servey2">
        <div class="modal-dialog modal-lg">
            <div class="modal-content ">
            
              
                <!-- Modal Header -->
                <div class="modal-header" style="background-color: #ffe6e6;">
                    <h2 class="modal-title" style="font-weight: bold; font-size: 18pt; margin: auto;">2021년도 2학기 강의평가 현황</h2>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    
                </div>
            
                <!-- Modal body -->
               <br> 
                  <table id="inthis" class="tg" style="width: 740px; margin: auto;">
                  
               </table>
                  
               
            <!-- Modal footer -->
                <div class="modal-footer" style="margin: auto;">            
               <button type="button" class="btn btn-secondary" id="noDelete" data-dismiss="modal">취소</button>      
             </div>
             <br>   
            </div>   
        </div>
    </div>
        

<form name="GoServey">
   <input type="hidden" id="serveyCode" name="serveyCode" value="">
</form>

        


</body>
</html>
