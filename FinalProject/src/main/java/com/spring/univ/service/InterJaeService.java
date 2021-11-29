package com.spring.univ.service;

import java.util.List;
import java.util.Map;

import com.spring.univ.model.ClassContentBoardVO;
import com.spring.univ.model.ClassContentCommentVO;
import com.spring.univ.model.SubjectVO;
import com.spring.univ.model.WeekVO;



public interface InterJaeService {

	//수업 리스트 가져오기
	List<Map<String, String>> getclassList(String code);

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
	String attendCheck(Map<String, String> paraMap);

	//각 과목당 출석체크했는지 확인 
	String getAttendCheck(Map<String, String> paraMap);

	//과목의 각 주차당 몇개의 차시가 있는지 알아오기
	String getlessonCnt(Map<String, String> paraMap);

	//과목의 각 주차에 몇 개나 출석을 했는지 가져오기
	String getlessonAttendCnt(Map<String, String> paraMap);

	//출석현황에서 어떤걸 출석했는지 알아오기
	String getlessonCheck(Map<String, String> paraMap2);

	//출석현황에서 학습현황 보여주려고    각 수업 게시물에 댓글쓴걸 알아온다.
	String getlessonComment(Map<String, String> paraMap2);

	//지각 인정기간에 출석 안한 수업들 인서트하기
	int goLateAttend(Map<String, String> paraMap2);

	//count로 알아오는게 아닌 status로 알아온다.
	String getlessonCheck2(Map<String, String> paraMap2);

	//출석테이블에 넣기전 지각인지 결석인지 알아오기 - 지각이나 결석이라면 이미 테이블에 status 2,3,4로 들어가 있기 때문에 insert하려고 하면 유니크 제약으로 오류 발생
	String getlessonCheckForAttendInsert(Map<String, String> paraMap);

	// 출석테이블에 있다면 status가 뭔지 알아오고 1,2,3,4에 따라서 결과 정해주기
	String getAttendStatus(Map<String, String> paraMap);

	//지각 인정기간에 수업을 들어 status를 3으로 업데이트
	String lateUpdate(Map<String, String> paraMap);

	//결석처리 업데이트
	int notAttendUpdate(Map<String, String> paraMap2);
	
	//총 수업 횟수
	int getTotalLessonCnt(Map<String, String> paraMap3);

	//총 출석 횟수
	int getTotalAttendCnt(Map<String, String> paraMap3);

	// 총 지각 횟수
	int getTotalLateCnt(Map<String, String> paraMap3);

	// 총 지각 출석 횟수
	int getTotalLateAttendCnt(Map<String, String> paraMap3);

	// 총 결석 처리 횟수
	int getTotalNotAttendCnt(Map<String, String> paraMap3);




	

}
