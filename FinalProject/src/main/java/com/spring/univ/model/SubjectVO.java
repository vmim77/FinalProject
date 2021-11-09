package com.spring.univ.model;

public class SubjectVO {

	//////////////////////////////////////////////////////////////
	
	private String code;        // 과목코드
	private String subject;     // 과목명 
	private String teacher;     // 담당교수님
	private int hakjum;         // 배정학점
	private String classDate;   // 수업요일
	private String fk_deptCode; // 학과코드
	
	//////////////////////////////////////////////////////////////
	
	public String getFk_deptCode() {
		return fk_deptCode;
	}
	public void setFk_deptCode(String fk_deptCode) {
		this.fk_deptCode = fk_deptCode;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getTeacher() {
		return teacher;
	}
	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}
	public int getHakjum() {
		return hakjum;
	}
	public void setHakjum(int hakjum) {
		this.hakjum = hakjum;
	}
	public String getClassDate() {
		return classDate;
	}
	public void setClassDate(String classDate) {
		this.classDate = classDate;
	}
	
}//end of public class SubjectVO {------------------------------
