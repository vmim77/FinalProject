package com.spring.univ.service;

import java.util.*;

import com.spring.univ.model.DepartmentVO;
import com.spring.univ.model.FreeBoardVO;
import com.spring.univ.model.FreeCommentVO;
import com.spring.univ.model.JjokjiVO;
import com.spring.univ.model.MemberVO;

public interface InterRuService {
	// 열린게시판 //
	
	// 글쓰기(파일첨부가 없는 글쓰기)
	int add(FreeBoardVO Freeboardvo);
	
	// 글 조회수 증가와 함께 글 1개를 보여주는 것
	FreeBoardVO getView(Map<String, String> paraMap, String login_userid);

	// 새로고침을 통해 조회수 1증가 막기
	FreeBoardVO getWithNoAddCount(Map<String, String> paraMap);

	// 1개글 수정하기
	int edit(FreeBoardVO freecommentvo);

	// 글 삭제하기
	int del(FreeBoardVO freecommentvo);

	// 댓글쓰기(트랜잭션 처리하기)
	int addComment(FreeCommentVO freecommentvo) throws Throwable;

	// 원게시물에 있는 댓글들을 조회
	List<FreeCommentVO> getCommentList(String parentSeq);

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

	
	////////////////////////////////////////////////////////////
	//쪽지//
	
	// 쪽지 수신함 페이지 목록 가져오기
	
	List<Map<String,String>> receiveList(Map<String, String> paraMap);
	
	// 쪽지 발신함 페이지 목록 가져오기
	List<Map<String,String>> sendList(Map<String, String> paraMap);
	
	
	// 쪽지 첨부파일 없는 경우
	int sendjjokji(JjokjiVO jjokjivo);

	// 쪽지 첨부파일이 있는 경우
	int sendjjokji_withFile(JjokjiVO jjokjivo);

	// 수신함 총 게시물 건수
	int receiveTotalCount(Map<String, String> paraMap);

	// 발신함 총 게시물 건수
	int sendTotalCount(Map<String, String> paraMap);

	// 쪽지 첨부파일 다운로드 받기 
	JjokjiVO getjjokjiList(Map<String, String> paraMap);

	
	//////////////////////////////////////////////////////////////////////////////////
	
	// 쪽지 보내기 과목 및 과목번호 가져오기
	List<DepartmentVO> getDeptList();
    
	// 쪽지 보내기 담당교수 가져오기 
	List<MemberVO> getTeacherList(Map<String, String> paraMap);

	// 수신함,발신함 쪽지 삭제하기(Ajax 로 처리)
	int jjokjiListDel(Map<String, String[]> map);

	

	
	
}//end of public interface InterBoardService {
