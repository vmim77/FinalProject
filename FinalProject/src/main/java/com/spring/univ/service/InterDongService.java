package com.spring.univ.service;

import java.util.*;
import com.spring.univ.model.MemberVO;
import com.spring.univ.model.SubjectVO;

public interface InterDongService {
		
	// 로그인 처리하기
	MemberVO getLoginMember(Map<String, String> paraMap);

	// 담당교수 조회하기
	List<SubjectVO> getTeacher();

	
}//end of public interface InterBoardService {
