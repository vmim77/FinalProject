package com.spring.univ.model;

import java.util.*;
import javax.annotation.Resource;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.spring.univ.model.MemberVO;

@Repository
public class FreeBoardDAO implements InterFreeBoardDAO {

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
	// === 맴버 조회하기 === //
	@Override
	public MemberVO getMember(Map<String, String> paraMap) {

		MemberVO loginuser = sqlsession2.selectOne("Dong.getMember", paraMap);
		
		return loginuser;
	}
//=================================================================================================
	
	
	
	
	
	
	
	
	
}//end of public class BoardDAO implements InterBoardDAO {