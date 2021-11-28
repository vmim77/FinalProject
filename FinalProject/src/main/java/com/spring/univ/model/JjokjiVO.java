package com.spring.univ.model;

import org.springframework.web.multipart.MultipartFile;

public class JjokjiVO {
	private String jseq; 			// 쪽지번호 
	private String receive_hakbun;  // 수신자
	private String sender_hakbun;   // 발신자
	private String jjokjiTime;		// 보낸시간
	private String jjokjiContent;   //  쪽지내용
	private String fileName; 		//  WAS(톰캣)에 저장될 파일명(2021110809271535243254235235234.png) 
	private String orgFilename; 	//  진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
	private String fileSize;		//  파일크기
	
	private String star;			// 추가
	
	private MultipartFile attach;
	
	

	///////////////////////////////////////////////////////

	public JjokjiVO() {}

	public JjokjiVO(String jseq, String receive_hakbun, String sender_hakbun, String jjokjiTime, String jjokjiContent,
			String fileName, String orgFilename, String fileSize, String star) {
		
		this.jseq = jseq;
		this.receive_hakbun = receive_hakbun;
		this.sender_hakbun = sender_hakbun;
		this.jjokjiTime = jjokjiTime;
		this.jjokjiContent = jjokjiContent;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
		this.star = star;
	}


	///////////////////////////////////////////////////////////////////
	public String getJseq() {
		return jseq;
	}


	public void setJseq(String jseq) {
		this.jseq = jseq;
	}

	
	
	public String getReceive_hakbun() {
		return receive_hakbun;
	}


	public void setReceive_hakbun(String receive_hakbun) {
		this.receive_hakbun = receive_hakbun;
	}


	public String getSender_hakbun() {
		return sender_hakbun;
	}


	public void setSender_hakbun(String sender_hakbun) {
		this.sender_hakbun = sender_hakbun;
	}


	public String getJjokjiTime() {
		return jjokjiTime;
	}


	public void setJjokjiTime(String jjokjiTime) {
		this.jjokjiTime = jjokjiTime;
	}


	public String getJjokjiContent() {
		return jjokjiContent;
	}


	public void setJjokjiContent(String jjokjiContent) {
		this.jjokjiContent = jjokjiContent;
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
	
	
	
	
	public String getStar() {
		return star;
	}

	public void setStar(String star) {
		this.star = star;
	}



	
	
}
