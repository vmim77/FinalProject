package com.spring.univ.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.univ.model.*;

@Service
public class HyunService implements InterHyunService {
	
	@Autowired
	private InterHyunDAO dao; // 다형성
	
// ================================================================================================
// ========================= *************** QnA(문의게시판) *************** =========================
	// 파일첨부가 없는 글쓰기
	@Override
	public int QnAAdd(QnAVO QnAvo) {
		
		// === #144. 글쓰기가 원글쓰기인지 아니면 답변글쓰기인지를 구분하여
		//           tbl_board 테이블에 insert를 해주어야 한다.
		//           원글쓰기 이라면 tbl_board 테이블에 groupno 컬럼의 값은 
		//           groupno 컬럼의 최대값(max)+1 로 해서 insert 해야하고,
		//			  답변글쓰기 이라면 넘겨받은 값(boardvo)을 그대로 insert 해주어야 한다.
		
		// === 원글쓰기인지 답변글쓰기인지 구분하기 시작 === //
		if("".equals(QnAvo.getFk_seq())) { 
			// 이러면 원글쓰기임, 아까 폼태그로 보내기전에 컨트롤러에서 null이면 ""을 넣어줌
			// groupno 컬럼의 값은  groupno 컬럼의 최대값(max)+1 로 해야 한다.
			int groupno = dao.getQnAGroupnoMax() + 1;
			QnAvo.setGroupno(String.valueOf(groupno));
		}
		
		int n = dao.QnAAdd(QnAvo);
		return n;
	}
	
	
	// 글 조회수 증가와 함께 글 1개를 보여주는 것
	@Override
	public QnAVO getQnAView(Map<String, String> paraMap, String login_userid) {
	
		// 글 1개를 조회해주는 함수 호출
		QnAVO QnAvo = dao.getQnAView(paraMap);
		
		if(login_userid != null && QnAvo != null && !(login_userid.equals(QnAvo.getFk_hakbun()))) {
			
			// 글 조회수 1 증가시키는 함수 - 글 번호만 넘겨준다.
			dao.setQnAAddReadCount(QnAvo.getSeq()); 
			QnAvo = dao.getQnAView(paraMap); // 조회수가 증가된 상태로 다시 한 번 호출하기
		}
		
		return QnAvo;
	}
	
	
	// 새로고침을 통해 조회수 1증가 막기
	@Override
	public QnAVO getQnAWithNoAddCount(Map<String, String> paraMap) {
		QnAVO QnAvo = dao.getQnAView(paraMap);
		return QnAvo;
	}
	
	
	// 글 수정하기
	@Override
	public int QnAEdit(QnAVO QnAvo) {
		int n = dao.QnAEdit(QnAvo);
		return n;
	}
	
	
	// 글 삭제하기
	@Override
	public int QnADel(QnAVO QnAvo) {
		int n = dao.QnADel(QnAvo);
		return n;
	}
	
	
	// 검색어 입력시 자동글 완성하기3
	@Override
	public List<String> QnAWordSearchShow(Map<String, String> paraMap) {
		List<String> wordList =  dao.QnAWordSearchShow(paraMap);
		return wordList;
	}
	
	
	// 총 게시물 건수(totalCount) 구하기 ==> 검색이 있을떄 || 검색이 없을때 로 나뉜다
	@Override
	public int getQnATotalCount(Map<String, String> paraMap) {
		int n = dao.getQnATotalCount(paraMap);
		return n;
	}
	
	
	// 페이징 처리한 글 목록 가져오기(검색의 유무와 상관 없이 모두 호환 가능하다)
	@Override
	public List<QnAVO> QnASearchWithPaging(Map<String, String> paraMap) {
		List<QnAVO> QnAList = dao.QnASearchWithPaging(paraMap);
		return QnAList;
	}
// ======================== *************** QnA(문의게시판) 끝  *************** ========================
// ================================================================================================

	
	
	
	
	
// ================================================================================================
// ======================== *************** Notice(공지사항) *************** ========================
	// 파일첨부가 없는 글쓰기
	@Override
	public int noticeAdd(NoticeVO noticevo) {
		int n = dao.noticeAdd(noticevo);
		return n;
	}
	
	
	// 글 조회수 증가와 함께 글 1개를 보여주는 것
	@Override
	public NoticeVO getNoticeView(Map<String, String> paraMap, String login_userid) {
	
		// 글 1개를 조회해주는 함수 호출
		NoticeVO noticevo = dao.getNoticeView(paraMap);
		
		if(login_userid != null && noticevo != null && !(login_userid.equals(noticevo.getFk_hakbun()))) {
			
			// 글 조회수 1 증가시키는 함수 - 글 번호만 넘겨준다.
			dao.setNoticeAddReadCount(noticevo.getSeq()); 
			noticevo = dao.getNoticeView(paraMap); // 조회수가 증가된 상태로 다시 한 번 호출하기
		}
		
		return noticevo;
	}
	
	
	// 새로고침을 통해 조회수 1증가 막기
	@Override
	public NoticeVO getNoticeWithNoAddCount(Map<String, String> paraMap) {
		NoticeVO noticevo = dao.getNoticeView(paraMap);
		return noticevo;
	}
	
	
	// 1개글 수정하기
	@Override
	public int noticeEdit(NoticeVO noticevo) {
		int n = dao.noticeEdit(noticevo);
		return n;
	}
	
	
	// 글 삭제하기
	@Override
	public int noticeDel(NoticeVO noticevo) {
		int n = dao.noticeDel(noticevo);
		return n;
	}
	
	
	// 댓글쓰기(트랜잭션 처리하기)
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int addNoticeComment(NoticeCommentVO noticecommentvo) throws Throwable{
		
		int n=0, m=0;
		
		// 댓글쓰기(tbl_comment 테이블에 insert)
		n = dao.addNoticeComment(noticecommentvo);
		
		if(n==1) {
			// tbl_board 테이블에 commentCount 컬럼이 1증가(update)
			m = dao.updateNoticeCommentCount(noticecommentvo.getParentSeq());
		}
		
		return m;
		
	}
	
	
	// 원게시물에 있는 댓글들을 조회
	@Override
	public List<NoticeCommentVO> getNoticeCommentList(String parentSeq) {
		List<NoticeCommentVO> noticecommentList = dao.getNoticeCommentList(parentSeq);
		return noticecommentList;
	}
	
	
	// 검색어 입력시 자동글 완성하기3
	@Override
	public List<String> noticeWordSearchShow(Map<String, String> paraMap) {
		List<String> wordList =  dao.noticeWordSearchShow(paraMap);
		return wordList;
	}
	
	
	// 총 게시물 건수(totalCount) 구하기 ==> 검색이 있을떄 || 검색이 없을때 로 나뉜다
	@Override
	public int getNoticeTotalCount(Map<String, String> paraMap) {
		int n = dao.getNoticeTotalCount(paraMap);
		return n;
	}
	
	
	// 페이징 처리한 글 목록 가져오기(검색의 유무와 상관 없이 모두 호환 가능하다)
	@Override
	public List<NoticeVO> noticeListSearchWithPaging(Map<String, String> paraMap) {
		List<NoticeVO> noticeList = dao.noticeListSearchWithPaging(paraMap);
		return noticeList;
	}
	
	
	// 원게시물에 있는 댓글들을페이징 처리해서 조회해오기	
	@Override
	public List<NoticeCommentVO> getNoticeCommentListPaging(Map<String, String> paraMap) {
		List<NoticeCommentVO> noticecommentList = dao.getNoticeCommentListPaging(paraMap);
		return noticecommentList;
	}
	
	
	// 원글 글번호(parentSeq)에 해당하는 댓글의 총개수를 알아오기
	@Override
	public int getNoticeCommentTotalCount(Map<String, String> paraMap) {
		int totalCount = dao.getNoticeCommentTotalCount(paraMap);
		return totalCount;
	}
// ======================= *************** Notice(공지사항) 끝  *************** =======================
// ================================================================================================

	
	
	
	
	
	
}



