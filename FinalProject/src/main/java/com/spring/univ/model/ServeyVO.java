package com.spring.univ.model;

public class ServeyVO {
	
	private String serveyCode;
	private String evaluationTopic;
	
	public ServeyVO() {}

	public ServeyVO(String serveyCode, String evaluationTopic) {
		this.serveyCode = serveyCode;
		this.evaluationTopic = evaluationTopic;
	}

	public String getServeyCode() {
		return serveyCode;
	}

	public void setServeyCode(String serveyCode) {
		this.serveyCode = serveyCode;
	}

	public String getEvaluationTopic() {
		return evaluationTopic;
	}

	public void setEvaluationTopic(String evaluationTopic) {
		this.evaluationTopic = evaluationTopic;
	}
	
	

}
