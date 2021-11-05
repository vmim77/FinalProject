package com.spring.univ.controller;

import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.univ.common.MyUtil;
import com.spring.univ.model.FreeBoardVO;
import com.spring.univ.model.FreeCommentVO;
import com.spring.univ.model.MemberVO;
import com.spring.univ.service.InterUnivService;

@Controller
public class GillController {
	
	@Autowired
	private InterUnivService service;
	

//=========================================================================	
	// 관리자 페이지 //
	@RequestMapping(value="/adminIndex.univ")
	public ModelAndView adminIndex(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 관리자인지 우선 확인하기

		mav.setViewName("admin/adminIndex");
		
		return mav;
	
	}//end of public ModelAndView requiredLogin_add(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
//=========================================================================

}	
