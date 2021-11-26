<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

#contents {
   /*  position: relative; */
    margin: auto;
    min-height: 1500px;
}

.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-zv4m{border-color:#000000;text-align:left;vertical-align:top}
.tg .tg-8jgo{border-bottom:hidden;text-align:center;vertical-align:top}
.tg .tg-ofj5{border-top:hidden;text-align:right;vertical-align:top}

label.title{
	font-weight: bold;
}

button#btnok {
	width: 60px;
	height: 30px;
	margin-left: 93%;
}

</style>

<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	
	var outcome = "";
	var cnt = 0;
	
	$("button#btnok").click(function(){

		for(var i=1; i<=12; i++){
			
			$("input:radio[name = reply"+i+"]").each(function(){
				
				// 체크박스의 체크유무 검사
				if($(this).is(":checked")){
					
					outcome += $(this).val() + ",";
					cnt++;
				}
				
			});
			
			
			
		}
		
		if(cnt != 12){
			alert("다 체크하세요");
			cnt = 0;
		}
		else{
	
			$.ajax({
	            url:"<%= request.getContextPath()%>/Seolmoon2.univ",
	            type:"POST",
	            data:{"outcome":outcome},
	            dataType:"JSON",
	            success:function(json){
	               
	              if(json.n == "1"){ // json.m으로 변경
	            	  alert("제출이 완료되었습니다");
	            	  location.href="<%= ctxPath%>/Myinfo.univ";
	              }
	              else {
	            	  alert("제출이 실패하였습니다.");
	            	  location.reload();
	              }
	                    
	            },
	            error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	             }
	            
	         });//end of $.ajax({-------------------------------------------------------- 
		}
	
	});// end of $("button#btnOK").click(function(){}----------------------------------
	
	   
	});// end of $(document).ready(function(){

</script>



