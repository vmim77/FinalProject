package com.spring.univ.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.univ.model.InterSungDAO;
import com.spring.univ.model.LessonBoardCommentVO;
import com.spring.univ.model.LessonBoardVO;

@Service
public class SungService implements InterSungService {
	
	@Autowired
	private InterSungDAO dao;
	
	// 해당 학생이 수강하고있는 과목의 정보를 가져온다.
	@Override
	public Map<String,String> getSubjectInfo(String code) {
		Map<String,String> subjectMap = dao.getSubjectInfo(code);
		return subjectMap;
	}
	
	// 해당 과목의 강좌자료실 내용을 가져온다.
	@Override
	public List<LessonBoardVO> getLessonBoard(String code) {
		List<LessonBoardVO> boardList = dao.getLessonBoard(code);
		return boardList;
	}
	
	// 로그인한 유저의 수강리스트를 뽑아온다.
	@Override
	public List<Map<String, String>> getSugang(String hakbun) {
		List<Map<String, String>> sugangList = dao.getSugang(hakbun);
		return sugangList;
	}
	
	// 로그인한 학생이 듣는 수업인지 확인을 한다.
	@Override
	public int checkSugang(Map<String, String> paraMap) {
		int n = dao.checkSugang(paraMap);
		return n;
	}
	
	// 과목코드가 정상적인지 확인한다.
	@Override
	public int checkCode(String sessionCode) {
		int result = dao.checkCode(sessionCode);
		return result;
	}
	
	// 교수의 담당과목을 불러온다.
	@Override
	public List<Map<String, String>> getsuUp(String hakbun) {
		List<Map<String, String>> suupList = dao.getsuUp(hakbun);
		return suupList;
	}
	
	// 교수 본인이 담당하는 과목인지 확인한다.
	@Override
	public int checkLesson(Map<String, String> paraMap) {
		int n = dao.checkLesson(paraMap);
		return n;
	}
	
	// [교수] 강의자료실 글쓰기
	@Override
	public int lessonWriteEnd(LessonBoardVO lbvo) {
		int n = dao.lessonWriteEnd(lbvo);
		return n;
	}
	
	// 해당 과목 강좌자료실의 특정 글을 가져온다.
	@Override
	public LessonBoardVO getLessonBoardDetail(Map<String, String> paraMap) {
		LessonBoardVO lbvo = dao.getLessonBoardDetail(paraMap);
		return lbvo;
	}
	
	// 강의자료실 댓글쓰기
	@Override
	public int addLessonBoardComment(LessonBoardCommentVO lbcvo) {
		int n = dao.addLessonBoardComment(lbcvo);
		return n;
	}
	
	// 강의자료실 댓글목록 가져오기
	@Override
	public List<LessonBoardCommentVO> getLessonBoardComment(String parentSeq) {
		List<LessonBoardCommentVO> commentList = dao.getLessonBoardComment(parentSeq);
		return commentList;
	}
	
	// 강의자료실 글 삭제하기
	@Override
	public int deleteLessonBoard(String seq) {
		int n = dao.deleteLessonBoard(seq);
		return n;
	}
	
	// 강의자료실 글 수정하기 완료요청
	@Override
	public int editLessonBoard(LessonBoardVO lbvo) {
		int n = dao.editLessonBoard(lbvo);
		return n;
	}

}
