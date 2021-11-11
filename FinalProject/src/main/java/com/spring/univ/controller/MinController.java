package com.spring.univ.controller;

import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.spring.univ.model.WeekVO;
import com.spring.univ.service.InterMinService;


/*
	사용자 웹브라우저 요청(View)  ==> DispatcherServlet ==> @Controller 클래스 <==>> Service단(핵심업무로직단, business logic단) <==>> Model단[Repository](DAO, DTO) <==>> myBatis <==>> DB(오라클)           
	(http://...  *.action)                                  |                                                                                                                              
	 ↑                                                View Resolver
	 |                                                      ↓
	 |                                                View단(.jsp 또는 Bean명)
	 -------------------------------------------------------| 
	
	사용자(클라이언트)가 웹브라우저에서 http://localhost:9090/board/test_insert.action 을 실행하면
	배치서술자인 web.xml 에 기술된 대로  org.springframework.web.servlet.DispatcherServlet 이 작동된다.
	DispatcherServlet 은 bean 으로 등록된 객체중 controller 빈을 찾아서  URL값이 "/test_insert.action" 으로
	매핑된 메소드를 실행시키게 된다.                                               
	Service(서비스)단 객체를 업무 로직단(비지니스 로직단)이라고 부른다.
	Service(서비스)단 객체가 하는 일은 Model단에서 작성된 데이터베이스 관련 여러 메소드들 중 관련있는것들만을 모아 모아서
	하나의 트랜잭션 처리 작업이 이루어지도록 만들어주는 객체이다.
	여기서 업무라는 것은 데이터베이스와 관련된 처리 업무를 말하는 것으로 Model 단에서 작성된 메소드를 말하는 것이다.
	이 서비스 객체는 @Controller 단에서 넘겨받은 어떤 값을 가지고 Model 단에서 작성된 여러 메소드를 호출하여 실행되어지도록 해주는 것이다.
	실행되어진 결과값을 @Controller 단으로 넘겨준다.
*/

// ==== #30. 컨트롤러 선언 ====
// @Component // 이 어노테이션으로 인해 BoardController 클래스는 자동적으로 bean으로 올라간다.
// --> @Controller에는 @Component 기능이 이미 존재하기 때문에 @Component 생략 가능!!!!!
/* 
	XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
	그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
	즉, 여기서 bean의 이름은 boardController 이 된다. 
	여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/


@Controller
public class MinController {
	
	@Autowired
	private InterMinService MinService;
	
	@RequestMapping(value="/attendance.univ")
	public ModelAndView attendance(HttpServletRequest request, ModelAndView mav, HttpServletResponse response) {
		
		String week = "2";
		
		List<WeekVO> SubList = MinService.getSubList(week);
		List<WeekVO> WeekList = MinService.getWeekList();
		
	
		mav.addObject("SubList", SubList);
		mav.addObject("WeekList", WeekList);
		mav.setViewName("attendance.tiles1"); // 이건 만약 login 안에 있으면 login/attendance.tiles1 이런식
		
		return mav;
		
	}//end of public String test1(HttpServletRequest request) {}------------
	
	
	

	@RequestMapping(value="/pp.univ")
	public String pp(HttpServletRequest request) {
		
		return "pp.tiles1";
		
	}//end of public String test1(HttpServletRequest request) {}------------
	
	
    @RequestMapping(value="/servey.univ")
    public ModelAndView servey(ModelAndView mav, HttpServletRequest request) {
       
    
       mav.setViewName("login/servey");
       
       return mav;
    }// end of public ModelAndView servey(ModelAndView mav, HttpServletRequest request) {}--------------------------
    
    
    @RequestMapping(value="/evaluation.univ")
    public ModelAndView evaluation(ModelAndView mav, HttpServletRequest request) {
       
       mav.setViewName("login/evaluation");
       
       return mav;
    }// end of public ModelAndView servey(ModelAndView mav, HttpServletRequest request) {}--------------------------
	
	
	
}	
