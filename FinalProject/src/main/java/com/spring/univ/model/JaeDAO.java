package com.spring.univ.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;


public class JaeDAO implements InterJaeDAO{

	@Resource
	private SqlSessionTemplate sqlsession2;
	
	@Override
	public List<Map<String, String>> getclassList() {
		List<Map<String, String>> classList = sqlsession2.selectList("Jae.getclassList");
		return classList;
	}

}