<div style="display: flex;">
	<div  id="contents" style="margin: auto;">
		<div class="titleArea" style="margin-top: 80px;">
			<h2 style="font-size: 28pt; font-weight: bold; text-align: center;">쌍용대학교 취업지원시스템 설문 조사</h2>
		</div>
		<br><br>
	<div class="typeWrite ">
		<table class="tg" style="margin: auto;">
		<thead>
		  <tr>
		    <th class="tg-8jgo"><span style="font-weight:bold;text-decoration:underline">쌍용대학교 취업지원시스템 만족도 및 취업 준비 현황 조사</span></th>
		  </tr>
		</thead>
		<tbody>
		  <tr>
		    <td class="tg-zv4m"><br>안녕하십니까? 바쁘신 와중에 시간을 내어주셔서 감사합니다.<br>본 설문조사는 본교 취업지원시스템 만족도 및 취업 준비 현황 파악을 목적으로 실시하는 설문조사입니다.<br>설문에는 정답이나 오답이 없으며, 단지 귀하의 생각을 표현하는 것이므로 솔직하게 답변해주실 것을 <br>부탁드립니다. 작성하신 모든 문장은 통계법 30조에 의거하여 철저히 익명성이 보장되며, <br>통계적 자료는 실태파악 목적으로만 사용할 것을 약속드립니다.<br>감사합니다.<br></td>
		  </tr>
		  <tr>
		    <td class="tg-ofj5">2021년 12월 1일<br>쌍용대학교 취업지원관리센터<br>(☎ 02-336-8546 , email:ssangyong@naver.com)</td>
		  </tr>
		</tbody>
		</table>

		<br><br>
		
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문1] 귀하의 성별은?</label> <br>
				<label for="men">&nbsp;&nbsp;1.남자</label> <input type="radio" name="reply1" id="men" value="1.남자" />
				<label for="female">&nbsp;&nbsp;2.여자</label> <input type="radio" name="reply1" id="female" value="2.여자" />
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문2] 현재 귀하의 전공은?</label> <br>
				<label for="moon">&nbsp;&nbsp;1.인문사회계열</label> <input type="radio" name="reply2" id="moon" value="1.인문사회계열"/>
				<label for="lee">&nbsp;&nbsp;2.이공계열</label> <input type="radio" name="reply2" id="lee" value="2.이공계열"/>
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문3] 현재 귀하의 학년은?</label> <br>
				<label for="1">&nbsp;&nbsp;1.1학년</label> <input type="radio" name="reply3" id="1" value="1.1학년"/>
				<label for="2">&nbsp;&nbsp;2.2학년</label> <input type="radio" name="reply3" id="2" value="2.2학년"/>
				<label for="3">&nbsp;&nbsp;3.3학년</label> <input type="radio" name="reply3" id="3" value="3.3학년"/>
				<label for="4">&nbsp;&nbsp;4.4학년</label> <input type="radio" name="reply3" id="4" value="4.4학년"/>
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문4] 졸업후 희망하는 진로는? (가장 중요한 것 1개만 선택)</label> <br>
				<label for="business">&nbsp;&nbsp;1.사업(창업)</label> <input type="radio" name="reply4" id="business" value="1.사업(창업)"/>
				<label for="worker">&nbsp;&nbsp;2.회사원(취업)</label> <input type="radio" name="reply4" id="worker" value="2.회사원(취업)"/>
				<label for="official">&nbsp;&nbsp;3.공무원</label> <input type="radio" name="reply4" id="official" value="3.공무원"/>
				<label for="schooll">&nbsp;&nbsp;4.대학원</label> <input type="radio" name="reply4" id="schooll" value="4.대학원"/>
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문5] 현재 졸업후 진로에 대한 준비 정도는?</label> <br>
				<label for="now">&nbsp;&nbsp;1.현재 준비하고 있다.</label> <input type="radio" name="reply5" id="now" value="1.현재 준비하고 있다."/>
				<label for="soon">&nbsp;&nbsp;2.곧 준비하려고 한다.</label> <input type="radio" name="reply5" id="soon" value="2.곧 준비하려고 한다."/>
				<label for="yet">&nbsp;&nbsp;3.아직 준비를 하지 않고 있다.</label> <input type="radio" name="reply5" id="yet" value="3.아직 준비를 하지 않고 있다."/>
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문6] 귀하가 취업을 목적으로 해본 활동은? (가장 중요한 것 1개만 선택)</label> <br>
				<label for="english">&nbsp;&nbsp;1.TOEIC/TOEFL</label> <input type="radio" name="reply6" id="english" value="1.TOEIC/TOEFL"/>
				<label for="glicense">&nbsp;&nbsp;2.각종 자격증 취득</label> <input type="radio" name="reply6" id="glicense" value="2.각종 자격증 취득"/>
				<label for="lecture">&nbsp;&nbsp;3.관련 학원 수강</label> <input type="radio" name="reply6" id="lecture" value="3.관련 학원 수강"/>
				<label for="presentation">&nbsp;&nbsp;4.설명회 참관</label> <input type="radio" name="reply6" id="presentation" value="4.설명회 참관"/>
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문7] 귀하가 취업을 위해 현재 가장 우선적으로 준비하고 있는 스펙을 골라주십시오.</label> <br>
				<label for="hakjum">&nbsp;&nbsp;1.학점관리</label> <input type="radio" name="reply7" id="hakjum" value="1.학점관리"/>
				<label for="toeic">&nbsp;&nbsp;2.공인어학점수</label> <input type="radio" name="reply7" id="toeic" value="2.공인어학점수"/>
				<label for="license">&nbsp;&nbsp;3.자격증</label> <input type="radio" name="reply7" id="license" value="3.자격증"/>
				<label for="activity">&nbsp;&nbsp;4.대외활동 및 공모전</label> <input type="radio" name="reply7" id="activity" value="4.대외활동 및 공모전"/>
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문8] 귀하는 취업에 있어 개인의 능력과 학교의 지원 중 어느 부분이 더 중요하다고 생각합니까?</label> <br>
				<label for="personal">&nbsp;&nbsp;1.개인의 능력</label> <input type="radio" name="reply8" id="personal" value="1.개인의 능력"/>
				<label for="school">&nbsp;&nbsp;2.학교의 지원</label> <input type="radio" name="reply8" id="school" value="2.학교의 지원"/>
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문9] 귀하는 본교에서 실시하는 취업지원프로그램들을 알고 있습니까?</label> <br>
				<label for="know">&nbsp;&nbsp;1.잘 알고 있다.</label> <input type="radio" name="reply9" id="know" value="1.잘 알고 있다."/>
				<label for="listen">&nbsp;&nbsp;2.들어본적 있다.</label> <input type="radio" name="reply9" id="listen" value="2.들어본적 있다."/>
				<label for="not">&nbsp;&nbsp;3.잘 모른다.</label> <input type="radio" name="reply9" id="not" value="3.잘 모른다."/>
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문10] 본교에서 실시하는 취업지원프로그램 중 참여한 경험이 있는 프로그램을 골라주십시오</label> <br>
				<label for="group">&nbsp;&nbsp;1.취업동아리</label> <input type="radio" name="reply10" id="group" value="1.취업동아리"/>
				<label for="camp">&nbsp;&nbsp;2.취업캠프</label> <input type="radio" name="reply10" id="camp" value="2.취업캠프"/>
				<label for="internship">&nbsp;&nbsp;3.현장실습 및 인턴십</label> <input type="radio" name="reply10" id="internship" value="3.현장실습 및 인턴십"/>
				<label for="slecture">&nbsp;&nbsp;4.초청 특강</label> <input type="radio" name="reply10" id="lecture" value="4.초청 특강"/> <br>
				<label for="sprogram">&nbsp;&nbsp;5.학과 자체 프로그램</label> <input type="radio" name="reply10" id="sprogram" value="5.학과 자체 프로그램"/>
				<label for="consult ">&nbsp;&nbsp;6.지도교수 상담</label> <input type="radio" name="reply10" id="consult " value="6.지도교수 상담"/>
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문11] 현재 본교에서 실시하는 취업지원프로그램에 대해 얼마나 만족하십니까?</label> <br>
				<label for="know2">&nbsp;&nbsp;1.만족한다.</label> <input type="radio" name="reply11" id="know2" value="1.만족한다."/>
				<label for="listen2">&nbsp;&nbsp;2.보통이다.</label> <input type="radio" name="reply11" id="listen2" value="2.보통이다."/>
				<label for="not2">&nbsp;&nbsp;3.만족하지 않는다.</label> <input type="radio" name="reply11" id="not2" value="3.만족하지 않는다."/>
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문12] 현재 우리 대학교가 취업을 위해 최우선으로 신경 써야 할 사항은 무엇이라고 생각합니까?</label> <br>
				<label for="fee">&nbsp;&nbsp;1.각종 자격증 응시료 지원 확대</label> <input type="radio" name="reply12" id="fee" value="1.각종 자격증 응시료 지원 확대"/>
				<label for="increase ">&nbsp;&nbsp;2.취업 특강 횟수 증대</label> <input type="radio" name="reply12" id="increase " value="2.취업 특강 횟수 증대"/>
				<label for="study">&nbsp;&nbsp;3.스터디 공간 확충</label> <input type="radio" name="reply12" id="study" value="3.스터디 공간 확충"/><br>
				<label for="club">&nbsp;&nbsp;4.취업 동아리 지원 확대</label> <input type="radio" name="reply12" id="club" value="4.취업 동아리 지원 확대"/>
				<br><br>
			</li>	
		</ul>
		
		<p style="float: right; font-weight: bold;">응답해주셔서 감사합니다.</p>

		<br><br><br>
 		<button id="btnok">제출</button>

</div>
</div>
</div>