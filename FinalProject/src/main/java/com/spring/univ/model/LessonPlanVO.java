package com.spring.univ.model;

public class LessonPlanVO {
	
	/////////////////////////////////////////////////////////////////////
	// 수업계획서 VO
	
	private String lessonplanSeq;		// 수업계획서 시퀀스
	private String fk_code;				// 과목코드
	private String week; 				// 주차
	private String fk_hakbun;			// 멤버테이블 학번
	private String subject;				// 제목
	private String content;				// 내용
	private String regDate;				// 등록일자
	private String status;				// 상태(1: 정상, 0: 삭제)
	private String fileName;			// WAS에 저장될 파일명
	private String orgFilename;			// 업로드, 다운로드할 파일명
	private String fileSize;			// 파일사이즈
	
	/////////////////////////////////////////////////////////////////////
	
	public LessonPlanVO() {}
	
	


	public LessonPlanVO(String lessonplanSeq, String fk_code, String week, String fk_hakbun, String subject,
			String content, String regDate, String status, String fileName, String orgFilename, String fileSize) {
		this.lessonplanSeq = lessonplanSeq;
		this.fk_code = fk_code;
		this.week = week;
		this.fk_hakbun = fk_hakbun;
		this.subject = subject;
		this.content = content;
		this.regDate = regDate;
		this.status = status;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
	}




	public String getLessonplanSeq() {
		return lessonplanSeq;
	}


	public void setLessonplanSeq(String lessonplanSeq) {
		this.lessonplanSeq = lessonplanSeq;
	}



	public String getFk_hakbun() {
		return fk_hakbun;
	}


	public void setFk_hakbun(String fk_hakbun) {
		this.fk_hakbun = fk_hakbun;
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


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
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




	public String getFk_code() {
		return fk_code;
	}




	public void setFk_code(String fk_code) {
		this.fk_code = fk_code;
	}




	public String getWeek() {
		return week;
	}




	public void setWeek(String week) {
		this.week = week;
	}
	
	
	
	
	
	
	
	
	
}
