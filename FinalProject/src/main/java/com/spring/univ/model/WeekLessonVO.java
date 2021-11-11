package com.spring.univ.model;

public class WeekLessonVO {
	
	/////////////////////////////////////////////////////////////////////
	// 수업차시 테이블 VO

	private String lessonseq;	// 수업차시 시퀀스
	private String fk_weekseq;	// 주차테이블 시퀀스
	private String lesson;		// 수업차시
	private String video;		// 비디오 파일명
	private String savefile;	// 세이브 파일명
	private String uploadfile;	// 업로드 파일명
	
	/////////////////////////////////////////////////////////////////////
	
	public WeekLessonVO() {}
	
	public WeekLessonVO(String lessonseq, String fk_weekseq, String lesson, String video, String savefile,
			String uploadfile) {
		this.lessonseq = lessonseq;
		this.fk_weekseq = fk_weekseq;
		this.lesson = lesson;
		this.video = video;
		this.savefile = savefile;
		this.uploadfile = uploadfile;
	}

	public String getLessonseq() {
		return lessonseq;
	}

	public void setLessonseq(String lessonseq) {
		this.lessonseq = lessonseq;
	}

	public String getFk_weekseq() {
		return fk_weekseq;
	}

	public void setFk_weekseq(String fk_weekseq) {
		this.fk_weekseq = fk_weekseq;
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
