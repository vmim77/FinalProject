<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">



</style>

<script type="text/javascript">

var obj =  $("iframe#classVideo");

   $(document).ready(function(){
	   
		$("ul#sideMenuList > li:nth-child(7)").addClass("hoverdEffect");
		
		$("ul#sideMenuList").hover(function(){
			$("ul#sideMenuList > li:nth-child(7)").removeClass("hoverdEffect");
		}, function(){
			$("ul#sideMenuList > li:nth-child(7)").addClass("hoverdEffect");
		});
	   
	   // 이 페이지를 보여줒기 위해선 항상 이 4개의 값이 필요하다. 게시물 글쓰다가 들어와도 보여줘야하고 출석확인하고도 보여줘야 한다.
	   sessionStorage.setItem('code', "${requestScope.oneClassView.code}");
	   sessionStorage.setItem('week', "${requestScope.oneClassView.week}");
	   sessionStorage.setItem('lesson', "${requestScope.oneClassView.lesson}");
	   sessionStorage.setItem('lessonseq', "${requestScope.oneClassView.lessonseq}");
	   
	  //var code = sessionStorage.getItem('code');
	   //var week = sessionStorage.getItem('week');
	   //var lesson = sessionStorage.getItem('lesson');
	   //var lessonseq = sessionStorage.getItem('lessonseq');
	   
	   //console.log(code);
	  // console.log(week);
	  // console.log(lesson);
	  // console.log(lessonseq);
	  
	   if(${not empty requestScope.classContentList}){
		   classContentViewComment(1);   
	   }
	   
	   
	   getAttend();
	   
	   $("input#searchWord").keyup(function(event){
		   if(event.keyCode==13){
			   commentSearch();
		   }
	   })
	   //var b = sessionStorage.getItem('code');
	   	   
	 /*   setTimeout(function(){
		
		   var time = obj.duration;
		   console.log("time : " +time);
		   		setTimeout(function(){
		   			javascript:location.reload();
		   		}, (time+0.5)*1000);
		   
	   },500); */
	   
	   
	  /*  $("button#attend").click(function(){
		   //getAttend();
			  if(check){
				  alert("출석완료");
				  $(this).disabled = true;
				  
			  }
			  
			  else{
				  alert("학습을 완료하고 누르세요.");
			  }
			  
		  }); */
	   
	   
	     
   });// end of $(document).ready(function(){-----------------------------------
	   
	   
   
   function classContentDel(classBoardSeq){
	   
	   var del = confirm("정말로 삭제하시겠습니까?");
	   
	   var code = sessionStorage.getItem('code');
	   var week = sessionStorage.getItem('week');
	   var lesson = sessionStorage.getItem('lesson');
	   var lessonseq = sessionStorage.getItem('lessonseq');
	   
	   	   
	    if(del){
		   location.href="<%= request.getContextPath()%>/classContentDel.univ?classBoardSeq="+classBoardSeq+"&code="+code+"&week="+week+"&lesson="+lesson+"&lessonseq="+lessonseq+"";
	   }
   }// end of function classContentDel(classBoardSeq){---------------------------------------------
   
   
   
   //첨부파일이 없는 댓글쓰기
   function classCommentWrite(classBoardSeq){
	   //alert(classBoardSeq);
	   
	      // 먼저 유효성 검사!
	      var contentVal = $("input#commentContent").val().trim();
	      if(contentVal == ""){
	         alert("댓글 내용을 입력하세요!!");
	         return; // 종료
	      }
	   
	   if($("input#attach").val() == "") {
		      classCommentWrite_noAttach(); // 댓글에 첨부파일이 없는 댓글쓰기
	      }
	      else{
	    	  classCommentWrite_withAttach(); // 댓글에 첨부파일이 있는 댓글쓰기
	      }
	   
	   
   }//end of function classCommentWrite(classBoardSeq){----------------------------------------------
   
   
   
   
