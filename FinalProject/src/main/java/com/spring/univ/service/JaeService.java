package com.spring.univ.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.spring.univ.model.InterJaeDAO;

public class JaeService implements InterJaeService {

	@Autowired
	private InterJaeDAO dao;
	
	//수업 리스트 가져오기
	@Override
	public List<Map<String, String>> getclassList() {
		List<Map<String, String>> classList = dao.getclassList();
		return classList;
	}

}
