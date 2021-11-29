package com.spring.univ.model;

import java.util.*;

public interface InterGillDAO {

	// 학생 리스트 가져오기
	List<MemberVO> getStudentList(Map<String, String> paraMap);

	// 과목 리스트 가져오기
	List<SubjectVO> getSubjectList(Map<String, String> paraMap);

	// 학과 및 학과번호 가져오기
	List<DepartmentVO> getDeptList();

	// 새로운 회원 입력하기
	int UpdateMember(Map<String, String> paraMap);

	// 학번 중복여부 가져오기
	String getcheckHakbun(Map<String, String> paraMap);

	// 담당교수 가져오기
	List<MemberVO> getTeacherList(Map<String, String> paraMap);

	// 새로운 전공 입력하기
	int UpdateSubject(Map<String, String> paraMap);

	// 과목명 중복여부 가져오기
	String getcheckSubject(Map<String, String> paraMap);

	// 학과코드 중복여부 가져오기
	String getcheckCode(Map<String, String> paraMap);

	// 상태 수정하기
	int UpdateStatus(Map<String, String> paraMap);

	// 교수님 스케줄 조회해오기
	List<SubjectVO> getTeacherScheduleList(Map<String, String> paraMap);

	// 과 선택시 수강 미신청 인원 알아오기
	List<Map<String, String>> getsugangNoMemberList(Map<String, String> paraMap);

	// 과 선택시 수강 신청 인원 알아오기
	List<Map<String, String>> getsugangYesMemberList(Map<String, String> paraMap);

	// 과 선택시 해당과 시간표 알아오기
	List<SubjectVO> getsugangSubjectList(Map<String, String> paraMap);

	// 수업 선택시 해당 요일 알아오기
	String getsubjectClassDate(Map<String, String> paraMap);

	// 전공신청 안한 학생한명 알아오기
	List<MemberVO> getsearchNoMemberList(Map<String, String> paraMap);

	// 수강신청 저장
	void SaveSugang(Map<String, String> paraMap);

	// 전공신청 한 학생한명 알아오기
	List<Map<String, String>> getselectSugangMemberList(Map<String, String> paraMap);

	// 수강하지 않는 과목 가져와서 값 넣어주기
	List<Map<String, String>> getsugangNoSubjectList(Map<String, String> paraMap);

	// 우선 해당 학번이 가지고 있는 수강목록 전부 지우기
	int DeleteSugang(String hakbun);

	// 전공 수정 전 먼저 지워주기
	void DeleteSubject(Map<String, String> paraMap);

	// 각 문제 별 체크한 문항번호 가져오기
	String getCheckNum(Map<String, String> map);

	// 교수 담당수업 가져오기
	List<SubjectVO> getserveySubject(Map<String, String> paraMap);

	// 평가문항 가져오기
	List<Map<String, String>> getPyungga(Map<String, String> paraMap);

	// 설문 가져오기
	List<ServeyVO> getServeyList();

	// 설문 문항 가져오기
	List<ServeyDetailVO> getSulmoonMoonhangList(Map<String, String> paraMap);

	// 설문 분석대상 문항가져오기
	List<ServeyResultVO> getBoonsukList(Map<String, String> paraMap);
	
	// 총 몇개인지 설문분석 결과값 가져오기
	String getResult(Map<String, String> map);
	
	// 쪽지 발신함 가져오기
	List<Map<String, String>> getSenderList(Map<String, String> map);

	// 쪽지 수신함 가져오기
	List<Map<String, String>> getReceiveList(Map<String, String> map1);

	// 연락처 가져오기
	List<Map<String, String>> getContactList();

	// 발신함 삭제하기
	int jjokjiDel(Map<String, String[]> map);

	// 즐겨찾기 목록 가져오기
	List<Map<String, String>> getStarList(Map<String, String> map2);

	// 즐겨찾기 등록하기
	int jjokjiStar(Map<String, String[]> map);

	// 즐겨찾기 등록해제
	int jjokjiStarNo(Map<String, String[]> map);

	// 쪽지보내기 (첨부파일이 없는경우)
	int adminSendJjokji(Map<String, String> map);

	// 쪽지보내기 (첨부파일이 있는경우)
	int adminSendJjokji_withFile(JjokjiVO jjokjivo);

	// 쪽지 첨부파일 다운로드 받기
	JjokjiVO getAdminJjokjiList(Map<String, String> paraMap);

	// 파일 삭제를 위해 파일있는지 확인해오기
	String getDelFileSelect(String jseq);

}//end of public interface InterBoardDAO {
