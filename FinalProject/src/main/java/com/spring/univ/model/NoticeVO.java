package com.spring.univ.model;

public class NoticeVO {
	
	private String seq;				// 글번호
	private String fk_hakbun;		// 사용자학번
	private String fk_code;			// 과목코드
	private String name;			// 글쓴이
	private String subject;			// 글제목
	private String content;			// 글내용
	private String readCount;		// 글조회수
	private String regDate;			// 글쓴시간
	private String status;			// 글삭제여부   1:사용가능한 글,  0:삭제된글
	private String commentCount;	// 조회수
	
	private String previousseq;		// 이전글번호 //숫자는 int로 안써도 됨. String써도 다 호환됨.
	private String previoussubject;	// 이전글제목
	private String nextseq;			// 다음글번호
	private String nextsubject;		// 다음글제목
	
	
	
	public NoticeVO() {}
	
	public NoticeVO(String seq, String fk_hakbun, String name, String fk_code, String subject, String content, String pw,
			String readCount, String regDate, String status, String commentCount) {
		this.seq = seq;
		this.fk_hakbun = fk_hakbun;
		this.fk_code = fk_code;
		this.name = name;
		this.subject = subject;
		this.content = content;
		this.readCount = readCount;
		this.regDate = regDate;
		this.status = status;
		this.commentCount = commentCount;
	}
	
	
	
	
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	
	public String getFk_hakbun() {
		return fk_hakbun;
	}
	public void setFk_hakbun(String fk_hakbun) {
		this.fk_hakbun = fk_hakbun;
	}
	
	public String getFk_code() {
		return fk_code;
	}
	public void setFk_code(String fk_code) {
		this.fk_code = fk_code;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public String getReadCount() {
		return readCount;
	}
	public void setReadCount(String readCount) {
		this.readCount = readCount;
	}

	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

	public String getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(String commentCount) {
		this.commentCount = commentCount;
	}

	

	public String getPreviousseq() {
		return previousseq;
	}
	public void setPreviousseq(String previousseq) {
		this.previousseq = previousseq;
	}
	
	public String getPrevioussubject() {
		return previoussubject;
	}
	public void setPrevioussubject(String previoussubject) {
		this.previoussubject = previoussubject;
	}
	
	public String getNextseq() {
		return nextseq;
	}
	public void setNextseq(String nextseq) {
		this.nextseq = nextseq;
	}
	
	public String getNextsubject() {
		return nextsubject;
	}
	public void setNextsubject(String nextsubject) {
		this.nextsubject = nextsubject;
	}
	

	
}
