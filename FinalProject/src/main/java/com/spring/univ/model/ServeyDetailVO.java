package com.spring.univ.model;

public class ServeyDetailVO {
	
	private String fk_serveyCode;
	private String serveyNum;
	private String serveyContent;
	
	public ServeyDetailVO() {}

	public ServeyDetailVO(String fk_serveyCode, String serveyNum, String serveyContent) {
		this.fk_serveyCode = fk_serveyCode;
		this.serveyNum = serveyNum;
		this.serveyContent = serveyContent;
	}

	public String getFk_serveyCode() {
		return fk_serveyCode;
	}

	public void setFk_serveyCode(String fk_serveyCode) {
		this.fk_serveyCode = fk_serveyCode;
	}

	public String getServeyNum() {
		return serveyNum;
	}

	public void setServeyNum(String serveyNum) {
		this.serveyNum = serveyNum;
	}

	public String getServeyContent() {
		return serveyContent;
	}

	public void setServeyContent(String serveyContent) {
		this.serveyContent = serveyContent;
	}
	
	


}
