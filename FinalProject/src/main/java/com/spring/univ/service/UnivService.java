package com.spring.univ.service;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.spring.univ.model.*;

@Service
public class UnivService implements InterUnivService {
//==============================================================================================
	@Autowired
	private InterFreeBoardDAO dao;
//==============================================================================================
	
	// === 로그인 처리하기 === //
		@Override
		public MemberVO getLoginMember(Map<String, String> paraMap) {
			
			MemberVO loginuser =  dao.getLoginMember(paraMap);
			
			return loginuser;
		}
	
	
}//end of public class BoardService implements InterBoardService {
