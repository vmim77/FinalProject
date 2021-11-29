package com.spring.univ.model;

import java.util.*;

public interface InterMinBoardDAO {
	

	// 과목 가져오기 
	List<WeekVO> getSubList(String week);

	// 주차 가져오기
	List<WeekVO> getWeekList();

	// 강의평가
	List<SubjectVO> Teacherservey(String serveyCode);

	// 강의평가 결과
	int resultUpdate(Map<String, String> paraMap);

	// 강의평가 참여
	int attendance(Map<String, String> paraMap);


	// 설문조사 결과
	int outcomeUpdate(Map<String, String> paraMap);

	// 설문조사 참여
	void seolattendance(Map<String, String> paraMap);
	
}//end of public interface InterBoardDAO {
