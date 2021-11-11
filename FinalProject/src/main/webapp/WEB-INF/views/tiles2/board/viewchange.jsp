<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    
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
    background-color: #7e7f80;
    border-color: #7e7f80;
    color: #FFF; 
    }    
    
	.btn-secondary:hover,
	.btn-secondary:focus {
    border-color: #cccccc;
    background-color: #cccccc;
    color: #FFF; }   
    
</style>    

<div class="pt-4 pb-5">	
	  <div style="margin: 20px 20px 20px 70px; width: 80%;">
	    <div class="card-body" style="display: flex; height: 13%;   background-color:#f2f2f2;  border: solid 1px gray; padding: 15px 15px 15px 15px;  ">
	  		<button type="button" style="height: 36px; margin-left: 2%;"  class="btn btn-secondary" onclick="javascript:location.href='<%= request.getContextPath()%>/list.univ'">전체목록보기</button>
	  		&nbsp;&nbsp;
	  		<button type="button" style="height: 36px;"  class="btn btn-secondary" onclick="javascript:location.href='<%= request.getContextPath()%>${requestScope.gobackURL}'">검색된 결과목록보기</button>
	  		
	  		<button type="button"  onclick="javascript:location.href='<%= request.getContextPath()%>/edit.univ'" class="btn btn-light" style="height: 36px; margin-left: 50%;font-weight:bold; font-size: 10pt; padding: 7px 12px; text-align: right; "><i class="far fa-edit"></i>&nbsp;수정</button>
	  		&nbsp;&nbsp;
	  		<button type="button"  onclick="javascript:location.href='<%= request.getContextPath()%>/del.univ'" class="btn btn-light" style="height: 36px; font-weight:bold; font-size: 10pt; padding: 7px 12px;"><i class="far fa-trash-alt"></i>&nbsp;삭제</button>&nbsp;	
	   		
	  	</div>
	  	<div class="pl-4">
	  	 <br>
	  	 <br>
		  	<div style="font-weight: bold; font-size: 20px;">
		   		테스트
		   	</div>
		
		<br>
	 		<span style="">작성자 :&ensp;이루리 &ensp;|&ensp;작성일 :&ensp;2021-11-10&ensp;</span> 
	 		<span style="margin-left: 610px;"> 조회수: 0</span>
	   
	    <br>
	    <br>
		    <div>
		    	글내용입니다
		    </div>
		    
		</div>   
		<br>    
	    <br>
	    <hr>
	    
	    <button type="button"  onclick="javascript:location.href='<%= request.getContextPath()%>/edit.univ'" class="btn btn-light" style="font-weight:bold; font-size: 10pt; padding: 7px 12px; text-align: right; height: 36px;"> ‹ 이전글 </button>&nbsp;
	    <button type="button"  onclick="javascript:location.href='<%= request.getContextPath()%>/edit.univ'" class="btn btn-light float-right" style="font-weight:bold; font-size: 10pt; padding: 7px 12px; text-align: right; height: 36px;"> › 다음글 </button>&nbsp;
	  
	  <br>
	  <br>
	  <%-- === 댓글쓰기 폼  === --%>
	  <form name="addWriteFrm" id="addWriteFrm" style="margin-top: 20px;"> 
				
			 <div class="card-body" style="display: flex; height: 13%;   background-color:#f2f2f2;  border: solid 1px gray; padding: 15px 15px 15px 15px;  ">
			 		   
					      <input type="hidden" id="fk_hakbun" value="${sessionScope.loginuser.hakbun}" /> <%-- fk_userid => fk_hakbun --%>
					   	  <input type="hidden" id="name" value="${sessionScope.loginuser.name}" readonly />
					   	  <textarea id="commentContent" maxlength="400" cols="100" style="width: 850px; height: 40px;"></textarea>
					   	  <input type="hidden" id="parentSeq" value="${freeboardvo.seq}" readonly />
					   	  &ensp;
					   	  <button style="margin-top: 0px; height: 40px;" type="button" class="btn btn-secondary btn-sm mr-3" onclick="goAddWrite()">등록</button>
					   	  
			  </div>		  
			</form>
	  
	  <%-- === 댓글 내용 보여주기  === --%>
	  
	  </div>
	  
	  
	  
</div>
	
	
	
	
	</div>
