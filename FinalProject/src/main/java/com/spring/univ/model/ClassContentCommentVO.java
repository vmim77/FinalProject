package com.spring.univ.model;

import org.springframework.web.multipart.MultipartFile;

public class ClassContentCommentVO {

	
	private String classCommentSeq;
	private String fk_classBoardSeq;
	private String fk_hakbun;
	private String name;
	private String commentContent;
	private String regdate;
	private String status;
	
	
	private MultipartFile attach;
	
	
	private String fileName;
	private String orgFilename;
	private String FileSize;
	
	
	
	
	public String getClassCommentSeq() {
		return classCommentSeq;
	}
	public void setClassCommentSeq(String classCommentSeq) {
		this.classCommentSeq = classCommentSeq;
	}
	public String getFk_classBoardSeq() {
		return fk_classBoardSeq;
	}
	public void setFk_classBoardSeq(String fk_classBoardSeq) {
		this.fk_classBoardSeq = fk_classBoardSeq;
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
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
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
		return FileSize;
	}
	public void setFileSize(String fileSize) {
		FileSize = fileSize;
	}

	

}
