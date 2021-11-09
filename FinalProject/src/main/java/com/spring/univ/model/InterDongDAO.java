package com.spring.univ.model;

import java.util.*;

public interface InterDongDAO {

	// 로그인 처리
	MemberVO getLoginMember(Map<String, String> paraMap);

	// 담당교수 조회하기
	List<SubjectVO> getTeacher();

	
	
}//end of public interface InterBoardDAO {
