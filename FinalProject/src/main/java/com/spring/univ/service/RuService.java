package com.spring.univ.service;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.*;

import com.spring.univ.model.*;

@Service
public class RuService implements InterRuService {
//==============================================================================================
	@Autowired
	private InterRuDAO dao;
	
	
	
//==============================================================================================
	// 파일첨부가 없는 글쓰기
	@Override
	public int add(FreeBoardVO freeboardvo) {
		int n = dao.add(freeboardvo);
		return n;
	}//end of public int add(FreeBoardVO freeboardvo) {-----------------------------------------
//==============================================================================================
	// 글 조회수 증가와 함께 글 1개를 보여주는 것
	@Override
	public FreeBoardVO getView(Map<String, String> paraMap, String login_userid) {
	
		// 글 1개를 조회해주는 함수 호출
		FreeBoardVO freeboardvo = dao.getView(paraMap);
		
		if(login_userid != null && freeboardvo != null && !(login_userid.equals(freeboardvo.getFk_hakbun()))) {
			
			// 글 조회수 1 증가시키는 함수 - 글 번호만 넘겨준다.
			dao.setAddReadCount(freeboardvo.getSeq()); 
			freeboardvo = dao.getView(paraMap); // 조회수가 증가된 상태로 다시 한 번 호출하기
		}
		
		return freeboardvo;
	}//end of public BoardVO getView(Map<String, String> paraMap, String login_userid)----------
//==============================================================================================
	// 새로고침을 통해 조회수 1증가 막기
	@Override
	public FreeBoardVO getWithNoAddCount(Map<String, String> paraMap) {
		FreeBoardVO freeboardvo = dao.getView(paraMap);
		return freeboardvo;
	}//end of public BoardVO getWithNoAddCount(Map<String, String> paraMap) {------------------
//==============================================================================================
	// 1개글 수정하기
	@Override
	public int edit(FreeBoardVO freeboardvo) {
		int n = dao.edit(freeboardvo);
		return n;
	}//end of public int edit(BoardVO boardvo) {------------------------------------------------
//==============================================================================================
	// 글 삭제하기
	@Override
	public int del(FreeBoardVO freeboardvo) {
		int n = dao.del(freeboardvo);
		return n;
	}//end of public int del(BoardVO boardvo) {-------------------------------------------------
//==============================================================================================
	// 댓글쓰기(트랜잭션 처리하기)
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int addComment(FreeCommentVO freecommentvo) throws Throwable{
		
		int n=0, m=0;
		
		// 댓글쓰기(tbl_comment 테이블에 insert)
		n = dao.addComment(freecommentvo);
		
		if(n==1) {
			// tbl_board 테이블에 commentCount 컬럼이 1증가(update)
			m = dao.updateCommentCount(freecommentvo.getParentSeq());
		}
		
		return m;
		
	}//end of public int addComment(CommentVO commentvo) {--------------------------------------
//==============================================================================================
	// 원게시물에 있는 댓글들을 조회
	@Override
	public List<FreeCommentVO> getCommentList(String parentSeq) {
		List<FreeCommentVO> getFreeCommentList = dao.getFreeCommentList(parentSeq);
		return getFreeCommentList;
	}//end of public List<CommentVO> getCommentList(String parentSeq) {-------------------------
//==============================================================================================
	// 검색어 입력시 자동글 완성하기3
	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> wordList =  dao.wordSearchShow(paraMap);
		return wordList;
	}//end of public List<String> wordSearchShow(Map<String, String> paraMap) {-----------------
//==============================================================================================
	// 총 게시물 건수(totalCount) 구하기 ==> 검색이 있을떄 || 검색이 없을때 로 나뉜다
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = dao.getTotalCount(paraMap);
		return n;
	}//end of public int getTotalCount(Map<String, String> paraMap) {---------------------------
