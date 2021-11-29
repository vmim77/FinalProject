package com.spring.univ.service;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.*;
import com.spring.univ.model.*;

@Service
public class MinService implements InterMinService {
//==============================================================================================
	@Autowired
	private InterMinBoardDAO dao;
//==============================================================================================
	
//==============================================================================================
//	민경자리
//==============================================================================================
	// 과목 가져오기
	@Override
	public List<WeekVO> getSubList(String week) {
		
		List<WeekVO> SubList = dao.getSubList(week);
		return SubList;
	}

	// 주차 가져오기
	@Override
	public List<WeekVO> getWeekList() {
		
		List<WeekVO> WeekList = dao.getWeekList();
		return WeekList;
	}

	// 강의평가
	@Override
	public List<SubjectVO> Teacherservey(String serveyCode) {
		List<SubjectVO> serveyList = dao.Teacherservey(serveyCode);
		return serveyList;
	}

	// 강의평가 결과
	@Override
	public int resultUpdate(Map<String, String> paraMap) {
		
		int n = dao.resultUpdate(paraMap);
		
		return n; 
	}

	// 강의평가 참여
	@Override
	public int attendance(Map<String, String> paraMap) {

		int n = dao.attendance(paraMap);
		return n;
	}


	// 설문조사 결과
	@Override
	public int outcomeUpdate(Map<String, String> paraMap) {
		
		int n = dao.outcomeUpdate(paraMap);
		
		return n; 
	}

	@Override
	public void seolattendance(Map<String, String> paraMap) {
		
		dao.seolattendance(paraMap);
	}






	
}//end of public class BoardService implements InterBoardService {
