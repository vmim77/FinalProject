package com.spring.univ.model;

import org.springframework.web.multipart.MultipartFile;

public class LessonBoardVO {
	
	/////////////////////////////////////////////////////////////////////
	
	private String seq;				// 글번호
	private String fk_hakbun;		// 사용자학번
	private String fk_code;			// 과목코드
	private String name;			// 글쓴이
	private String subject;			// 글제목
	private String content;			// 글내용
	private String pw;				// 글암호
	private String regDate;			// 글쓴시간
	private String status;			// 글삭제여부	1:사용가능한 글, 0:삭제된글
	private String commentCount;	// 조회수
	
	
	private MultipartFile attach; 	// 폼태그에서 첨부된 파일
	private String fileName;		// WAS에 저장될 파일명
	private String orgFilename;		// 진짜 파일명
	private String fileSize;		// 파일사이즈
	
	/////////////////////////////////////////////////////////////////////
	
	private String previousSeq;
	private String previousSubject;
	private String nextSeq;
	private String nextSubject;
	
	////////////////////////////////////////////////////////////////////
	
	public LessonBoardVO() {}
	
	public LessonBoardVO(String seq, String fk_hakbun, String fk_code, String name, String subject, String content, String pw,
			String readCount, String regDate, String status, String commentCount, String fileName, String orgFilename,
			String fileSize, String previousSeq, String previousSubject, String nextSeq, String nextSubject) {
		this.seq = seq;
		this.fk_hakbun = fk_hakbun;
		this.fk_code = fk_code;
		this.name = name;
		this.subject = subject;
		this.content = content;
		this.pw = pw;
		this.regDate = regDate;
		this.status = status;
		this.commentCount = commentCount;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
		this.previousSeq = previousSeq;
		this.previousSubject = previousSubject;
		this.nextSeq = nextSeq;
		this.nextSubject = nextSubject;
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

	public String getFk_code() {
		return fk_code;
	}

	public void setFk_code(String fk_code) {
		this.fk_code = fk_code;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public String getPreviousSeq() {
		return previousSeq;
	}

	public void setPreviousSeq(String previousSeq) {
		this.previousSeq = previousSeq;
	}

	public String getPreviousSubject() {
		return previousSubject;
	}

	public void setPreviousSubject(String previousSubject) {
		this.previousSubject = previousSubject;
	}

	public String getNextSeq() {
		return nextSeq;
	}

	public void setNextSeq(String nextSeq) {
		this.nextSeq = nextSeq;
	}

	public String getNextSubject() {
		return nextSubject;
	}

	public void setNextSubject(String nextSubject) {
		this.nextSubject = nextSubject;
	}
	
	
	
	
	
}
