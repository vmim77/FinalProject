package com.spring.univ.model;

import java.util.*;
import javax.annotation.Resource;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class DongBoardDAO implements InterDongBoardDAO {

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
	
	
	
	
	
	
	
	
}//end of public class BoardDAO implements InterBoardDAO {