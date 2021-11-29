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
		public List<Map<String, String>> getTeacher(Map<String,String> paraMap) {
			
			List<Map<String, String>> TeacherList = dao.getTeacher(paraMap);
			
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
		
		// === 사진추가하기 === //

		@Override
		public int getPicture(MemberVO membervo) {
			
			int n = dao.getPicture(membervo);
			return n;
		}
//==============================================================================================
		// === 시간표 조회하기 === //

		@Override
		public List<SubjectVO> getselectSugangList(Map<String, String> paraMap) {
			
			List<SubjectVO> selectSugangList = dao.getselectSugangList(paraMap);
			return selectSugangList;
		}
//==============================================================================================

		// === 비밀번호 찾기 완료
		@Override
		public String getpwdFindEnd(Map<String, String> paraMap) {

			String pwd = dao.getpwdFindEnd(paraMap);
			
			return pwd;
		}

//==============================================================================================

		
		// 내가 신청한 전공평가 가져오기
		@Override
		public List<Map<String, String>> getServeyList(String hakbun) {
			  List<Map<String, String>> serveyList = dao.getServeyList(hakbun);
			return serveyList;
		}
//==============================================================================================
		 // 강의평가 했는지 확인하기
		@Override
		public String getServeyMemberList(Map<String, String> paraMap) {
			String serveyDate = dao.getServeyMemberList(paraMap);
			return serveyDate;
		}

//==============================================================================================
		// 설문조사 가져오기
		@Override
		public List<ServeyVO> getSeolmoonList() {
			List<ServeyVO> seolmoonList = dao.getSeolmoonList();
			return seolmoonList;
		}

//==============================================================================================
		// 설문조사 했는지 확인하기
		@Override
		public String getSeolmoonMemberList(Map<String, String> paraMap) {
			String seolmoonDate = dao.getSeolmoonMemberList(paraMap);
			return seolmoonDate;
		}



//==============================================================================================
	
}//end of public class BoardService implements InterBoardService {
