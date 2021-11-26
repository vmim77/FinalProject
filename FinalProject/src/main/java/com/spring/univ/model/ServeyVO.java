package com.spring.univ.model;

public class ServeyVO {
	
	private String serveyCode;
	private String serveyTopic;
	
	public ServeyVO() {}

	public ServeyVO(String serveyCode, String evaluationTopic) {
		this.serveyCode = serveyCode;
		this.serveyTopic = serveyTopic;
	}

	public String getServeyCode() {
		return serveyCode;
	}

	public void setServeyCode(String serveyCode) {
		this.serveyCode = serveyCode;
	}

	public String getServeyTopic() {
		return serveyTopic;
	}

	public void setServeyTopic(String serveyTopic) {
		this.serveyTopic = serveyTopic;
	}

	
	

}
