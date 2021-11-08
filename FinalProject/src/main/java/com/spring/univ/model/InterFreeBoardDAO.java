package com.spring.univ.model;

import java.util.*;

public interface InterFreeBoardDAO {

	// 로그인 처리
	MemberVO getLoginMember(Map<String, String> paraMap);

	// 맴버 조회하기
	MemberVO getMember(Map<String, String> paraMap);
	
	
	
}//end of public interface InterBoardDAO {
