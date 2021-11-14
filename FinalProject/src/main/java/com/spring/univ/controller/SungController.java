package com.spring.univ.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.univ.model.*;
import com.spring.univ.service.*;


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
public class SungController {
	
	@Autowired
	private InterSungService service;
	
	// 대쉬보드
	@RequestMapping(value="/dashboard.univ")
	public String requiredLogin_dashboard(HttpServletRequest request, HttpServletResponse response) {
		
		return "Sunghyun/dashboard.tiles1";
	}
	
	
	// 과목 index 페이지 ( 어떤 과목에 들어가면 가장 먼저 보게될 페이지 )
	@RequestMapping(value="/subject.univ")
	public ModelAndView subject_subject(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("Sunghyun/subject.tiles2");
		return mav;
	}
	
	// 강의자료실 페이지
	@RequestMapping(value="/lesson.univ")
	public ModelAndView subject_lesson(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		String code = (String) session.getAttribute("code"); // 해당 과목의 강의자료실 게시글을 가져오기 위한 과목코드
		
		if(code != null) {
			List<LessonBoardVO> boardList = service.getLessonBoard(code);
			mav.addObject("boardList", boardList);
			mav.setViewName("Sunghyun/lesson.tiles2");
			return mav;
		}
		
		else { // URL로 접근을 했다면 CODE가 있을 수 없기 때문에 쫓아낸다.
			mav.addObject("message", "메인페이지로 이동을 합니다.");
			mav.addObject("loc", request.getContextPath()+"/dashboard.univ");
			mav.setViewName("msg");
			return mav;
		}
		
	}
	
	// 강의자료실 글쓰기 폼 요청하기
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/lessonWrite.univ")
	public ModelAndView subject_lessonWrite(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String login_hakbun = loginuser.getHakbun();
		
		Map<String, String> subjectMap = (Map<String, String>) request.getAttribute("subjectMap");
		String subject_hakbun = subjectMap.get("fk_hakbun");
		
		if(login_hakbun != null && !subject_hakbun.equals(login_hakbun)) {
			
			mav.addObject("message", "해당과목의 교수님만 접근이 가능합니다!");
			mav.addObject("loc", request.getContextPath()+"/lesson.univ");
			mav.setViewName("msg");
			return mav;
		}
		
		mav.setViewName("Sunghyun/lessonWrite.tiles2");
		return mav;
	}
	
