package com.spring.univ.model;

import java.util.*;

public interface InterFreeBoardDAO {
	
	// 글쓰기(파일첨부가 없는 글쓰기)
	int add(FreeBoardVO Freeboardvo);
	
	// 글 조회수 증가와 함께 글 1개를 보여주는 것
	FreeBoardVO getView(Map<String, String> paraMap);
	
	// 글 조회수 1 증가시키는 함수
	void setAddReadCount(String seq); 		

	// 1개글 수정하기
	int edit(FreeBoardVO freecommentvo);

	// 글 삭제하기
	int del(FreeBoardVO freecommentvo);

	// 댓글쓰기(트랜잭션 처리하기)
	int addComment(FreeCommentVO freecommentvo) throws Throwable;

	// tbl_board 테이블에 commentCount 컬럼이 1증가(update)
	int updateCommentCount(String parentSeq);	
	
	// 원게시물에 있는 댓글들을 조회
	List<FreeCommentVO> getFreeCommentList(String parentSeq);

	// 검색어 입력시 자동글 완성하기3
	List<String> wordSearchShow(Map<String, String> paraMap);

	// 총 게시물 건수(totalCount) 구하기 ==> 검색이 있을떄 || 검색이 없을때 로 나뉜다
	int getTotalCount(Map<String, String> paraMap);

	// 페이징 처리한 글 목록 가져오기(검색의 유무와 상관 없이 모두 호환 가능하다)
	List<FreeBoardVO> boardListSearchWithPaging(Map<String, String> paraMap);

	// 원게시물에 있는 댓글들을페이징 처리해서 조회해오기
	List<FreeCommentVO> getCommentListPaging(Map<String, String> paraMap);

	// 원글 글번호(parentSeq)에 해당하는 댓글의 총개수를 알아오기
	int getCommentTotalCount(Map<String, String> paraMap);

	// 과목 가져오기 
	List<WeekVO> getWeekList();


	
}//end of public interface InterBoardDAO {
