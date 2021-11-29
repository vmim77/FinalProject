package com.spring.univ.model;

public class ServeyResultVO {
	
	private String fk_serveyCode;
	private String fk_serveyNum;
	private String serveyCheckNum;
	
	public ServeyResultVO() {}

	public ServeyResultVO(String fk_serveyCode, String fk_serveyNum, String serveyCheckNum) {
		this.fk_serveyCode = fk_serveyCode;
		this.fk_serveyNum = fk_serveyNum;
		this.serveyCheckNum = serveyCheckNum;
	}

	public String getFk_serveyCode() {
		return fk_serveyCode;
	}

	public void setFk_serveyCode(String fk_serveyCode) {
		this.fk_serveyCode = fk_serveyCode;
	}

	public String getFk_serveyNum() {
		return fk_serveyNum;
	}

	public void setFk_serveyNum(String fk_serveyNum) {
		this.fk_serveyNum = fk_serveyNum;
	}

	public String getServeyCheckNum() {
		return serveyCheckNum;
	}

	public void setServeyCheckNum(String serveyCheckNum) {
		this.serveyCheckNum = serveyCheckNum;
	}
	
	

}
