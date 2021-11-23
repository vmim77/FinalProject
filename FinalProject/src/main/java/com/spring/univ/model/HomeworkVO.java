package com.spring.univ.model;

import org.springframework.web.multipart.MultipartFile;

public class HomeworkVO {
	
	private String seq;
	private String fk_hakbun;
	private String fk_code;
	private String name;
	private String subject;
	private String content;
	private String regDate;
	private String commentCount;
	private String fileName;
	private String orgFilename;
	private String fileSize;
	private String acceptance;
	private String deadline;
	private MultipartFile attach;
	
	
	public HomeworkVO() {}
	
	public HomeworkVO(String seq, String fk_hakbun, String fk_code, String name, String subject, String content,
			String regDate, String commentCount, String fileName, String orgFilename, String fileSize, String acceptance,
			String deadline, MultipartFile attach) {
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
		this.acceptance = acceptance;
		this.deadline = deadline;
		this.attach = attach;
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

	public String getAcceptance() {
		return acceptance;
	}

	public void setAcceptance(String acceptance) {
		this.acceptance = acceptance;
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
