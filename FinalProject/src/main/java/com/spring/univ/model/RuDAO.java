package com.spring.univ.model;

import java.util.*;
import javax.annotation.Resource;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class RuDAO implements InterRuDAO {

	@Resource
	private SqlSessionTemplate sqlsession2; // 원격DB에 연결
	
	
//================================================================================================	
	// 글쓰기(파일첨부가 없는 글쓰기)
	@Override
	public int add(FreeBoardVO freeboardvo) {
		int n = sqlsession2.insert("Ru.add", freeboardvo);
		return n;
	}//end of public int add(BoardVO boardvo)-----------------------------------------------------
//================================================================================================
	// 글 조회수 증가와 함께 글 1개를 보여주는 것
	@Override
	public FreeBoardVO getView(Map<String, String> paraMap) {
		FreeBoardVO freeboardvo = sqlsession2.selectOne("Ru.getView", paraMap);
		return freeboardvo;
	}//end of public BoardVO getView(Map<String, String> paraMap)---------------------------------
//================================================================================================
	// 글 조회수 1 증가시키는 함수
	@Override
	public void setAddReadCount(String seq) {
		sqlsession2.update("Ru.setAddReadCount", seq); // 조회수 업데이트하기
	}//end of public void setAddReadCount(String seq)---------------------------------------------
//================================================================================================
	// 1개글 수정하기
	@Override
	public int edit(FreeBoardVO freeboardvo) {
		int n = sqlsession2.update("Ru.edit", freeboardvo);
		return n;
	}//end of public int edit(BoardVO boardvo) {--------------------------------------------------
//================================================================================================
	// 글 삭제하기
	@Override
	public int del(FreeBoardVO freeboardvo) {
		int n = sqlsession2.delete("Ru.del", freeboardvo);
		return n;
	}//end of public int del(BoardVO boardvo) {---------------------------------------------------
//================================================================================================
	// 댓글쓰기(트랜잭션 처리하기)
	@Override
	public int addComment(FreeCommentVO freecommentvo) {
		int n = sqlsession2.insert("Ru.addComment", freecommentvo);
		return n;
	}//end of public int addComment(CommentVO commentvo) {----------------------------------------
	// tbl_board 테이블에 commentCount 컬럼이 1증가(update) 
	@Override
	public int updateCommentCount(String parentSeq) {
		int n = sqlsession2.update("Ru.updateCommentCount", parentSeq);
		return n;
	}//end of public int updateCommentCount(String parentSeq) {-----------------------------------
//================================================================================================
	// 원게시물에 있는 댓글들을 조회
	@Override
	public List<FreeCommentVO> getFreeCommentList(String parentSeq) {
		List<FreeCommentVO> freecommentList = sqlsession2.selectList("Ru.getCommentList", parentSeq); 
		return freecommentList;
	}//end of public List<CommentVO> getCommentList(String parentSeq) {---------------------------
//================================================================================================
	// 검색어 입력시 자동글 완성하기3
	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> wordList = sqlsession2.selectList("Ru.wordSearchShow", paraMap);
		return wordList;
	}//end of public List<String> wordSearchShow(Map<String, String> paraMap) {-------------------
//================================================================================================
	// 총 게시물 건수(totalCount) 구하기 ==> 검색이 있을떄 || 검색이 없을때 로 나뉜다
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = sqlsession2.selectOne("Ru.getTotalCount", paraMap);
		return n;
	}//end of public int getTotalCount(Map<String, String> paraMap) {-----------------------------
//================================================================================================
	// 페이징 처리한 글 목록 가져오기(검색의 유무와 상관 없이 모두 호환 가능하다)
	@Override
	public List<FreeBoardVO> boardListSearchWithPaging(Map<String, String> paraMap) {
		List<FreeBoardVO> freeboardList = sqlsession2.selectList("Ru.boardListSearchWithPaging", paraMap);
		return freeboardList;
	}//end of public List<BoardVO> boardListSearchWithPaging(Map<String, String> paraMap) {-------
//================================================================================================
	// 원게시물에 있는 댓글들을페이징 처리해서 조회해오기	
	@Override
	public List<FreeCommentVO> getCommentListPaging(Map<String, String> paraMap) {
		List<FreeCommentVO> freecommentList = sqlsession2.selectList("Ru.getCommentListPaging", paraMap);
		return freecommentList;
	}//end of public List<CommentVO> getCommentListPaging(Map<String, String> paraMap) {----------
//================================================================================================
	// 원글 글번호(parentSeq)에 해당하는 댓글의 총개수를 알아오기
	@Override
	public int getCommentTotalCount(Map<String, String> paraMap) {
		int totalCount = sqlsession2.selectOne("Ru.getCommentTotalCount", paraMap);
		return totalCount;
	}//end of public int getCommentTotalCount(Map<String, String> paraMap) {
//================================================================================================
	
	
	
	
	// 쪽지 수신함 페이지 목록 가져오기
	
	@Override
	public List<Map<String,String>>  receiveList(Map<String, String> paraMap) {
		List<Map<String,String>>  receiveList= sqlsession2.selectList("Ru.receiveList", paraMap);
		return receiveList;
	}
	
	
	
	
	// 쪽지 발신함 페이지 목록 가져오기
	
		@Override
		public List<Map<String,String>>  sendList(Map<String, String> paraMap) {
			List<Map<String,String>> sendList= sqlsession2.selectList("Ru.sendList", paraMap);
			return sendList;
		}
	
	
	
	// 쪽지 첨부파일 없는 경우
	@Override
	public int sendjjokji(JjokjiVO jjokjivo) {
		int n = sqlsession2.insert("Ru.sendjjokji", jjokjivo); 
		return n;
	}
	
	
	// 쪽지 첨부파일이 있는 경우
	@Override
	public int sendjjokji_withFile(JjokjiVO jjokjivo) {
		int n = sqlsession2.insert("Ru.sendjjokji_withFile", jjokjivo); 
		return n;
	}
	
	
	// 수신함 총 게시물 건수
	@Override
	public int receiveTotalCount(Map<String, String> paraMap) {
		int n = sqlsession2.selectOne("Ru.receiveTotalCount", paraMap);
		return n;
	}
	
	
	
	// 발신함 총 게시물 건수
	@Override
	public int sendTotalCount(Map<String, String> paraMap) {
		int n = sqlsession2.selectOne("Ru.sendTotalCount", paraMap);
		return n;
	}
	
	
	
	// 쪽지 첨부파일 다운로드 받기 
	@Override
	public JjokjiVO getjjokjiList(Map<String, String> paraMap) {
		JjokjiVO jjokjivo = sqlsession2.selectOne("Ru.getjjokjiList", paraMap); //글번호 담긴 맵을 파라미터에 넣음 
		return jjokjivo;
	}
	
	
	//////////////////////////////////////////////////////////////////////////////////
	
	
	
	// 쪽지 보내기 과목 및 과목번호 가져오기
	@Override
	public List<DepartmentVO> getDeptList() {
		 List<DepartmentVO> getDeptList = sqlsession2.selectList("Ru.getDeptList");
		return getDeptList;
	}
	
	
	
	
	// 쪽지 보내기 담당교수 가져오기 
	@Override
	public List<MemberVO> getTeacherList(Map<String, String> paraMap) {
		List<MemberVO> getTeacherList = sqlsession2.selectList("Ru.getTeacherList");
		return getTeacherList;
	}
	
	
	
	
	
	
//================================================================================================
		
	
	
	
	
	
	
}//end of public class BoardDAO implements InterBoardDAO {