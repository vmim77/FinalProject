package com.spring.univ.service;

import java.util.*;

import com.spring.univ.model.FreeBoardVO;
import com.spring.univ.model.FreeCommentVO;
import com.spring.univ.model.MemberVO;

public interface InterUnivService {
		
	//로그인 처리하기
	MemberVO getLoginMember(Map<String, String> paraMap);

	// 맴버 조회하기
	MemberVO getMember(Map<String, String> paraMap);
	
}//end of public interface InterBoardService {
