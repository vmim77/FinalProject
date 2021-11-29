<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath();%>

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
		
		
		$("ul#sideMenuList > li:nth-child(2)").addClass("hoverdEffect");
		
		$("ul#sideMenuList").hover(function(){
			$("ul#sideMenuList > li:nth-child(2)").removeClass("hoverdEffect");
		}, function(){
			$("ul#sideMenuList > li:nth-child(2)").addClass("hoverdEffect");
		});
		
		// 쓰기 버튼
		$("button#btnDelete").click(function(){
			
			//폼(form)을 전송(submit)
			var frm = document.DelFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/noitceDelEnd.univ";
			frm.submit();
		});
		
	}); // end of $(document).ready(function(){})----------------------------

</script>

<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left;"><span style="color: #0099ff; text-decoration: underline;">공지사항</span></h3>
<hr style="clear: both;">


<div style="display:flex;">
	<div style="margin: auto; margin-left: 20%; padding-top: 9%;">
		<h2 style="font-size:23px; margin-bottom: 45px;"><i class="far fa-trash-alt"></i>&nbsp;&nbsp;게시글 삭제</h2>
		<form name="DelFrm">
			<input type="hidden" name="seq" value="${requestScope.noticevo.seq}"/>
			<span style="width:900px;">
				<span style="font-size: 20px;">&nbsp;&nbsp;&nbsp;글제목 : <span style="font-size: 15px;">${requestScope.noticevo.subject}</span></span>&nbsp;&nbsp;&nbsp;&nbsp;			
			</span>
			&nbsp;&nbsp;&nbsp;
			<span style="margin-left: 100px;">
				<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnDelete">글삭제</button>
				<button type="button" class="btn btn-light btn-sm" onclick="javascript:history.back()" >취소</button>
			</span>
		</form>
	</div>
</div>



