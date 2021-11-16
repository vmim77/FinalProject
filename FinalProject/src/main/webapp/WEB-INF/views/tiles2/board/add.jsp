<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath();%>
<style type="text/css">

    
    /* 부트스트랩 버튼 색 변경    */

.btn-light {
    background-color: #ffffff;
    border-color: #778899;
    color:  #616161;}
.btn-light:hover,
.btn-light:focus {
    border-color: #cccccc;
    background-color: #cccccc;
    color: #FFF; }
    
    
   .btn-secondary {
    background-color: #778899;
    border-color: #778899;
    color: #FFF; 
    }    
    
	.btn-secondary:hover,
	.btn-secondary:focus {
    border-color: #cccccc;
    background-color: #cccccc;
    color: #FFF; }   
    
</style>
<script type="text/javascript">

	$(document).ready(function(){
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
		<%--  	
			var contentVal = $("textarea#content").val().trim();
			if(contentVal == ""){
				alert("글내용을 입력하세요!!");
				return;
			}
		--%>
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
      
          $("textarea#content").val(contentval); //p태그 다 제거한걸 넣어줌
       
          // alert(contentval);
      <%-- === 스마트에디터 구현 끝 === --%>
      
			//글암호 유효성 검사
			var pwVal = $("input#pw").val().trim();
			if(pwVal == ""){
				alert("글암호을 입력하세요!!");
				return;
			}
			
			//폼(form)을 전송(submit)
			var frm = document.addFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/addEnd.univ";
			frm.submit();
		});
		
	}); // end of $(document).ready(function(){})----------------------------

</script>

<div class="container p-5 pl-3" >

<div>
<div style="margin:auto; margin-left: padding-top:70px;">

	<h2 style=" font-size:23px; font-weight: bold;"><i class="far fa-edit" style="margin-right: 8px; font-size: 29px;"></i>게시글 작성</h2>
	<hr style="width: 843px; margin-left: 0px;">
	<form name="addFrm">
		
			
					<input type="hidden" name="fk_hakbun" value="${sessionScope.loginuser.hakbun}" readonly/>
					<input type="hidden" name="name" value="${sessionScope.loginuser.name}" readonly/>
					<input type="hidden" name="fk_code" id="fk_code" size="100" value="${sessionScope.code}" readonly/>
				
			
			
				
				<div>					
					<input style="margin-bottom: 13px;" type="text" name="subject"  id="subject" size="100"/>
				</div>
			
			
				<div>					
					<textarea rows="11" cols="102" name="content" id="content"></textarea>
				</div>
		
			<br>
		<div style="margin-left: 543px;">
			<div >
				<span style="margin-bottom: 10px;"><i class="fas fa-key" style="margin-right: 10px;"></i>비밀번호</span> 
				<span>					
					<input type="password" name="pw"  id="pw" />
				</span>
			</div>			
		</div>
		
		
			<br>
			<hr style="width: 843px; margin-left: 0px;">
			
		<div style="margin-left: 736px;">	
			<div>
				<button type="button" class="btn btn-light  btn-sm" onclick="javascript:history.back()">취소</button>
				<button style="margin-left: 7px;"type="button" class="btn btn-secondary btn-sm" id="btnWrite" >저장</button>	
			</div>
		</div>
		
	</form>

</div>
</div>

</div>