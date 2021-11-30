package com.spring.univ.model;

import java.util.List;
import java.util.Map;

public interface InterHyunDAO {
	
// ================================================================================================
// ========================= *************** QnA(문의게시판) *************** =========================
	// 글쓰기(파일첨부가 없는 글쓰기)
	int QnAAdd(QnAVO QnAvo);
	
	// 글 조회수 증가와 함께 글 1개를 보여주는 것
	QnAVO getQnAView(Map<String, String> paraMap);
	
	// 글 조회수 1 증가시키는 함수
	void setQnAAddReadCount(String seq); 		

	// 글 수정하기
	int QnAEdit(QnAVO QnAvo);

	// 글 삭제하기
	int QnADel(QnAVO QnAvo);

	// 검색어 입력시 자동글 완성하기3
	List<String> QnAWordSearchShow(Map<String, String> paraMap);

	// 총 게시물 건수(totalCount) 구하기 ==> 검색이 있을떄 || 검색이 없을때 로 나뉜다
	int getQnATotalCount(Map<String, String> paraMap);

	// 페이징 처리한 글 목록 가져오기(검색의 유무와 상관 없이 모두 호환 가능하다)
	List<QnAVO> QnASearchWithPaging(Map<String, String> paraMap);
	
	// tbl_QnA 테이블에서 groupno 컬럼의 최대값 구하기
	int getQnAGroupnoMax();
// ======================== *************** QnA(문의게시판) 끝 *************** ========================
// ================================================================================================

	
	
	
	
// ================================================================================================
// ======================== *************** Notice(공지사항) *************** ========================
	// 글쓰기(파일첨부가 없는 글쓰기)
	int noticeAdd(NoticeVO noticevo);
	
	// 글 조회수 증가와 함께 글 1개를 보여주는 것
	NoticeVO getNoticeView(Map<String, String> paraMap);
	
	// 글 조회수 1 증가시키는 함수
	void setNoticeAddReadCount(String seq); 		

	// 1개글 수정하기
	int noticeEdit(NoticeVO noticevo);

	// 글 삭제하기
	int noticeDel(NoticeVO noticevo);

	// 검색어 입력시 자동글 완성하기3
	List<String> noticeWordSearchShow(Map<String, String> paraMap);

	// 총 게시물 건수(totalCount) 구하기 ==> 검색이 있을떄 || 검색이 없을때 로 나뉜다
	int getNoticeTotalCount(Map<String, String> paraMap);

	// 페이징 처리한 글 목록 가져오기(검색의 유무와 상관 없이 모두 호환 가능하다)
	List<NoticeVO> noticeListSearchWithPaging(Map<String, String> paraMap);
// ======================= *************** Notice(공지사항) 끝  *************** =======================
// ================================================================================================
	
	
	
	
// ================================================================================================
// ======================= *************** Calendar(일정)  *************** =======================
	// 로그인한 사용자의 일정 뽑아오기
	List<CalendarVO> getCalendar(Map<String, String> paraMap);
	
	// 일정 추가
	void calendarAdd(CalendarVO calendarvo);
// ======================= *************** Calendar(일정) 끝  *************** =======================
// ================================================================================================
	
	
}




