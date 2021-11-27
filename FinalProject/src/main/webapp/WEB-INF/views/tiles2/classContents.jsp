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
	   
		$("ul#sideMenuList > li:nth-child(7)").addClass("hoverdEffect");
		
		$("ul#sideMenuList").hover(function(){
			$("ul#sideMenuList > li:nth-child(7)").removeClass("hoverdEffect");
		}, function(){
			$("ul#sideMenuList > li:nth-child(7)").addClass("hoverdEffect");
		});
	 
      
	  /*  $("button.numbtn").click(function(){
		   $(this).addClass("numbtn_click");		   
	   }); */
	   
	   $("button.btn").click(function(){
		  
		   var week = $(this).next().next().val();
		   
		   if($(this).next().val() == ""){
			   $(this).next().val("hi");
			   viewlesson(week);
		   }
		   else if($(this).next().val() == "hi"){
			   $("div#accordionLesson" + week).empty();
			   $(this).next().val("");
		   }
		
		   
		   
	   });
	   
	
   });
   
   function viewlesson(week){
	   

	    // alert(week);
	     	     
	    $.ajax({
		   url:"<%=ctxPath%>/getlesson.univ",
		   //async:false,
		   data:{"week":week},
		   dataType:"JSON",
		   success:function(json){
			 
				   var html = "";
				   
				   
			//	   console.log(JSON.stringify(json));
				 
			       $.each(json, function(index, item){
			    	   
			    	   
			    	 /*   html += "<div id='collapse1' class='collapse"+index+"' aria-labelledby='heading1' data-parent='#accordion1' style='background-color:#f7f7f7;'>";
			    	   html += "ㅎㅎㅎ";
			    	   html += "</div>"; */
			    	   
			    	   	    
			       	   // html += "<div id='collapse"+week+"' class='collapse' aria-labelledby='heading1' data-parent='#accordion1' style='background-color:#f7f7f7;'>";
			         	html += "<div id='collapse1'                  aria-labelledby='heading1' data-parent='#accordion1' style='background-color:#f7f7f7;'>";
						html += 	"<div class='card-body' style='border:1px solid #DDD; margin-top:20px;  margin-bottom:10px; margin-right:20px; margin-left:20px; background-color:white;  font-size:9pt;'>";
						html += 		"<div class='accordion' id='accordion1_1' style='margin:0px; padding:0px;'>";
						html +=				"<div id='heading1_1' style='background-color:white; border:none;'>";
						html += 				"<button class='btn btn-link btn-sm' type='button' data-toggle='collapse' data-target='#collapse"+item.lessonseq+"' aria-expanded='true' aria-controls='collapse"+item.lessonseq+"' style='height:30px;color:black; border:none; outline:none; box-shadow: none; text-decoration:none;'>";
						html +=						item.lesson+"차시";
						html +=					"</button>";
						html +=				"</div>";
						html +=				"<div id='collapse"+item.lessonseq+"' class='collapse' aria-labelledby='heading1_1' data-parent='#accordion1_1' style='background-color:white;  font-size:9pt;'>";
						html +=					"<div style='padding-left:2px; border-left:4px solid #008ae6;'>";
						html +=						"<div  style='padding-left:5px; height:50px; padding-top:15px; border-bottom:0.5px solid #DDD;  font-size:11pt; font-weight:bold;'>";
						html +=						"<img src='/univ/resources/images/재생버튼2.png' style='width:25px;' />&nbsp; <a href='/univ/classContentsView.univ?code="+item.code+"&week="+item.week+"&lesson="+item.lesson+"&lessonseq="+item.lessonseq+"' style='text-decoration:none; color:black;'>"+item.subject+" "+item.week+"주차 -"+item.lesson+"교시</a> <div style='display:inline-block;text-align:right; float:right;' >";
						if(item.isCheck == 1){
							html += 					"<button style='background-color:#1a75ff; color:white; border-radius: 10px; border:none;'>수강 완료</button>";
						}
						else{
							html += 					"<button style='background-color:#ff0000; color:white; border-radius: 10px; border:none;'>미수강</button>";
						}
						
						html += 					"</div>";
						html +=						"</div>";
						html +=					"</div>";
						html +=				"</div>";
						html +=				"<div id='collapse"+item.lessonseq+"' class='collapse' aria-labelledby='heading1_1' data-parent='#accordion1_1' style='background-color:white;  font-size:9pt;'>";
						html += 				"<div style='padding-left:2px; border-left:4px solid #008ae6;'>";
						html += 					"<div  style='padding-left:5px; height:50px; padding-top:15px; border-bottom:0.5px solid #DDD; font-size:11pt; font-weight:bold;'>";
						html +=							"<img src='/univ/resources/images/요약본3.png' style='width:25px;'>&nbsp; <a href='/univ/classContentsView.univ?code="+item.code+"&week="+item.week+"&lesson="+item.lesson+"&lessonseq="+item.lessonseq+"' style='text-decoration:none; color:black;'>"+item.subject+" "+item.week+"주차 - 요약정리</a>";
						html += 					"</div>";
						html +=					"</div>";
						html +=				"</div>";
						html +=			"</div>";
					    html +=		"</div>";
					  
					    
			       });
			    
			       //$("div#collapse1").html(html);
			       $("div#accordionLesson"+week).html(html);
			
			<%--	   
				   $.each(json, function(index, item){
					   html += "<div id='collapse1' class='collapse' aria-labelledby='heading1' data-parent='#accordion1' style='background-color:#f7f7f7;'>";
					   html += "</div>";
					   
				   });
				   
				   $("div#accordionLesson1").html(html);
				   
				   $.each(json, function(index, item){
					     html += 	"<div class='card-body ' style=' border:1px solid #DDD; margin-top:20px;  margin-bottom:10px; margin-right:20px; margin-left:20px; background-color:white;  font-size:9pt;'>";
						html += 		"<div class='accordion' id='accordion1_1' style='margin:0px; padding:0px;''>";
						html +=				"<div id='heading1_1' style='background-color:white; border:none;'>";
						html += 				"<button class='btn btn-link btn-sm' type='button' data-toggle='collapse' data-target='#collapse1_1' aria-expanded='true' aria-controls='collapse1_1' style='height:30px;color:black; border:none; outline:none; box-shadow: none; text-decoration:none;'>";
						html +=						item.lesson+"차시";
						html +=					"</button>";
						html +=				"</div>";
						html +=				"<div id='collapse1_1' class='collapse' aria-labelledby='heading1_1' data-parent='#accordion1_1' style=' background-color:white;  font-size:9pt;'>";
						html +=					"<div style='padding-left:2px; border-left:4px solid #008ae6;'>";
						html +=						"<div  style='padding-left:5px; height:50px; padding-top:15px; border-bottom:0.5px solid #DDD;  font-size:11pt; font-weight:bold;'>";
						html +=						"<img src='univ/resources/images/재생버튼2.png' style='width:25px;' />&nbsp; <a href='univ/classContentsView.univ' style='text-decoration:none; color:black;'>"+item.subject+item.week+"주차 -"+item.lesson+"교시</a> <div style='display:inline-block;text-align:right; float:right;' ><button style='background-color:#1a75ff; color:white; border-radius: 10px; border:none;'>출석</button></div>";
						html +=						"</div>";
						html +=					"</div>";
						html +=				"</div>";
						html +=				"<div id='collapse1_1' class='collapse' aria-labelledby='heading1_1' data-parent='#accordion1_1' style=' background-color:white;  font-size:9pt;'>";
						html += 				"<div style='padding-left:2px; border-left:4px solid #008ae6;'>";
						html += 					"<div  style='padding-left:5px; height:50px; padding-top:15px; border-bottom:0.5px solid #DDD; font-size:11pt; font-weight:bold;'>";
						html +=							"<img src='/univ/resources/images/요약본3.png' style='width:25px;'>&nbsp; "+item.subject,item.week+"주차 - 요약정리";
						html += 					"</div>";
						html +=					"</div>";
						html +=				"</div>";
						html +=			"</div>"; 
					   
				   });
				   
				   $("div#collapse1").html(html);
					   
			 		   
					   html += "<div class='accordion' id='accordionExample'>                                                                                                                                ";
					   html += "<div class='card'>                                                                                                                                                           ";
					   html += "  <div class='card-header' id='headingOne'>                                                                                                                                  ";
					   html += "    <h2 class='mb-0'>                                                                                                                                                        ";
					   html += "      <button class='btn btn-link btn-block text-left' type='button' data-toggle='collapse' data-target='#collapseOne' aria-expanded='true' aria-controls='collapseOne'>     ";
					   html += "      "+item.subject+ item.lesson+"                                                                                                                                             ";
					   html += "      </button>                                                                                                                                                              ";
					   html += "    </h2>                                                                                                                                                                    ";
					   html += "  </div>                                                                                                                                                                     ";
                       html += "                                                                                                                                                                             ";
					   html += "  <div id='collapseOne' class='collapse show' aria-labelledby='headingOne' data-parent='#accordionExample'>                                                                  ";
					   html += "    <div class='card-body'>                                                                                                                                                  ";
					   html += "    "+item.subject+ item.lesson+"                                                                                                                                              ";
					   html += "    </div>                                                                                                                                                                   ";
					   html += "  </div>                                                                                                                                                                     ";
					   html += "</div>"; 
					 
			 		   
			  $.each(json, function(index, item){
					    html += "<div id='collapse1' class='collapse' aria-labelledby='heading1' data-parent='#accordion1' style='background-color:#f7f7f7;'>";
						html += 	"<div class='card-body ' style=' border:1px solid #DDD; margin-top:20px;  margin-bottom:10px; margin-right:20px; margin-left:20px; background-color:white;  font-size:9pt;'>";
						html += 		"<div class='accordion' id='accordion1_1' style='margin:0px; padding:0px;''>";
						html +=				"<div id='heading1_1' style='background-color:white; border:none;'>";
						html += 				"<button class='btn btn-link btn-sm' type='button' data-toggle='collapse' data-target='#collapse1_1' aria-expanded='true' aria-controls='collapse1_1' style='height:30px;color:black; border:none; outline:none; box-shadow: none; text-decoration:none;'>";
						html +=						item.lesson+"차시";
						html +=					"</button>";
						html +=				"</div>";
						html +=				"<div id='collapse1_1' class='collapse' aria-labelledby='heading1_1' data-parent='#accordion1_1' style=' background-color:white;  font-size:9pt;'>";
						html +=					"<div style='padding-left:2px; border-left:4px solid #008ae6;'>";
						html +=						"<div  style='padding-left:5px; height:50px; padding-top:15px; border-bottom:0.5px solid #DDD;  font-size:11pt; font-weight:bold;'>";
						html +=						"<img src='univ/resources/images/재생버튼2.png' style='width:25px;' />&nbsp; <a href='univ/classContentsView.univ' style='text-decoration:none; color:black;'>"+item.subject+item.week+"주차 -"+item.lesson+"교시</a> <div style='display:inline-block;text-align:right; float:right;' ><button style='background-color:#1a75ff; color:white; border-radius: 10px; border:none;'>출석</button></div>";
						html +=						"</div>";
						html +=					"</div>";
						html +=				"</div>";
						html +=				"<div id='collapse1_1' class='collapse' aria-labelledby='heading1_1' data-parent='#accordion1_1' style=' background-color:white;  font-size:9pt;'>";
						html += 				"<div style='padding-left:2px; border-left:4px solid #008ae6;'>";
						html += 					"<div  style='padding-left:5px; height:50px; padding-top:15px; border-bottom:0.5px solid #DDD; font-size:11pt; font-weight:bold;'>";
						html +=							"<img src='/univ/resources/images/요약본3.png' style='width:25px;'>&nbsp; "+item.subject,item.week+"주차 - 요약정리";
						html += 					"</div>";
						html +=					"</div>";
						html +=				"</div>";
						html +=			"</div>";
						html +=		"</div>";
						  
						
				   });
				   
			   		$("div#accordionLesson1").html(html);
			 
	         --%>
			    
		   },
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
	   });  
	    
   }// end of  function viewlesson(week){------------------------------------------------------------
   
	   

   