// 첨부파일이 없는 댓글쓰기 
	function classCommentWrite_noAttach() {
		
	
	$.ajax({
			url:"<%= request.getContextPath()%>/classCommentWrite_noAttach.univ",
			data:{"commentContent":$("input#commentContent").val()
				 ,"fk_classBoardSeq":$("input#fk_classBoardSeq").val()},
			type:"POST",
			dataType:"JSON",
			success:function(json){ 
			   
				if(json.n == 1){
					alert("댓글쓰기 성공!");
					classContentViewComment(1);
				}
				
				$("input#commentContent").val("");
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
		
	}// end of function goAddWrite_noAttach() {}------------------------------
	
	
	
	
	//첨부파일이 있는 댓글쓰기
	function classCommentWrite_withAttach() {
	      
	      var form_data = $("form[name=commentFrm]").serialize(); // serialize할때는 반드시 name이 필요함. 그래서 댓글 폼에 각각 name을 다 달아줌!
	      
	      $("form[name=commentFrm]").ajaxForm({
	         url:"<%= request.getContextPath()%>/classCommentWrite_withAttach.univ",
	         data:form_data,
	         type:"POST",
	         enctype:"multipart/form-data", // 파일 첨부가 되려면 반드시 입력해줌.
	         dataType:"JSON",
	         success:function(json){ //          {"n":1, "name":"이순신"}
	                           // 또는      {"n":0, "name":"이순신"}
	                           
	        	 if(json.n == 1){
						alert("댓글쓰기 성공!");
						classContentViewComment(1);
					}
	            
	            $("input#commentContent").val(""); // 작성완료이니 내용을 비워준다.
	            $("input#attach").val(""); // 작성완료이니 첨부된 파일을 비워준다.
	            
	         },
	         error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	           }
	      });
	      
	      
	      $("form[name=commentFrm]").submit();
	      
	   }//end of function classCommentWrite_withAttach()-------------------
	
	
	// === Ajax로 불러온 댓글내용을 페이징처리 하기 === //
	   function classContentViewComment(currentShowPageNo) {
	      
	      $.ajax({
	         url:"<%= request.getContextPath()%>/commentList.univ", 
	         data:{"fk_classBoardSeq":$("input#fk_classBoardSeq").val()
	            , "currentShowPageNo":currentShowPageNo
	            , "searchWord":$("input#searchWord").val()},
	         type:"POST",
	         dataType:"JSON",
	         success:function(json){
	            var html = "";
	           
  
	              if(json.length > 0){
	               $.each(json, function(index, item){
	            	   
	            	                                                                                                                                                                          
	            	                                                                                                                                                                          
	            	html += "   <table style='width:100%; border:0.5px solid #DDD; margin-bottom:20px;'>"
					html += "	<tr>"
					html += "		<td></td>"
					html += "		<td>"
					html += "			<div style='text-align:right; padding-right:15px; padding-top:15px;'><button style='background-color:white; border:0.5px solid white;' onclick='commentDel("+item.classCommentSeq+")'>X</button></div>"
					html += "		</td>"
					html += "	</tr>"
					html += "	<tr style='height:100px;'>"
					html += "		<td rowspan='2' style='width:50px;  padding-left:10px;'>"
					html += "			<img src='<%= ctxPath%>/resources/images/회원사진.png' style='width:40px;'>"
					html += "		</td>"
					html += "		<td style='font-size:10pt; padding-left:10px;'>"
					html += "			<br><span style='color:#0099ff;'>"+item.name+"("+item.fk_hakbun+")</span><br><span>"+item.regDate+"</span>"
					html += "		</td> "
					html += "	</tr>"
					html += "	<tr>"
					html += "		<td>   "
					html += "			   "
					html += "		</td>  "
					html += "	</tr>      "
					html += "	<tr  style='height:100px;'>"
					html += "		<td colspan='2'>       "
					html += "			"+item.commentContent+""
					html += "		</td>           "					
					html += "	</tr>               "
					html += "	<tr style='height:60px; border-top:0.5px solid #DDD;'"
					if(item.fileName != null && item.fileName != "" && item.fileName !=" "){
						html += "<td colspan='2' style='font-size:10pt; padding-left:8px; '>"
						html += 	"<a href='/univ/downloadClassContentComment.univ?classCommentSeq="+item.classCommentSeq+"'>"+item.orgFilename+"</a>"
						html += "</td>"
						
					}
					else{
						html += "		<td colspan='2' style='font-size:10pt; padding-left:8px; '>"						
						html += "			첨부된 파일이 없습니다."
						html += "		</td>"
					}
					
					html += "	</tr>"
					html += "</table>"
	            	   
	            	   
	               }); 
	               
	             }
		               else{
		            	  
		            	html += "<div style='height:250px; display:flex; text-align:center; border-top:0.5px solid #DDD; border-bottom:0.5px solid #DDD;'>"	;              
						html += 	"<div style='margin:auto;'>등록된 댓글이 없습니다.</div>";
						html += "</div>";
		            	  	            	  
		              } 
	            	  
	              
	            
	            $("#commentView").html(html);
	            
	            // 페이지바 함수 호출
	            makeClassContentCommentPageBar(currentShowPageNo); 
	            
	         },
	         error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	           }
	      });
	      
	   }// end of function classContentViewComment() {}----------------------
	   
	   
	   
	   
	// ===== 댓글내용 페이지바 Ajax로 만들기 ===== //
		function makeClassContentCommentPageBar(currentShowPageNo) {
			
			<%-- === 원게시물에 대한 댓글의 totalPage 수를 알아오려고 한다.=== --%>
			$.ajax({
				url:"<%= request.getContextPath()%>/getClassContentCommentTotalPage.univ", 
				data:{"fk_classBoardSeq":$("input#fk_classBoardSeq").val()
		            , "currentShowPageNo":currentShowPageNo
		            , "searchWord":$("input#searchWord").val()
					 ,"sizePerPage":"3"},
				type:"GET",
				dataType:"JSON",
				success:function(json){
				//	console.log("확인용 전체 페이지수 =>" + json.totalPage);
				     
			        if(json.totalPage > 0) {
			        	// 댓글이 있는 경우 
			        	
			        	var totalPage = json.totalPage;
			        	
			        	var pageBarHTML = "<ul style='list-style: none;' >";
			        	
			        //	var blockSize = 10;
			        	var blockSize = 2;
			        
			            // blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수 이다.
						/*
						      1 2 3 4 5 6 7 8 9 10  다음                   -- 1개블럭
						   이전  11 12 13 14 15 16 17 18 19 20  다음   -- 1개블럭
						   이전  21 22 23
						*/
						
						var loop = 1;
						/*
					    	loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
					    */
					    
					    if(typeof currentShowPageNo == "string") {
					    	currentShowPageNo = Number(currentShowPageNo);
					    }
					    
					 // *** !! 다음은 currentShowPageNo 를 얻어와서 pageNo 를 구하는 공식이다. !! *** //
					    var pageNo = Math.floor( (currentShowPageNo - 1)/blockSize ) * blockSize + 1;

					 
					    // === [맨처음][이전] 만들기 === 
						if(pageNo != 1) {
							pageBarHTML += "<li style='display:inline-block; width:60px; font-size:12pt;'><a href='javascript:classContentViewComment(\"1\")'>맨처음</a></li>"; 
							pageBarHTML += "<li style='display:inline-block; width:50px; font-size:11pt;'><a href='javascript:classContentViewComment(\""+(pageNo-1)+"\")'>이전</a></li>";
						}
							
						while( !(loop > blockSize || pageNo > totalPage) ) {
							
							if(pageNo == currentShowPageNo) {
								pageBarHTML += "<li style='display:inline-block; width:30px; font-size:11pt; font-weight:bold; border: color:#0066ff; padding:2px 4px;'>"+pageNo+"</li>";
							}
							else {
								pageBarHTML += "<li style='display:inline-block; width:30px; font-size:11pt;'><a href='javascript:classContentViewComment(\""+pageNo+"\")'>"+pageNo+"</a></li>";
							}
							
							loop++;
							pageNo++;
							
						}// end of while------------------------------
							
							
						// === [다음][마지막] 만들기 ===
						if( pageNo <= totalPage ) {
							pageBarHTML += "<li style='display:inline-block; width:50px; font-size:11pt;'><a href='javascript:classContentViewComment(\""+pageNo+"\")'>다음</a></li>";
							pageBarHTML += "<li style='display:inline-block; width:60px; font-size:11pt;'><a href='javascript:classContentViewComment(\""+totalPage+"\")'>마지막</a></li>";
						}
			        	
			        	pageBarHTML += "</ul>";
			        	
			        	$("div#pageBar").html(pageBarHTML);
			        	
			        }// end of if------------------------	
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
			});
			
		}// end of function makeCommentPageBar(currentShowPageNo) {}-------------
		
		
		
		function commentSearch(){
			
			 classContentViewComment(1);
			 
		};// end of function commentSearch(){-----------------------
		
		
		
		function commentDel(classCommentSeq){
		  //alert(classCommentSeq);
		  
		  var code = sessionStorage.getItem('code');
		  var week = sessionStorage.getItem('week');
		  var lesson = sessionStorage.getItem('lesson');
		  var lessonseq = sessionStorage.getItem('lessonseq');
			
		  var del = confirm("정말로 삭제하시겠습니까?");
	   	   
		    if(del){
			   location.href="<%= request.getContextPath()%>/commentDel.univ?classCommentSeq="+classCommentSeq+"&code="+code+"&week="+week+"&lesson="+lesson+"&lessonseq="+lessonseq+"";
		   }
		    
		}// end od function commentDel(classCommentSeq){-------------------------------------
		
   
</script>



<!--############ 유튜브 동영상 #####################################################################################################-->
<script>
	
	var tag = document.createElement('script');		 
	tag.src = "https://www.youtube.com/iframe_api";
	var firstScriptTag = document.getElementsByTagName('script')[0];
	firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);  
	
	
	
	var player;
	function onYouTubeIframeAPIReady() {
	  player = new YT.Player('player', {
	    height: '560',
	    width: '1000',
	    videoId: '${requestScope.oneClassView.video}',
	    playerVars: {
            'autoplay': 0,     // 자동실행여부
            'controls': 1,    // 재생컨트롤 노출여부
            'autohide': 2,     // 재생컨트롤이 자동으로 사라질지의 여부
            'rel': 0,     // 동영상 재생완료 후 유사동영상 노출여부
            'wmode': 'transparent'
        },
	    events: {
	      'onReady': onPlayerReady,
	      'onStateChange': onPlayerStateChange
	    }
	  });
	  
	  //window.tmp_obj = player;
	  
	}// end of function onYouTubeIframeAPIReady() {---------------------------------------------
	
	
		
	function onPlayerReady(event) {
	 // event.target.playVideo();
	  //player.mute();
	 /*  var currentTime = player.getCurrentTime();
	  
	  console.log(currentTime); */
	  //console.log((tmp_obj.getDuration())/60);
	  var totalTime = player.getDuration();
	  //console.log(time/60);
	  
	  var min = Math.floor(totalTime/60);
	  //console.log("분 : " +min)
	  
	  var x = totalTime/60;
	  int_part = Math.trunc(x); 
	  
	  var decimals = x - Math.floor(x);
	
	  var decimalPlaces = x.toString().split('.')[1].length;
	  decimals = decimals.toFixed(decimalPlaces);
	  
	  //console.log("decimals : " + decimals)
	  
	  var second = Math.round(decimals*60);
	  //console.log("second 초 : "+ second);
	
	  //float_part = Number((x-int_part).toFixed(3)); // return 0.2  소수점 이하값만 얻어오기
	
	  //console.log(int_part);
	  //console.log(float_part);
	  
	  //var round_float_part = Math.round(float_part*60);
      //console.log(round_float_part);
      
      
      var html = "";
      
      html += "재생시간 "+min+" 분 "+second+" 초";
      
      var html2 = "";
      
      html2 += "학습 진행 상태 : "+min+"분 "+second+"초(100%)";
      
      $("td#playTime").html(html);
     // $("span#classStatus").html(html2);
    	  
    	 
	}// end of function onPlayerReady(event) {--------------------------------------------
	

	
	var done = false;
	var playerState;

	var playNum = 0;
	var check = false;
	
	
	function onPlayerStateChange(event) {
		
		
		  
		  $("span#classStatusCheck").click(function(){
			  
		  
			  
			  var currentTime = player.getCurrentTime();
			  
			  //console.log(currentTime);
			  
			  var currentMin = Math.floor(currentTime/60);
			  console.log(currentMin);
			  
			  var x = currentTime/60;
			  int_part = Math.trunc(x); 
			  
			  var decimals = x - Math.floor(x);
			
			  var decimalPlaces = x.toString().split('.')[1].length;
			  decimals = decimals.toFixed(decimalPlaces);
			  
			  var currentSecond = Math.round(decimals*60);
			  //console.log("currentSecond 초 : "+ currentSecond);
			  
			  
			  var totalTime = player.getDuration();
			  var min = Math.floor(totalTime/60);
			  
			  var progress = Math.round((currentMin/min)*100);
			  
			  
			  var html = "학습 진행 상태 : "+currentMin+"분 "+currentSecond+"초("+progress+"%)";
			  
			  html += ""
			  $("span#classStatus").html(html);
		 
			  })
		  
		
		if (event.data == 0) {
			  check = true;			  
			  goAttend();
        }
		
	/* 	 playerState = event.data == YT.PlayerState.ENDED ? 'end' :

				event.data == YT.PlayerState.PLAYING ? 'playing' :

				event.data == YT.PlayerState.PAUSED ? 'stop' :

				event.data == YT.PlayerState.BUFFERING ? 'buffering' :

				event.data == YT.PlayerState.CUED ? 'playready' :

				event.data == -1 ? 'not start' : 'error';
	  
	  if (playerState == "end") {  			 
			  check = true;			  
			  goAttend();			  
		  }	  	   */
	}// end of function onPlayerStateChange(event) {-----------------------------------------------
	
	
		//출석테이블에 insert
	function goAttend(){
		
		var code = sessionStorage.getItem('code');
	    var week = sessionStorage.getItem('week');
	    var lesson = sessionStorage.getItem('lesson');
	    var lessonseq = sessionStorage.getItem('lessonseq');	
				
		var frm = document.attendFrm
		frm.keycode.value = code;
		frm.keyweek.value = week;
		frm.keylesson.value = lesson;
		frm.keylessonseq.value = lessonseq;
		frm.method="POST";
		frm.action="<%=ctxPath%>/goAttend.univ";
		frm.submit();
	}// end of function goAttend(){------------------------------------------------------------
		
		
		
	//출석테이블 셀렉해서 미수강, 출석완료 표시해주기
	function getAttend(){
		
		$.ajax({
			url:"<%= request.getContextPath()%>/getAttend.univ",
			data:{"fk_lessonseq":$("input#fk_lessonseq").val()
				 ,"fk_hakbun":$("input#fk_hakbun").val()},
			type:"POST",
			dataType:"JSON",
			success:function(json){ 
			   
				var html = "";
				if(json.n == 1){
					
					html += "<button id='attend' style='background-color:#1a75ff; color:white; border-radius: 5px; border:none; font-size:9pt; width:80px; height:30px; margin-right:10px;'>&nbsp;출석 완료&nbsp;</button>"
					
				}
				else{
					html += "<button id='attend' style='background-color:#ff0000; color:white; border-radius: 5px; border:none; font-size:9pt; width:80px; height:30px; margin-right:10px;'>&nbsp;미수강&nbsp;</button>"
				}
				
				$("span#attendCheck").html(html);
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
			
		})
		
	}// end of function getAttend(){----------------------------
	
	
</script>

<i class="hideSubjectMenu fas fa-bars fa-2x" style="float:left; margin-right: 20px; cursor: pointer;"></i>
<h3 style="float:left;"><span style="color: #0099ff; text-decoration: underline;">강의콘텐츠</span></h3>
<hr style="clear: both;">

<form name="attendFrm">
<!-- 출석테이블에 넣기위한것 -->
<input type="hidden" id="fk_lessonseq" name="fk_lessonseq" value="${requestScope.oneClassView.lessonseq}"/>
<input type="hidden" id="fk_hakbun" name="fk_hakbun" value="${sessionScope.loginuser.hakbun }"/>

<input type="hidden" id = "keycode" name="keycode" value=""/>
<input type="hidden" id = "keyweek" name="keyweek" value=""/>
<input type="hidden" id = "keylesson" name="keylesson" value=""/>
<input type="hidden" id = "keylessonseq" name="keylessonseq" value=""/>
</form>

<div class="container" style="margin-top:200px;">
	<div>
		<div class="btn" style=" border:1px solid #DDD; margin-bottom:15px;" onclick="javascript:location.href='<%= request.getContextPath()%>/classContents.univ'">Ξ 목록으로 돌아가기</div><div class="btn btn-secondary" style="display:inline-block; float:right;">학습 종료</div>
	</div>
	
	<table style="width:100%; margin-bottom:50px; font-size:10pt;">
		<tr style="border:0.7px solid #DDD; height:40px;">
			<td style="width:100px; text-align:center; border-right:0.7px solid #DDD;">
				<div class="dropdown">
				  <button class="btn dropdown-toggle" type="button" id="list" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false" style="box-shadow: none;">
				    목차
				  </button>
				  <div class="dropdown-menu" aria-labelledby="list">  <!-- aria-labelledby="dropdownMenuButton"이게 id값 맵핑 해준것!! -->
				  <c:forEach var="classListmap" items="${requestScope.classListbyWeek}">
				    <a class="dropdown-item" href="<%=ctxPath%>/classContentsView.univ?code=${classListmap.code}&week=${classListmap.week}&lesson=${classListmap.lesson}&lessonseq=${classListmap.lessonseq}">${classListmap.lesson}교시</a>
				   </c:forEach>				    
				  </div>
				</div>
			</td>	
			<td style="text-align:right;  border-right:0.7px solid #DDD;">◁이전학습&nbsp;&nbsp;</td>
			<td style="text-align:left;">&nbsp;&nbsp;다음학습▷</td>
		</tr>
	</table>
	
	<div style="font-weight:bold; font-size:15pt; margin-bottom:15px;">
		<img src="<%= ctxPath%>/resources/images/재생버튼.png" style="width:30px;"> ${requestScope.oneClassView.subject } 0${requestScope.oneClassView.week } 주차- ${requestScope.oneClassView.lesson }교시
	</div>
	
	<table style="width:100%; margin-bottom:15px; font-size:10pt; color:gray;">
		<tr style="border-top:0.7px solid #DDD; border-bottom:0.7px solid #DDD; height:40px;">
			<td >출석 마감일 ${requestScope.oneClassView.startday}</td>
			<td >지각 마감일 ${requestScope.oneClassView.endday}</td>
			<td >열람기간 ${requestScope.oneClassView.openday} &nbsp;~&nbsp; ${requestScope.oneClassView.endday}</td>
			<td id="playTime"></td>
		</tr>
	</table>
	<table style="width:100%; font-size:10pt; margin-bottom:20px;">
		<tr style="background-color:#ffe6e6; width:100%; height:40px;">
			<td style="width:100%; color:#ff4d4d; font-weight:bold; padding-left:10px;">※ 지각 인정 기간입니다.</td>
		</tr>
	</table>
	
	
	<div align="center" id="video">
		 <div id="player"></div> 
		<!-- <iframe id="player" type="text/html" width="1000" height="560"
  src="https://www.youtube.com/embed/Nr8eClE0VOU?rel=0amp;contrlos=0&amp;showinfo=0&amp;enablejsapi=1&amp;autoplay=1&amp;version=3&amp;playerapiid=ytplayer"
  frameborder="0" gesture="media" allow="encrypted-media"></iframe>  -->
	
		<%-- <iframe id="classVideo" width="1000" height="560" src="${requestScope.oneClassView.video}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> --%>
	</div>
	
	
	<div style="margin-top:30px; color:gray; margin-bottom:70px;">
	<span id="classStatus">학습 진행 상태 : 0분 0초(0%)</span> 
	<span id="classStatusCheck" class="btn" style=" border:1px solid #DDD; font-size:9pt;"><img src="<%= ctxPath%>/resources/images/새로고침.png" style="width:17px; ">&nbsp;학습상태 확인&nbsp;</span>
	<span id="attendCheck"></span>
	<!-- <button id="attend" style="background-color:#ff0000; color:white; border-radius: 20px; border:none; font-size:9pt; width:80px; height:30px; margin-right:10px;">&nbsp;출석완료&nbsp;</button> -->
	</div>   
	
	
	
	<div style="font-weight:bold; font-size:15pt; margin-bottom:15px;">
		<img src="<%= ctxPath%>/resources/images/요약본3.png" style="width:30px;"> ${requestScope.oneClassView.subject } 0${requestScope.oneClassView.week } 주차- ${requestScope.oneClassView.lesson }차시- 요약본
	</div>
	<table style="width:100%; margin-bottom:15px; font-size:10pt; color:gray;">
		<tr style="border-top:0.7px solid #DDD; border-bottom:0.7px solid #DDD; height:40px;">
			<td >출석 마감일 ${requestScope.oneClassView.startday}</td>
			<td >지각 마감일 ${requestScope.oneClassView.endday}</td>
			<td >열람기간 ${requestScope.oneClassView.openday} &nbsp;~&nbsp; ${requestScope.oneClassView.endday}</td>
			<td>배점 1점</td>
		</tr>
	</table>
	
	<table style="width:100%; font-size:10pt; margin-bottom:15px;">
		<tr style="background-color:#ffe6e6; width:100%; height:40px;">
			<td style="width:100%; color:#ff4d4d; font-weight:bold; padding-left:10px;">※ 지각 인정 기간입니다.</td>
		</tr>
	</table>
	
	
	
	<!--############# 여기부터 교수님 게시물올리기 및 학생들 댓글 달기 부분 ##############################-->
	
	<c:if test="${sessionScope.loginuser.authority == 1 or  sessionScope.loginuser.authority == 2}">
		<div style="text-align:right; padding-right:10px;"><button class="btn btn-dark" style="margin-bottom:20px;" onclick="javascript:location.href='<%= request.getContextPath()%>/classContentWrite.univ?lessonseq=${requestScope.oneClassView.lessonseq }&code=${requestScope.oneClassView.code}'">게시물 작성</button></div>		
	</c:if>
	
	<c:if test="${not empty requestScope.classContentList}">
		<c:forEach var = "list" items="${requestScope.classContentList}" varStatus="status">
			<table style="width:100%; border:0.5px solid #DDD; margin-bottom:40px;">
				<tr style="background-color:#f2f2f2; height:60px;">
					<td>
						
						<!-- <button style="display:inline-block; float:right; width:30px; background-color:#f2f2f2; border:0.5px solid #DDD; margin-right:10px;">⋮</button> -->
						<c:if test="${sessionScope.loginuser.authority == 1 or  sessionScope.loginuser.authority == 2}">
							<button class="btn btn-dark btn-sm" style="color:black; display:inline-block; float:right; width:130px; background-color:#f2f2f2; border:0.5px solid #DDD; margin-right:10px; font-size:10pt;" onclick="classContentDel(${list.classBoardSeq})">게시물 삭제하기</button>
							<button class="btn btn-dark btn-sm" style="color:black; display:inline-block; float:right; width:130px; background-color:#f2f2f2; border:0.5px solid #DDD; margin-right:10px;" onclick="javascript:location.href='<%= request.getContextPath()%>/classContentEdit.univ?classBoardSeq=${list.classBoardSeq}'">게시물 수정하기</button>
						</c:if>	
					</td>
				</tr>
				<tr style="height:50px;">
					<td >
						<div style="width:99%; height:30px; background-color:#ccefff; border-radius:5px; margin:auto; font-size:10pt; padding-left:10px; padding-top:5px;"><span style="color:#008bcc; font-size:10pt; font-weight:bold;">채점대상 토론입니다.</span> : 1점 가능<div style="display:inline-block; float:right; margin-right:10px;">마감 ${list.enddate}</div></div>
					</td>
				</tr>
				<tr>
					<td>
						<div><div style="display:inline-block; font-size:15pt;"><img src="<%= ctxPath%>/resources/images/회원사진.png" style="width:40px;">${list.subject}<br><span style="color:#1ab6ff; font-size:9pt;">${list.name}</span></div></div>
					</td>
				</tr>
				<tr style="height:200px;">
					<td>
						${list.content}
					</td>
				</tr>
				<tr>
					<td style="font-style:italic; font-size:9pt;">
					이 주제를 <span style="color:blue; font-weight:bold;">${list.name}</span>이(가) 편집함.
					</td>
				</tr>
				<tr>
					<c:if test="${empty list.fileName}">
						<td style="font-style:italic; font-size:9pt;">
							첨부파일이 없습니다.
						</td>
					</c:if>
					
					<c:if test="${not empty list.fileName}">
						<td style="font-style:italic; font-size:9pt;">
							<a href="<%= request.getContextPath()%>/classContentDownload.univ?classBoardSeq=${list.classBoardSeq}">${list.orgFilename}</a>
						</td>
					</c:if>
				</tr>
				
				<c:if test="${status.index==0 }">
				<form name="commentFrm" enctype="multipart/form-data">
					<tr style="height:50px; background-color:#f2f2f2;">
						<td>
						<input type="text" id="searchWord" name="searchWord" placeholder="댓글 작성자 검색 " style="margin-left:10px;"/> 
						</td>
					</tr>				
				
						<tr style="height:60px; border-top:0.5px solid #DDD;">
							<td colspan="2">
								<input type="text" id="commentContent" name="commentContent" placeholder="↖ 댓글작성" style="width:99%; border:0.5px solid #DDD; margin-left:5px; ">
								<input type="hidden" id="fk_classBoardSeq" name="fk_classBoardSeq" value="${list.classBoardSeq}"/>
								<input type="hidden" id="name" name="name" value="${sessionScope.loginuser.name}"/>
								<input type="hidden" id="fk_hakbun" name="fk_hakbun" value="${sessionScope.loginuser.hakbun}"/>
							</td>
						</tr>
						<tr style="padding-bottom:15px; ">
							
							<td style="font-size:10pt; padding-left:8px; ">					
								<span style="margin-right:10px;">파일첨부</span><input type="file" name="attach" id="attach"/>
							</td>
						</tr>
						
						<tr>
							
							<td style="font-size:10pt; padding-right:14px; padding-bottom:15px; text-align:right;">					
								<button type="button" class="btn btn-warning btn-sm" style="margin-right:8px;" onclick="classCommentWrite(${list.classBoardSeq})">작성하기</button>
								<button type="reset" class="btn btn-warning btn-sm">취소</button>
							</td>
						</tr>
					</form>
				</c:if>
			</table>
		
		</c:forEach>
		
		
		
				<!-- 학생들 댓글 들어오는곳 -->
				<div id="commentView">

				</div>
				<div style="display:flex;">
					<div id="pageBar" style="margin:auto;"></div>
				</div>
							
			</c:if>
			
			<c:if test="${empty requestScope.classContentList}">
				<div style="height:250px; display:flex; text-align:center; border-top:0.5px solid #DDD; border-bottom:0.5px solid #DDD;">
					<div style="margin:auto;">등록된 게시물이 없습니다.</div>
				</div>
			</c:if>



</div>