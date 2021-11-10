package com.spring.univ.model;

import java.util.List;
import java.util.Map;

public interface InterJaeDAO {

	//수업 리스트 가져오기
	List<Map<String, String>> getclassList();

}
