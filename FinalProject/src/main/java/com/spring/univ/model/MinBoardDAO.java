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

	@Override
	public List<SubjectVO> Teacherservey(String serveyCode) {
		List<SubjectVO> serveyList = sqlsession2.selectList("Min.Teacherservey", serveyCode);
		return serveyList;
	}

	
	
	
	
}//end of public class BoardDAO implements InterBoardDAO {