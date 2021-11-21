package com.spring.univ.service;

import java.util.*;

import com.spring.univ.model.MemberVO;
import com.spring.univ.model.SubjectVO;
import com.spring.univ.model.WeekVO;

public interface InterMinService {
		
	// 과목 가져오기
	List<WeekVO> getSubList(String week);

	// 주차 가져오기
	List<WeekVO> getWeekList();
	
	// 아가리여물어라
	List<SubjectVO> Teacherservey(String serveyCode);





	
}//end of public interface InterBoardService {
