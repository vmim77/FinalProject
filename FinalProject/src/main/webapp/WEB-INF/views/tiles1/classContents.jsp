<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	.btn btn-link{
		border: none;
   		 outline:none;  		 
	}
	.numbtn_click{
		background-color:blue;
		color:blue;
	}

</style>

<script type="text/javascript">

   $(document).ready(function(){
      
	  /*  $("button.numbtn").click(function(){
		   $(this).addClass("numbtn_click");		   
	   }); */
	
   });

</script>


<c:forEach var="map" items="${requestScope.classList}" varStatus="status"> 
${map.subject}
</c:forEach>


<div class="container" style="margin-top: 200px; color:black; ">

	<div  style="margin-bottom:30px;">
		<button type="button" class="numbtn btn btn-sm" style="border:0.5px solid #DDD; background-color:white; width:30px;  border-radius: 1px;">1</button>
		<button type="button" class="numbtn btn btn-sm " style="border:0.5px solid #DDD; background-color:white; width:30px; border-radius: 1px;">2</button>
		<button type="button" class="numbtn btn btn-sm " style="border:0.5px solid #DDD; background-color:white; width:30px; border-radius: 1px;">3</button>
		<button type="button" class="numbtn btn btn-sm "style="border:0.5px solid #DDD; background-color:white; width:30px; border-radius: 1px;">4</button>
		<button type="button" class="numbtn btn btn-sm " style="border:0.5px solid #DDD; background-color:white; width:30px; border-radius: 1px;">5</button>
	</div>
	<hr>
	<br>
	<div class="dropdown" align=right style="margin-bottom: 10px;">
		  <button style="background-color:white; color:black;" class="btn btn-secondary dropdown-toggle btn-sm" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false">
		    모든주차펴기
		  </button>
		  <div class="dropdown-menu btn-sm" aria-labelledby="dropdownMenuButton">  
		    <a class="dropdown-item btn-sm" href="#">1주차</a>
		    <a class="dropdown-item  btn-sm" href="#">2주차</a>
		    <a class="dropdown-item btn-sm" href="#">3주차</a>
		  </div>
		</div>
		
		
		
		
		<div class="accordion" id="accordion1" style="height:500px;">
		   <div class="card">
		      <div class="card-header" id="heading1" style="height:60px;">
		        
		          <button class="btn btn-link btn-sm" type="button" data-toggle="collapse" data-target="#collapse1" aria-expanded="true" aria-controls="collapse1" style="height:40px;color:black; border:none; outline:none; box-shadow: none; text-decoration:none;">
		            <p><span style="font-size:8pt;">▼ 01</span>  &nbsp;|&nbsp; <span style="font-size:12pt; font-weight:bold;">1주차</span>	</p>
		          </button>
		          
		          <div style="float:right; margin-top: 3px; " >    	
			          	<div class="progress" style="width:100px; height:15px;">
						  <div class="progress-bar" role="progressbar" aria-valuenow="70"
						  aria-valuemin="0" aria-valuemax="100" style="width:70%">
						    70%
						  </div>
						</div>	
						<div style="font-size:8pt; margin-top: 3px; text-align:right; padding-right:10px;">
						  시작일: 2021-11-04
					</div>  
					</div>
					<div style="display:inline-block; align:right; float:right; font-size:11pt;">6/6&nbsp;&nbsp;</div>		          		          	     		        
		      </div>
		
		      <div id="collapse1" class="collapse" aria-labelledby="heading1" data-parent="#accordion1" style="background-color:#f7f7f7;">
		         <!-- .collapse show 는 맨 처음에는  내용물을 보여주도록 하는 것임. -->
		         <div class="card-body " style=" border:1px solid #DDD; margin-top:20px;  margin-bottom:10px; margin-right:20px; margin-left:20px; background-color:white;  font-size:9pt;">
		          
		          
			          
			          <!-- callapse 다시 시작 -->
			          <div class="accordion" id="accordion1_1" style="margin:0px; padding:0px;">		          	
			          		<div class="" id="heading1_1" style="background-color:white; border:none;">
				          		<button class="btn btn-link btn-sm" type="button" data-toggle="collapse" data-target="#collapse1_1" aria-expanded="true" aria-controls="collapse1_1" style="height:30px;color:black; border:none; outline:none; box-shadow: none; text-decoration:none;">
				            		1차시
				          		</button>         		
			          		</div>
			      		
			          		<div id="collapse1_1" class="collapse" aria-labelledby="heading1_1" data-parent="#accordion1_1" style=" background-color:white;  font-size:9pt;">
				          		<div style="padding-left:2px; border-left:4px solid #008ae6;">			          					         
							         <div class="" style="padding-left:5px; height:50px; padding-top:15px; border-bottom:0.5px solid #DDD;  font-size:11pt; font-weight:bold;">
							           	<img src="<%= ctxPath%>/resources/images/재생버튼2.png" style="width:25px;">&nbsp; <a href="<%=ctxPath%>/classContentsView.univ" style="text-decoration:none; color:black;">빅데이터실무1주차 - 1교시</a> <div style="display:inline-block;text-align:right; float:right;" > <button style="background-color:#1a75ff; color:white; border-radius: 10px; border:none;">출석</button></div>
							         </div>
							         
							    </div>     				         
					      	</div>
					      	<div id="collapse1_1" class="collapse" aria-labelledby="heading1_1" data-parent="#accordion1_1" style=" background-color:white;  font-size:9pt;">
					      		<div style="padding-left:2px; border-left:4px solid #008ae6;">			          					         
							         <div class="" style="padding-left:5px; height:50px; padding-top:15px; border-bottom:0.5px solid #DDD; font-size:11pt; font-weight:bold;">
							           	<img src="<%= ctxPath%>/resources/images/요약본3.png" style="width:25px;">&nbsp; 빅데이터실무1주차 - 요약정리
							         </div>		
						         </div>		         
					      	</div>		        	
			          </div>	          			      
		         </div>
		      </div>
		      
      
		      <div id="collapse1" class="collapse" aria-labelledby="heading1" data-parent="#accordion1" style="background-color:#f7f7f7;">
		         <!-- .collapse show 는 맨 처음에는  내용물을 보여주도록 하는 것임. -->
		         <div class="card-body " style=" border:1px solid #DDD; margin-top:20px;  margin-bottom:20px; margin-right:20px; margin-left:20px; background-color:white;  font-size:9pt;">
		          
		          
			          
			          <!-- callapse 다시 시작 -->
			          <div class="accordion" id="accordion1_1" style="margin:0px; padding:0px;">		          	
			          		<div class="" id="heading1_1" style="background-color:white; border:none;">
				          		<button class="btn btn-link btn-sm" type="button" data-toggle="collapse" data-target="#collapse1_1" aria-expanded="true" aria-controls="collapse1_1" style="height:30px;color:black; border:none; outline:none; box-shadow: none; text-decoration:none;">
				            		2차시
				          		</button>         		
			          		</div>
			      		
			          		<div id="collapse1_1" class="collapse" aria-labelledby="heading1_1" data-parent="#accordion1_1" style=" background-color:white;  font-size:9pt;">
				          		<div style="padding-left:2px; border-left:4px solid #008ae6;">			          					         
							         <div class="" style="padding-left:5px; height:50px; padding-top:15px; border-bottom:0.5px solid #DDD;  font-size:11pt; font-weight:bold;">
							           	<img src="<%= ctxPath%>/resources/images/재생버튼2.png" style="width:25px;">&nbsp; 빅데이터실무1주차 - 1교시 <div style="display:inline-block;text-align:right; float:right;" > <button style="background-color:#1a75ff; color:white; border-radius: 10px; border:none;">출석</button></div>
							         </div>
							         
							    </div>     				         
					      	</div>
					      	<div id="collapse1_1" class="collapse" aria-labelledby="heading1_1" data-parent="#accordion1_1" style=" background-color:white;  font-size:9pt;">
					      		<div style="padding-left:2px; border-left:4px solid #008ae6;">			          					         
							         <div class="" style="padding-left:5px; height:50px; padding-top:15px; border-bottom:0.5px solid #DDD; font-size:11pt; font-weight:bold;">
							           	<img src="<%= ctxPath%>/resources/images/요약본3.png" style="width:25px;">&nbsp; 빅데이터실무1주차 - 요약정리
							         </div>		
						         </div>		         
					      	</div>		        	
			          </div>
			           
		         </div>
		      </div>
		      

		    
		   </div>
		   
		
		   

		   
		  
		   <div class="card">
		      <div class="card-header" id="headingThree">
		        <h2 class="mb-0">
		          <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree" style="color:black; border:none; outline:none; box-shadow: none;">
		            3주차
		          </button>
		        </h2>
		      </div>
		      
		      <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion1">
		         <div class="card-body">
		            1차시
		         </div>
		      </div>
		      <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion1">
		         <div class="card-body">
		            2차시
		         </div>
		      </div>
		   </div>
		</div>
</div>


