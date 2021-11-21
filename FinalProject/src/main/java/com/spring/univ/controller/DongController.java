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

import com.spring.univ.common.FileManager;
import com.spring.univ.model.MemberVO;
import com.spring.univ.model.SubjectVO;
import com.spring.univ.service.InterDongService;
import com.spring.univ.service.InterSungService;



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
public class DongController {
	
 @Autowired
   private InterDongService service;
   // Type에 따라 알아서 Bean 을 주입해준다.
 
 @Autowired
  private InterSungService service2;
 
	@Autowired
	private FileManager fileManager;
 // Type에 따라 알아서 Bean 을 주입해준다.

 	// 사용자 및 그룹
	@RequestMapping(value="/user.univ") 
	public ModelAndView user(HttpServletRequest request,ModelAndView mav) {
		
		 String searchType = request.getParameter("searchType");
	     String searchWord = request.getParameter("searchWord");
	      
	      if(searchType == null || (!"subject".equals(searchType) && !"name".equals(searchType)) ) {
	         searchType = "";
	      }
	      
	      if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
	         searchWord = "";
	      }
	      
	      Map<String,String> paraMap = new HashMap<>();
	      paraMap.put("searchType", searchType);
	      paraMap.put("searchWord", searchWord);
	      
	      List<SubjectVO> TeacherList = service.getTeacher();
	      
	      // 아래는 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
	      if(!"".equals(searchType) && !"".equals(searchWord)) {
	         mav.addObject("paraMap", paraMap);
	      }
		
		mav.addObject("TeacherList", TeacherList);
		mav.setViewName("user.tiles1");
	    return mav;
	}

	
//=======================================================================
 
	
// # 로그인페이지 처리

	@RequestMapping(value="/MemberLogin.univ",method= {RequestMethod.GET}) 
	public ModelAndView MemberLogin(HttpServletRequest request,ModelAndView mav) {//
		
		
		mav.setViewName("login/MemberLogin");
		
		
		return mav;
	}
//==========================================================================================		   
	 //////////////////////////////////////////////////////////////////////////////////
	//# 로그인

	@RequestMapping(value="/dashboard.univ", method= {RequestMethod.POST}) // /test1.action의 url은 아래의 메소드가 응답함!
	public ModelAndView dashboard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {//
		
		 String hakbun = request.getParameter("hakbun");
	     String pwd = request.getParameter("pwd");
	    
	      Map<String, String> paraMap = new HashMap<>();
	      paraMap.put("hakbun", hakbun);
	      paraMap.put("pwd", pwd);
	      
	      MemberVO loginuser = service.getLoginMember(paraMap);
	      
	      if(loginuser == null) { // 로그인 실패시
	        
	    	  String message = "학번 또는 암호가 틀립니다.";
	         String loc = "javascript:history.back()";
	         
	         mav.addObject("message", message); // request.setAttribute("message", message);
	         mav.addObject("loc", loc);         // request.setAttribute("loc", loc);
	      
	         mav.setViewName("msg");             // return "msg"; 
	      //  /WEB-INF/views/msg.jsp 파일을 생성한다.
	    	
	      }
	      
	      else {
	    	  
	    	  	HttpSession session = request.getSession();
	    	  
	    	   session.setAttribute("loginuser", loginuser);
	    	   
		       hakbun = loginuser.getHakbun(); // 로그인한 유저의 학번을 가져온다.
		       int authority = loginuser.getAuthority(); // 로그인한 유저의 권한값을 가져온다.
		       
		       if(authority==0) { // 학생
		    	   List<Map<String, String>> sugangList = service2.getSugang(hakbun); // 학번을 이용하여 해당 학생의 수강목록을 가져온다.
		    	   session.setAttribute("sugangList", sugangList); // 수강목록을 session에 저장시킨다.
		       }
		       else if (authority==1) {
		    	   List<Map<String, String>> suupList = service2.getsuUp(hakbun); // 학번을 이용하여 해당 교수의 수업목록을 가져온다.
		    	   session.setAttribute("suupList", suupList); // 수업목록을 세션에 저장시킨다.
		       }
	    	   
	    	   mav.addObject("session", session);
	    	   mav.setViewName("redirect:/dashboard.univ"); // redirect로 이동을 시킨다.
	      }
	     
	     
		return mav;

	     
	}
	
	
