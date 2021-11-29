package com.spring.univ.model;

public class LessonBoardCommentVO {
	
	private String seq;			// 시퀀스
	private String fk_hakbun;	// 학번
	private String name;		// 성명
	private String content;		// 댓글내용
	private String parentSeq;	// 부모글 번호
	private String regDate;		// 작성일자
	
	public LessonBoardCommentVO() {}
	
	public LessonBoardCommentVO(String seq, String fk_hakbun, String name, String content, String parentSeq,
			String regDate) {
		this.seq = seq;
		this.fk_hakbun = fk_hakbun;
		this.name = name;
		this.content = content;
		this.parentSeq = parentSeq;
		this.regDate = regDate;
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

	public String getParentSeq() {
		return parentSeq;
	}

	public void setParentSeq(String parentSeq) {
		this.parentSeq = parentSeq;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	
	
	
	
	
}
