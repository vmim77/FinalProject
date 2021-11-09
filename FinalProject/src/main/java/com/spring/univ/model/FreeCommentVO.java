package com.spring.univ.model;

public class FreeCommentVO {

	/////////////////////////////////////////////////////////////////////
	
	private String seq;        // 댓글번호
	private String fk_hakbun;  // 사용자학번
	private String name;       // 성명
	private String content;    // 댓글내용
	private String regDate;    // 작성일자
	private String parentSeq;     // 원게시물 글번호
	private int status;        // 글삭제여부 ( 1사용가능한 글,  0 삭제된 글, 댓글은 원글이 삭제되면 자동적으로 삭제되어야 한다) _
	private String fk_code;   // 과목코드 추가                                             
	/////////////////////////////////////////////////////////////////////
	                                               
	public FreeCommentVO() {}
	
	public FreeCommentVO(String seq, String fk_hakbun,String name, String fk_code, String content,String regDate,String parentSeq,int status) {
		this.seq = seq;
		this.fk_hakbun = fk_hakbun;
		this.name = name;
		this.fk_code = fk_code;
		this.content = content;
		this.regDate = regDate;
		this.parentSeq = parentSeq;
		this.status = status;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getParentSeq() {
		return parentSeq;
	}

	public void setParentSeq(String parentSeq) {
		this.parentSeq = parentSeq;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	/////////////////////////////////////////////////////////////////////
	public String getFk_code() {
		return fk_code;
	}

	public void setFk_code(String fk_code) {
		this.fk_code = fk_code;
	}


}
