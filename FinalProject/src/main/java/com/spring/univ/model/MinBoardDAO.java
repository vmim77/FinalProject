package com.spring.univ.model;

import java.util.*;
import javax.annotation.Resource;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MinBoardDAO implements InterMinBoardDAO {

	@Resource
	private SqlSessionTemplate sqlsession2; // 원격DB에 연결

//================================================================================================
	// 과목 가져오기
	@Override
	public List<Map<String,String>> getSubList() {
		List<Map<String,String>> SubList = sqlsession2.selectList("Min.getSubList");
		return SubList;
	}
	

	
	
	
	
	
	
	
	
}//end of public class BoardDAO implements InterBoardDAO {