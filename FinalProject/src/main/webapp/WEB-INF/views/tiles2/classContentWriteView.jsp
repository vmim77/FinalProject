<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath();%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("ul#sideMenuList > li:nth-child(7)").addClass("hoverdEffect");
		
		$("ul#sideMenuList").hover(function(){
			$("ul#sideMenuList > li:nth-child(7)").removeClass("hoverdEffect");
		}, function(){
			$("ul#sideMenuList > li:nth-child(7)").addClass("hoverdEffect");
		});
		
		var code = sessionStorage.getItem('code');
	    var week = sessionStorage.getItem('week');
	    var lesson = sessionStorage.getItem('lesson');
	    var lessonseq = sessionStorage.getItem('lessonseq');
	    console.log(code);
	    console.log(week);
	    console.log(lesson);
	    console.log(lessonseq);

		<%-- === #167. 스마트 에디터 구현 시작 === --%>
	       //전역변수
	       var obj = [];
	       
	       //스마트에디터 프레임생성
	       nhn.husky.EZCreator.createInIFrame({
	           oAppRef: obj,
	           elPlaceHolder: "content",
	           sSkinURI: "<%= request.getContextPath() %>/resources/smarteditor/SmartEditor2Skin.html",
	           htParams : {
	               // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	               bUseToolbar : true,            
	               // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	               bUseVerticalResizer : true,    
	               // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	               bUseModeChanger : true,
	           }
	       });
	       <%-- === 스마트 에디터 구현 끝 === --%>
		
	      
		// 쓰기 버튼
		$("button#btnWrite").click(function(){
			
			
			 <%-- === 스마트 에디터 구현 시작 === --%>
	          //id가 content인 textarea에 에디터에서 대입
	           obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	         <%-- === 스마트 에디터 구현 끝 === --%>
			
			//글제목 유효성 검사
			var subjectVal = $("input#subject").val().trim();
			if(subjectVal == ""){
				alert("글제목을 입력하세요!!");
				return;
			}
			
			//글내용 유효성 검사(스마트에디터 사용 안할시)
		/* 	
			var contentVal = $("textarea#content").val().trim();
			if(contentVal == ""){
				alert("글내용을 입력하세요!!");
				return;
			}
		*/
		
		
		<%-- === 스마트에디터 구현 시작 === --%>
     //스마트에디터 사용시 무의미하게 생기는 p태그 제거
      var contentval = $("textarea#content").val();
          
       // === 확인용 ===
       // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
       // "<p>&nbsp;</p>" 이라고 나온다.
       
       // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
       // 글내용 유효성 검사 
       if(contentval == "" || contentval == "<p>&nbsp;</p>") {
          alert("글내용을 입력하세요!!");
          return;
       }
       
       // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
       contentval = $("textarea#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
   /*    
               대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
       ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
                    그리고 뒤의 gi는 다음을 의미합니다.

          g : 전체 모든 문자열을 변경 global
          i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
   */    
       contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
       contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
       contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
   
       $("textarea#content").val(contentval);
    
       // alert(contentval);
   <%-- === 스마트에디터 구현 끝 === --%>
   
   

			//폼(form)을 전송(submit)
			var frm = document.classContentWriteFrm;
			frm.keycode.value = code;
			frm.keyweek.value = week;
			frm.keylesson.value = lesson;
			frm.keylessonseq.value = lessonseq;
			frm.method = "POST";
			frm.action = "<%=ctxPath%>/classContentWriteEnd.univ";
			frm.submit(); 
			
		});
	
		
	});// end of $(document).ready(function()----------------------------------

</script>
<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left;"><span style="color: #0099ff; text-decoration: underline;">강의콘텐츠</span></h3>
<hr style="clear: both;">
<div style="display:flex;">
<div style="margin:auto; margin-top:200px; padding-left:3px;">

<h2 style="margin-bottom: 30px;"> 게시물 작성</h2>

<form name="key">
	
</form>

<!-- <form name="addFrm"> -->
<!-- #149. 파일 첨부하기 
     먼저 위의 <form name="addFrm"> 을 주석처리 한 이후에 아래와 같이 해야 한다.
     enctype="multipart/form-data" 를 해주어야만 파일첨부가 되어진다.-->
<form name="classContentWriteFrm" enctype="multipart/form-data">

		<table style="width:1024px;" class="table table-borderd">
			<tr>
				<th style="width:15%; background-color:#DDDDDD">성명</th>
				<td>
					<input type="text" name="name" value="${sessionScope.loginuser.name}" readonly/>					
					<input type="hidden" name="fk_hakbun" value="${sessionScope.loginuser.hakbun}"/>
					<input type="hidden" name="fk_lessonSeq" value="${requestScope.lessonseq}"/>
					<input type="hidden" name="fk_code" value="${requestScope.code}"/>
				</td>
			</tr>
			<tr>
				<th style="width:15%; background-color:#DDDDDD">제목</th>
				<td>									
					<input type="text" name="subject"  id="subject" size="100"/>									
				</td>
			</tr>
			<tr>
				<th style="width:15%; background-color:#DDDDDD; vertical-align:middle;">내용</th>
				<td>					
					<textarea rows="11" cols="102" name="content" id="content"></textarea>
				</td>
			</tr>
			
			<%-- ===#150. 파일첨부 타입 추가하기 --%>
			<tr>
				<th style="width:15%; background-color:#DDDDDD">파일첨부</th>
				<td>					
					<input type="file" name="attach"   />
				</td>
			</tr>			
		</table>
		
		<div style="margin:20px;">
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite" >글쓰기</button>
			<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
		</div>
		
		
		<input type="hidden" id = "keycode" name="keycode" value=""/>
		<input type="hidden" id = "keyweek" name="keyweek" value=""/>
		<input type="hidden" id = "keylesson" name="keylesson" value=""/>
		<input type="hidden" id = "keylessonseq" name="keylessonseq" value=""/>
</form>
		
		
		
</div>
</div>
		