</script>

<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left;"><span style="color: #0099ff; text-decoration: underline;">강의콘텐츠</span></h3>
<hr style="clear: both;">

<div class="container" style="margin-top: 200px; color:black; ">

	<div  style="margin-bottom:30px;">
		<button type="button" class="numbtn btn btn-sm" style="border:0.5px solid #DDD; background-color:white; width:30px;  border-radius: 1px;">1</button>
		<button type="button" class="numbtn btn btn-sm " style="border:0.5px solid #DDD; background-color:white; width:30px; border-radius: 1px;">2</button>
		<button type="button" class="numbtn btn btn-sm " style="border:0.5px solid #DDD; background-color:white; width:30px; border-radius: 1px;">3</button>
		<button type="button" class="numbtn btn btn-sm "style="border:0.5px solid #DDD; background-color:white; width:30px; border-radius: 1px;">4</button>
		<button type="button" class="numbtn btn btn-sm " style="border:0.5px solid #DDD; background-color:white; width:30px; border-radius: 1px;">5</button>
	</div>
		<div class="btn btn-secondary btn-sm" onclick="javascript:location.href='<%= request.getContextPath()%>/classWeekRegister.univ?code=${requestScope.code}'">수업  주차 등록하기</div>
		<div class="btn btn-secondary btn-sm" onclick="javascript:location.href='<%= request.getContextPath()%>/classLessonRegister.univ?code=${requestScope.code}'">수업  차시 등록하기</div>
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
		
		
		
		<!-- 전체 아코디언 시작 -->
		<%-- <c:forEach var="weekvo" items="${requestScope.getWeek}" varStatus="status"> --%>
		<div class="accordion" id="accordion1" style="height:1000px;">
		
			<!-- 주차 반복 시작   1주차, 2주차, 3주차... -->
			 <c:forEach var="weekvo" items="${requestScope.getWeek}" varStatus="status">
			   <div class="card" id="card">
			      <div class="card-header" id="heading1" style="height:60px;">
			        
			          <button class="btn btn-link btn-sm" type="button" data-toggle="collapse${status.count}" data-target="#collapse${status.count}" aria-expanded="true" aria-controls="collapse${status.count}" style="height:40px;color:black; border:none; outline:none; box-shadow: none; text-decoration:none; ">
			            <p><span style="font-size:8pt;">▼ 0${weekvo.week}</span>  &nbsp;|&nbsp; <span style="font-size:12pt; font-weight:bold;">${weekvo.week}주차</span>	</p>
			          </button>
			          <input type="hidden" value="" />
			          <input type="hidden" value="${weekvo.week}" />
			          <div style="float:right; margin-top: 3px; " >    	
				          	<div class="progress" style="width:100px; height:15px;">
							  <div class="progress-bar" role="progressbar" aria-valuenow="70"
							  aria-valuemin="0" aria-valuemax="100" style="width:70%">
							    70%
							  </div>
							</div>	
							<div style="font-size:8pt; margin-top: 3px; text-align:right; padding-right:10px;">
							  시작일: ${weekvo.startday}
						</div>  
						</div>
						<div style="display:inline-block; align:right; float:right; font-size:11pt;">6/6&nbsp;&nbsp;</div>		          		          	     		        
			      </div>
			      
			      
			     <%--  <c:forEach var="map" items="${requestScope.classList}" varStatus="status"> 
				      <div id="collapse1" class="collapse" aria-labelledby="heading1" data-parent="#accordion1" style="background-color:#f7f7f7;">				      
				      </div>
			      </c:forEach> --%>
						<!-- 여기에 차시 반복이 들어온다. -->
					 <div id="accordionLesson${status.count}" style="background-color:#f7f7f7;" > 
					
					
					<%-------------------------- 반복시작  -------------------------------------- --%>
						<%-- 	<div id="collapse1" class="collapse" aria-labelledby="heading1" data-parent="#accordion1" style="background-color:#f7f7f7;">
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
										           	<img src="<%= ctxPath%>/resources/images/재생버튼2.png" style="width:25px;">&nbsp; <a href="<%=ctxPath%>/classContentsView.univ" style="text-decoration:none; color:black;">빅데이터실무${weekvo.week}주차 - 1교시</a> <div style="display:inline-block;text-align:right; float:right;" > <button style="background-color:#1a75ff; color:white; border-radius: 10px; border:none;">출석</button></div>
										         </div>
										    </div>     				         
								      	</div>
								      	
								      	<div id="collapse1_1" class="collapse" aria-labelledby="heading1_1" data-parent="#accordion1_1" style=" background-color:white;  font-size:9pt;">
								      		<div style="padding-left:2px; border-left:4px solid #008ae6;">			          					         
										         <div class="" style="padding-left:5px; height:50px; padding-top:15px; border-bottom:0.5px solid #DDD; font-size:11pt; font-weight:bold;">
										           	<img src="<%= ctxPath%>/resources/images/요약본3.png" style="width:25px;">&nbsp; 빅데이터실무${weekvo.week}주차 - 요약정리
										         </div>		
									         </div>		         
								      	</div>
								      	
								      				      			        	
						          </div>	
						          <!-- callapse 다시 끝 -->   
						          
					          </div> 	
					      	</div> --%>
					 <%--------------------------- 반복끝 ------------------------------------- --%>  	
					 
					 
					  
					 </div> 
					
				</div>
			   </c:forEach>
		   
		</div> 
		<%-- </c:forEach>  --%>
		<!-- 전체 아코디언 끝 -->
		
		
