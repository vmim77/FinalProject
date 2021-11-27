<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    
<style type="text/css">
	
	form[name=lessonWriteFrm] { margin-top: 50px; display: flex; }
	
	#lessonTblFlex { width: 60%; margin: auto; }
	
	#lessonWriteTbl { width: 100%; }
	
	#lessonWriteTbl th { background-color: #ffb84d; }
	
	#btnWrite::after { content: ''; display: block; clear: both;  }
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("ul#sideMenuList > li:nth-child(2)").addClass("hoverdEffect");
		
		$("ul#sideMenuList").hover(function(){
			$("ul#sideMenuList > li:nth-child(2)").removeClass("hoverdEffect");
		}, function(){
			$("ul#sideMenuList > li:nth-child(2)").addClass("hoverdEffect");
		});
		
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
	    	
	    	var subject = $("input[name=subject]").val().trim();
	    	
	    	if(subject == "") {
	    		swal("warning", "제목을 입력하세요!", "warning");
	    		return;
	    	}
	    	
			var pw = $("input[name=pw]").val().trim();
			
			if(pw == "") {
				swal("warning", "글암호를 입력하세요!", "warning");
				return;
			}
	    	
	        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	        
	        var contentval = $("#content").val();
		        
	        // 글내용 유효성 검사 
	        if(contentval == "" || contentval == "<p>&nbsp;</p>") {
	        	swal("warning", "글내용을 입력하세요!", "warning");
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
	<div id="lessonTblFlex">
		<table id="lessonWriteTbl" class="table table-bordered">
			<tr>
				<th>제목</th>
				<td><input type="text" name="subject" size="95" maxlength="100" /></td>
			</tr>
			<tr>
				<th>글쓴이</th>
				<td><input type="text" name="name" value="${sessionScope.loginuser.name}" readonly /></td>
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
				<th>글암호</th>
				<td><input type="password" name="pw" /></td>
			</tr>
		</table>
		
		<button class="btn btn-dark btn-md" type="button" style="background-color: #ffb84d; float: right;" onclick="javascript:location.href='<%= request.getContextPath()%>/homework.univ'">취소</button>
		<button class="btn btn-dark btn-md" type="button" style="background-color: #ffb84d; float: right; margin-right: 10px;" id="btnWrite">작성</button>
	</div>
	
	<input type="hidden" name="fk_code" value="${sessionScope.code}" />
	<input type="hidden" name="fk_hakbun" value="${sessionScope.loginuser.hakbun}" />
</form>
