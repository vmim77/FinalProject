package com.spring.univ.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class JaeDAO implements InterJaeDAO{

	@Resource
	private SqlSessionTemplate sqlsession2;
	
	//수업 리스트 가져오기
	@Override
	public List<Map<String, String>> getclassList() {
		List<Map<String, String>> classList = sqlsession2.selectList("Jae.getclassList");
		return classList;
	}

	
	//과목당 몇주차까지 있는지 알아오기
	@Override
	public List<WeekVO> getWeek(String code) {
		List<WeekVO> getWeek = sqlsession2.selectList("Jae.getWeek", code);
		return getWeek;
	}


	//주차별 차시 수업정보 가져오기
	@Override
	public List<Map<String, String>> classListbyWeek(Map<String, String> paraMap2) {
		List<Map<String, String>> classListbyWeek = sqlsession2.selectList("Jae.classListbyWeek", paraMap2);
		return classListbyWeek;
	}


	//하나의 수업 정보 가져오기
	@Override
	public Map<String, String> getOneClassView(Map<String, String> paraMap) {
		Map<String, String> getOneClassView = sqlsession2.selectOne("Jae.getOneClassView", paraMap);
		return getOneClassView;
	}


	
	//첨부파일이 없는 교수님 강의콘텐츠 게시물 올리기
	@Override
	public int classContentAdd(ClassContentBoardVO ccbvo) {
		int n = sqlsession2.insert("Jae.classContentAdd",ccbvo);
		return n;
	}


	//첨부파일이 있는  교수님 강의콘텐츠 게시물 올리기
	@Override
	public int classContentAdd_withFile(ClassContentBoardVO ccbvo) {
		int n = sqlsession2.insert("Jae.classContentAdd_withFile",ccbvo);
		return n;
	}

	
	//교수가 올린 강의 게시물 가져오기
	@Override
	public List<ClassContentBoardVO> getclassContentList(String lessonseq) {
		List<ClassContentBoardVO> getclassContentList = sqlsession2.selectList("Jae.getclassContentList",lessonseq);
		return getclassContentList;
	}


	//교수가 올린 하나의 강의 게시물 가져오기(각 글의 첨부파일 정보를 얻어오기 위함)
	@Override
	public ClassContentBoardVO getClassOneContent(String classBoardSeq) {
		ClassContentBoardVO getClassOneContent = sqlsession2.selectOne("Jae.getClassOneContent",classBoardSeq);
		return getClassOneContent;
	}


	
	//변경할 첨부파일이 없는 경우 게시물 수정하기
	@Override
	public int classContentEdit(ClassContentBoardVO ccbvo) {
		int n = sqlsession2.update("Jae.classContentEdit", ccbvo);
		return n;
	}


	//교수가 올린 강의 게시물 삭제하기
	@Override
	public int classContentDel(Map<String, String> paraMap) {
		int n = sqlsession2.delete("Jae.classContentDel",paraMap);
		return n;
	}


	//변경할 첨부파일이 있는 경우 게시물 수정하기
	@Override
	public int classContentEdit_withFile(ClassContentBoardVO ccbvo) {
		int n = sqlsession2.update("Jae.classContentEdit_withFile", ccbvo);
		return n;
	}


	//첨부파일 없는 댓글쓰기(Ajax)
	@Override
	public int classCommentWrite_noAttach(Map<String, String> paraMap) {
		
		int n = sqlsession2.insert("Jae.classCommentWrite_noAttach",paraMap);
		return n;
	}
	
	
	//첨부파일이 있는 댓글쓰기
	@Override
	public int classCommentWrite_withAttach(ClassContentCommentVO cccvo) {
		int n = sqlsession2.insert("Jae.classCommentWrite_withAttach",cccvo);
		return n;
	}


	//게시물에 달린 댓글 페이징처리하여 알아오기(검색포함)
	@Override
	public List<ClassContentCommentVO> getCommentListPaging(Map<String, String> paraMap) {
		List<ClassContentCommentVO> getCommentListPaging = sqlsession2.selectList("Jae.getCommentListPaging",paraMap);
		return getCommentListPaging;
	}


	// 댓글 총 개수 알아오기 (검색포함)
	@Override
	public int getCommentTotalPageCount(Map<String, String> paraMap) {
		int getCommentTotalPageCount = sqlsession2.selectOne("Jae.getCommentTotalPageCount",paraMap);
		return getCommentTotalPageCount;
	}


	//댓글 1개 조회해오기
	@Override
	public ClassContentCommentVO getClassContentCommentOne(String classCommentSeq) {
		ClassContentCommentVO getClassContentCommentOne = sqlsession2.selectOne("Jae.getClassContentCommentOne",classCommentSeq);
		return getClassContentCommentOne;
	}

	
	
	//댓글 삭제하기
	@Override
	public int classCommentDel(Map<String, String> paraMap) {
		int n = sqlsession2.delete("Jae.classCommentDel", paraMap);
		return n;
	}


	
	//과목코드로 하나의 과목정보 알아오기
	@Override
	public SubjectVO getOneSubjectByCode(String code) {
		SubjectVO getOneSubjectByCode = sqlsession2.selectOne("Jae.getOneSubjectByCode",code);
		return getOneSubjectByCode;
	}


	
	//몇 주차까지 등록되어있는지 알아오기
	@Override
	public int getWeekCount(String code) {
		int n = sqlsession2.selectOne("Jae.getWeekCount", code);
		return n;
	}


	//수업 주차 등록하기
	@Override
	public int classWeekRegister(Map<String, String> paraMap) throws Exception{
		int n = sqlsession2.insert("Jae.classWeekRegister",paraMap);
		return n;
	}


	//수업 차시 등록하기
	@Override
	public int classLessonRegister(Map<String, String> paraMap) {
		int n = sqlsession2.insert("Jae.classLessonRegister",paraMap);
		return n;
	}


	
	//출석테이블에 인서트
	@Override
	public int goAttend(Map<String, String> paraMap) throws Exception{
		int n = sqlsession2.insert("Jae.goAttend",paraMap);
		return n;
	}


	//출석체크했는지 확인
	@Override
	public int attendCheck(Map<String, String> paraMap) {
		int n = sqlsession2.selectOne("Jae.attendCheck",paraMap);
		return n;
	}


	
	//각 차시마다 출석했는지 알아오기
	@Override
	public int getAttendCheck(Map<String, String> paraMap) {
		int isCheck = sqlsession2.selectOne("Jae.getAttendCheck",paraMap);
		return isCheck;
	}


	
	
	
	
	

}
