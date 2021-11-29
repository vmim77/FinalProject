package com.spring.univ.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class HyunDAO implements InterHyunDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession2; // 원격DB 연결
	// Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의 sqlsession2 bean 을  sqlsession2 에 주입시켜준다. 
    // 그러므로 sqlsession2 는 null 이 아니다.
	
// ================================================================================================
// ========================= *************** QnA(문의게시판) *************** =========================
	// 글쓰기(파일첨부가 없는 글쓰기)
	@Override
	public int QnAAdd(QnAVO QnAvo) {
		int n = sqlsession2.insert("Hyun.QnAAdd", QnAvo);
		return n;
	}
	
	// tbl_QnA 테이블에서 groupno 컬럼의 최대값 알아오기
	@Override
	public int getQnAGroupnoMax() {
		int max = sqlsession2.selectOne("Hyun.getQnAGroupnoMax");
		return max;
	}
	
	// 글 조회수 증가와 함께 글 1개를 보여주는 것
	@Override
	public QnAVO getQnAView(Map<String, String> paraMap) {
		QnAVO QnAvo = sqlsession2.selectOne("Hyun.getQnAView", paraMap);
		return QnAvo;
	}
	
	
	// 글 조회수 1 증가시키는 함수
	@Override
	public void setQnAAddReadCount(String seq) {
		sqlsession2.update("Hyun.setQnAAddReadCount", seq); // 조회수 업데이트하기
	}
	
	
	// 글 수정하기
	@Override
	public int QnAEdit(QnAVO QnAvo) {
		int n = sqlsession2.update("Hyun.QnAEdit", QnAvo);
		return n;
	}
	
	
	// 글 삭제하기
	@Override
	public int QnADel(QnAVO QnAvo) {
		int n = sqlsession2.delete("Hyun.QnADel", QnAvo);
		return n;
	}
	
	
	// 검색어 입력시 자동글 완성하기3
	@Override
	public List<String> QnAWordSearchShow(Map<String, String> paraMap) {
		List<String> wordList = sqlsession2.selectList("Hyun.QnAWordSearchShow", paraMap);
		return wordList;
	}
	
	
	// 총 게시물 건수(totalCount) 구하기 ==> 검색이 있을떄 || 검색이 없을때 로 나뉜다
	@Override
	public int getQnATotalCount(Map<String, String> paraMap) {
		int n = sqlsession2.selectOne("Hyun.getQnATotalCount", paraMap);
		return n;
	}
	
	
	// 페이징 처리한 글 목록 가져오기(검색의 유무와 상관 없이 모두 호환 가능하다)
	@Override
	public List<QnAVO> QnASearchWithPaging(Map<String, String> paraMap) {
		List<QnAVO> QnAList = sqlsession2.selectList("Hyun.QnASearchWithPaging", paraMap);
		return QnAList;
	}
// ======================== *************** QnA(문의게시판) 끝 *************** ========================
// ================================================================================================

	
	
	
// ================================================================================================
// ======================== *************** Notice(공지사항) *************** ========================
	// 글쓰기(파일첨부가 없는 글쓰기)
	@Override
	public int noticeAdd(NoticeVO noticevo) {
		int n = sqlsession2.insert("Hyun.noticeAdd", noticevo);
		return n;
	}
	
	
	// 글 조회수 증가와 함께 글 1개를 보여주는 것
	@Override
	public NoticeVO getNoticeView(Map<String, String> paraMap) {
		NoticeVO noticevo = sqlsession2.selectOne("Hyun.getNoticeView", paraMap);
		return noticevo;
	}
	
	
	// 글 조회수 1 증가시키는 함수
	@Override
	public void setNoticeAddReadCount(String seq) {
		sqlsession2.update("Hyun.setNoticeAddReadCount", seq); // 조회수 업데이트하기
	}
	
	
	// 1개글 수정하기
	@Override
	public int noticeEdit(NoticeVO noticevo) {
		int n = sqlsession2.update("Hyun.noticeEdit", noticevo);
		return n;
	}
	
	
	// 글 삭제하기
	@Override
	public int noticeDel(NoticeVO noticevo) {
		int n = sqlsession2.delete("Hyun.noticeDel", noticevo);
		return n;
	}
	
	
	// 댓글쓰기(트랜잭션 처리하기)
	@Override
	public int addNoticeComment(NoticeCommentVO noticecommentvo) {
		int n = sqlsession2.insert("Hyun.addNoticeComment", noticecommentvo);
		return n;
	}
	
	
	// tbl_board 테이블에 commentCount 컬럼이 1증가(update) 
	@Override
	public int updateNoticeCommentCount(String parentSeq) {
		int n = sqlsession2.update("Hyun.updateNoticeCommentCount", parentSeq);
		return n;
	}
	
	
	// 원게시물에 있는 댓글들을 조회
	@Override
	public List<NoticeCommentVO> getNoticeCommentList(String parentSeq) {
		List<NoticeCommentVO> noticecommentList = sqlsession2.selectList("Hyun.getNoticeCommentList", parentSeq); 
		return noticecommentList;
	}
	
	
	// 검색어 입력시 자동글 완성하기
	@Override
	public List<String> noticeWordSearchShow(Map<String, String> paraMap) {
		List<String> wordList = sqlsession2.selectList("Hyun.noticeWordSearchShow", paraMap);
		return wordList;
	}
	
	
	// 총 게시물 건수(totalCount) 구하기 ==> 검색이 있을떄 || 검색이 없을때 로 나뉜다
	@Override
	public int getNoticeTotalCount(Map<String, String> paraMap) {
		int n = sqlsession2.selectOne("Hyun.getNoticeTotalCount", paraMap);
		return n;
	}
	
	
	// 페이징 처리한 글 목록 가져오기(검색의 유무와 상관 없이 모두 호환 가능하다)
	@Override
	public List<NoticeVO> noticeListSearchWithPaging(Map<String, String> paraMap) {
		List<NoticeVO> noticeList = sqlsession2.selectList("Hyun.noticeListSearchWithPaging", paraMap);
		return noticeList;
	}
	
	
	// 원게시물에 있는 댓글들을페이징 처리해서 조회해오기	
	@Override
	public List<NoticeCommentVO> getNoticeCommentListPaging(Map<String, String> paraMap) {
		List<NoticeCommentVO> noticecommentList = sqlsession2.selectList("Hyun.getNoticeCommentListPaging", paraMap);
		return noticecommentList;
	}
	
	
	// 원글 글번호(parentSeq)에 해당하는 댓글의 총개수를 알아오기
	@Override
	public int getNoticeCommentTotalCount(Map<String, String> paraMap) {
		int totalCount = sqlsession2.selectOne("Hyun.getNoticeCommentTotalCount", paraMap);
		return totalCount;
	}
// ======================= *************** Notice(공지사항) 끝  *************** =======================
// ================================================================================================

	

	
	
}




