package com.spring.univ.service;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.*;
import com.spring.univ.model.*;

@Service
public class MinService implements InterMinService {
//==============================================================================================
	@Autowired
	private InterMinBoardDAO dao;
//==============================================================================================
	
//==============================================================================================
//	민경자리
//==============================================================================================
	// 과목 가져오기
	@Override
	public List<Map<String,String>> getSubList() {
		
		List<Map<String,String>> SubList = dao.getSubList();
		return SubList;
	}

	
}//end of public class BoardService implements InterBoardService {
