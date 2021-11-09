package com.spring.univ.model;

public class WeekVO {
	
	/////////////////////////////////////////////////////////////////////
	
	private String weekseq;		// 주차 테이블 시퀀스
	private String fk_code;		// 과목 테이블 코드
	private String week;		// 주차
	private String startday;	// 시작일자
	
	/////////////////////////////////////////////////////////////////////
	
	public WeekVO() {}
	
	public WeekVO(String weekseq, String fk_code, String week, String startday) {
		this.weekseq = weekseq;
		this.fk_code = fk_code;
		this.week = week;
		this.startday = startday;
	}

	public String getWeekseq() {
		return weekseq;
	}

	public void setWeekseq(String weekseq) {
		this.weekseq = weekseq;
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

	public String getStartday() {
		return startday;
	}

	public void setStartday(String startday) {
		this.startday = startday;
	}
	
	
	
	
	
}
