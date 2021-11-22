package com.spring.univ.model;

import org.springframework.web.multipart.MultipartFile;

public class HomeworkVO {
	
	// 과제 및 평가 게시판 VO
	
	private String seq;				// 글번호
	private String fk_hakbun;		// 작성자 학번
	private String fk_code;			// 과목번호
	private String name;			// 작성자명
	private String subject;			// 제목
	private String content;			// 내용
	private String regDate;			// 작성일자
	private String commentCount;	// 댓글수
	private String fileName;		// 파일명(WAS DISK) 
	private String orgFilename;		// 원본파일명
	private String fileSize;		// 파일사이즈
	private String status;			// 과제 진행중, 과제 마감(댓글달기 불가)
	private String deadline;		// 마감기한
	
	private MultipartFile attach;
	
	
	public HomeworkVO() {}
	
	public HomeworkVO(String seq, String fk_hakbun, String fk_code, String name, String subject, String content,
			String regDate, String commentCount, String fileName, String orgFilename, String fileSize, String status, String deadline) {
		this.seq = seq;
		this.fk_hakbun = fk_hakbun;
		this.fk_code = fk_code;
		this.name = name;
		this.subject = subject;
		this.content = content;
		this.regDate = regDate;
		this.commentCount = commentCount;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
		this.status = status;
		this.deadline = deadline;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDeadline() {
		return deadline;
	}

	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	
	
	
	
	

}
