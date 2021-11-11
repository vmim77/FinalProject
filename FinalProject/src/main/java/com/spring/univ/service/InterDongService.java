package com.spring.univ.service;

import java.util.*;
import com.spring.univ.model.MemberVO;
import com.spring.univ.model.SubjectVO;

public interface InterDongService {
		
	// 로그인 처리하기
	MemberVO getLoginMember(Map<String, String> paraMap);

	// 담당교수 조회하기
	List<SubjectVO> getTeacher();

	// 개인정보 수정하기
	int MyUpdate(Map<String, String> paraMap);

	// 마이페이지 보여주기
	List<MemberVO> getMyMember(Map<String, String> paraMap);


	
}//end of public interface InterBoardService {
