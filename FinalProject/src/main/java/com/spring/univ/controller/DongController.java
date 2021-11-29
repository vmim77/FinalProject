package com.spring.univ.controller;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.univ.common.MyUtil;
import com.spring.univ.common.FileManager;
import com.spring.univ.model.MemberVO;
import com.spring.univ.model.ServeyVO;
import com.spring.univ.model.SubjectVO;
import com.spring.univ.model.WeekLessonVO;
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
	      String code = request.getParameter("code");
	      
	      if(searchType == null || (!"hakbun".equals(searchType) && !"name".equals(searchType)) ) {
	         searchType = "";
	      }
	      
	      if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
	         searchWord = "";
	      }
	      
	      Map<String,String> paraMap = new HashMap<>();
	      paraMap.put("searchType", searchType);
	      paraMap.put("searchWord", searchWord);
	      paraMap.put("code", code);
	      
	      
	    List<Map<String,String>> TeacherList = service.getTeacher(paraMap);
		
	    
		mav.addObject("TeacherList", TeacherList);
		mav.setViewName("user.tiles1");
	    return mav;
	}

	
//=======================================================================
 
	
// # 로그인페이지 처리

	@RequestMapping(value="/MemberLogin.univ",method= {RequestMethod.GET}) 
	public ModelAndView MemberLogin(HttpServletRequest request,ModelAndView mav) {//
		
		HttpSession session = request.getSession(); // 비정상 종료시 로그아웃을 하지 않아서 세션의 값이 남아있어서 비운다.
		session.invalidate(); // 비정상 종료시 로그아웃을 하지 않아서 세션의 값이 남아있어서 비운다.
		
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
	      
	      HttpSession session = request.getSession();
	      
	      String goBackURL = (String) session.getAttribute("goBackURL");
	      
	      session.invalidate();
	      
	      String message = "로그아웃 되었습니다.";
	      
	      String loc = "";
	      if(goBackURL != null) {
	         loc = request.getContextPath()+"/MemberLogin.univ";
	      }
	      else {
	         loc = request.getContextPath()+"/MemberLogin.univ";
	      }
	      
	      mav.addObject("message", message); 
	      mav.addObject("loc", loc);         
	      mav.setViewName("msg");
	      
	      return mav;
	   }
//====================================================================================================================
	   // === 비밀번호 찾기 === //
	   @RequestMapping(value="/pwdFind.univ") 
		public ModelAndView pwdFind(HttpServletRequest request,ModelAndView mav) {
		   
		   
		   mav.setViewName("login/pwdFind");
		   
		   return mav;
	   
	   }
//====================================================================================================================
	   
	   // === 비밀번호 찾기 완료=== //
	   @ResponseBody
	   @RequestMapping(value="/pwdFindEnd.univ") 
		public String pwdFindEnd(HttpServletRequest request) {
		   
		   String hakbun = request.getParameter("hakbun");
		   
		   Map<String,String> paraMap = new HashMap<>();
		   
		   paraMap.put("hakbun", hakbun);
		   
		   String pwd = service.getpwdFindEnd(paraMap);
		   
		   JSONObject jsonObj = new JSONObject();
		   
		   if(pwd == null) {
			   jsonObj.put("n",0+"");
		   }
		   else {
			   jsonObj.put("n",1+"");
			   jsonObj.put("pwd",pwd);
			   
		   }
		   
		   
		   return jsonObj.toString();

		   
	   }
