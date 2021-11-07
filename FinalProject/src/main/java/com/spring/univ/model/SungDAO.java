package com.spring.univ.model;

import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class SungDAO implements InterSungDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession2;
	
	// 해당 학생이 수강하고있는 과목의 정보를 가져온다.
	@Override
	public Map<String, String> getSubjectInfo(String code) {
		Map<String,String> subjectMap = sqlsession2.selectOne("Sung.getSubjectInfo", code);
		return subjectMap;
	}

}
