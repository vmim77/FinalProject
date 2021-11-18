package com.spring.univ.model;

import java.util.List;
import java.util.Map;

public interface InterSungDAO {
	
	// 해당 학생이 수강하고있는 과목의 정보를 가져온다.
	Map<String,String> getSubjectInfo(String code);
	
	// 해당 과목의 강좌자료실 내용을 가져온다.
	List<LessonBoardVO> getLessonBoard(Map<String, String> paraMap);
	
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
	
	// [교수] 강의자료실 글쓰기
	int lessonWriteEnd(LessonBoardVO lbvo);
	
	// 해당 과목 강좌자료실의 특정 글을 가져온다.
	LessonBoardVO getLessonBoardDetail(Map<String, String> paraMap);
	
	// 강의자료실 댓글쓰기
	int addLessonBoardComment(LessonBoardCommentVO lbcvo);
	
	// 강의자료실 댓글목록 가져오기
	List<LessonBoardCommentVO> getLessonBoardComment(String parentSeq);
	
	// 강의자료실 글 삭제하기
	int deleteLessonBoard(String seq);
	
	// 강의자료실 글 수정하기 완료요청
	int editLessonBoard(LessonBoardVO lbvo);
	
	// 강의자료실 댓글 삭제하기
	int deleteLessonComment(Map<String, String> paraMap);
	
	// 강의자료실 댓글작성 -> 해당 글 댓글 수 1 증가
	int updateCommentCnt(String parentSeq);
	
	// 강의자료실 댓글삭제 -> 해당 글 댓글 수 1 차감
	int downCommentCnt(Map<String, String> paraMap);
	
	// 강의자료실 전체 페이지수
	int getTotalLessonPage(Map<String, String> paraMap);

}