//====================================================================================================================
	   
	   // === 마이페이지 보여주기
	   @RequestMapping(value="/Myinfo.univ", method= {RequestMethod.GET})
	   public ModelAndView Myinfo(ModelAndView mav, HttpServletRequest request) {
		   
		   
		   String checknull = request.getParameter("checknull");
		   
		   if("checknull".equals(checknull)) {
		   
			   String name = request.getParameter("name");
			   String hakbun = request.getParameter("hakbun");
			   String pwd = request.getParameter("pwd");
			   String phone = request.getParameter("phone");
			   String email = request.getParameter("email");
			   String address = request.getParameter("address");
			   
			   Map<String,String>paraMap = new HashMap<>();
			   
			   paraMap.put("name", name);
			   paraMap.put("hakbun", hakbun);
			   paraMap.put("pwd", pwd);
			   paraMap.put("phone", phone);
			   paraMap.put("email", email);
			   paraMap.put("address", address);
			   service.MyUpdate(paraMap);
		   
		   }
			   
			   HttpSession session = request.getSession();
			   MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		    	  
			   String hakbun = loginuser.getHakbun();
			   
			   Map<String,String>paraMap = new HashMap<>();
			   paraMap.put("hakbun", hakbun);
			   List<MemberVO> MemberList = service.getMyMember(paraMap);
			   
			   for(MemberVO svo : MemberList) {
				   mav.addObject("name",svo.getName());
				   mav.addObject("hakbun",svo.getHakbun());
				   mav.addObject("pwd",svo.getPwd());
				   mav.addObject("phone",svo.getPhone());
				   mav.addObject("email",svo.getEmail());
				   mav.addObject("address",svo.getAddress());

			   }
			   
			   mav.addObject("loginuser",loginuser);
			   mav.setViewName("login/Myinfo");
			      
			   return mav;
			   
		 
		
		   
	 }
	   
	   
