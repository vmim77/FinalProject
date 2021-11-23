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
	
	// [학생] 학생이 접근하려는 과목의 정보를 가져온다.
	@Override
	public Map<String, String> getSubjectInfo(String code) {
		Map<String,String> subjectMap = sqlsession2.selectOne("Sung.getSubjectInfo", code);
		return subjectMap;
	}
	
	// 과제게시판의 글 목록을 가져온다.
	@Override
	public List<LessonBoardVO> getLessonBoard(Map<String, String> paraMap) {
		List<LessonBoardVO> boardList = sqlsession2.selectList("Sung.getLessonBoard", paraMap);
		return boardList;
	}
	
	// [학생] 로그인한 유저가 학생이라면 해당 학생의 수강신청 목록을 가져온다.
	@Override
	public List<Map<String, String>> getSugang(String hakbun) {
		List<Map<String, String>> sugangList = sqlsession2.selectList("Sung.getSugang", hakbun);
		return sugangList;
	}
	
	// [학생] 로그인한 학생이 접근하려는 과목이 수강신청한 과목인지 아닌지 검사한다.
	@Override
	public int checkSugang(Map<String, String> paraMap) {
		int n = sqlsession2.selectOne("Sung.checkSugang", paraMap);
		return n;
	}
	
	// 접근하려는 과목 코드가 정상적인 코드인지 확인한다. (URL 접근 차단용)
	@Override
	public int checkCode(String sessionCode) {
		int result = sqlsession2.selectOne("Sung.checkCode", sessionCode);
		return result;
	}
	
	// [교수] 로그인한 유저가 교수라면 해당 교수의 담당과목 목록을 가져온다.
	@Override
	public List<Map<String, String>> getsuUp(String hakbun) {
		List<Map<String, String>> suupList = sqlsession2.selectList("Sung.getsuUp", hakbun);
		return suupList;
	}
	
	// [교수] 교수가 접근하려는 과목이 본인의 담당과목인지 아닌지 검사한다.
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
	
	// 강의자료실 글 상세조회
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
	
	// [교수] 강의자료실 글 삭제하기
	@Override
	public int deleteLessonBoard(String seq) {
		int n = sqlsession2.delete("Sung.deleteLessonBoard", seq);
		return n;
	}
	
	// [교수] 강의자료실 글 수정하기 완료요청
	@Override
	public int editLessonBoard(LessonBoardVO lbvo) {
		int n = sqlsession2.update("Sung.editLessonBoard", lbvo);
		return n;
	}
	
	// 강의자료실 댓글 삭제하기
	@Override
	public int deleteLessonComment(Map<String, String> paraMap) {
		int n = sqlsession2.delete("Sung.deleteLessonComment", paraMap);
		return n;
	}
	
	// 강의자료실 댓글작성 -> 해당 글 댓글 수 1 증가
	@Override
	public int updateCommentCnt(String parentSeq) {
		int n = sqlsession2.update("Sung.updateCommentCnt", parentSeq);
		return n;
	}
	
	// 강의자료실 댓글삭제 -> 해당 글 댓글 수 1 차감
	@Override
	public int downCommentCnt(Map<String, String> paraMap) {
		int n = sqlsession2.update("Sung.downCommentCnt", paraMap);
		return n;
	}
	
	// 강의자료실 전체 페이지 수
	@Override
	public int getTotalLessonPage(Map<String, String> paraMap) {
		int n = sqlsession2.selectOne("Sung.getTotalLessonPage", paraMap);
		return n;
	}
	
	// 과제 및 평가 게시판 글목록 조회
	@Override
	public List<HomeworkVO> getHomeworkList(String code) {
		List<HomeworkVO> homeworkList = sqlsession2.selectList("Sung.getHomeworkList", code);
		return homeworkList;
	}
	
	// 과제 및 평가 게시판의 댓글 가져오기
	@Override
	public List<HomeWorkCommentVO> getHomeworkComment(String code) {
		List<HomeWorkCommentVO> homeworkCommentList = sqlsession2.selectList("Sung.getHomeworkComment", code);
		return homeworkCommentList;
	}
	
	// 과제 및 평가 게시판 댓글쓰기[파일첨부기능]
	@Override
	public int writeHomeworkComment(HomeWorkCommentVO hwcvo) {
		int n = sqlsession2.insert("Sung.writeHomeworkComment", hwcvo);
		return n;
	}
	
	// 과제 및 평가 게시판 부모글 댓글갯수 증가
	@Override
	public int plusCommentCnt(HomeWorkCommentVO hwcvo) {
		int m = sqlsession2.update("Sung.plusCommentCnt", hwcvo);		
		return m;
	}
	
	// 마감기한인 과제게시물의 status를 바꾼다.
	@Override
	public void updateStatus(String seq) {
		sqlsession2.update("Sung.updateStatus", seq);
		
	}
	
	// [교수] 과제 및 평가 게시판 글쓰기 완료 요청
	@Override
	public int homeworkWriteEnd(HomeworkVO hwvo) {
		int n = sqlsession2.insert("Sung.homeworkWriteEnd", hwvo);
		return n;
	}
	
	// 과제 및 게시판 특정글 조회
	@Override
	public HomeworkVO getHomeworkDetail(String seq) {
		HomeworkVO hwvo = sqlsession2.selectOne("Sung.getHomeworkDetail", seq);
		return hwvo;
	}
	
	// 과제 및 게시판 특정댓글 조회
	@Override
	public HomeWorkCommentVO getHomeworkCommentDetail(String seq) {
		HomeWorkCommentVO hwcvo = sqlsession2.selectOne("Sung.getHomeworkCommentDetail", seq);
		return hwcvo;
	}
	
	// 과제 및 게시판 댓글 삭제
	@Override
	public int deleteHomeworkCommentDelete(Map<String, String> paraMap) {
		int n = sqlsession2.delete("Sung.deleteHomeworkCommentDelete", paraMap);
		return n;
	}
	
	// 과제 및 평가 게시판 부모글 댓글갯수 차감
	@Override
	public int minusCommentCnt(Map<String, String> paraMap) {
		int n = sqlsession2.update("Sung.minusCommentCnt", paraMap);
		return n;
	}
	
	// 과제 및 게시판 게시글 삭제
	@Override
	public int deleteHomework(String seq) {
		int n = sqlsession2.delete("Sung.deleteHomework", seq);
		return n;
	}
	
	// 과제 및 게시판 수정 완료 요청
	@Override
	public int homeworkEditEnd(HomeworkVO hwvo) {
		int n = sqlsession2.update("Sung.homeworkEditEnd", hwvo);
		return n;
	}

	
	

}
