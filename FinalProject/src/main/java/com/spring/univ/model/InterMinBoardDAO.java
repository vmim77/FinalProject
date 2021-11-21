package com.spring.univ.model;

import java.util.*;

public interface InterMinBoardDAO {
	

	// 과목 가져오기 
	List<WeekVO> getSubList(String week);

	// 주차 가져오기
	List<WeekVO> getWeekList();

	// 민경장군
	List<SubjectVO> Teacherservey(String serveyCode);
	
}//end of public interface InterBoardDAO {
