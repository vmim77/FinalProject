<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    
<style type="text/css">
	
	form[name=lessonWriteFrm] {
		margin-top: 20px;
	}
	
	#lessonWriteTbl {
		width: 60%;
	}
	
	 td {
	 	padding: 5px;
	 }

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
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
	    
	    //쓰기버튼
	    $("#btnWrite").click(function(){
	        //id가 content인 textarea에 에디터에서 대입
	        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	        
            //스마트에디터 사용시 무의미하게 생기는 p태그 제거
	        var contentval = $("#content").val();
		        
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
	        contentval = $("#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
	        contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
	        contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환 
	        contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
	    
	        $("#content").val(contentval);
	        
	        //폼 submit
	        var lessonWriteFrm = document.lessonWriteFrm;
			lessonWriteFrm.action = "<%= request.getContextPath() %>/lessonWriteEnd.univ";
			lessonWriteFrm.method = "POST";
			lessonWriteFrm.submit();
	    });
		
	}); // end of ready()-------------------------------------------
	
</script>   
 
<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left;">${requestScope.subjectMap.subject} 강의실(${requestScope.subjectMap.name}) > 강의자료실 > <span style="color: #0099ff; text-decoration: underline;">게시글 작성하기</span></h3>
<hr style="clear: both;">


<form enctype="multipart/form-data" name="lessonWriteFrm">
	<table id="lessonWriteTbl" class="table table-bordered">
		<tr>
			<th>제목</th>
			<td><input type="text" name="subject" size="95" /></td>
		</tr>
		<tr>
			<th>글쓴이</th>
			<td><input type="text" name="name" value="${sessionScope.loginuser.name}" /></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea id="content" name="content" cols="100" rows="20" style="resize: none;"></textarea></td>
		</tr>
		<tr>
			<th>파일첨부</th>
			<td><input type="file" name="attach" /></td>
		</tr>
		<tr>
			<th>암호</th>
			<td><input type="password" name="pw" /></td>
		</tr>
	</table>
	
	<input type="hidden" name="fk_code" value="${sessionScope.code}" />
	<input type="hidden" name="fk_hakbun" value="${sessionScope.loginuser.hakbun}" />
	
	<button class="btn btn-dark btn-md" type="button" id="btnWrite">작성</button>
	<button class="btn btn-dark btn-md" type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/lesson.univ'">취소</button>
</form>
