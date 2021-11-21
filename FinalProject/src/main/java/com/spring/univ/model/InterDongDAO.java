package com.spring.univ.model;

import java.util.*;

public interface InterDongDAO {

	// 로그인 처리
	MemberVO getLoginMember(Map<String, String> paraMap);

	// 담당교수 조회하기
	List<SubjectVO> getTeacher();

	// 개인정보 수정하기
	int MyUpdate(Map<String, String> paraMap);

	// 마이페이지 보여주기
	List<MemberVO> getMyMember(Map<String, String> paraMap);

	// 내가 신청한 전공평가 가져오기
	List<Map<String, String>> getServeyList(String hakbun);

	// 강의평가 했는지 확인하기
	String getServeyMemberList(Map<String, String> paraMap);


	
}//end of public interface InterBoardDAO {

