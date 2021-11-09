package com.spring.univ.model;


//=== #52. VO 생성하기
//먼저, 오라클에서 tbl_board 테이블을 생성해야 한다.
public class FreeBoardVO {
	
	/////////////////////////////////////////////////////////////////////
	
	private String seq;       // 글번호
	private String fk_hakbun; // 사용자학번
	private String name;      // 글쓴이 
	private String subject;   // 글제목
	private String content;   // 글내용   -- clob (최대 4GB까지 허용) 
	private String pw;        // 글암호
	private String readCount; // 글조회수
	private String regDate;   // 글쓴시간
	private int status;       // 글삭제여부   1:사용가능한 글,  0:삭제된글
	private int commentCount; // 조회수
	private String fk_code;   // 과목코드
	
	/////////////////////////////////////////////////////////////////////
	
	// 아래 네가지는 select용이라서 // insert용 **라고 적힌 부분에 파라미터안에 넣지 않아도 됨.
   
	private String previousseq;      // 이전글번호 //숫자는 int로 안써도 됨. String써도 다 호환됨.
	private String previoussubject;  // 이전글제목
	private String nextseq;          // 다음글번호
	private String nextsubject;      // 다음글제목

	public FreeBoardVO() {}
	
	public FreeBoardVO(String seq, String fk_hakbun, String name, String fk_code, String subject, String content, String pw,
			String readCount, String regDate, int status, int commentCount) {
		this.seq = seq;
		this.fk_hakbun = fk_hakbun;
		this.name = name;
		this.fk_code = fk_code;
		this.subject = subject;
		this.content = content;
		this.pw = pw;
		this.readCount = readCount;
		this.regDate = regDate;
		this.status = status;
		this.commentCount = commentCount;
	}

	/////////////////////////////////////////////////////////////////////
	
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

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}

	/////////////////////////////////////////////////////////////////////


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
	
	//////////////////////////////////////////////////과목코드 추가
	
	public String getFk_code() {
		return fk_code;
	}
	
	public void setFk_code(String fk_code) {
		this.fk_code = fk_code;
	}
	




}