	// 강의자료실 글 DB에 보내기
	@RequestMapping(value="/lessonWriteEnd.univ", method= {RequestMethod.POST})
	public ModelAndView subject_lessonWriteEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, LessonBoardVO lbvo) {
		
		MultipartFile attach = lbvo.getAttach();
		
		String content = lbvo.getContent();
		content = content.replaceAll("<", "&lt;");
		content = content.replaceAll(">", "&gt;");
		
		lbvo.setContent(content);
		
		if(!attach.isEmpty()) {
			// 파일이 있는 게시글
			
			String path = request.getSession().getServletContext().getRealPath("/");
			String root = path + "resources" + File.separator + "files"; 
			
			try {
				
				byte[] bytes = attach.getBytes(); // 실제 파일내용물
				
				String newFilename = "";
				String fileExt = attach.getOriginalFilename().substring(attach.getOriginalFilename().lastIndexOf(".")); 
				
				newFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
				newFilename += System.nanoTime();
				newFilename += fileExt;
				
				lbvo.setFileName(newFilename); // WAS DISK에 저장될 파일명
				lbvo.setOrgFilename(attach.getOriginalFilename()); 	// 실제 파일명
				lbvo.setFileSize(String.valueOf(attach.getSize())); // 파일사이즈
				
				File file = new File(root);
				
				if(!file.exists()) { // 폴더가 없으면 만들어준다.
					file.mkdir();
				}
				
				String pathname = root + File.separator + newFilename;
				
				FileOutputStream fos;
				
				fos = new FileOutputStream(pathname);
				fos.write(bytes); 
				fos.flush();
				fos.close();
				
				
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			
		}
		
		else {
			lbvo.setFileName("");
		}
		
		int n = service.lessonWriteEnd(lbvo);
		
		if(n==1) {
			String message = "강의자료실 글쓰기 성공";
			String loc = request.getContextPath()+"/lesson.univ";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
			
		}
		else {
			String message = "강의자료실 글쓰기 실패";
			String loc = request.getContextPath()+"/lesson.univ";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	
	// 스마트에디터 다중사진첨부
	@RequestMapping(value="/image/multiplePhotoUpload.univ", method={RequestMethod.POST})
	public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) {
		
	      HttpSession session = request.getSession();
	      String root = session.getServletContext().getRealPath("/"); 
	      String path = root + "resources"+File.separator+"photo_upload";
	      
	      File dir = new File(path);
	      if(!dir.exists()) {
	    	  dir.mkdirs();
	      }
	      
	      String strURL = "";
	      
	      try {
		      String filename = request.getHeader("file-name");
		      
		      InputStream is = request.getInputStream();
		      
		      if(filename == null || "".equals(filename)) {
		    	  return;
		      } 
		      
		      String fileExt = filename.substring(filename.lastIndexOf("."));
		      if(fileExt == null || fileExt.equals("")) {
		    	  return;
		      }
		      
		      String newFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
		      newFilename += System.nanoTime();
		      newFilename += fileExt;
		      
		     dir = new File(path);
		      if(!dir.exists()) {
		    	  dir.mkdirs();
		      }
		      
		      String pathname = path + File.separator + newFilename;
		      
		      byte[] byteArr = new byte[1024];
		      int size = 0;
		      FileOutputStream fos = new FileOutputStream(pathname);
		      
		      while((size = is.read(byteArr)) != -1) {
		         fos.write(byteArr, 0, size);
		         fos.flush();
		      }
		      
		      fos.close();
		      is.close();
		      
		      String ctxPath = request.getContextPath();
              
              strURL += "&bNewLine=true&sFileName="+newFilename;
              strURL += "&sWidth=";
              strURL += "&sFileURL="+ctxPath+"/resources/photo_upload/"+newFilename;
              
              // === 웹브라우저상에 사진 이미지를 쓰기 === //
              PrintWriter out = response.getWriter();
              out.print(strURL);
	      
	      } catch (Exception e) {
	    	  e.printStackTrace();
	      }
	}
	
	// 강의자료실 글 상세보기
	@RequestMapping(value="/lessonDetail.univ")
	public ModelAndView subject_lessonDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String code = request.getParameter("code");
		String seq = request.getParameter("seq");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("code", code);
		paraMap.put("seq", seq);
		
		LessonBoardVO lbvo = service.getLessonBoardDetail(paraMap);
		
		mav.addObject("lbvo", lbvo);
		mav.setViewName("Sunghyun/lessonDetail.tiles2");
		
		return mav;
	}
	
	// 강의자료실 댓글쓰기
	@ResponseBody
	@RequestMapping(value="/addComment_LessonBoard.univ", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String subject_addComment_LessonBoard(HttpServletRequest request, HttpServletResponse response, LessonBoardCommentVO lbcvo) {
		
		String content = lbcvo.getContent();
		content = content.replaceAll("<", "&lt;");
		content = content.replaceAll(">", "&gt;");
		
		lbcvo.setContent(content);
		
		int n = service.addLessonBoardComment(lbcvo);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
		
		return jsObj.toString();
	}
	
	// 강의자료실 댓글목록 가져오기
	@ResponseBody
	@RequestMapping(value="/getComment_LessonBoard.univ", produces="text/plain;charset=UTF-8")
	public String subject_getComment_LessonBoard(HttpServletRequest request, HttpServletResponse response) {
		
		String parentSeq = request.getParameter("parentSeq");
		
		List<LessonBoardCommentVO> commentList = service.getLessonBoardComment(parentSeq);
		
		JSONArray jsonArr = new JSONArray();
		
		
		for(LessonBoardCommentVO lbcvo : commentList) {
			JSONObject jsObj = new JSONObject();
			jsObj.put("seq", lbcvo.getSeq());
			jsObj.put("fk_hakbun", lbcvo.getFk_hakbun());
			jsObj.put("name", lbcvo.getName());
			jsObj.put("content", lbcvo.getContent());
			jsObj.put("regDate", lbcvo.getRegDate());
			
			jsonArr.put(jsObj);
		}
		
		return jsonArr.toString();
		
	}
	
	// 강의자료실 파일 다운로드
	@RequestMapping(value="/downloadLessonFile.univ")
	public void subject_downloadLessonFile(HttpServletRequest request, HttpServletResponse response) {
		
		String seq = request.getParameter("seq");
		String code = request.getParameter("code");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("code", code);
		paraMap.put("seq", seq);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null; 
		
		try {
			Integer.parseInt(seq);
			
			LessonBoardVO lbvo = service.getLessonBoardDetail(paraMap);
			
			if(lbvo == null || (lbvo != null && lbvo.getFileName() == null)) {
				out = response.getWriter();
				out.println("<script type='text/javascript'> alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일 다운로드가 불가합니다!!'); history.back(); </script>");
				return;
			}
			
			else {
				String fileName = lbvo.getFileName();
				String orgFilename = lbvo.getOrgFilename();
				
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/");
				String pathname = root + "resources" + File.separator + "files" + File.separator + fileName;
				
				
				if(orgFilename == null || "".equals(orgFilename)) {
					orgFilename = fileName;
				}
				
				orgFilename = new String(orgFilename.getBytes("UTF-8"),"8859_1"); 
				
				File file = new File(pathname);
				
				if(file.exists()) {
					
					response.setContentType("application/octet-stream");
					
					response.setHeader("Content-disposition",
                             "attachment; filename=" + orgFilename);
					
					byte[] readByte = new byte[4096];
					
					BufferedInputStream bfin = new BufferedInputStream(new FileInputStream(file));
					
					ServletOutputStream souts = response.getOutputStream();
					
					int length = 0;
					
					while( (length = bfin.read(readByte, 0, 4096)) != -1) {
						souts.write(readByte, 0, length);
					}
					souts.flush();
					souts.close();
					bfin.close();
				}
			}
			
		} catch (Exception e) {
			
		}
		
	}
	
	
	// 과제 게시판
	@RequestMapping(value="/homework.univ")
	public ModelAndView subject_homework(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("Sunghyun/homework.tiles2");
		return mav;
	}

	
}	
