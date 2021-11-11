package com.spring.univ.model;

import java.util.List;
import java.util.Map;

public interface InterSungDAO {
	
	// 해당 학생이 수강하고있는 과목의 정보를 가져온다.
	Map<String,String> getSubjectInfo(String code);
	
	// 해당 과목의 강좌자료실 내용을 가져온다.
	List<LessonBoardVO> getLessonBoard(String code);
	
	// 로그인한 유저의 수강리스트를 뽑아온다.
	List<Map<String, String>> getSugang(String hakbun);
	
	// 로그인한 학생이 듣는 수업인지 확인을 한다.
	int checkSugang(Map<String, String> paraMap);
	
	// 과목코드가 정상적인지 확인한다.
	int checkCode(String sessionCode);
	
	// 교수의 담당과목을 불러온다.
	List<Map<String, String>> getsuUp(String hakbun);
	
	// 교수 본인이 듣는 과목인지 확인한다.
	int checkLesson(Map<String, String> paraMap);

}
