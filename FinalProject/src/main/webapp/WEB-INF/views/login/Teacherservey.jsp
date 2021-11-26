<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

  <!-- Font Awesome 5 Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  
  <!-- 직접 만든 CSS 1 -->
  <link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/style2.css" />
  
  <!-- Optional JavaScript -->
  <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
  <script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 
  <script type="text/javascript" src="<%= ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> 
  
  <%--  ===== 스피너를 사용하기 위해  jquery-ui 사용하기 ===== --%>
  <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.11.4.custom/jquery-ui.css" />
  <script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.11.4.custom/jquery-ui.js"></script>

  <%-- *** ajax로 파일을 업로드할때 가장 널리 사용하는 방법 ==> ajaxForm *** --%>
  <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery.form.min.js"></script>
  
<style type="text/css">

#contents {
   /*  position: relative; */
    margin: auto;
    min-height: 1100px;
}
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:0.5px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:0.5px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-0pky{border-color:inherit;text-align:center;vertical-align:top}
.tg .tg-d1nvv{background-color:#ebebeb;border-color:#c0c0c0;font-weight:bold;text-align:center;vertical-align:middle}
.tg .tg-d1nv{background-color:#ebebeb;border-color:#c0c0c0;font-weight:bold;text-align:center;vertical-align:middle;width: 80px;}
.tg .tg-ve35{border-color:#c0c0c0;text-align:left;vertical-align:middle}
.tg .tg-m594{background-color:#fbe4e3;border-color:#c0c0c0;font-size:13.5px;text-align:left;vertical-align:top}
.tg .tg-fzdr{border-color:#c0c0c0;text-align:center;vertical-align:top}

button {
	width: 60px;
	height: 30px;
	float: right;
}
textarea.app {
	width:970px;
	height: 150px;
	resize: none;
}
 

</style>


<script type="text/javascript">

$(document).ready(function(){
    
		var resultArr = [];
		
		var result = "";
		var cnt = 0;
		
		$("button#btnOK").click(function(){
			
			for(var i=1; i<=12; i++){
				
				$("input:radio[name = answer"+i+"]").each(function(){
					
					var bool = $(this).is(":checked"); // 체크박스의 체크유무 검사
					
					if(bool == true){
						
						result += $(this).attr("id") + ",";
						cnt++;
					}
					
				});
				
				
				
			}
			
			if(cnt != 12){
				alert("다 체크하세요");
				console.log($("input#serveyCode").val());
				cnt = 0;
			}
			else{
				
				$.ajax({
		            url:"<%= request.getContextPath()%>/Teacherservey2.univ",
		            type:"POST",
		            data:{"result":result,
		    			"serveyCode":$("input#serveyCode").val()},
		            dataType:"JSON",
		            success:function(json){
		               
		              if(json.m == "1"){ // json.m으로 변경
		            	  alert("제출이 완료되었습니다");
		            	  location.href="<%= ctxPath%>/Myinfo.univ";
		              }
		              else {
		            	  alert("제출이 실패하였습니다.");
		            	  location.reload();
		              }
		                    
		            },
		            error: function(request, status, error){
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		             }
		            
		         });//end of $.ajax({--------------------------------------------------------
			}
		
		});// end of $("button#btnOK").click(function(){}----------------------------------
		
	
		
	
		
		    
		    
	
			
});
	

		
   



</script>



<div style="display: flex;">
<div  id="contents" style="margin: auto;">
		<div class="titleArea" style="margin-top: 80px;">
			<h2 style="font-size: 28pt; font-weight: bold; text-align: center;">2021학년도 2학기 쌍용대학교  강의평가</h2>
		</div>
		<br><br>
	<div class="typeWrite ">

<form name="evaluationFrm">

<input type="hidden" name="hakbun" value="${sessionScope.loginuser.hakbun}" />

<table class="tg" style="width: 970px;">
<thead>
  <tr>
    <th class="tg-m594" colspan="7"><br>이 강의평가 자료는 다음 학기의 강의에 참고하고자 하니,  본 교과목을 수강하면서 느낀 점을 객관적인 입장에서 솔직하고 성실하게 답변하여 주시기 바랍니다. <br><br>강의평가 결과에 대한 학생정보는 절대 비밀이 보장되며, 교수의 권한으로 학생의 정보를 알기는 불가능하오니 걱정하지 않으셔도 됩니다.<br><br></th>
  </tr>
</thead>
<tbody class="ser">
  <tr>
    <td class="tg-d1nvv" colspan="2">평가문항</td>
    <td class="tg-d1nv">매우그렇다</td>
    <td class="tg-d1nv">그렇다</td>
    <td class="tg-d1nv">보통</td>
    <td class="tg-d1nv">그렇지않다</td>
    <td class="tg-d1nv">매우그렇지않다</td>
  </tr>
  <tr>
  	<td class="tg-0pky">1</td>
    <td class="tg-ve35">나는 수업에 적극적으로 참여하였다.</td>
    <td class="tg-fzdr"><input type="radio" name="answer1" id="one" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer1" id="two" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer1" id="three" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer1" id="four" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer1" id="five" /></td>
  </tr>
  <tr>
  	<td class="tg-0pky">2</td>
    <td class="tg-ve35">${requestScope.subject} 강의는 수업 계획서대로 진행되었다.</td>
    <td class="tg-fzdr"><input type="radio" name="answer2" id="one" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer2" id="two" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer2" id="three" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer2" id="four" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer2" id="five" /></td>
  </tr>
  <tr>
  	<td class="tg-0pky">3</td>
    <td class="tg-ve35">수업 계획서에는 강의에 관한 정보가 체계적이고 명확하게 제시되었다.</td>
    <td class="tg-fzdr"><input type="radio" name="answer3" id="one" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer3" id="two" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer3" id="three" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer3" id="four" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer3" id="five" /></td>
  </tr>
  <tr>
  	<td class="tg-0pky">4</td>
    <td class="tg-ve35">${requestScope.name} 교수는 수업준비(교재,학습자료 등)을 철저히 하였다.</td>
    <td class="tg-fzdr"><input type="radio" name="answer4" id="one" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer4" id="two" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer4" id="three" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer4" id="four" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer4" id="five" /></td>
  </tr>
  <tr>
  	<td class="tg-0pky">5</td>
    <td class="tg-ve35">${requestScope.name} 교수는 결강을 하지 않았으며, 휴강시에는 보강을 철저히 하였다.</td>
    <td class="tg-fzdr"><input type="radio" name="answer5" id="one" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer5" id="two" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer5" id="three" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer5" id="four" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer5" id="five" /></td>
  </tr>
  <tr>
  	<td class="tg-0pky">6</td>
    <td class="tg-ve35">${requestScope.name} 교수는 학생들의 출결관리를 철저하게 하였다.</td>
    <td class="tg-fzdr"><input type="radio" name="answer6" id="one" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer6" id="two" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer6" id="three" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer6" id="four" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer6" id="five" /></td>
  </tr>
  <tr>
  	<td class="tg-0pky">7</td>
    <td class="tg-ve35">${requestScope.name} 교수는 교과내용을 학생들이 이해할 수 있도록 명확하게 설명하였다.</td>
    <td class="tg-fzdr"><input type="radio" name="answer7" id="one" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer7" id="two" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer7" id="three" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer7" id="four" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer7" id="five" /></td>
  </tr>
  <tr>
  	<td class="tg-0pky">8</td>
    <td class="tg-ve35">과제는 학습효과를 높이는데 도움이 되었다.</td>
    <td class="tg-fzdr"><input type="radio" name="answer8" id="one" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer8" id="two" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer8" id="three" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer8" id="four" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer8" id="five" /></td>
  </tr>
  <tr>
  	<td class="tg-0pky">9</td>
    <td class="tg-ve35">평가 기준 및 방식은 객관적이고 합리적으로 제시되었다.</td>
    <td class="tg-fzdr"><input type="radio" name="answer9" id="one" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer9" id="two" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer9" id="three" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer9" id="four" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer9" id="five" /></td>
  </tr>
  <tr>
  	<td class="tg-0pky">10</td>
    <td class="tg-ve35">${requestScope.subject} 강의에 대해 만족하여, 동기나 후배에게도 추천하고 싶다.</td>
    <td class="tg-fzdr"><input type="radio" name="answer10" id="one" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer10" id="two" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer10" id="three" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer10" id="four" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer10" id="five" /></td>
  </tr>
  <tr>
  	<td class="tg-0pky">11</td>
    <td class="tg-ve35">${requestScope.name} 교수는 학생들의 질문을 적절히 수용하였고 성실히 응답하였다.</td>
    <td class="tg-fzdr"><input type="radio" name="answer11" id="one" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer11" id="two" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer11" id="three" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer11" id="four" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer11" id="five" /></td>
  </tr>
  <tr>
  	<td class="tg-0pky">12</td>
    <td class="tg-ve35">${requestScope.name} 교수는 열성적으로 강의하였다.</td>
    <td class="tg-fzdr"><input type="radio" name="answer12" id="one" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer12" id="two" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer12" id="three" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer12" id="four" /></td>
    <td class="tg-fzdr"><input type="radio" name="answer12" id="five" /></td>
  </tr>
</tbody>
</table>

		<br><br>
		

		<button type="button" id="btnOK">제출</button>  
 		
 		<!-- <input type="button" id="btnOK" value="제출" />-->
 
		</form>
		
<input type="hidden" id="serveyCode" name="serveyCode" value="${requestScope.serveyCode}"/>
</div>
</div>
</div>