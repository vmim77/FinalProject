<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<base target="_blank">
<style type="text/css">
	.syllabus, .syllabus_week{width:800px; border-width: 2px; border-collapse: collapse; border-color: black; border-style: solid; font-size: 12px; line-height: 24px; min-height: 24px; margin-top:10px; table-layout: fixed;}
	.syllabus_sub {width:600px; border-width: 1px; border-collapse: collapse; border-color: black; border-style: solid; font-size: 12px; line-height: 24px; min-height: 24px; margin-top:3px;margin-bottom:3px; k-layout: fixed;}
	tr{min-height: 22px; }
	th{border: 1px black solid; text-align: center; font-weight: bold; background-color: #EFEFEF}
	th.no_topLine{border-top:0px black solid;}
	th.no_botLine{border-bottom:0px black solid;}
	td{border: 1px black solid; text-align: left; padding-left: 3px; min-height: 22px; vertical-align: middle; background-color: #FFFFFF}
	td p{min-height: 22px;}
	td pre{margin:auto; min-height: 1px;}
	
	.multi-line {line-height:1.3em; padding-top:4px}		
</style>
<title>강의계획서 보기</title>

<script type="text/javascript" src="../function/common.js"></script>
<script type="text/javascript" src="../function/sortTable.js"></script>
<script>
	function goPrint(){
		
		var src = '';
		if(isCompatibleIE()){
			src = "../rdreport/r_designer_cs.jsp?repo_val1=2021&repo_val2=2&repo_val3=TA04206&repo_val4=01&repo_val5=101349&repo_path=../sbr/sbr3072.mrd";
		}else{
			src = "https://app.kangnam.ac.kr/knumis/rdreport/r_designer_cs.jsp?repo_val1=2021&repo_val2=2&repo_val3=TA04206&repo_val4=01&repo_val5=101349&repo_path=../sbr/sbr3072.mrd";
		}

		openWin('',src,850,630,0,0);

		self.close();
	}
</script>
</head>

<body>


<div align="center" style="font-size: 12px; padding-left:500px; height:12px">
	최초작성일 : 2021/11/13 , 최종수정일 : 2021/11/14
</div>


<div align="center" style="margin-top: 0px; ; overflow-y:scroll;">
	<table class="syllabus">
		<colgroup>
			<col width="10%">
			<col width="7%">
			<col width="10%">
			<col width="20%">
			<col width="16%">
			<col width="8%">
			<col width="21%">
		</colgroup>
		
		<tbody>
			<tr>
				<th colspan="5" rowspan="2"><span style="font-size: 24px;">강 의 계 획 서</span></th>
				<th>년 도</th>
				<td>2021</td>
			</tr>
			<tr>
				<th>학 기</th>
				<td>2 학기</td>
			</tr>
			<tr>
				<th rowspan="2">교과목명</th>
				<th>한글</th>
				<td colspan="2">다이어트비법</td>
				<th rowspan="2">담당교수</th>
				<td rowspan="2" colspan="2">금길영</td>
			</tr>
			<tr>
				<th>영문</th>
				<td colspan="2">Introduction to Management Information System</td>
			</tr>
			<tr>
				<th colspan="2">학수번호-분반</th>
				<td colspan="2">TA04206 - 01</td>
				<th>강의요일교시</th>
				<td colspan="2">(주)월5b6ab,수7ab8a</td>
			</tr>
			<tr>
				<th colspan="2">학점(시간수)</th>
				<td colspan="2">3(3)</td>
				<th>강의실</th>
				<td colspan="2">강의실302</td>
			</tr>			
			<tr>
				<th rowspan="3"colspan="2">개설(이수)구분</th>
				<th>교양</th>
				<td colspan="4">
					<input type="checkbox"  disabled="disabled">기초교양
					<input type="checkbox"  disabled="disabled" style="margin-left:20px">계열교양
					<input type="checkbox"  disabled="disabled" style="margin-left:20px">일반교양
					<input type="checkbox"  disabled="disabled" style="margin-left:20px">균형교양: 
				</td>
			</tr>
			<tr>
				<th>전공</th>
				<td colspan="4">
					<input type="checkbox"  disabled="disabled">학부기초
					<input type="checkbox"  disabled="disabled" style="margin-left:20px">전공기초
					<input type="checkbox" checked disabled="disabled" style="margin-left:20px">전공선택 ( 1 ) 학년
					<input type="checkbox"  disabled="disabled" style="margin-left:20px">전공필수 ( &nbsp; ) 학년					
				</td>				
				
			</tr>
			<tr>
				<th>일반선택</th>
				<td colspan="2">
					<input type="checkbox"  disabled="disabled">교직
					<input type="checkbox"  disabled="disabled" style="margin-left:20px">자유선택
				</td>
				<td colspan="2">학부(과) : IT쌍용학과 </td>
			</tr>
		
			<tr>
				<th rowspan="2" colspan="2">강좌특성</th>
				<td colspan="5">
					<input type="checkbox" checked disabled="disabled">이론강의
					<input type="checkbox"  disabled="disabled" style="margin-left:20px">실험·실습·실기
					<input type="checkbox"  disabled="disabled" style="margin-left:20px">이론/실험·실습병행
					<input type="checkbox"  disabled="disabled" style="margin-left:20px">패스
					<input type="checkbox"  disabled="disabled" style="margin-left:20px">팀티칭
				</td>
			</tr>
			<tr>
				<th>학문특성</th>
				<td></td>
				<th>기타특성</th>				
				<td colspan="2">C러닝</td>
			</tr>
			<tr>
				<th rowspan="2" colspan="2">교수학습<br>방법</th>
				<th colspan="2">표준 교과목운영 기준</th>
				<th colspan="2">학생 자기주도식 수업운영</th>
				<th>현장 연계 방법</th>
			</tr>
			<tr>
				<td colspan="2" style="line-height: 1.0em">
					<input type="checkbox" checked disabled="disabled">강의<br>
					<input type="checkbox"  disabled="disabled">발표<br>
					<input type="checkbox"  disabled="disabled">토론·토의<br>
					<input type="checkbox"  disabled="disabled">협력학습<br>
					<input type="checkbox"  disabled="disabled">문제기반학습<br>
				</td>
				<td colspan="2">
					<input type="checkbox" checked disabled="disabled">문제기반학습(PBL)<br>
					<input type="checkbox"  disabled="disabled">프로젝트기반학습(PBL)<br>
					<input type="checkbox"  disabled="disabled">플립러닝<br>
					<input type="checkbox"  disabled="disabled">K-MOOC<br>
					<input type="checkbox"  disabled="disabled">팀기반학습(TBL)<br>
					<input type="checkbox"  disabled="disabled">블랜디드러닝<br>
					<input type="checkbox"  disabled="disabled">캡스톤디자인<br>
				</td>
				<td>
					<input type="checkbox"  disabled="disabled">현장전문가초청<br>
					<input type="checkbox"  disabled="disabled">현장탐방<br>
					<input type="checkbox" checked disabled="disabled">기타<br>
				</td>
			</tr>
			
			<tr>
				<th colspan="2">전공능력</th>
				<td colspan="2">DB-K,DB-S,DB-A</td>
				<th>성적평가기준</th>
				<td colspan="2">
					상대평가 유형 1

				</td>
			</tr>
			
			<tr>
				<th colspan="2" rowspan="3">연락처</th>
				<th>연구실</th>
				<td></td>
				<th>E-Mail</th>
				<td colspan="2"></td>
				
			</tr>
			<tr>
				<th>휴대전화</th>
				<td></td>
				<th>면담가능시간</th>
				<td colspan="2"></td>
				
			</tr>
			<tr>
				<th>연구일</th>
				<td>요일</td>
				<th>관리부서</th>
				<td colspan="2">
					교학1팀 (031-280-3410 ~ 3)

				</td>
				
			</tr>
			<tr>
				<th colspan="2" rowspan="2">교육과정<br>참고사항</th>
				<th>선수과목</th>
				<td>기업경영과 IT, 전자상거래원론</td>
				<th>관련 기초과목</th>
				<td colspan="2">경영학개론</td>
			</tr>
			<tr>
				<th class="multi-line">동시수강<br>관련과목</th>
				<td></td>
				<th>관련 고급과목</th>
				<td colspan="2">다이어트 비법</td>
			</tr>
			
			<!-- ------------------------------------------------------------------------  -->
			<tr>
				<th colspan="2">교과목 개요</th>
				<td colspan="5">1. 다이어트의 원리
2. 다이어트를 해야하는이유
3. 다이어트 비법
4. 다이어트 플랜</td>
			</tr> 
			<tr>
				<th rowspan="3">교과목<br>운영</th>
				<th>수업목표</th>
				<td colspan="5">- 21세기 다이어트 유행<br>
- 인싸들에 핏 되는법<br>
- 건강의 중요한부분을 차지하는 살 <br>
- 하루 5분만 운동해도 인생이바뀐다<br>
- 나만의 플랜을 만들어서 운동해보자<br>
</td>
			</tr>
			<tr>
				<th class="multi-line">교수학습<br>세부운영<br>방법</th>
				<td colspan="5">- 사례 연구 실전 강의
- 시청각 교육을 통한 현장의 간접 사례 학습
- 인터넷 웹 사이트 탐방을 통한 사례 학습
- 온라인 녹화 강의(75분), 온라인 채팅 질의응답(75분)</td>				
			</tr>
			<tr>
				<th style="border-right:none">평가방법</th>
				<td colspan="5" style="padding: 0px; border-bottom:none">
					<table style="width:100%; border-collapse:collapse; border-width: 0px;">
						<tr>
							<th style="border-top:none; border-left:none" width="15%">중간고사</th>
							<th style="border-top:none; " width="15%">기말고사</th>
							<th style="border-top:none" width="14%">출석</th>
							<th style="border-top:none" width="14%">과제</th>
							<th style="border-top:none" width="14%">퀴즈</th>
							<th style="border-top:none" width="14%">토론</th>
							<th style="border-top:none; border-right:none" width="14%">기타</th>
						</tr>
						<tr>
							<td style="border-left:none">40&nbsp;</td>
							<td>40</td>
							<td>10</td>
							<td>10</td>
							<td></td>
							<td></td>
							<td style="border-right:none"></td>
						</tr>
						<tr>
							<th colspan="2" style="border-left:none; border-bottom:none">과제/퀴즈/토론/기타<br>문제 및 주제</th>
							<td colspan="5" style="border-right:none; border-bottom:none">- 필기시험: 80%(중간고사: 40%, 기말고사: 40%)
- 보고서: 10%
- 출석 및 수업 참여도: 10%</td>
						</tr>
					</table>
				</td>
			</tr>
			
			<!---------------교재 ---------------------- -->
			<tr>
				<th rowspan="2" colspan="2">교재</th>
				<th class="multi-line">주교재<br>(저자,출판사)</th>
				<td colspan="4">- 강의노트 대체</td>
			</tr>
			<tr>
				<th class="multi-line">참고도서<br>(저자,출판사)</th>
				<td colspan="4"> - 김민경의 다이어트는 어렵지않아요  <br>
 - 금길영의 살이 왜찌는지 모르겠어요<br>
 - 장현걸의 소녀소녀 다이어트비법<br>
 - 이재성의 국밥은 살이안쪄요<br>
 - 박성현의 뇌섹남은 다이어트를 하지않는다  <br>
</td>
			</tr>			
			
			<tr>
				<th colspan="2" class="multi-line">장애학생 수업<br>지원안내</th>
				<td colspan="5">학생요구사항의 수용 및 반영<br></td>
			</tr>
			
			
			
		</tbody>
	</table>
	
	<table class="syllabus_week">
		<colgroup>
			<col width="6%"> 
			<col width="34%">
			<col width="24%">
			<col width="18%">
			<col width="18%">
		</colgroup>
		
		<tbody>
			<tr>
				<th colspan="5"><span style="font-size: 18px;">주차별 강의내용</span></th>
			</tr>
			<tr>
				<th>주차</th>
				<th>학습주제</th>
				<th>수업방식/이용기자재</th>
				<th>교수학습자료</th>
				<th>과제</th>
			</tr>
			
			<tr>
				<th>1</th>
				<td>개별 인바디 측정</td>
				<td>강의 / Zoom</td>
				<td>매주 e-학습도우미에 PPT 자료 제공</td>
				<td>과제는 중간고사 이전과 이후에 각각 1번씩 2회 부여할 예정임 </td>
			</tr>
			
			<tr>
				<th>2</th>
				<td>전신운동법 PT체조</td>
				<td>강의 및 토론 / Zoom</td>
				<td></td>
				<td>  </td>
			</tr>
			
			<tr>
				<th>3</th>
				<td>개별 목표 플랜 작성하기<br></td>
				<td>강의 및 토론 / Projector</td>
				<td></td>
				<td>  </td>
			</tr>
			
			<tr>
				<th>4</th>
				<td>다이어트 원리 및 공부방법 </td>
				<td>강의 및 토론 / Projector</td>
				<td></td>
				<td>  </td>
			</tr>
			
			<tr>
				<th>5</th>
				<td>개별 식단 및 운동방법 공부하기 </td>
				<td>강의 및 토론 / Projector</td>
				<td></td>
				<td>  </td>
			</tr>
			
			<tr>
				<th>6</th>
				<td>3분할 운동법 교육 및 코칭 </td>
				<td>강의 및 토론 / Projector</td>
				<td></td>
				<td>  </td>
			</tr>
			
			<tr>
				<th>7</th>
				<td>중간고사</td>
				<td>강의 및 토론 / Projector</td>
				<td></td>
				<td> </td>
			</tr>
			
			<tr>
				<th>8</th>
				<td>인바디 2차 측정</td>
				<td>강의 및 토론 / Projector</td>
				<td></td>
				<td>  </td>
			</tr>
			
			<tr>
				<th>9</th>
				<td>기구 원리 및 체력측정 </td>
				<td>강의 및 토론 / Projector</td>
				<td></td>
				<td>  </td>
			</tr>
			
			<tr>
				<th>10</th>
				<td>체력의 중요성</td>
				<td>강의 및 토론 / Projector</td>
				<td></td>
				<td>  </td>
			</tr>
			
			<tr>
				<th>11</th>
				<td>원하는 몸 만들기 시작</td>
				<td>강의 및 토론 / Projector</td>
				<td></td>
				<td>  </td>
			</tr>
			
			<tr>
				<th>12</th>
				<td>원하는 몸 만들기 시작 2</td>
				<td>강의 및 토론 / Projector</td>
				<td></td>
				<td>  </td>
			</tr>
			
			<tr>
				<th>13</th>
				<td>중간 측정 및 확인 </td>
				<td>강의 및 토론 / Projector</td>
				<td></td>
				<td>  </td>
			</tr>
			
			<tr>
				<th>14</th>
				<td> 원하는 몸 만들기 시작 3</td>
				<td>강의 및 토론 / Projector</td>
				<td></td>
				<td>  </td>
			</tr>
			
			<tr>
				<th>15</th>
				<td>기말고사</td>
				<td>강의 및 토론 / Projector</td>
				<td></td>
				<td> </td>
			</tr>

		</tbody>
	</table>
</div>
</body>
</html>