</div>
		   <!-- 주차 반복 끝   1주차, 2주차, 3주차... -->
			
			
			
<%-- [원본 소스]
		      <div id="collapse1" class="collapse" aria-labelledby="heading1" data-parent="#accordion1" style="background-color:#f7f7f7;">
		         <!-- .collapse show 는 맨 처음에는  내용물을 보여주도록 하는 것임. -->
		         <div class="card-body " style=" border:1px solid #DDD; margin-top:20px;  margin-bottom:10px; margin-right:20px; margin-left:20px; background-color:white;  font-size:9pt;">
		          
		          
			          
			          <!-- callapse 다시 시작 -->
			          <div class="accordion" id="accordion1_1" style="margin:0px; padding:0px;">		          	
			          		<div class="" id="heading1_1" style="background-color:white; border:none;">
				          		<button class="btn btn-link btn-sm" type="button" data-toggle="collapse" data-target="#collapse1_1" aria-expanded="true" aria-controls="collapse1_1" style="height:30px;color:black; border:none; outline:none; box-shadow: none; text-decoration:none;">
				            		${map.lesson}차시
				          		</button>         		
			          		</div>
			      		
			          		<div id="collapse1_1" class="collapse" aria-labelledby="heading1_1" data-parent="#accordion1_1" style=" background-color:white;  font-size:9pt;">
				          		<div style="padding-left:2px; border-left:4px solid #008ae6;">			          					         
							         <div class="" style="padding-left:5px; height:50px; padding-top:15px; border-bottom:0.5px solid #DDD;  font-size:11pt; font-weight:bold;">
							           	<img src="<%= ctxPath%>/resources/images/재생버튼2.png" style="width:25px;">&nbsp; <a href="<%=ctxPath%>/classContentsView.univ" style="text-decoration:none; color:black;">빅데이터실무${weekvo.week}주차 - ${map.lesson}교시</a> <div style="display:inline-block;text-align:right; float:right;" > <button style="background-color:#1a75ff; color:white; border-radius: 10px; border:none;">출석</button></div>
							         </div>
							         
							    </div>     				         
					      	</div>
					      	<div id="collapse1_1" class="collapse" aria-labelledby="heading1_1" data-parent="#accordion1_1" style=" background-color:white;  font-size:9pt;">
					      		<div style="padding-left:2px; border-left:4px solid #008ae6;">			          					         
							         <div class="" style="padding-left:5px; height:50px; padding-top:15px; border-bottom:0.5px solid #DDD; font-size:11pt; font-weight:bold;">
							           	<img src="<%= ctxPath%>/resources/images/요약본3.png" style="width:25px;">&nbsp; 빅데이터실무${weekvo.week}주차 - 요약정리
							         </div>		
						         </div>		         
					      	</div>		        	
			          </div>	
			          <!-- callapse 다시 끝 -->   
			          
			                 			      
		         </div>
		      	</div> --%>

		   
	  <!----  이건 차시 변경 경계선  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  -->


   






