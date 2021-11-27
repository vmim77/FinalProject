package com.spring.univ.service;

import java.util.*;

import com.spring.univ.model.*;

public interface InterSungService {
	
	// [학생] 학생이 접근하려는 과목의 정보를 가져온다.
	Map<String,String> getSubjectInfo(String code);
	
	// 과제게시판의 글 목록을 가져온다.
	List<LessonBoardVO> getLessonBoard(Map<String, String> paraMap);
	
	// [학생] 로그인한 유저가 학생이라면 해당 학생의 수강신청 목록을 가져온다.
	List<Map<String, String>> getSugang(String hakbun);
	
	// [학생] 로그인한 학생이 접근하려는 과목이 수강신청한 과목인지 아닌지 검사한다.
	int checkSugang(Map<String, String> paraMap);
	
	// 접근하려는 과목 코드가 정상적인 코드인지 확인한다. (URL 접근 차단용)
	int checkCode(String sessionCode);
	
	// [교수] 로그인한 유저가 교수라면 해당 교수의 담당과목 목록을 가져온다.
	List<Map<String, String>> getsuUp(String hakbun);
	
	// [교수] 교수가 접근하려는 과목이 본인의 담당과목인지 아닌지 검사한다.
	int checkLesson(Map<String, String> paraMap);
	
	// [교수] 강의자료실 글쓰기
	int lessonWriteEnd(LessonBoardVO lbvo);
	
	// 강의자료실 글 상세조회
	LessonBoardVO getLessonBoardDetail(Map<String, String> paraMap);
	
	// 강의자료실 댓글쓰기
	int addLessonBoardComment(LessonBoardCommentVO lbcvo);
	
	// 강의자료실 댓글목록 가져오기
	List<LessonBoardCommentVO> getLessonBoardComment(String parentSeq);
	
	// [교수] 강의자료실 글 삭제하기
	int deleteLessonBoard(String seq);
	
	// [교수] 강의자료실 글 수정하기 완료요청
	int editLessonBoard(LessonBoardVO lbvo);
	
	// 강의자료실 댓글 삭제하기
	int deleteLessonComment(Map<String, String> paraMap);
	
	// 강의자료실 전체 페이지 수
	int getTotalLessonPage(Map<String, String> paraMap);
	
	// 과제 및 평가 게시판 글목록 조회
	List<HomeworkVO> getHomeworkList(String code);
	
	// 과제 및 평가 게시판의 댓글 가져오기
	List<HomeWorkCommentVO> getHomeworkComment(String code);
	
	// 과제 및 평가 게시판 댓글쓰기[파일첨부기능]
	int writeHomeworkComment(HomeWorkCommentVO hwcvo);
	
	// [교수] 과제 및 평가 게시판 글쓰기 완료 요청
	int homeworkWriteEnd(HomeworkVO hwvo);
	
	// 과제 및 게시판 특정글 조회
	HomeworkVO getHomeworkDetail(String seq);
	
	// 과제 및 게시판 특정댓글 조회
	HomeWorkCommentVO getHomeworkCommentDetail(String seq);
	
	// 과제 및 게시판 댓글 삭제
	int deleteHomeworkCommentDelete(Map<String, String> paraMap);
	
	// 과제 및 게시판 게시글 삭제
	int deleteHomework(String seq);
	
	// 과제 및 게시판 수정 완료 요청
	int homeworkEditEnd(HomeworkVO hwvo);
	
	// 해당 과목의 평가목록을 요청한다.
	List<Map<String, String>> getEvaluation(String code);
	
	// 엑셀용 데이터 조회
	List<Map<String, String>> getEvaluationExcel(String code);
	
	

}
