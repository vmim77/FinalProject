<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %> 

<style type="text/css">
	
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
	       
	       
	       
	       
		// 완료버튼
		$("button#btnUpdate").click(function(){
			
			 <%-- === 스마트 에디터 구현 시작 === --%>
	           //id가 content인 textarea에 에디터에서 대입
	            obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	           <%-- === 스마트 에디터 구현 끝 === --%>
	           
			
			// 글제목 유효성 검사
			var subjectVal = $("input#subject").val().trim();
			if(subjectVal == "") {
				alert("글제목을 입력하세요!!");
				return;
			}
			
			// 글내용 유효성 검사(스마트에디터 사용 안 할시)
		<%--		
			var contentVal = $("textarea#content").val().trim();
			if(contentVal == "") {
				alert("글내용을 입력하세요!!");
				return;
			}
			--%>
			
			<%-- === 스마트에디터 구현 시작 === --%>
	        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거
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
	        
	        
			// 폼(form)을 전송(submit)
			var frm = document.editFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/QnAEditEnd.univ";
			frm.submit();
		});
		
	});// end of $(document).ready(function(){})--------------------------

</script>
<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left;"><span style="color: #0099ff; text-decoration: underline;">문의게시판</span></h3>
<hr style="clear: both;">

<div class="container p-5 pl-3" >
	<div>
		<div style="margin:auto; margin-left: padding-top:70px;">
			<h2 style=" font-size:23px; font-weight: bold;"><i class="far fa-edit" style="margin-right: 8px; font-size: 29px;"></i>게시글 수정</h2>
			<hr style="width: 843px; margin-left: 0px;">
			<form name="editFrm">
				<input type="hidden" name="seq" value="${requestScope.QnAvo.seq}" />
				<input type="hidden" name="fk_hakbun" value="${requestScope.QnAvo.fk_hakbun}" readonly />
				<input type="hidden" name="name" value="${requestScope.QnAvo.name}" readonly />
				<input type="hidden" name="fk_code" id="fk_code" size="100" value="${requestScope.QnAvo.fk_code}" readonly/>
				
				<div>					
					<input style="margin-bottom: 13px;" type="text" name="subject"  id="subject" size="100" value="${requestScope.QnAvo.subject}" />
				</div>
				<div>					
					<textarea rows="11" cols="102" name="content" id="content">${requestScope.QnAvo.content}</textarea>
				</div>
				
				<br>
				<hr style="width: 843px; margin-left: 0px;">
				
				<div style="margin-left: 736px;">	
					<div>
						<button style="margin-left: 7px;"type="button" class="btn btn-secondary btn-sm" id="btnUpdate" >저장</button>	
						<button type="button" class="btn btn-light  btn-sm" onclick="javascript:history.back()">취소</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>



