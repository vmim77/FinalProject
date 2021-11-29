package com.spring.univ.model;

public class QnAVO {
	
	private String seq;			// 글번호
	private String fk_hakbun;	// 사용자학번
	private String fk_code;		// 과목코드
	private String name;		// 글쓴이 
	private String subject;		// 글제목
	private String content;		// 글내용   -- clob (최대 4GB까지 허용)
	private String readCount;	// 글조회수
	private String regDate;		// 글쓴시간
	private String status;			// 글삭제여부   1:사용가능한 글,  0:삭제된글
	
	
	/////////////////////////////////////////////////////////////////////////////////
	// select용!!!
	private String previousseq;      // 이전글번호 //숫자는 int로 안써도 됨. String써도 다 호환됨.
	private String previoussubject;  // 이전글제목
	private String nextseq;          // 다음글번호
	private String nextsubject;      // 다음글제목
	/////////////////////////////////////////////////////////////////////////////////
	
	
	private String groupno;
	/*
	   답변글쓰기에 있어서 그룹번호 
           원글(부모글)과 답변글은 동일한 groupno 를 가진다.
           답변글이 아닌 원글(부모글)인 경우 groupno 의 값은 groupno 컬럼의 최대값(max)+1 로 한다.
	 */
	
	private String fk_seq;
	/*
	   fk_seq 컬럼은 절대로 foreign key가 아니다.!!!!!!
       fk_seq 컬럼은 자신의 글(답변글)에 있어서 
              원글(부모글)이 누구인지에 대한 정보값이다.
              답변글쓰기에 있어서 답변글이라면 fk_seq 컬럼의 값은 
              원글(부모글)의 seq 컬럼의 값을 가지게 되며,
              답변글이 아닌 원글일 경우 0 을 가지도록 한다.
	 */
	
	private String depthno;
	/*
	   답변글쓰기에 있어서 답변글 이라면
           원글(부모글)의 depthno + 1 을 가지게 되며,
           답변글이 아닌 원글일 경우 0 을 가지도록 한다.
	 */
	
	
	
	public QnAVO() {}
	
	public QnAVO(String seq, String fk_hakbun, String fk_code, String name, String subject, String content,
			String readCount, String regDate, String status) {
		
		this.seq = seq;
		this.fk_hakbun = fk_hakbun;
		this.fk_code = fk_code;
		this.name = name;
		this.subject = subject;
		this.content = content;
		this.readCount = readCount;
		this.regDate = regDate;
		this.status = status;
		this.groupno = groupno;
		this.fk_seq = fk_seq;
		this.depthno = depthno;
		
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

	
	/////////////////////////////////////////////////////////////////////////////
	
	
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
	
	
	
	
	public String getGroupno() {
		return groupno;
	}

	public void setGroupno(String groupno) {
		this.groupno = groupno;
	}

	public String getFk_seq() {
		return fk_seq;
	}

	public void setFk_seq(String fk_seq) {
		this.fk_seq = fk_seq;
	}

	public String getDepthno() {
		return depthno;
	}

	public void setDepthno(String depthno) {
		this.depthno = depthno;
	}
	
	
	
	
	
	
	
	
}
