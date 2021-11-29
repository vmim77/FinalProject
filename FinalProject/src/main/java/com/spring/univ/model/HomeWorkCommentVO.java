package com.spring.univ.model;

import org.springframework.web.multipart.MultipartFile;

public class HomeWorkCommentVO {
	
	// 과제 및 평가 댓글VO
	
	private String seq; 		// 댓글번호
	private String parentSeq; 	// 원글번호
	private String fk_hakbun; 	// 작성자 학번
	private String name; 		// 작성자명
	private String fk_code; 	// 과목코드
	private String content; 	// 댓글내용
	private String regDate;		// 작성일자
	private String fileName; 	// 파일명(WAS DISK)
	private String orgFilename; // 원본파일명
	private String fileSize;	// 파일사이즈
	
	
	///////////////////////////////////////////////////////////
	// select 용 컬럼
	private String commentCount; // 원글 댓글갯수

	
	private MultipartFile attach;
	
	public HomeWorkCommentVO() {}
	
	public HomeWorkCommentVO(String seq, String parentSeq, String fk_hakbun, String content, String fileName,
			String orgFilename, String fileSize, String fk_code, String name, String regDate) {
		this.seq = seq;
		this.parentSeq = parentSeq;
		this.fk_hakbun = fk_hakbun;
		this.content = content;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
		this.fk_code = fk_code;
		this.name = name;
		this.regDate = regDate;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getParentSeq() {
		return parentSeq;
	}

	public void setParentSeq(String parentSeq) {
		this.parentSeq = parentSeq;
	}

	public String getFk_hakbun() {
		return fk_hakbun;
	}

	public void setFk_hakbun(String fk_hakbun) {
		this.fk_hakbun = fk_hakbun;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOrgFilename() {
		return orgFilename;
	}

	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
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

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(String commentCount) {
		this.commentCount = commentCount;
	}
	
	
	
	
	
	
}