//====================================================================================================================	
	
	   // ===  로그아웃 처리하기 === //
	   @RequestMapping(value="/logout.univ")
	   public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {
	      
		  HttpSession  session = request.getSession(); // 세션 불러오기
			
		  session.removeAttribute("loginuser");
	      
	      String message = "로그아웃 되었습니다.";
	      String loc = "";
	      
	      mav.addObject("message", message); 
	      mav.addObject("loc", loc);         
	      mav.setViewName("dashboard.tiles1");
	      
	      return mav;
	   }
//====================================================================================================================
	   
	   // === 마이페이지 보여주기
	   @RequestMapping(value="/Myinfo.univ")
	   public ModelAndView Myinfo(ModelAndView mav, HttpServletRequest request) {
		   
		   HttpSession session = request.getSession();
		   MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	    	  
		   String hakbun = loginuser.getHakbun();
		   
		   Map<String,String>paraMap = new HashMap<>();
		   paraMap.put("hakbun", hakbun);

		   List<MemberVO> MemberList = service.getMyMember(paraMap);
		   

		 

		   
		   mav.addObject("MemberList",MemberList);
		   mav.setViewName("login/Myinfo");
		      
		      return mav;
		   
	 }
	   
	   
//====================================================================================================================
	   
	   // === 내정보 수정하기 === //
	   @ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	   @RequestMapping(value="/myedit.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.GET})
	   public String myedit(HttpServletRequest request){
		   
		   String hakbun = request.getParameter("hakbun");
		   String phone = request.getParameter("phone");
		   String email = request.getParameter("email");
		   String address = request.getParameter("address");
		   
		   Map<String,String>paraMap = new HashMap<>();
		   
		   paraMap.put("hakbun", hakbun);
		   paraMap.put("phone", phone);
		   paraMap.put("email", email);
		   paraMap.put("address", address);
		   
		   int n = service.MyUpdate(paraMap);


            JSONObject jsonObj = new JSONObject();
            jsonObj.put("n",n);

		      
		      return jsonObj.toString();

	   }
	   

	   
//====================================================================================================================
	// 민경작업 //
	   @ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	   @RequestMapping(value="/servey.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.GET})
	   public String servey(HttpServletRequest request){
		   
		   HttpSession session = request.getSession();
		   MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	    	  
		   String hakbun = loginuser.getHakbun();
		   
		   // 내가 신청한 전공평가 가져오기
		   List<Map<String, String>> serveyList = service.getServeyList(hakbun);

		   JSONArray jsonarr = new JSONArray();
		      
		   
		   Map<String, String> paraMap = new HashMap<>();
		   
	         for(Map<String, String> ServeyMap : serveyList) {
	        	 	
	        	 JSONObject jsonobj = new JSONObject();
	        	 
	        	 paraMap.put("serveyCode", ServeyMap.get("serveyCode"));
	        	 paraMap.put("hakbun", hakbun);
	        	 System.out.println(ServeyMap.get("serveyCode"));
	        	 // 강의평가 했는지 확인하기
	        	 String serveyDate = service.getServeyMemberList(paraMap);
	
	        	 if(serveyDate == null) {
	        		 jsonobj.put("name", ServeyMap.get("name")); 
	 	             jsonobj.put("serveyTopic", ServeyMap.get("serveyTopic"));
	 	             jsonobj.put("serveyDate", "미 참여");
	 	             jsonobj.put("html", "<button id='goServey' value='"+ServeyMap.get("serveyCode")+"'>설문참여</button>");    	             
	        	 }
	        	 else {
	        		 jsonobj.put("name", ServeyMap.get("name")); 
	 	             jsonobj.put("serveyTopic", ServeyMap.get("serveyTopic"));
	 	             jsonobj.put("serveyDate", serveyDate);
	 	             jsonobj.put("html", "참여완료");
	        	 }
	        	 
	        	 jsonarr.put(jsonobj);	
		        	 
	        }
	         
		      return jsonarr.toString();   
	

	   }
		
	   
}	