//====================================================================================================================
	   
	   // === 내정보 수정하기 json === //
	   @ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	   @RequestMapping(value="/myedit.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.GET})
	   public String myedit(HttpServletRequest request){
		   
		   
		   String name = request.getParameter("name");
		   String hakbun = request.getParameter("hakbun");
		   String pwd = request.getParameter("pwd");
		   String phone = request.getParameter("phone");
		   String email = request.getParameter("email");
		   String address = request.getParameter("address");
		   
		   Map<String,String>paraMap = new HashMap<>();
		   
		   paraMap.put("name", name);
		   paraMap.put("hakbun", hakbun);
		   paraMap.put("pwd", pwd);
		   paraMap.put("phone", phone);
		   paraMap.put("email", email);
		   paraMap.put("address", address);
		   
		   int n = service.MyUpdate(paraMap);
		   

			   JSONObject jsonObj = new JSONObject();
			   jsonObj.put("n",n);
			   return jsonObj.toString();
			   
		  
	   }
	   
//====================================================================================================================
	   
	   // === 내정보 수정하기 === //
	   @RequestMapping(value="/EditPage.univ")
	   public ModelAndView EditPage(ModelAndView mav, HttpServletRequest request,HttpServletResponse response) {
		   
		
		       mav.setViewName("login/EditPage");
				
		
   		      return mav;
	   }

	   

//====================================================================================================================
	   
	   // === 마이페이지 사진 추가하기 === //
	   @RequestMapping(value="/EditPhoto.univ", method= {RequestMethod.GET})
	   public ModelAndView EditPhoto(ModelAndView mav, HttpServletRequest request,MemberVO membervo) {


		   HttpSession session = request.getSession();
		   MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	    	  
		   String hakbun = loginuser.getHakbun();
		   
		   
		   mav.addObject("hakbun", hakbun);
		   mav.setViewName("login/EditPhoto");
		   
		   return mav;
	   }
	   
	   
//====================================================================================================================
	   
	   // === 마이페이지 사진 추가하기 완료페이지 === //
	   @RequestMapping(value="/EditPhotoEnd.univ", method= {RequestMethod.POST})
	   public ModelAndView EditPhotoEnd(ModelAndView mav, HttpServletRequest request,MultipartHttpServletRequest mrequest,MemberVO membervo) {


		   HttpSession session = request.getSession();
		   MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		   MultipartFile attach = membervo.getAttach();
		      
		      if( !attach.isEmpty() ) {
		          session = mrequest.getSession();
		         String root = session.getServletContext().getRealPath("/");
		         
		         String path = root + "resources" + File.separator + "files";
		         
		            String newFileName = "";
		            
		            byte[] bytes = null;
		            
		            
		            try {
		               bytes = attach.getBytes();
		         
		               newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
		               loginuser.setPicture(newFileName);
		               
		               
		              int n = service.getPicture(loginuser);
		              
		              if(n == 1) {
		            	  session.setAttribute("loginuser", loginuser);
		              }
		               
		            } catch (Exception e) {
		               e.printStackTrace();
		            }
		      
		      }
		      
		   mav.addObject("membervo",membervo);
		   mav.setViewName("redirect:/Myinfo.univ");
		   
		   return mav;
	   }
	  	  
	   
	   
	   
//====================================================================================================================
	   
	// === 교수계획서 보여주기 === // 
	   @RequestMapping(value="/teacherPlan.univ")
	   public ModelAndView teacherPlan(ModelAndView mav, HttpServletRequest request) {
		
		   
		   mav.setViewName("login/teacherPlan");
		   
		   return mav;
	   }
	   

	   
//====================================================================================================================
		// === 학사규정 보여주기 === // 
	   @RequestMapping(value="/rule.univ")
	   public ModelAndView rule(ModelAndView mav, HttpServletRequest request) {
		
		   
		   mav.setViewName("login/rule");
		   
		   return mav;
	   }   
 
//====================================================================================================================
		// === 시간표 보여주기 === // 
	   @RequestMapping(value="/Schedule.univ")
	   public ModelAndView Schedule(ModelAndView mav, HttpServletRequest request) {
		
		   HttpSession session = request.getSession();
		   MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		   
		   String hakbun = loginuser.getHakbun();
		   
		   
		   Map<String, String> paraMap = new HashMap<>();
		         
		   paraMap.put("hakbun", hakbun);

		   // 전공신청 한 학생한명 알아오기
		   List<SubjectVO> selectSugangList = service.getselectSugangList(paraMap);
		   
			
			  String classDate = ""; 
			  String subject = "";
			  
			  for(SubjectVO svo : selectSugangList) {
			  
				  subject += svo.getSubject() + ",";
				  classDate += svo.getClassDate() + ",";
			  
			   }
			
		   
		   mav.addObject("classDate",classDate);
		   mav.addObject("subject",subject);
		   
		   mav.setViewName("login/Schedule");
		   
		   return mav;

	   }   
//====================================================================================================================
	// 민경작업 //
	   // === 설문조사 === //
	   @ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	   @RequestMapping(value="/seolmoon.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.GET})
	   public String seolmoon(HttpServletRequest request){

		   HttpSession session = request.getSession();
		   MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	    	  
		   String hakbun = loginuser.getHakbun();
		   
		   JSONObject jsonobj = new JSONObject();
		   
		   // 설문조사 가져오기
		   List<ServeyVO> seolmoonList = service.getSeolmoonList();
		   
	         for(ServeyVO svo : seolmoonList) {
	        	 
	        	 Map<String, String> paraMap = new HashMap<>();
	        	 
	        	 paraMap.put("hakbun", hakbun);
	        	 
	        	 // 설문조사 했는지 확인하기
	        	 String serveyDate = service.getSeolmoonMemberList(paraMap);
	
	        	 if(serveyDate == null) {
	 	             jsonobj.put("serveyTopic", svo.getServeyTopic());
	 	             jsonobj.put("serveyDate", "미 참여");
	 	             jsonobj.put("html", "<button id='goSeolmoon'  value='"+svo.getServeyCode()+"'>설문참여</button>");    	             
	        	 }
	        	 else {
	 	             jsonobj.put("serveyTopic", svo.getServeyTopic());
	 	             jsonobj.put("serveyDate", serveyDate);
	 	             jsonobj.put("html", "참여완료");
	        	 }
		        	 
	        }
	         
		      return jsonobj.toString();   
	

	   }
		
	//==================================================================================================================   
	   // === 강의평가 === //
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
	   
	   
	   ////////////////////////////////////////////////////////////////////////////////
	   //  === 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성 ===    
	   public void getCurrentURL(HttpServletRequest request) {
	      HttpSession session = request.getSession();
	      session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));
	   }
	   ////////////////////////////////////////////////////////////////////////////////

}	
