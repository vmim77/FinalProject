package com.spring.univ.service;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.spring.univ.model.*;

@Service
public class DongService implements InterDongService {
//==============================================================================================
	@Autowired
	private InterDongDAO dao;
//==============================================================================================
	
	// === 로그인 처리하기 === //
		@Override
		public MemberVO getLoginMember(Map<String, String> paraMap) {
			
			MemberVO loginuser =  dao.getLoginMember(paraMap);
			
			return loginuser;
		}
//==============================================================================================
		
	// === 담당교수 조회하기 === // 
		@Override
		public List<SubjectVO> getTeacher() {
			
			List<SubjectVO> TeacherList = dao.getTeacher();
			
			return TeacherList;
		}
//==============================================================================================
		// === 개인정보 수정하가 === //
		@Override
		public int MyUpdate(Map<String, String> paraMap) {
			
			int n  = dao.MyUpdate(paraMap);
			
			return n;
		}
		
//==============================================================================================
		
		// === 마이페이지 보여주기 === // 
		@Override
		public List<MemberVO> getMyMember(Map<String, String> paraMap) {
			
			List<MemberVO> MemberList = dao.getMyMember(paraMap);
			
			return MemberList;
		}


//==============================================================================================
	
}//end of public class BoardService implements InterBoardService {

