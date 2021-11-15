package com.spring.univ.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class SungDAO implements InterSungDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession2;
	
	// 해당 학생이 수강하고있는 과목의 정보를 가져온다.
	@Override
	public Map<String, String> getSubjectInfo(String code) {
		Map<String,String> subjectMap = sqlsession2.selectOne("Sung.getSubjectInfo", code);
		return subjectMap;
	}
	
	// 해당 과목의 강좌자료실 내용을 가져온다.
	@Override
	public List<LessonBoardVO> getLessonBoard(String code) {
		List<LessonBoardVO> boardList = sqlsession2.selectList("Sung.getLessonBoard", code);
		return boardList;
	}
	
	// 로그인한 유저의 수강리스트를 뽑아온다.
	@Override
	public List<Map<String, String>> getSugang(String hakbun) {
		List<Map<String, String>> sugangList = sqlsession2.selectList("Sung.getSugang", hakbun);
		return sugangList;
	}
	
	// 로그인한 학생이 듣는 수업인지 확인을 한다.
	@Override
	public int checkSugang(Map<String, String> paraMap) {
		int n = sqlsession2.selectOne("Sung.checkSugang", paraMap);
		return n;
	}
	
	// 과목코드가 정상적인지 확인한다.
	@Override
	public int checkCode(String sessionCode) {
		int result = sqlsession2.selectOne("Sung.checkCode", sessionCode);
		return result;
	}
	
	// 교수의 담당과목을 불러온다.
	@Override
	public List<Map<String, String>> getsuUp(String hakbun) {
		List<Map<String, String>> suupList = sqlsession2.selectList("Sung.getsuUp", hakbun);
		return suupList;
	}
	
	// 교수 본인이 수업하는 과목인지 확인한다.
	@Override
	public int checkLesson(Map<String, String> paraMap) {
		int n = sqlsession2.selectOne("Sung.checkLesson", paraMap);
		return n;
	}
	
	// [교수] 강의자료실 글쓰기
	@Override
	public int lessonWriteEnd(LessonBoardVO lbvo) {
		int n = sqlsession2.insert("Sung.lessonWriteEnd", lbvo);
		return n;
	}
	
	// 해당 과목 강좌자료실의 특정 글을 가져온다.
	@Override
	public LessonBoardVO getLessonBoardDetail(Map<String, String> paraMap) {
		LessonBoardVO lbvo = sqlsession2.selectOne("Sung.getLessonBoardDetail", paraMap);
		return lbvo;
	}
	
	// 강의자료실 댓글쓰기
	@Override
	public int addLessonBoardComment(LessonBoardCommentVO lbcvo) {
		int n = sqlsession2.insert("Sung.addLessonBoardComment", lbcvo);
		return n;
	}
	
	// 강의자료실 댓글목록 가져오기
	@Override
	public List<LessonBoardCommentVO> getLessonBoardComment(String parentSeq) {
		List<LessonBoardCommentVO> commentList = sqlsession2.selectList("Sung.getLessonBoardComment", parentSeq);
		return commentList;
	}
	
	// 강의자료실 글  삭제하기
	@Override
	public int deleteLessonBoard(String seq) {
		int n = sqlsession2.delete("Sung.deleteLessonBoard", seq);
		return n;
	}
	
	// 강의자료실 글 수정하기 완료요청
	@Override
	public int editLessonBoard(LessonBoardVO lbvo) {
		int n = sqlsession2.update("Sung.editLessonBoard", lbvo);
		return n;
	}
	
	// 강의자료실 댓글 삭제하기
	@Override
	public int deleteLessonComment(String seq) {
		int n = sqlsession2.delete("Sung.deleteLessonComment", seq);
		return n;
	}
	
	// 강의자료실 댓글작성 -> 해당 글 댓글 수 1 증가
	@Override
	public int updateCommentCnt(String parentSeq) {
		int n = sqlsession2.update("Sung.updateCommentCnt", parentSeq);
		return n;
	}
	
	

}
