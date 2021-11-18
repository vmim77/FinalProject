<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath();%>

<style type="text/css">

    
    /* 부트스트랩 버튼 색 변경    */

 /* 
.btn-light {
    background-color: #ffffff;
    border-color: #778899;
    color:  #616161;}
.btn-light:hover,
.btn-light:focus {
    border-color: #ffcc80;
    background-color: #ffcc80;
    color: #FFF; }
    
   
   .btn-secondary {
    background-color: #ffb84d;
    border-color: #ffb84d;
    color: #FFF; 
    }    
    
	.btn-secondary:hover,
	.btn-secondary:focus {
    border-color: #ffcc80;
    background-color: #ffcc80;
    color: #FFF; }    */
    
    /* 부트스트랩 버튼 색 변경    */
  .btn-light {
    background-color: #ffffff;
    border-color: #ff9900;
    color:  #ff8c00;}
.btn-light:hover,
.btn-light:focus {
    border-color: #ffcc80;
    background-color: #ffcc80;
    color: #FFF; }
     
    
   .btn-secondary {
    background-color: #ffb84d;
    border-color: #ffb84d;
    color: #FFF; 
    }    
    
	.btn-secondary:hover,
	.btn-secondary:focus {
    border-color: #ffcc80;
    background-color: #ffcc80;
    color: #FFF; }  
    
   
    
</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		// 쓰기 버튼
		$("button#btnDelete").click(function(){
			
			//폼(form)을 전송(submit)
			var frm = document.DelFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/delEnd.univ";
			frm.submit();
		});
		
	}); // end of $(document).ready(function(){})----------------------------

</script>

<div style="display:flex;">
<div style="margin: auto; margin-left: 20%; padding-top: 9%;">

	<h2 style="font-size:23px; margin-bottom: 45px;"><i class="far fa-trash-alt"></i>&nbsp;&nbsp;게시글 삭제</h2>
	
	<form name="DelFrm">
		<span style="width:900px;">
			
				<span style="font-size: 15pt;"><i class="fas fa-key"></i>&nbsp;&nbsp;&nbsp;비밀번호</span >&nbsp;&nbsp;&nbsp;&nbsp;
				<span>				
					<input type="hidden" name="seq" value="${requestScope.freeboardvo.seq}"/>	
					<input type="password" name="pw"  id="pw"/>
				</span>
				
					
		</span>
		&nbsp;&nbsp;&nbsp;
		
		<span style="margin-left: 0px;">
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnDelete">글삭제</button>
			<button type="button" class="btn btn-light btn-sm" onclick="javascript:history.back()" >취소</button>
		</span>
	</form>

</div>
</div>