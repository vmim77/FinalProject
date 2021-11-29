package com.spring.univ.model;

import java.util.*;
import javax.annotation.Resource;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class DongDAO implements InterDongDAO {

	@Resource
	private SqlSessionTemplate sqlsession2; // 원격DB에 연결
//================================================================================================
	// === 로그인 처리하기 === //
	@Override
	public MemberVO getLoginMember(Map<String, String> paraMap) {

		MemberVO loginuser = sqlsession2.selectOne("Dong.getLoginMember",paraMap);
		
		return loginuser;
	}
//================================================================================================
	@Override
	public List<Map<String, String>> getTeacher(Map<String,String>paraMap) {

		List<Map<String, String>> TeacherList = sqlsession2.selectList("Dong.getTeacher",paraMap);
		
		return TeacherList;
	}
//=================================================================================================
	// === 개인정보 수정하기 === //
	@Override
	public int MyUpdate(Map<String, String> paraMap) {
		
		int n = sqlsession2.update("Dong.MyUpdate", paraMap);
		
		return n;
	}
//=================================================================================================
	
	// === 마이페이지 보여주기 === //
	@Override
	public List<MemberVO> getMyMember(Map<String, String> paraMap) {
		
		List<MemberVO> MemberList = sqlsession2.selectList("Dong.getMyMember", paraMap);
		
		return MemberList;
	}
//=================================================================================================
	
	
	@Override
	public int getPicture(MemberVO membervo) {
		
		int n = sqlsession2.update("Dong.getPicture",membervo);
		return n;
	}
//=================================================================================================
	// 시간표 보여주기
	@Override
	public List<SubjectVO> getselectSugangList(Map<String, String> paraMap) {
		
		List<SubjectVO> getselectSugangList = sqlsession2.selectList("Dong.getselectSugangList", paraMap);
		
		
		return getselectSugangList;
	}
	
	
	
//=================================================================================================
	// 비밀번호 찾기 완료
	@Override
	public String getpwdFindEnd(Map<String, String> paraMap) {
		
		String pwd = sqlsession2.selectOne("Dong.getpwdFindEnd", paraMap);
		
		return pwd;
	}
//=================================================================================================

	// 내가 신청한 전공평가 가져오기
		@Override
		public List<Map<String, String>> getServeyList(String hakbun) {
			List<Map<String, String>> serveyList = sqlsession2.selectList("Dong.getServeyList", hakbun);
			return serveyList;
		}
		
		// 강의평가 했는지 확인하기
		@Override
		public String getServeyMemberList(Map<String, String> paraMap) {
			String serveyDate = sqlsession2.selectOne("Dong.getServeyMemberList", paraMap);
			return serveyDate;
		}
		
		// 설문조사 가져오기
		@Override
		public List<ServeyVO> getSeolmoonList() {
			List<ServeyVO> seolmoonList = sqlsession2.selectList("Dong.getSeolmoonList");
			return seolmoonList;
		}

		// 설문조사 했는지 확인하기
		@Override
		public String getSeolmoonMemberList(Map<String, String> paraMap) {
			String seolmoonDate = sqlsession2.selectOne("Dong.getSeolmoonMemberList", paraMap);
			return seolmoonDate;
		}

		
		
//=================================================================================================

	
	
	
	
	
	
	
	
}//end of public class BoardDAO implements InterBoardDAO {