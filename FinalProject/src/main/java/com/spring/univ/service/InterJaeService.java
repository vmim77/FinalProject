package com.spring.univ.service;

import java.util.List;
import java.util.Map;

import com.spring.univ.model.ClassContentBoardVO;
import com.spring.univ.model.ClassContentCommentVO;
import com.spring.univ.model.SubjectVO;
import com.spring.univ.model.WeekVO;



public interface InterJaeService {

	//수업 리스트 가져오기
	List<Map<String, String>> getclassList();

	//과목당 몇주차까지 있는지 알아오기
	List<WeekVO> getWeek(String code);

	//주차별 차시 수업정보 가져오기
	List<Map<String, String>> classListbyWeek(Map<String, String> paraMap2);

	//하나의 수업 정보 가져오기
	Map<String, String> getOneClassView(Map<String, String> paraMap);

	//첨부파일이 없는 교수님 강의콘텐츠 게시물 올리기
	int classContentAdd(ClassContentBoardVO ccbvo);

	//첨부파일이 있는  교수님 강의콘텐츠 게시물 올리기
	int classContentAdd_withFile(ClassContentBoardVO ccbvo);

	//교수가 올린 강의 게시물 가져오기
	List<ClassContentBoardVO> getclassContentList(String lessonseq);

	//교수가 올린 하나의 강의 게시물 가져오기(각 글의 첨부파일 정보를 얻어오기 위함)
	ClassContentBoardVO getClassOneContent(String classBoardSeq);

	//변경할 첨부파일이 없는 경우 게시물 수정하기
	int classContentEdit(ClassContentBoardVO ccbvo);

	//변경할 첨부파일이 있는 경우 게시물 수정하기
	int classContentEdit_withFile(ClassContentBoardVO ccbvo, Map<String, String> paraMap);
	
	//교수가 올린 강의 게시물 삭제하기
	int classContentDel(Map<String, String> paraMap);

	//첨부파일 없는 댓글쓰기(Ajax)
	int classCommentWrite_noAttach(Map<String, String> paraMap);
	
	// 첨부파일이 있는 댓글쓰기
	int classCommentWrite_withAttach(ClassContentCommentVO cccvo);

	//게시물에 달린 댓글 페이징처리하여 알아오기(검색포함)
	List<ClassContentCommentVO> getCommentListPaging(Map<String, String> paraMap);

	// 댓글 총 개수 알아오기 (검색포함)
	int getCommentTotalPageCount(Map<String, String> paraMap);

	//댓글 1개 조회해오기
	ClassContentCommentVO getClassContentCommentOne(String classCommentSeq);

	//댓글 삭제하기
	int classCommentDel(Map<String, String> paraMap);

	//과목코드로 하나의 과목정보 알아오기
	SubjectVO getOneSubjectByCode(String code);

	//몇 주차까지 등록되어있는지 알아오기
	int getWeekCount(String code);

	//수업 주차 등록하기
	int classWeekRegister(Map<String, String> paraMap) throws Exception;

	//수업 차시 등록하기
	int classLessonRegister(Map<String, String> paraMap);

	//출석테이블에 인서트
	int goAttend(Map<String, String> paraMap) throws Exception;

	//출석체크했는지 확인
	int attendCheck(Map<String, String> paraMap);

	//각 과목당 출석체크했는지 확인 
	int getAttendCheck(Map<String, String> paraMap);



	

}
