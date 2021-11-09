package com.spring.univ.model;

import java.util.List;
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
	
	// 해당 과목의 강좌자료실 내용을 가져온다.
	@Override
	public List<LessonBoardVO> getLessonBoard(String code) {
		List<LessonBoardVO> boardList = sqlsession2.selectList("Sung.getLessonBoard", code);
		return boardList;
	}

}