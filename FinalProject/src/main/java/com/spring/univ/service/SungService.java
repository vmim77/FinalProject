package com.spring.univ.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.univ.model.HomeWorkCommentVO;
import com.spring.univ.model.HomeworkVO;
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
	public List<LessonBoardVO> getLessonBoard(Map<String, String> paraMap) {
		List<LessonBoardVO> boardList = dao.getLessonBoard(paraMap);
		
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
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int addLessonBoardComment(LessonBoardCommentVO lbcvo) {
		int m = 0;
		int n = dao.addLessonBoardComment(lbcvo);
		
		if(n==1) {
			 m = dao.updateCommentCnt(lbcvo.getParentSeq());
		}
		
		return m;
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
	
	// 강의자료실 댓글 삭제하기
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int deleteLessonComment(Map<String, String> paraMap) {
		
		int n = dao.deleteLessonComment(paraMap);
		
		if(n==1) {
			int m = dao.downCommentCnt(paraMap);
		}
		
		return n;
	}
	
	// 강의자료실 전체 페이지수
	@Override
	public int getTotalLessonPage(Map<String, String> paraMap) {
		int n = dao.getTotalLessonPage(paraMap);
		return n;
	}
	
	// 과제게시판의 글목록 조회
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public List<HomeworkVO> getHomeworkList(String code) {
		
		List<HomeworkVO> homeworkList = dao.getHomeworkList(code);
		
		if(homeworkList != null) {
			
			for(HomeworkVO hwvo : homeworkList) {
				
				Date now = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String currentDate = sdf.format(now);
				
				String dbDate = hwvo.getDeadline().substring(0, 10);
				
				if(dbDate.equals(currentDate)) {
					dao.updateStatus(hwvo.getSeq());
				}
				
			}// end of for------------------------------------
			
			homeworkList = dao.getHomeworkList(code);
		}
		
		
		
		return homeworkList;
	}
	
	// 과제게시판의 댓글 가져오기
	@Override
	public List<HomeWorkCommentVO> getHomeworkComment(String code) {
		List<HomeWorkCommentVO> homeworkCommentList = dao.getHomeworkComment(code);
		return homeworkCommentList;
	}
	
	// 과제게시판 댓글쓰기[파일첨부기능]
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int writeHomeworkComment(HomeWorkCommentVO hwcvo) {
		
		int n = 0, m = 0;
		
		n = dao.writeHomeworkComment(hwcvo);
		
		if(n==1) {
			m = dao.plusCommentCnt(hwcvo);
		}
		
		return m;
	}
	
	// 과제게시판 글쓰기 요청
	@Override
	public int homeworkWriteEnd(HomeworkVO hwvo) {
		int n = dao.homeworkWriteEnd(hwvo);
		return n;
	}
	
	// 과제게시판 특정글 요청
	@Override
	public HomeworkVO getHomeworkDetail(String seq) {
		HomeworkVO hwvo = dao.getHomeworkDetail(seq);
		return hwvo;
	}
	
	// 과제게시판 특정댓글 요청
	@Override
	public HomeWorkCommentVO getHomeworkCommentDetail(String seq) {
		HomeWorkCommentVO hwcvo = dao.getHomeworkCommentDetail(seq);
		return hwcvo;
	}
	
	// 과제게시판 댓글 삭제하기
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int deleteHomeworkCommentDelete(Map<String, String> paraMap) {
		
		int n = dao.deleteHomeworkCommentDelete(paraMap);
		
		int m = 0;
		
		if(n==1) {
			m = dao.minusCommentCnt(paraMap);
		}
		return m;
	}
	
	// 과제게시판 글 삭제하기
	@Override
	public int deleteHomework(String seq) {
		int n = dao.deleteHomework(seq);
		return n;
	}
	
	// 과제게시판 글 수정하기
	@Override
	public int homeworkEditEnd(HomeworkVO hwvo) {
		int n = dao.homeworkEditEnd(hwvo);
		return n;
	}
	

}
