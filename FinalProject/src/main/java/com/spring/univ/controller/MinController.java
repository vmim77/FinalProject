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

import com.spring.univ.model.MemberVO;
import com.spring.univ.model.ServeyVO;
import com.spring.univ.model.SubjectVO;
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
	
	
	// 출결 주차
	@RequestMapping(value="/attendance.univ")
	public ModelAndView attendance(HttpServletRequest request, ModelAndView mav, HttpServletResponse response) {
		
		String week = "2";
		
		List<WeekVO> SubList = MinService.getSubList(week);
		List<WeekVO> WeekList = MinService.getWeekList();
		
	
		mav.addObject("SubList", SubList);
		mav.addObject("WeekList", WeekList);
		mav.setViewName("attendance.tiles1"); // 이건 만약 login 안에 있으면 login/attendance.tiles1 이런식
		
		return mav;
		
	}//end of public ModelAndView attendance(HttpServletRequest request, ModelAndView mav, HttpServletResponse response) {}------------

	
	// 강의평가 보여주기
	@RequestMapping(value="/Teacherservey.univ", method= {RequestMethod.POST})
	public String Teacherservey(HttpServletRequest request) {
		
		String serveyCode = request.getParameter("serveyCode");
		
		
		List<SubjectVO> serveyList = MinService.Teacherservey(serveyCode);
		
		String subject = "";
		String name = "";
		String code = "";
		
		for(SubjectVO svo : serveyList) {
			subject = svo.getSubject();
			name = svo.getFk_hakbun();
			code = svo.getCode();
			
		}
		
		request.setAttribute("subject", subject);
		request.setAttribute("name", name);
		request.setAttribute("serveyCode", code);
		
		
		
		
		return "login/Teacherservey";
		
	}//end of public String Teacherservey(HttpServletRequest request) {}------------
	

	   // === 강의평가 결과 === //
	   @ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	   @RequestMapping(value="/Teacherservey2.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	   public String Teacherservey2(HttpServletRequest request){
		   
		   HttpSession session = request.getSession();
		   MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		   String hakbun = loginuser.getHakbun();
		   
		   
		   String result = request.getParameter("result");
		   String serveyCode = request.getParameter("serveyCode");
		   
		   
		   
		   result = result.substring(0,result.lastIndexOf(","));
		   
		   int n = 0;
		   String[] resultArr = result.split(",");
		   
		   Map<String,String>paraMap = new HashMap<>();
		   
		   for(int i=0; i<resultArr.length; i++) {
			   
			   paraMap.put("serveyCode", serveyCode);
			   paraMap.put("fk_serveynum", (i+1)+"");
			   
			   
			   if("one".equals(resultArr[i])) {
				   paraMap.put("serveychecknum", 1+"");   
			   } 
			   else if("two".equals(resultArr[i])) {
				   paraMap.put("serveychecknum", 2+"");
			   }
			   else if("three".equals(resultArr[i])) {
				   paraMap.put("serveychecknum", 3+"");
			   }
			   else if("four".equals(resultArr[i])) {
				   paraMap.put("serveychecknum", 4+"");
			   }
			   else {
				   paraMap.put("serveychecknum", 5+"");
			   }
			   
			   n = MinService.resultUpdate(paraMap);
			   
		   }
		   
		   int m = 0;
		   
		   if(n==1) {
			   paraMap.put("hakbun", hakbun);
			   m = MinService.attendance(paraMap);
		   }


         JSONObject jsonObj = new JSONObject();
         jsonObj.put("m", m); // 여기를 int m 으로 바꿔서 보내야함 그래야 두 메소드가 성공했는지 알 수 있음

		      
		 return jsonObj.toString();

	   }// end of public String myedit(HttpServletRequest request) -----------------------------------
	   

	// 설문조사 보여주기
	@RequestMapping(value="/Seolmoon.univ", method= {RequestMethod.POST})
	public String Seolmoon(HttpServletRequest request) {

		return "login/Seolmoon";
		
	}//end of public String Seolmoon(HttpServletRequest request) {}------------
	
	
	// === 설문조사 결과 === //
	   @ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	   @RequestMapping(value="/Seolmoon2.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	   public String Seolmoon2(HttpServletRequest request){
		   
		   HttpSession session = request.getSession();
		   MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		   String hakbun = loginuser.getHakbun();
		   String outcome = request.getParameter("outcome");
		   
		   outcome = outcome.substring(0,outcome.lastIndexOf(","));
		   
		   int n = 0;
		   String[] outcomeArr = outcome.split(",");
		   
		   Map<String,String>paraMap = new HashMap<>();
		   
		   for(int i=0; i<outcomeArr.length; i++) {

			   paraMap.put("fk_serveynum", (i+1)+"");
			   paraMap.put("serveychecknum", outcomeArr[i]);   
			 
			   n = MinService.outcomeUpdate(paraMap);
			   
		   }
		   
		   if(n==1) {
			   paraMap.put("hakbun", hakbun);
			   MinService.seolattendance(paraMap);
		   }

      JSONObject jsonObj = new JSONObject();
      jsonObj.put("n", n); // 여기를 int m 으로 바꿔서 보내야함 그래야 두 메소드가 성공했는지 알 수 있음

		      
		 return jsonObj.toString();

	   }// end of public String myedit(HttpServletRequest request) -----------------------------------

	
}	
