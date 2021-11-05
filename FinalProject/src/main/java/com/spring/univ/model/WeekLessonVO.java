package com.spring.univ.model;

public class WeekLessonVO {

	//////////////////////////////////////////////////////////////////
	
	private String fk_week;     // 몇주차인지
	private String lesson;      // 차시 명 ( 1주차 1차시, 1주차 2차시... )
	private String video;       // 비디오 명(유투브)
	private String savefile;    // 저장용
	private String uploadfile;  // 업로드용 
	
	//////////////////////////////////////////////////////////////////
	
	public String getFk_week() {
		return fk_week;
	}
	public void setFk_week(String fk_week) {
		this.fk_week = fk_week;
	}
	public String getLesson() {
		return lesson;
	}
	public void setLesson(String lesson) {
		this.lesson = lesson;
	}
	public String getVideo() {
		return video;
	}
	public void setVideo(String video) {
		this.video = video;
	}
	public String getSavefile() {
		return savefile;
	}
	public void setSavefile(String savefile) {
		this.savefile = savefile;
	}
	public String getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(String uploadfile) {
		this.uploadfile = uploadfile;
	}

}//end of public class WeekLessonVO {-------------------