//==============================================================================================
	// 페이징 처리한 글 목록 가져오기(검색의 유무와 상관 없이 모두 호환 가능하다)
	@Override
	public List<FreeBoardVO> boardListSearchWithPaging(Map<String, String> paraMap) {
		List<FreeBoardVO> FreeboardList = dao.boardListSearchWithPaging(paraMap);
		return FreeboardList;
	}//end of public List<BoardVO> boardListSearchWithPaging(Map<String, String> paraMap) {-----
//==============================================================================================
	// 원게시물에 있는 댓글들을페이징 처리해서 조회해오기	
	@Override
	public List<FreeCommentVO> getCommentListPaging(Map<String, String> paraMap) {
		List<FreeCommentVO> FreecommentList = dao.getCommentListPaging(paraMap);
		return FreecommentList;
	}//end of public List<CommentVO> getCommentListPaging(Map<String, String> paraMap) {--------
//==============================================================================================
	// 원글 글번호(parentSeq)에 해당하는 댓글의 총개수를 알아오기
	@Override
	public int getCommentTotalCount(Map<String, String> paraMap) {
		int totalCount = dao.getCommentTotalCount(paraMap);
		return totalCount;
	}//end of public int getCommentTotalCount(Map<String, String> paraMap) {-------------------
//==============================================================================================
	
	
	
	// 쪽지 수신함 페이지 목록 가져오기
	@Override
	public List<Map<String,String>> receiveList(Map<String, String> paraMap) {
		List<Map<String,String>> receiveList = dao.receiveList(paraMap);
		return receiveList;
	}
	
	
	// 쪽지 발신함 페이지 목록 가져오기
	
	
	@Override
	public List<Map<String,String>> sendList(Map<String, String> paraMap) {
		List<Map<String,String>> sendList = dao.sendList(paraMap);
		return sendList;
	}
	
	
	
	
	
	// 쪽지 첨부파일 없는 경우
	@Override
	public int sendjjokji(JjokjiVO jjokjivo) {
		int n = dao.sendjjokji(jjokjivo);  //의존객체인 dao에 보내기
		return n;
	}
	
	
	
	// 쪽지 첨부파일이 있는 경우
	@Override
	public int sendjjokji_withFile(JjokjiVO jjokjivo) {
		int n = dao.sendjjokji_withFile(jjokjivo);  // 첨부파일이 있는 경우
		return n;
	}
	
	
	
	
	// 수신함 총 게시물 건수
	@Override
	public int receiveTotalCount(Map<String, String> paraMap) {
		int n = dao.receiveTotalCount(paraMap);
		return n;
	}
	
	
	// 발신함 총 게시물 건수
	@Override
	public int sendTotalCount(Map<String, String> paraMap) {
		int n = dao.sendTotalCount(paraMap);
		return n;
	}
	
	
	
	
	// 쪽지 첨부파일 다운로드 받기 
	@Override
	public JjokjiVO getjjokjiList(Map<String, String> paraMap) {
		JjokjiVO jjokjivo = dao.getjjokjiList(paraMap); 
		return jjokjivo;
	}
	
	
	
	//////////////////////////////////////////////////////////////////////////////////
	
	// 쪽지 보내기 과목 및 과목번호 가져오기
	@Override
	public List<DepartmentVO> getDeptList() {
		List<DepartmentVO> getDeptList = dao.getDeptList();
		return getDeptList;
	}
	
	
	
	
	// 쪽지 보내기 담당교수 가져오기 
	@Override
	public List<MemberVO> getTeacherList(Map<String, String> paraMap) {
		List<MemberVO> teacherList = dao.getTeacherList(paraMap);
		return teacherList;
	}
	
	
//==============================================================================================
	
	
	// 수신함,발신함 쪽지 삭제하기(Ajax 로 처리)
	@Override
	public int jjokjiListDel(Map<String, String[]> map) {
		int n = dao.jjokjiListDel(map);
		return n;
	}
	
//==============================================================================================
		
	
	
	
	
	
	
	
	
}//end of public class BoardService implements InterBoardService {
