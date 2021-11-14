package com.spring.univ.model;

import java.util.Calendar;

import org.springframework.web.multipart.MultipartFile;

public class MemberVO {

	/////////////////////////////////////////////////////////////////////
	
	private String hakbun;        // 학번
	private String name;          // 이름
	private String birth;         // 생년월일     
	private String fk_deptCode;   // 학과코드
	private String pwd;           // 비밀번호
	private String email;         // 이메일
	private String address;       // 주소
	private int status;           // 상태     ( 0등록예정, 1재학, 2휴학, 3자퇴, 4졸업 )
	private String picture;       // 증명사진   
	private String phone;         // 전화번호
	private int authority;        // ( 0학생, 1교수, 2총 관리자 ) 
	
	
	 private MultipartFile attach; // 파일첨부에 필요한 VO
	
	/////////////////////////////////////////////////////////////////////
	
	public MemberVO() {}
	
	public MemberVO(String hakbun, String name, String birth, String fk_deptCode, String pwd, String email,
			String address, int status, String picture, String phone, int authority) {
		this.hakbun = hakbun;
		this.name = name;
		this.birth = birth;
		this.fk_deptCode = fk_deptCode;
		this.pwd = pwd;
		this.email = email;
		this.address = address;
		this.status = status;
		this.picture = picture;
		this.phone = phone;
		this.authority = authority;
	}
	
	/////////////////////////////////////////////////////////////////////

	public int getAge() {
		int age = 0;
		
		Calendar currentDate = Calendar.getInstance(); 
		// 현재날짜와 시간을 얻어온다.
		
		int currentYear = currentDate.get(Calendar.YEAR);
		
		age =  currentYear - Integer.parseInt( birth.substring(0, 4) ) + 1;
		
		return age;
	}
	
	/////////////////////////////////////////////////////////////////////

	public String getHakbun() {
		return hakbun;
	}

	public void setHakbun(String hakbun) {
		this.hakbun = hakbun;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getFk_deptCode() {
		return fk_deptCode;
	}

	public void setFk_deptCode(String fk_deptCode) {
		this.fk_deptCode = fk_deptCode;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getAuthority() {
		return authority;
	}

	public void setAuthority(int authority) {
		this.authority = authority;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	
	
	
}
