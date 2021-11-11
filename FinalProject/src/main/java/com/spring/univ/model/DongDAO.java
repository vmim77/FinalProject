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
	public List<SubjectVO> getTeacher() {

		List<SubjectVO> TeacherList = sqlsession2.selectList("Dong.getTeacher");
		
		return TeacherList;
	}
//=================================================================================================
	// === 개인정보 수정하기 === //
	@Override
	public int MyUpdate(Map<String, String> paraMap) {
		
		int n = sqlsession2.update("Dong.MyUpdate", paraMap);
		
		return n;
	}
	
	// === 마이페이지 보여주기 === //
	@Override
	public List<MemberVO> getMyMember(Map<String, String> paraMap) {
		
		List<MemberVO> MemberList = sqlsession2.selectList("Dong.getMyMember", paraMap);
		
		return MemberList;
	}


	
	
	
	
	
	
	
	
}//end of public class BoardDAO implements InterBoardDAO {