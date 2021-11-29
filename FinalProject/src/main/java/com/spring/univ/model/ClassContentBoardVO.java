package com.spring.univ.model;

import org.springframework.web.multipart.MultipartFile;

public class ClassContentBoardVO {
	
	private String classBoardSeq;
	private String fk_hakbun;
	private String fk_code;
	private String fk_lessonSeq;
	private String name;
	private String subject;
	private String content;
	private String regdate;
	private String status;
	
	private String enddate;    // select용
	
	private MultipartFile attach;
	
	
	private String fileName;     // WAS(톰캣)에 저장될 파일명(2021110809271535243254235235234.png)
    private String orgFilename;  // 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
    private String fileSize; 
	
	
	
	
	
	public String getClassBoardSeq() {
		return classBoardSeq;
	}
	public void setClassBoardSeq(String classBoardSeq) {
		this.classBoardSeq = classBoardSeq;
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
	public String getFk_lessonSeq() {
		return fk_lessonSeq;
	}
	public void setFk_lessonSeq(String fk_lessonSeq) {
		this.fk_lessonSeq = fk_lessonSeq;
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
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	
	
	
	

}
