package com.spring.univ.service;

import java.util.*;

import com.spring.univ.model.DepartmentVO;
import com.spring.univ.model.MemberVO;
import com.spring.univ.model.SubjectVO;

public interface InterGillService {
		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// === 관리자 모드 === //
	
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

	
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
}//end of public interface InterBoardService {
