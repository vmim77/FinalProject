package com.spring.univ.model;

import java.util.List;
import java.util.Map;

public interface InterSungDAO {
	
	// 해당 학생이 수강하고있는 과목의 정보를 가져온다.
	Map<String,String> getSubjectInfo(String code);

}
