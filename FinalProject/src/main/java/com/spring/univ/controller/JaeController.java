package com.spring.univ.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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


import com.spring.univ.common.FileManager;
import com.spring.univ.model.ClassContentBoardVO;
import com.spring.univ.model.ClassContentCommentVO;
import com.spring.univ.model.MemberVO;
import com.spring.univ.model.SubjectVO;
import com.spring.univ.model.WeekVO;
import com.spring.univ.service.InterJaeService;


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
public class JaeController {
	
	
	 @Autowired
	 private InterJaeService service;
	 
	 @Autowired
	 private FileManager fileManager;
	 
	// 수업주차들과 총 수업 정보들 가져오기
	@RequestMapping(value="/classContents.univ")
	public ModelAndView subject_classContents(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		String code = (String) session.getAttribute("code");
		
		List<WeekVO> getWeek = service.getWeek(code);
		List<Map<String,String>> classList = service.getclassList();
		
		
		mav.addObject("code", code);
		mav.addObject("getWeek", getWeek);
		mav.addObject("classList", classList);
		mav.setViewName("classContents.tiles2");
		
		return mav;
		//return "classContents.tiles2";
		
		
	}
	
	
	//주차별 차시 정보들 가져오기(Ajax로 아코디언 꽂아주는 것)
	@ResponseBody
	@RequestMapping(value="/getlesson.univ" ,method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String requiredLogin_getlesson(HttpServletRequest request,HttpServletResponse response) {
		
		String week = request.getParameter("week");
		
		//과목코드도 넣을 것
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String code = (String)session.getAttribute("code");
		
		String fk_hakbun = loginuser.getHakbun();
		
		Map<String, String> paraMap2 = new HashMap<>();
		paraMap2.put("week", week);
		paraMap2.put("fk_code", code);
		
		List<Map<String,String>> classListbyWeek = service.classListbyWeek(paraMap2);
		
		String lessonseq = "";
		JSONArray jsonArr = new JSONArray();
		
		if (classListbyWeek != null) {
			
			for(Map<String,String> map : classListbyWeek) {
				
				lessonseq = map.get("lessonseq");
				
				Map<String,String> paraMap = new HashMap<>();
				paraMap.put("fk_lessonseq", lessonseq);
				paraMap.put("fk_hakbun", fk_hakbun);
				
				int isCheck = service.getAttendCheck(paraMap);
				
				
				
				
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("code", map.get("code"));
				jsonObj.put("subject", map.get("subject"));
				jsonObj.put("hakjum", map.get("hakjum"));
				jsonObj.put("classdate", map.get("classdate"));
				jsonObj.put("fk_deptcode", map.get("fk_deptcode"));
				jsonObj.put("startday", map.get("startday"));
				jsonObj.put("weekseq", map.get("weekseq"));
				jsonObj.put("lessonseq", map.get("lessonseq"));
				jsonObj.put("week", map.get("week"));
				jsonObj.put("lesson", map.get("lesson"));
				jsonObj.put("video", map.get("video"));
				jsonObj.put("savefile", map.get("savefile"));
				jsonObj.put("uploadfile", map.get("uploadfile"));
				jsonObj.put("isCheck", isCheck);
				
				
				jsonArr.put(jsonObj);
			}
		}
		//System.out.println(jsonArr);
		return jsonArr.toString();
				
	}
	
	
	
	
	//수업 주차 등록하기(폼 보여주기)	
	@RequestMapping(value="/classWeekRegister.univ")
	public ModelAndView classWeekRegister(HttpServletRequest request, ModelAndView mav) {
		
		String code = request.getParameter("code");
		//System.out.println(code);
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String hakbun = loginuser.getHakbun();
		
		//로그인 검사
		//로그인을 했어도 교수이어야 하고 등록하고 자하는 전공교수 학번과 로그인한 교수 학번이 같은지 검사
		
		//현재 받아온 코드를 가지고 이 전공을 등록한 교수의 학번이 뭔지 알아옴 그리고 로그인 비교한다.		
		SubjectVO sbvo = service.getOneSubjectByCode(code);
		
		int getWeekCount = service.getWeekCount(code);
		
		
		if( !sbvo.getFk_hakbun().equals( loginuser.getHakbun() ) && !String.valueOf(loginuser.getAuthority()).equals("2")) {
			
		   String message = "전공을 등록한 교수만 주차등록이 가능합니다.";
		   String loc = "javascript:history.back()";
		  
		   mav.addObject("message", message);
		   mav.addObject("loc", loc);
		  
		   mav.setViewName("msg");
		}
		else {
			
			mav.addObject("getWeekCount",getWeekCount);
			mav.addObject("sbvo", sbvo);
			mav.addObject("hakbun", hakbun);
			
			mav.setViewName("classWeekRegister.tiles2");
			
		}
		
		
		
		return mav;
	}
	
	
	
	
	//수업 주차 등록하기
	@RequestMapping(value="/classWeekRegisterEnd.univ", method= {RequestMethod.POST})
	public ModelAndView classWeekRegisterEnd(HttpServletRequest request, ModelAndView mav) {
		
		String week = request.getParameter("week");
		String fk_code = request.getParameter("fk_code");
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("week", week);
		paraMap.put("fk_code", fk_code);
		
		//System.out.println(week);
		//System.out.println(fk_code);
		
		int n;
		
		try {
			
			n = service.classWeekRegister(paraMap);
			if(n==1) {
			mav.addObject("message", "주차 등록에 성공했다..!");
			   
			mav.addObject("loc",request.getContextPath()+"/classContents.univ");
			}
			else {
				mav.addObject("message", "주차 등록 실패!!!!!!");
				   
				mav.addObject("loc",request.getContextPath()+"/classContents.univ");
				
			}
			
		} catch (Exception e) {
			 mav.addObject("message","이미 등록된 주차이므로 등록이 불가합니다.");	   
			   
			 mav.addObject("loc", request.getContextPath()+"/classContents.univ");
			e.printStackTrace();
		}
		
	    mav.setViewName("msg");
	 	
		
		return mav;
	}
	
	
	//수업 차시 등록하기(폼 보여주기)	
	@RequestMapping(value="/classLessonRegister.univ")
	public ModelAndView classLessonRegister(HttpServletRequest request, ModelAndView mav) {
		
		String code = request.getParameter("code");
		//System.out.println(code);
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String hakbun = loginuser.getHakbun();
		
		//로그인 검사
		//로그인을 했어도 교수이어야 하고 등록하고 자하는 전공교수 학번과 로그인한 교수 학번이 같은지 검사
		
		//현재 받아온 코드를 가지고 이 전공을 등록한 교수의 학번이 뭔지 알아옴 그리고 로그인 비교한다.		
		SubjectVO sbvo = service.getOneSubjectByCode(code);
		
		List<WeekVO> getWeek = service.getWeek(code);
		
		
		if( !sbvo.getFk_hakbun().equals( loginuser.getHakbun() ) && !String.valueOf(loginuser.getAuthority()).equals("2")) {
			
			 String message = "전공을 등록한 교수만 차시등록이 가능합니다.";
			   String loc = "javascript:history.back()";
			  
			   mav.addObject("message", message);
			   mav.addObject("loc", loc);
			  
			   mav.setViewName("msg");
		}
		else {
			
			mav.addObject("getWeek",getWeek);
			mav.addObject("sbvo", sbvo);
			mav.addObject("hakbun", hakbun);
			
			mav.setViewName("classLessonRegister.tiles2");
			
		}
		
		
		
		return mav;
	}
	
	
	
	
	//수업 차시 등록하기
	@RequestMapping(value="/classLessonRegisterEnd.univ", method= {RequestMethod.POST})
	public ModelAndView classLessonRegisterEnd(HttpServletRequest request, ModelAndView mav) {
		
		String fk_weekseq = request.getParameter("fk_weekseq");
		String lesson = request.getParameter("lesson");
		String video = request.getParameter("video");
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("fk_weekseq", fk_weekseq);
		paraMap.put("lesson", lesson);
		paraMap.put("video", video);
		
		//System.out.println(weekseq);
		//System.out.println(fk_code);
		
		int n;
		
		try {
			
			n = service.classLessonRegister(paraMap);
			
			if(n==1) {
				mav.addObject("message", "차시 등록에 성공했다..!");
				   
				mav.addObject("loc",request.getContextPath()+"/classContents.univ");
			}
			else {
				mav.addObject("message", "차시 등록 실패");
				   
				mav.addObject("loc",request.getContextPath()+"/classContents.univ");
				
			}
			
		} catch (Exception e) {
			 mav.addObject("message","이미 등록된 차시이므로 등록이 불가합니다.");	   
			   
			 mav.addObject("loc", request.getContextPath()+"/classContents.univ");
			e.printStackTrace();
		}
		
	    mav.setViewName("msg");
	 	
		
		return mav;
	}
	
	
	
	
	
	
	// 하나의 수업 정보 가져오기
	@RequestMapping(value="/classContentsView.univ")
	public ModelAndView classContentsView(HttpServletRequest request, ModelAndView mav) {
		
		//String code = "0501";
		//String week = "1";
		//String lesson = "1";
		//String lessonseq = "15";
		
		String code = request.getParameter("code");
		String week = request.getParameter("week");
		String lesson = request.getParameter("lesson");
		String lessonseq = request.getParameter("lessonseq");
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("code", code);
		paraMap.put("week", week);
		paraMap.put("lesson", lesson);
		paraMap.put("lessonseq", lessonseq);
		
		//하나의 수업 정보 가져오기
		Map<String,String> oneClassView = service.getOneClassView(paraMap);
		
		//주차별 차시 수업 정보들 가져오기 - 목록으로 돌아가기 넣기 위해
		
		Map<String,String> paraMap2 = new HashMap<>();
		paraMap2.put("fk_code", code);
		paraMap2.put("week", week);
		
		List<Map<String,String>> classListbyWeek = service.classListbyWeek(paraMap2);
		
		//교수가 올린 강의 게시물 가져오기
		List<ClassContentBoardVO> classContentList = service.getclassContentList(lessonseq);
		
		mav.addObject("oneClassView", oneClassView);
		mav.addObject("classListbyWeek", classListbyWeek);
		mav.addObject("classContentList", classContentList);
		
		mav.setViewName("classContentsView.tiles2");
		
		return mav;
				
		
	}
	
	
	// 교수님 강의콘텐츠에 게시물 올리는 폼 보여주기
	@RequestMapping(value="/classContentWrite.univ")
	public ModelAndView classContentWrite(HttpServletRequest request, ModelAndView mav) {
	
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		/*
		  로그인하면 로그인 정보 넘겨주기 학번,이름
		  지금은 그냥 넣어주겠음
		  
		  그리고 로그인 했을때만 들어오게 하고 교수로 로그인 했을때만 들어올수있게 해야함
		 */
		
		
		
		String code = request.getParameter("code");
		String lessonseq = request.getParameter("lessonseq");
		
		//System.out.println(loginuser.getName());
		
		mav.addObject("lessonseq", lessonseq);
		mav.addObject("code", code);
		
		
		mav.setViewName("classContentWriteView.tiles2");
		return mav;
	}	
	
	
	
	
	// 교수님 강의콘텐츠에 게시물 올리기
	@RequestMapping(value="/classContentWriteEnd.univ")
	 public ModelAndView classContentWriteEnd(Map<String,String> paraMap, ModelAndView mav, ClassContentBoardVO ccbvo,  MultipartHttpServletRequest mrequest) { // < == After Advice 를 사용하기
		   
		/*
	       form 태그의 name 명과  BoardVO 의 필드명이 같다라면 
	       request.getParameter("form 태그의 name명"); 을 사용하지 않더라도
	               자동적으로 ClassContentBoardVO ccbvo 에 set 되어진다.
	    */

		
		String code = mrequest.getParameter("keycode");
		String week = mrequest.getParameter("keyweek");
		String lesson = mrequest.getParameter("keylesson");
		String lessonseq = mrequest.getParameter("keylessonseq");
		
		//System.out.println(code);
		   MultipartFile attch = ccbvo.getAttach();
		   
		   if( !attch.isEmpty() ) {

			   HttpSession session = mrequest.getSession();
			   String root = session.getServletContext().getRealPath("/");
			   
			   //C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
			   
			   String path = root + "resources" + File.separator + "files";
			   /* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
			            운영체제가 Windows 이라면 File.separator 는  "\" 이고,
			            운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
			   */
			   
			   //path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
			   //System.out.println("~~~확인용 path : " + path );
			   
			   /*
			      2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
			    */
			   String newFileName = "";
			   //WAS(톰캣)의 디스크에 저장될 파일명
			   
			   byte[] bytes = null;
			   //첨부파일의 내용물을 담는 것
			   
			   long fileSize = 0;
			   // 첨부파일의 크기
			   
			   try {
				   
					bytes = attch.getBytes();
					// 첨부파일의 내용물을 읽어오는 것
					
					newFileName = fileManager.doFileUpload(bytes, attch.getOriginalFilename(), path);
					// 첨부되어진 파일을 업로드 하도록 하는 것이다. 
		            // attach.getOriginalFilename() 은 첨부파일의 파일명(예: 강아지.png)이다.
					
					//System.out.println(">> 확인용 : "+ newFileName);
					
				/*
				   3. ClassContentBoardVO ccbvo 에 fileName , orgFilename , fileSize 값을 넣어주기
				 */
					
					ccbvo.setFileName(newFileName);
					// WAS(톰캣) 에 저장될 파일명()
					ccbvo.setOrgFilename(attch.getOriginalFilename());
					// 게시판 페이지에서 첨부된 ㅣ파일(강아지.png)을 
					fileSize = attch.getSize();   // 첨부파일의 크기(단위는 byte임)
					ccbvo.setFileSize(String.valueOf(fileSize));
				
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			   
		   }
		   
		   //   !!! 첨부파일이 있는 경우 작업 끝 !!!
		   
			/*
			  System.out.println("확인용 fk_userid : "+ boardvo.getFk_userid());
			  System.out.println("확인용 name : "+ boardvo.getName());
			  System.out.println("확인용 subject : "+ boardvo.getSubject());
			 */
		//   int n = service.add(ccbvo);   // <== 파일첨부가 없는 글쓰기
		   
		   // 파일첨부가 있는 글쓰기 또는 파일첨부가 없는 글쓰기로 나뉘어서 Service 호출하기 ===/
		   // 먼저 위의 int n = service.add(ccbvo) 부분을 주석처리 하고서 아래와 같이 한다.
		   int n = 0;
		   	   
		   // 첨부파일이 없는 경우라면
		   if(attch.isEmpty()) {
			   n = service.classContentAdd(ccbvo);
		   }
		   
		   // 첨부파일이 있는 경우라면
		   else {
			   n = service.classContentAdd_withFile(ccbvo);
		   }
		   
		   mav.setViewName("redirect:/classContentsView.univ?code="+code+"&week="+week+"&lesson="+lesson+"&lessonseq="+lessonseq+"");
		   //classContentsView.univ 페이지로 redirect(페이지이동) 해라는 말이다.
		   
		   		  
		   
		   return mav;
	   }
	
	
	
	
	 // === 첨부파일 다운로드 받기 ===//
	   
	   @RequestMapping(value="/classContentDownload.univ")
	   public void classContentDownload(HttpServletRequest request, HttpServletResponse response) {
		   
		   String classBoardSeq = request.getParameter("classBoardSeq");
		   
		   // 첨부파일이 있는 글번호
		   
		   /*
		       첨부파일이 있는 글번호에서 
		   202111081126411253993601162100.jpg 처럼
		       이러한 fileName 값을 DB에서 가져온다.
		       또한 orgFilename 값도 DB에서 가져와야 한다.	       
		    */
		   Map<String, String> paraMap = new HashMap<>();
		   paraMap.put("classBoardSeq", classBoardSeq);
		   	   
		   response.setContentType("text/html; charset=UTF-8");
		   PrintWriter out = null;  // 이 out은 웹에 보여주겠다는 뜻    즉 view 단을 통해서가 아닌 여기서 바로 직접 웹에 보여주겠다. 메시지를!
		   
		   System.out.println();  // 이건 콘솔에 보여주겠따는 것
		   try {
			   Integer.parseInt(classBoardSeq);  //seq를 url에 문자로 쳐서 들어올경우 이렇게 잡아서 catch에 오류메시지를 띄워주게끔 해준다.
			   
			   ClassContentBoardVO ccbvo = service.getClassOneContent(classBoardSeq);
			   
			   if(ccbvo == null || (ccbvo != null && ccbvo.getFileName() == null ) ) {
				   
				   out = response.getWriter();
				   // 웹브라우저상에 메시지를 쓰기 위한 객체생성
				    
				   out.println("<script type='text/javascript'>alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 다운로드가 불가합니다!!'); history.back() </script>");

				   
				   return; //종료
			   }
			   
			   else {
				   String fileName = ccbvo.getFileName();
				   //202111081126411253993601162100.jpg 이것이 바로 WAS(톰캣) 디스크에 저장된 파일 이름이다.
				   
				   String orgFilename = ccbvo.getOrgFilename();
				   //동영상캡처.png 다운로드시 보여줄 파일명
				   
				   
				// 첨부파일이 저장되어 있는 WAS(톰캣)의 디스크 경로명을 알아와야만 다운로드를 해줄수 있다. 
		        // 이 경로는 우리가 파일첨부를 위해서 /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
				// WAS의 webapp 의 절대경로를 알아와야 한다.
				   HttpSession session = request.getSession();
				   String root = session.getServletContext().getRealPath("/");
				   
				   //C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
				   
				   String path = root + "resources" + File.separator + "files";
				  
				   
				   //path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
				   //System.out.println("~~~확인용 path : " + path );
				   
				   //*** file 다운로드하기 ***//
				   boolean flag = fileManager.doFileDownload(fileName, orgFilename, path, response);   // response를 쓰는 이유 모든 ㅡ종류의 파일을 다운로드해주겠다라는 걸 명기해주겠다라는 뜻으로 써준다.
				   // flag 값이 true로 받아오면 다운로드 성공을 말하고,
				   // flag 값이 false로 받아오면 다운로드 실패를 말한다.
				   
				   if(flag == false) {
					   
					   //다운로드가 실패할 경우 메시지를 띄워준다.
					   out = response.getWriter();
					   // 웹브라우저상에 메시지를 쓰기 위한 객체생성
					    
					   out.println("<script type='text/javascript'>alert('파일 다운로드가 실패되었습니다.'); history.back() </script>");
					   
					   
				   }
				   
			   }
		   }catch(IOException e2) {
			   e2.printStackTrace();
		   }catch(NumberFormatException e) {
			   
			   try {
				   out = response.getWriter();
				   // 웹브라우저상에 메시지를 쓰기 위한 객체생성
				    
				   	out.println("<script type='text/javascript'>alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 다운로드가 불가합니다!!'); history.back() </script>");
			   
			   }catch(IOException e1) {
				   
			   }
		   }
		   
	   }
	   
	   
	   //강의 콘텐츠 게시물 수정하는 폼 보여주기
	   @RequestMapping(value="/classContentEdit.univ")
	   public ModelAndView classContentEdit( HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		   
		   
		   
		   // 수정해야할 글 번호 가져오기
		   String classBoardSeq = request.getParameter("classBoardSeq");
		   
		   // 글 수정해야할 글1개 내용 가져오기
		   Map<String,String> paraMap = new HashMap<>();
		   paraMap.put("classBoardSeq",classBoardSeq);
		   
		   ClassContentBoardVO ccbvo = service.getClassOneContent(classBoardSeq);
		   
		  
		  HttpSession session = request.getSession();
		  MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		  
		  if( !loginuser.getHakbun().equals(ccbvo.getFk_hakbun()) ) {
			  String message = "다른 사용자의 게시물은 수정이 불가합니다";
			  String loc = "javascript:history.back()";
			  
			  mav.addObject("message", message);
			  mav.addObject("loc", loc);
			  
			  mav.setViewName("msg");
		  }
		  else {
			  //자신의 글을 수정할 경우
			  // 가져온 1개글을 글수정할 폼이 있는 view 단으로 보내준다.
			  mav.addObject("ccbvo",ccbvo);
			  mav.setViewName("classContentEdit.tiles2");
		  }
		   
		   return mav;
	   }
	   
	   
	   
	   
   
	   // 게시물 수정 하기 완료=== //
	   @RequestMapping(value="/classContentEditEnd.univ", method= {RequestMethod.POST})
	   public ModelAndView classContentEditEnd(ModelAndView mav, ClassContentBoardVO ccbvo, MultipartHttpServletRequest mrequest) {
		   
		   String code = mrequest.getParameter("keycode");
		   String week = mrequest.getParameter("keyweek");
		   String lesson = mrequest.getParameter("keylesson");
		   String lessonseq = mrequest.getParameter("keylessonseq");
		   
		   Map<String,String> paraMap = new HashMap<>();
		   
		   String classBoardSeq = ccbvo.getClassBoardSeq();
		   //System.out.println(classBoardSeq);
		   
		   
		   
      //==============첨부 파일도 변경할 경우  시작==========================================================================================//
		   
		   
		   MultipartFile attch = ccbvo.getAttach();
		   
		   if( !attch.isEmpty() ) {
			   // attch(첨부파일) 가 비어있니 않으면 (즉, 첨부파일이 있는 경우라면)
			   
			   HttpSession session = mrequest.getSession();
			   String root = session.getServletContext().getRealPath("/");
			   
			   System.out.println("~~~~확인용 webapp 의 절대경로 => " + root);
			   //C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
			   
			   String path = root + "resources" + File.separator + "files";

			   String newFileName = "";
			   //WAS(톰캣)의 디스크에 저장될 파일명
			   
			   byte[] bytes = null;
			   //첨부파일의 내용물을 담는 것
			   
			   long fileSize = 0;
			   // 첨부파일의 크기
			   
			   try {
				   
					bytes = attch.getBytes();
					// 첨부파일의 내용물을 읽어오는 것
					
					newFileName = fileManager.doFileUpload(bytes, attch.getOriginalFilename(), path);
					// 첨부되어진 파일을 업로드 하도록 하는 것이다. 

					
				/*
				   3. ClassContentBoardVO ccbvo 에 fileName , orgFilename , fileSize 값을 넣어주기
				 */
					
					ccbvo.setFileName(newFileName);
					// WAS(톰캣) 에 저장될 파일명()
					ccbvo.setOrgFilename(attch.getOriginalFilename());
					// 게시판 페이지에서 첨부된 ㅣ파일(강아지.png)을 
					fileSize = attch.getSize();   // 첨부파일의 크기(단위는 byte임)
					ccbvo.setFileSize(String.valueOf(fileSize));
				
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			   
		   }
  
		 //====첨부파일도 변경하는거라면 원래 있던 첨부파일을 삭제해야한다. 시작 ===//		   
		   
		  // ccbvo = service.getClassOneContent(classBoardSeq);  // 원본파일명을 알아오기 위해 위의 조회해오는 메소드를 재활용한다.		   
		  // String fileName = ccbvo.getFileName();
		   
		   String fileName = ccbvo.getFileName();
		   System.out.println("확인용 fileName : "+ fileName);
		   
		   if (fileName != null && !"".equals(fileName)) { // 삭제해야할 첨부파일이 있따면~~~~ 만약 없으면 실행안하고 패스~~~~~~ 그냥 글만 바로 삭제~~
			   
			   HttpSession session = mrequest.getSession();
			   String root = session.getServletContext().getRealPath("/");  //~~~/board/    이렇게 board 하고 / 까지 알아온다.
			   String path = root + "resources" + File.separator + "files";           // 합쳐서 진짜 구체적인 경로 만들기
			   
			   paraMap.put("path", path);// 삭제해야할 파일이 저장된 경로
			   paraMap.put("fileName",fileName);// 삭제해야할 파일명
		   }
		   
		   
		   
		   //====  첨부파일도 변경하는거라면 원래 있던 첨부파일을 삭제해야한다. 끝 ===//
		   
		 //==============첨부 파일도 변경할 경우  끝==========================================================================================//
		   System.out.println(ccbvo.getSubject());
		   System.out.println("파일네임: " + ccbvo.getFileName());
		   System.out.println("오리지널파일네임: " + ccbvo.getOrgFilename());
		   
		   int n = 0;
		   	   
		   // 첨부파일이 없는 경우라면, 단순 게시물만 수정하는거라면
		   if(fileName == null || "".equals(fileName)) {
			    n = service.classContentEdit(ccbvo);
		   }
		   
		   // 첨부파일도 변경하는거라면
		   else {
			   n = service.classContentEdit_withFile(ccbvo,paraMap);
		   }
		   		  
	   
		   if(n== 0) {
			   mav.addObject("message","게시물 수정에 실패했습니다.!");
			   
		   }
		   else {
			   mav.addObject("message", "게시물 수정에 성공했다..!");
		   }
		   
		   mav.addObject("loc",mrequest.getContextPath()+"/classContentsView.univ?code="+code+"&week="+week+"&lesson="+lesson+"&lessonseq="+lessonseq+"");
		   mav.setViewName("msg");
		  // mav.setViewName("redirect:/classContentsView.univ");
		   
		   return mav;
	   }
	   
	   
	   
	   
	   
	   
	   
	// === 게시글 삭제하기 //
	   @RequestMapping(value="/classContentDel.univ")
	   public ModelAndView classContentDel(ModelAndView mav,  HttpServletRequest request) {
		   
		   String code = request.getParameter("code");
		   String week = request.getParameter("week");
		   String lesson = request.getParameter("lesson");
		   String lessonseq = request.getParameter("lessonseq");
		   
		   
			// 삭제해야할 글 번호 가져오기
		   String classBoardSeq = request.getParameter("classBoardSeq");
		   
		   ClassContentBoardVO ccbvo = service.getClassOneContent(classBoardSeq);
		   
		   Map<String,String> paraMap = new HashMap<>();
		   paraMap.put("classBoardSeq", classBoardSeq);
			   
		   HttpSession session = request.getSession();
		   MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		  
		   if( !loginuser.getHakbun().equals(ccbvo.getFk_hakbun()) ) {
			   
				   String message = "다른 사용자의 글은 삭제 불가합니다";
				   String loc = "javascript:history.back()";
				  
				   mav.addObject("message", message);
				   mav.addObject("loc", loc);
				  
				   mav.setViewName("msg");
		   }
		   else {
				   
			   
				   //====파일첨부가 된 게시물이라면 삭제시 먼저 첨부파일을 삭제해주어야 한다. 시작 ===//
				   
				     // 원본파일명을 알아오기 
				   String fileName = ccbvo.getFileName();
				   
				   if (fileName != null && !"".equals(fileName)) { 
					   
					   
					   String root = session.getServletContext().getRealPath("/");  
					   String path = root + "resources" + File.separator + "files";          
					   
					   paraMap.put("path", path);// 삭제해야할 파일이 저장된 경로
					   paraMap.put("fileName",fileName);// 삭제해야할 파일명
				   }
				   
				   //====  파일첨부가 된 글이라면 삭제시 먼저 첨부파일을 삭제해주어야 한다. 끝 ===//
					   
				   
				   
				   
			   int n = service.classContentDel(paraMap);

			   
			   if(n== 0) {
				   mav.addObject("message","삭제 실패!!");	   

				   mav.addObject("loc", request.getContextPath()+"/classContentsView.univ?code="+code+"&week="+week+"&lesson="+lesson+"&lessonseq="+lessonseq+"");
				   
			   }
			   else {
				   mav.addObject("message", "글 삭제에 성공했다..!");
			   }
			   
			   mav.addObject("loc",request.getContextPath()+"/classContentsView.univ?code="+code+"&week="+week+"&lesson="+lesson+"&lessonseq="+lessonseq+"");
			   
			   mav.setViewName("msg");
				   
			   
			   
			   
		   }
		   
		   return mav;
		   
	   }
	
	
	
	   
	   
   //첨부파일이 없는 댓글쓰기
   @ResponseBody
   @RequestMapping(value="/classCommentWrite_noAttach.univ", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
   public String classCommentWrite_noAttach(ClassContentCommentVO cccvo , HttpServletRequest request) {
	   
	   
	   HttpSession session = request.getSession();
	   MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
	   
	   String fk_classBoardSeq = cccvo.getFk_classBoardSeq();
	   String commentContent = cccvo.getCommentContent();
	   	   
	   String hakbun = loginuser.getHakbun();
	   String name = loginuser.getName();
	   
	   Map<String,String> paraMap = new HashMap<>();
	   paraMap.put("fk_classBoardSeq", fk_classBoardSeq);
	   paraMap.put("commentContent", commentContent);
	   paraMap.put("hakbun", hakbun);
	   paraMap.put("name", name);
	   
	   
	   System.out.println(fk_classBoardSeq);
	   System.out.println(commentContent);
	   System.out.println(hakbun);
	   
	   int n = 0;
	   
	   //첨부파일 없는 댓글쓰기(Ajax)
	   n = service.classCommentWrite_noAttach(paraMap);
	   
	   JSONObject jsonObj = new JSONObject();
	   jsonObj = new JSONObject();
	   jsonObj.put("n", n);
	    
	   
	   
	   return jsonObj.toString();
   }
   
   
   
   // 첨부파일이 있는 댓글쓰기(Ajax 로 처리) === //
   @ResponseBody
   @RequestMapping(value="/classCommentWrite_withAttach.univ", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
   public String classCommentWrite_withAttach(ClassContentCommentVO cccvo, MultipartHttpServletRequest mrequest) {
      // 댓글쓰기에 첨부파일이 있는 경우
      
	// String aa = mrequest.getParameter("fk_hakbun");
	      //System.out.println(aa);
	   
	   
      // === !!! 첨부파일이 있는 경우 작업 시작 !!! === //
      MultipartFile attach = cccvo.getAttach();    
      
      if(!attach.isEmpty()) {// attach(첨부파일)가 비어있지 않다면(즉, 첨부파일이 있는 경우라면)
         
         /*
          1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
          >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
                   우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
              Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다. 
         */
         // WAS의 webapp 의 절대경로를 알아와야 한다.
         HttpSession session = mrequest.getSession();
         String root = session.getServletContext().getRealPath("/");
         
         // System.out.println("~~~ 확인용 webapp 의 절대경로 => " + root);
         // C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
         
         String path = root + "resources" + File.separator + "files"; 
         /* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
                    운영체제가 Windows 이라면 File.separator 는  "\" 이고,
                    운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
          */
         
         // path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
         // System.out.println("~~~ 확인용 path => " + path);
         // C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files
         
         /*
             2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일올리기
         */
         String newFileName = "";
         // WAS(톰캣)의 디스크에 저장될 파일명
         
         byte[] bytes = null;
         // 첨부파일의 내용물을 담는 것
         
         long fileSize = 0;
         // 첨부파일의 크기
         
         try {
            bytes = attach.getBytes();
            // 첨부파일의 내용물을 읽어오는 것
            
            newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
            // 첨부되어진 파일을 업로드 하도록 하는 것이다. 
               // attach.getOriginalFilename() 은 첨부파일의 파일명(예: 강아지.png)이다.
            
            // System.out.println(">>> 확인용 newFileName => " + newFileName);
            // >>> 확인용 newFileName => 20211108112622657914648244900.png
            
         /*
            3. CommentVO commentvo 에 fileName, orgFilename, fileSize 값이 들어가야 한다.
         */
            cccvo.setFileName(newFileName);
            // WAS(톰캣)에 저장될 파일명(20211108112622657914648244900.png)
            
            cccvo.setOrgFilename(attach.getOriginalFilename());
            // 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
            // 또한 사용자가 파일을 다운로드 할때 사용되어지는  파일명으로 사용. 
            
            fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
            cccvo.setFileSize(String.valueOf(fileSize));
            
            
         } catch (Exception e) {
            e.printStackTrace();
         }
      }
      // === !!! 첨부파일이 있는 경우 작업 끝 !!! === //
      
      
      int n = 0;
      
      try {
         n = service.classCommentWrite_withAttach(cccvo);
      } catch (Throwable e) {
         e.printStackTrace();
      }
      
      // 댓글쓰기(insert) 및 원게시물(tbl_board 테이블)에 댓글의 개수 증가(update 1씩 증가)하기 
       // 이어서 회원의 포인트를 50점을 증가하도록 한다. (tbl_member 테이블에 point 컬럼의 값을 50 증가하도록 update 한다.) 
      
      JSONObject jsonObj = new JSONObject();
      jsonObj.put("n", n);
      jsonObj.put("name", cccvo.getName());
      
      return jsonObj.toString();
   }
   
   
   
   //댓글쓴거 불러오기(Ajax)
   @ResponseBody
   @RequestMapping(value="/commentList.univ", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
   public String commentList(HttpServletRequest request) {
	   
	   String fk_classBoardSeq = request.getParameter("fk_classBoardSeq");
	   String currentShowPageNo = request.getParameter("currentShowPageNo");
	   String searchWord = request.getParameter("searchWord");
	      // default는 무조건 1페이지이다.
	   
	   //System.out.println("확인용 fk_classBoardSeq : " + fk_classBoardSeq);
	   //System.out.println("확인용 currentShowPageNo : " + currentShowPageNo);
	   //System.out.println("확인용 searchWord : " + searchWord);
	      
	   
	   
	      if(currentShowPageNo == null) {
	         currentShowPageNo = "1";
	      }
	      
	      int sizePerPage = 5; // 한 페이지당 5개의 댓글을 보여줄 것이다.
	      
	      // **** 가져올 게시글의 범위를 구한다.(공식임!!!) **** 
	        /*
	             currentShowPageNo      startRno     endRno
	            --------------------------------------------
	                 1 page        ===>    1           5
	                 2 page        ===>    6           10
	                 3 page        ===>    11          15
	                 4 page        ===>    16          20
	                 ......                ...         ...
	         */
	      
	      int startRno = (( Integer.parseInt(currentShowPageNo) - 1 ) * sizePerPage) + 1;
	       int endRno = startRno + sizePerPage - 1; 
	      
	       // 댓글은 검색기능이 없으니 무조건 다 보여주는 것이다.
	       
	       Map<String, String> paraMap = new HashMap<>();
	       paraMap.put("fk_classBoardSeq", fk_classBoardSeq);
	       paraMap.put("startRno", String.valueOf(startRno));
	       paraMap.put("endRno", String.valueOf(endRno));
	       
	       if(fk_classBoardSeq == null || "".equals(fk_classBoardSeq) || fk_classBoardSeq.trim().isEmpty()) {
	    	   fk_classBoardSeq = "";
		   }
	       if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty()) {
			   searchWord = "";
		   }
	       
	       paraMap.put("searchWord", searchWord);
	       
	      List<ClassContentCommentVO> commentList = service.getCommentListPaging(paraMap);
	      
	      JSONArray jsonArr = new JSONArray(); // []
	      
	      if(commentList != null) {
	         
	         for(ClassContentCommentVO cccvo : commentList) {
	            JSONObject jsonObj = new JSONObject();
	            jsonObj.put("classCommentSeq", cccvo.getClassCommentSeq());
	            jsonObj.put("commentContent", cccvo.getCommentContent());
	            jsonObj.put("name", cccvo.getName());
	            jsonObj.put("regDate", cccvo.getRegdate());
	            jsonObj.put("fk_hakbun", cccvo.getFk_hakbun());
	            jsonObj.put("fk_classBoardSeq", cccvo.getFk_classBoardSeq());
	            
	            
	            // 댓글 읽어오기에 있어서 첨부파일 기능을 넣은 경우 시작 //	            
	            jsonObj.put("fileName", cccvo.getFileName());
	            jsonObj.put("orgFilename", cccvo.getOrgFilename());
	            jsonObj.put("fileSize", cccvo.getFileSize());
	            // 댓글 읽어오기에 있어서 첨부파일 기능을 넣은 경우 끝 //
	            
	            jsonArr.put(jsonObj);
	         }// end of for---------------------------------
	         
	      }// 어떤 글은 댓글이 없을수도 있다.
	   
	   return jsonArr.toString();
   }
   
   
   
   //댓글 totalPage 알아오기(Ajax)
   @ResponseBody
   @RequestMapping(value="/getClassContentCommentTotalPage.univ", produces="text/plain;charset=UTF-8")
   public String getClassContentCommentTotalPage(HttpServletRequest request){
	   
	   String fk_classBoardSeq = request.getParameter("fk_classBoardSeq");
	   String searchWord = request.getParameter("searchWord");
	   String sizePerPage = request.getParameter("sizePerPage");
	   
	   if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty()) {
		   searchWord = "";
	   }
	   
	   Map<String,String> paraMap = new HashMap<>();
	   paraMap.put("fk_classBoardSeq", fk_classBoardSeq);
	   paraMap.put("searchWord", searchWord);
	   paraMap.put("sizePerPage", sizePerPage);
	   
	   //원글 글번호(parentSeq) 에 해당하는 댓글의 총개수 알아오기
	   int totalCount = service.getCommentTotalPageCount(paraMap);
	   
	   //=== 총페이지수(totalPage)구하기 ===
	   // 만약에 총 게시물 건수(totalCount) 가 12개 이라면
	   // 총페이지수(totalPage) 는 3개가 되어야 한다.
	  int totalPage = (int)Math.ceil((double)totalCount/Integer.parseInt(sizePerPage)); // (double)12/5 ==> 2.4 ==> Math.ceil(2.4) ==> 3.0 ==> (int)3.0 ==> 3
	  
	  JSONObject jsonObj = new JSONObject();
	  jsonObj.put("totalPage", totalPage);     // {"totalPage":3}
	   
	   
	   return jsonObj.toString();
   }
   
   
   
   
// === 댓글 첨부파일 다운로드 받기 === //
   @RequestMapping(value="/downloadClassContentComment.univ")
   public void downloadClassContentComment(HttpServletRequest request, HttpServletResponse response) {
      
      String classCommentSeq = request.getParameter("classCommentSeq");
      // 첨부파일이 있는 댓글 번호
      
      
      response.setContentType("text/html; charset=UTF-8"); // 응답은 어떠한 방식으로 한다는 뜻이다. - 해당 내용은 웹브라우저에 응답해주겠다는 뜻이다.
      PrintWriter out = null; // 콘솔출력은 System.out.println(); PrintWriter는 위의 setContentType에 따라 웹브라우저에 쓰겠다는 뜻이다.
      
      try {
         
         Integer.parseInt(classCommentSeq);
         
         ClassContentCommentVO cccvo = service.getClassContentCommentOne(classCommentSeq);
         
         if(cccvo == null || (cccvo != null && cccvo.getFileName() == null)) {          
            // 다운로드 링크(<a>)를 확실히 눌렀을때만 다운로드를 하게 해준다.
            // 존재하지 않는 글이거나, 존재는 하지만 파일이 없는 글이라면 조치를 취해준다. (둘다 URL로 장난쳤으면 해당됨)
            out = response.getWriter();
            // 웹브라우저상에 메시지를 쓰기 위한 객체생성이다.
            
            out.println("<script type='text/javascript'> alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일 다운로드가 불가합니다!!'); history.back(); </script>");
            
            return; // 종료
         }
         else { // 올바르게 다운로드에 접근한 경우
            String fileName = cccvo.getFileName();
            // 20211108204609518275380020400.jpg 이것이 바로 WAS(톰캣) 디스크에 저장된 파일명이다.
            
            String orgFilename = cccvo.getOrgFilename();
            // 진짜 파일명(berkelekle디스트리뷰트06.jpg) 파일 다운로드시 보여줄 파일명
            
            
            // 첨부파일이 저장되어 있는 WAS(톰캣)의 디스크 경로명을 알아와야만 다운로드를 해줄수 있다. 
               // 이 경로는 우리가 파일첨부를 위해서 /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
            // WAS의 webapp 의 절대경로를 알아와야 한다.
            HttpSession session = request.getSession();
            String root = session.getServletContext().getRealPath("/");
            
            // System.out.println("~~~ 확인용 webapp 의 절대경로 => " + root);
            // C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
            
            String path = root + "resources" + File.separator + "files"; 
            /* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
                       운영체제가 Windows 이라면 File.separator 는  "\" 이고,
                       운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
             */
            
            // path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
            // System.out.println("~~~ 확인용 path => " + path);
            // C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files
            
            // **** file 다운로드 하기 **** //
            
            boolean flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
            // flag가 true면 다운로드 성공
            // flag가 false면 다운로드 실패  
            
            
            if(flag == false) {
               // 다운로드 실패할 경우 메시지를 띄워준다.
               
               out = response.getWriter();
               // 웹브라우저상에 메시지를 쓰기 위한 객체생성이다.
               
               out.println("<script type='text/javascript'> alert('파일 다운로드가 실패되었습니다.'); history.back(); </script>");
            }
            
            
         }
         
      } catch(NumberFormatException e) {
         try {
            out = response.getWriter();
            out.println("<script type='text/javascript'> alert('존재하지 않는 글번호 이므로 파일 다운로드가 불가합니다!!'); history.back(); </script>");
         } catch (IOException e1) {
            
         }
      } catch(IOException e2) {
         
      }
      
   }
   
   
   
   // 댓글 삭제하기
   @RequestMapping(value="/commentDel.univ")
   public ModelAndView commentDel(HttpServletRequest request, ModelAndView mav) {
	   
	   String code = request.getParameter("code");
	   String week = request.getParameter("week");
	   String lesson = request.getParameter("lesson");
	   String lessonseq = request.getParameter("lessonseq");
	   
	   //로그인 검사하기
	   HttpSession session = request.getSession();
	   MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
	   
	   String classCommentSeq = request.getParameter("classCommentSeq");
	   //System.out.println(classCommentSeq);
	   ClassContentCommentVO cccvo = service.getClassContentCommentOne(classCommentSeq);
	   
	   Map<String,String> paraMap = new HashMap<>();
	   paraMap.put("classCommentSeq", classCommentSeq);
	   
	   if( !loginuser.getHakbun().equals(cccvo.getFk_hakbun()) && !String.valueOf(loginuser.getAuthority()).equals("1") && !String.valueOf(loginuser.getAuthority()).equals("2")) {
		   
		   String message = "다른 사용자의 댓글은 삭제 불가합니다";
		   String loc = "javascript:history.back()";
		  
		   mav.addObject("message", message);
		   mav.addObject("loc", loc);
		  
		   mav.setViewName("msg");
	   }
	   else {
		   

		   //====파일첨부가 된 댓글이라면 삭제시 먼저 첨부파일을 삭제해주어야 한다. 시작 ===//
		   
		     // 원본파일명을 알아오기 
		   String fileName = cccvo.getFileName();
		   
		   if (fileName != null && !"".equals(fileName)) { 
			   
			   
			   String root = session.getServletContext().getRealPath("/");  
			   String path = root + "resources" + File.separator + "files";          
			   
			   paraMap.put("path", path);// 삭제해야할 파일이 저장된 경로
			   paraMap.put("fileName",fileName);// 삭제해야할 파일명
		   }
		   
		   //====  파일첨부가 된 댓글이라면 삭제시 먼저 첨부파일을 삭제해주어야 한다. 끝 ===//
			   
		   
		   
	   //댓글 삭제하기
	   int n = service.classCommentDel(paraMap);

	   
	   if(n== 0) {
		   mav.addObject("message","삭제 실패!!");	   

		   mav.addObject("loc", request.getContextPath()+"/classContentsView.univ?code="+code+"&week="+week+"&lesson="+lesson+"&lessonseq="+lessonseq+"");
		   
	   }
	   else {
		   mav.addObject("message", "댓글 삭제에 성공했다..!");
	   }
	   
	   mav.addObject("loc",request.getContextPath()+"/classContentsView.univ?code="+code+"&week="+week+"&lesson="+lesson+"&lessonseq="+lessonseq+"");
	   
	   mav.setViewName("msg");
		   
	   }
	   
	   return mav;
   
   }
   
   
   
   
   //출석 테이블에 인서트
   @RequestMapping(value="/goAttend.univ", method= {RequestMethod.POST})
	 public ModelAndView goAttend(HttpServletRequest request, ModelAndView mav) {
	   
	   String code = request.getParameter("keycode");
	   String week = request.getParameter("keyweek");
	   String lesson = request.getParameter("keylesson");
	   String lessonseq = request.getParameter("keylessonseq");
	   
	   String fk_lessonseq = request.getParameter("fk_lessonseq");
	   String fk_hakbun = request.getParameter("fk_hakbun");
	   
	   Map<String,String> paraMap = new HashMap<>();
	   paraMap.put("fk_lessonseq", fk_lessonseq);
	   paraMap.put("fk_hakbun", fk_hakbun);
	   
	   int n = 0;
	   
		if(fk_hakbun ==null || "".equals(fk_hakbun)) {
			mav.addObject("message","로그인 하세요!!!!");	 
			
		}
		
		else {
			
			try {
				
			 n = service.goAttend(paraMap);
		
			 	if(n==1) {
					
					mav.addObject("message","학습을 완료하여 출석 처리되었습니다.");	   
				}
				else {
					mav.addObject("message","출석 실패!!!!!");	 
				}
				
			} catch (Exception e) {
				mav.addObject("message","이미 수강완료 하셨습니다.!");	   
				e.printStackTrace();
			}
			
	   }
	   	   
	   mav.addObject("loc", request.getContextPath()+"/classContentsView.univ?code="+code+"&week="+week+"&lesson="+lesson+"&lessonseq="+lessonseq+"");
	   mav.setViewName("msg");
	   
	   return mav;
   }
   
   
   
   
   // 출석했는지 확인해오기(Ajax)
   @ResponseBody
   @RequestMapping(value="/getAttend.univ", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	 public String getAttend(HttpServletRequest request) {
	   
	   String fk_lessonseq = request.getParameter("fk_lessonseq");
	   String fk_hakbun = request.getParameter("fk_hakbun");
	   
	   Map<String,String> paraMap = new HashMap<>();
	   paraMap.put("fk_lessonseq", fk_lessonseq);
	   paraMap.put("fk_hakbun", fk_hakbun);
	   
	   int n = service.attendCheck(paraMap);
	   
	   JSONObject jsonObj = new JSONObject();
	   jsonObj.put("n", n);     
		   		   
	   return jsonObj.toString();
   }
   
		   
   
   
   
   
   
   
	
	
	
}
