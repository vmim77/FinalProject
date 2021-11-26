<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
 
 
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 
 
<script type="text/javascript">

$(document).ready(function(){
	
	$("button#btnWrite").click(function(){
		var frm = document.addFrm;
		frm.action = "<%= request.getContextPath() %>/EditPhotoEnd.univ";
		frm.method = "POST";
		frm.submit();	
	});//end of $("button#btnWrite").click(function(){-------------
	
});
	
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



	<table>
			<tr>
				<th style="text-align: center;">미리보기</th>
				<br>
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
					<input type="file" name="attach" style="width: 200px" height="150px" /> 
					<input type="hidden" name="hakbun"/>
					<input type="hidden" name="checkNull" value="checkNull"/>
				</td>
			</tr>
			
		</table>
			
		<div style="margin: 20px;">
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">완료</button>
		</div>
	</form>