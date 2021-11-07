package com.spring.univ.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.univ.model.InterSungDAO;

@Service
public class SungService implements InterSungService {
	
	@Autowired
	private InterSungDAO dao;
	
	// 해당 학생이 수강하고있는 과목의 정보를 가져온다.
	@Override
	public Map<String,String> getSubjectInfo(String code) {
		Map<String,String> subjectMap = dao.getSubjectInfo(code);
		return subjectMap;
	}

}
