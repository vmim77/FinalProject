<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<style type="text/css">

#contents {
   /*  position: relative; */
    margin: auto;
    min-height: 1100px;
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

button {
	width: 60px;
	height: 30px;
	float: center;
}

</style>


<script type="text/javascript">

   $(document).ready(function(){
      
   
   });

</script>



<div style="display: flex;">
	<div  id="contents" style="margin: auto;">
		<div class="titleArea" style="margin-top: 80px;">
			<h2 style="font-size: 28pt; font-weight: bold; text-align: center;">쌍용대학교 취업지원시스템 설문 조사</h2>
		</div>
		<br><br>
	<div class="typeWrite ">

	<form name="serveyFrm" action="Myinfo.univ">
	
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
				<label for="men">&nbsp;&nbsp;1. 남자</label> <input type="radio" name="gender" id="men" />
				<label for="female">&nbsp;&nbsp;2. 여자</label> <input type="radio" name="gender" id="female" />
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문2] 현재 귀하의 전공은?</label> <br>
				<label for="moon">&nbsp;&nbsp;1. 인문사회계열</label> <input type="radio" name="major" id="moon" />
				<label for="lee">&nbsp;&nbsp;2. 이공계열</label> <input type="radio" name="major" id="lee" />
				<label for="elseee">&nbsp;&nbsp;3. 기타</label> <input type="radio" name="major" id="elseee" />
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문3] 현재 귀하의 학년은?</label> <br>
				<label for="1">&nbsp;&nbsp;1. 1학년</label> <input type="radio" name="grade" id="1" />
				<label for="2">&nbsp;&nbsp;2. 2학년</label> <input type="radio" name="grade" id="2" />
				<label for="3">&nbsp;&nbsp;3. 3학년</label> <input type="radio" name="grade" id="3" />
				<label for="4">&nbsp;&nbsp;4. 4학년</label> <input type="radio" name="grade" id="4" />
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문4] 졸업후 희망하는 진로는? (가장 중요한 것 1개만 선택)</label> <br>
				<label for="business">&nbsp;&nbsp;1. 사업(창업)</label> <input type="radio" name="job" id="business" />
				<label for="worker">&nbsp;&nbsp;2. 회사원(취업)</label> <input type="radio" name="job" id="worker" />
				<label for="official">&nbsp;&nbsp;3. 공무원</label> <input type="radio" name="job" id="official" />
				<label for="schooll">&nbsp;&nbsp;4. 대학원</label> <input type="radio" name="job" id="schooll" />
				<label for="elsee">&nbsp;&nbsp;5. 기타</label> <input type="radio" name="job" id="elsee" />
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문5] 현재 졸업후 진로에 대한 준비 정도는?</label> <br>
				<label for="now">&nbsp;&nbsp;1. 현재 준비하고 있다.</label> <input type="radio" name="ready" id="now" />
				<label for="soon">&nbsp;&nbsp;2. 곧 준비하려고 한다.</label> <input type="radio" name="ready" id="soon" />
				<label for="yet">&nbsp;&nbsp;3. 아직 준비를 하지 않고 있다.</label> <input type="radio" name="ready" id="yet" />
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문6] 귀하가 취업을 목적으로 해본 활동은? (가장 중요한 것 1개만 선택)</label> <br>
				<label for="english">&nbsp;&nbsp;1. TOEIC/TOEFL</label> <input type="radio" name="activity" id="english" />
				<label for="glicense">&nbsp;&nbsp;2. 각종 자격증 취득</label> <input type="radio" name="activity" id="glicense" />
				<label for="lecture">&nbsp;&nbsp;3. 관련 학원 수강</label> <input type="radio" name="activity" id="lecture" />
				<label for="presentation">&nbsp;&nbsp;4. 설명회,박람회 참관</label> <input type="radio" name="activity" id="presentation" />
				<label for="else">&nbsp;&nbsp;5. 기타</label> <input type="radio" name="activity" id="else" />
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문7] 귀하가 취업을 위해 현재 가장 우선적으로 준비하고 있는 스펙을 골라주십시오.</label> <br>
				<label for="hakjum">&nbsp;&nbsp;1. 학점관리</label> <input type="radio" name="spec" id="hakjum" />
				<label for="toeic">&nbsp;&nbsp;2. 공인어학점수</label> <input type="radio" name="spec" id="toeic" />
				<label for="license">&nbsp;&nbsp;3. 자격증</label> <input type="radio" name="spec" id="license" />
				<label for="activity">&nbsp;&nbsp;4. 대외활동 및 공모전</label> <input type="radio" name="spec" id="activity" />
				<label for="els">&nbsp;&nbsp;5. 기타</label> <input type="radio" name="spec" id="els" />
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문8] 귀하는 취업에 있어 개인의 능력과 학교의 지원 중 어느 부분이 더 중요하다고 생각합니까?</label> <br>
				<label for="personal">&nbsp;&nbsp;1. 개인의 능력</label> <input type="radio" name="important" id="personal" />
				<label for="school">&nbsp;&nbsp;2. 학교의 지원</label> <input type="radio" name="important" id="school" />
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문9] 귀하는 본교에서 실시하는 취업지원프로그램들을 알고 있습니까?</label> <br>
				<label for="know">&nbsp;&nbsp;1. 잘 알고 있다.</label> <input type="radio" name="program" id="know" />
				<label for="listen">&nbsp;&nbsp;2. 들어본적 있다.</label> <input type="radio" name="program" id="listen" />
				<label for="not">&nbsp;&nbsp;3. 잘 모른다.</label> <input type="radio" name="program" id="not" />
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문10] 본교에서 실시하는 취업지원프로그램 중 참여한 경험이 있는 프로그램을 골라주십시오</label> <br>
				<label for="group">&nbsp;&nbsp;1. 취업동아리</label> <input type="radio" name="join" id="group" />
				<label for="camp">&nbsp;&nbsp;2. 취업캠프</label> <input type="radio" name="join" id="camp" />
				<label for="internship">&nbsp;&nbsp;3. 현장실습 및 인턴십</label> <input type="radio" name="join" id="internship" />
				<label for="slecture">&nbsp;&nbsp;4. 초청 특강</label> <input type="radio" name="join" id="lecture" /> <br>
				<label for="sprogram">&nbsp;&nbsp;5. 학과 자체 프로그램</label> <input type="radio" name="join" id="sprogram" />
				<label for="consult ">&nbsp;&nbsp;6. 취업지원실 및 지도교수 방문 상담</label> <input type="radio" name="join" id="consult " />
				<label for="ele">&nbsp;&nbsp;7. 기타</label> <input type="radio" name="join" id="ele" />
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문11] 현재 본교에서 실시하는 취업지원프로그램에 대해 얼마나 만족하십니까?</label> <br>
				<label for="know">&nbsp;&nbsp;1. 만족한다.</label> <input type="radio" name="satisfaction" id="know" />
				<label for="listen">&nbsp;&nbsp;2. 보통이다.</label> <input type="radio" name="satisfaction" id="listen" />
				<label for="not">&nbsp;&nbsp;3. 만족하지 않는다.</label> <input type="radio" name="satisfaction" id="not" />
				<br><br>
			</li>	
		</ul>
		<ul style="list-style-type: none;">
			<li>
				<label class="title">[설문12] 현재 우리 대학교가 취업을 위해 최우선으로 신경 써야 할 사항은 무엇이라고 생각합니까?</label> <br>
				<label for="fee">&nbsp;&nbsp;1. 각종 자격증 응시료 지원 확대</label> <input type="radio" name="first" id="fee" />
				<label for="increase ">&nbsp;&nbsp;2. 취업 특강 횟수 증대</label> <input type="radio" name="first" id="increase " />
				<label for="study">&nbsp;&nbsp;3. 스터디 공간 확충</label> <input type="radio" name="first" id="study" /><br>
				<label for="club">&nbsp;&nbsp;4. 취업 동아리 지원 확대</label> <input type="radio" name="first" id="club" />
				<label for="el">&nbsp;&nbsp;5. 기타</label> <input type="radio" name="first" id="el" />
				<br><br>
			</li>	
		</ul>
		
		<p style="float: right; font-weight: bold;">응답해주셔서 감사합니다.</p>

		<br><br><br>
 		<button type="submit">제출</button>

 
	</form>
		

</div>
</div>
</div>