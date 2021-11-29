package com.spring.univ.model;

import java.util.*;
import javax.annotation.Resource;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MinBoardDAO implements InterMinBoardDAO {

	@Resource
	private SqlSessionTemplate sqlsession2; // 원격DB에 연결

//================================================================================================
	// 과목 가져오기
	@Override
	public List<WeekVO> getSubList(String week) {
		List<WeekVO> SubList = sqlsession2.selectList("Min.getSubList",week);
		return SubList;
	}

	// 주차 가져오기
	@Override
	public List<WeekVO> getWeekList() {
		List<WeekVO> WeekList = sqlsession2.selectList("Min.getWeekList");
		return WeekList;
	}

	// 강의평가
	@Override
	public List<SubjectVO> Teacherservey(String serveyCode) {
		List<SubjectVO> serveyList = sqlsession2.selectList("Min.Teacherservey", serveyCode);
		return serveyList;
	}

	// 강의평가 결과
	@Override
	public int resultUpdate(Map<String, String> paraMap) {
		int n = sqlsession2.insert("Min.resultUpdate", paraMap);
		return n;
	}

	// 강의평가 참여
	@Override
	public int attendance(Map<String, String> paraMap) {
		int n = sqlsession2.insert("Min.attendance", paraMap);
		return n;
	}


	// 설문조사 결과
	@Override
	public int outcomeUpdate(Map<String, String> paraMap) {
		int n = sqlsession2.insert("Min.outcomeUpdate", paraMap);
		return n;
	}

	// 설문조사 참여
	@Override
	public void seolattendance(Map<String, String> paraMap) {
		sqlsession2.insert("Min.seolattendance", paraMap);
	}
	
	
	
	
}//end of public class BoardDAO implements InterBoardDAO {