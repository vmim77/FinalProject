package com.spring.univ.model;

public class CalendarVO {
	
	private String seq;
	private String fk_hakbun;
	private String title;
	private String detail;
	private String startDate;
	private String endDate;
	
	
	
	public CalendarVO() {}
	
	public CalendarVO(String seq, String fk_hakbun, String title, String detail, String startDate, String endDate) {
		this.seq = seq;
		this.fk_hakbun = fk_hakbun;
		this.title = title;
		this.detail = detail;
		this.startDate = startDate;
		this.endDate = endDate;
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

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}

	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
	
	
	
	
	
	
	
}
