package com.spring.univ.service;

import java.util.List;
import java.util.Map;

public interface InterSungService {
	
	// 해당 학생이 수강하고있는 과목의 정보를 가져온다.
	Map<String,String> getSubjectInfo(String code);

}
