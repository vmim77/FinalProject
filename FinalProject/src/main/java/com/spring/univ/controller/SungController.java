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

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// 대쉬보드 페이지
	@RequestMapping(value="/dashboard.univ")
	public String requiredLogin_dashboard(HttpServletRequest request, HttpServletResponse response) {
		
		return "Sunghyun/dashboard.tiles1";
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	// 과목메뉴 메인 페이지
	@RequestMapping(value="/subject.univ")
	public ModelAndView subject_subject(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("Sunghyun/subject.tiles2");
		return mav;
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// 강의자료실 페이지
	@RequestMapping(value="/lesson.univ")
	public ModelAndView subject_lesson(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		String code = (String) session.getAttribute("code"); // 해당 과목의 강의자료실 게시글을 가져오기 위한 과목코드
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
	    String searchType = request.getParameter("searchType");
	    String searchWord = request.getParameter("searchWord");
	    
	    if(searchType == null || (!"subject".equals(searchType) && !"content".equals(searchType)) ) {
		   searchType = "";
		}
		
		if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
		   searchWord = "";
		}
		
		mav.addObject("searchType", searchType);
		mav.addObject("searchWord", searchWord);
		
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("code", code);
		paraMap.put("currentShowPageNo", str_currentShowPageNo);
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		
	    int totalCount = 0;        
	    int sizePerPage = 5;      
	    int currentShowPageNo = 0; 
	    int totalPage = 0;         
	    
	    int startRno = 0;          
	    int endRno = 0; 
	    
	    totalCount = service.getTotalLessonPage(paraMap);
	    
	    totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
	    
	    if(str_currentShowPageNo == null) {
		       currentShowPageNo = 1;
		}
	    
		else {
		   try {
		      currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
		      if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
		         currentShowPageNo = 1;
		      }
		   } catch(NumberFormatException e) {
		      currentShowPageNo = 1;
		   }
		}
	    
	    startRno = ( (currentShowPageNo - 1) * sizePerPage ) + 1;
	    endRno = startRno + sizePerPage - 1;
	    
	    paraMap.put("startRno", String.valueOf(startRno));
	    paraMap.put("endRno", String.valueOf(endRno));
	    
	    if(!"".equals(searchType) && !"".equals(searchWord)) {
		       mav.addObject("paraMap", paraMap);
		}
	    
	    int blockSize = 10;
	    
	    int loop = 1;
	    
	    int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
	    
	    String pageBar = "<ul style='list-style: none; margin: auto; padding: 0 60px 0 0; width: 100%;'>";
	    String url = "lesson.univ";
	    
	    if(pageNo != 1) {
	         pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
	         pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
	      }
	      
	    while( !(loop > blockSize || pageNo > totalPage) ) {
	       
	       if(pageNo == currentShowPageNo) {
	          pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
	       }
	       else {
	          pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
	       }
	       
	       loop++;
	       pageNo++;
	       
	    }// end of while------------------------
	    
	    
	    if(pageNo <= totalPage) {
	       pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
	       pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
	    }
	    
	    pageBar += "</ul>";
	    
	    mav.addObject("pageBar", pageBar);
		
		if(code != null) {
			List<LessonBoardVO> boardList = service.getLessonBoard(paraMap);
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// 강의자료실 글쓰기 마무리 요청
	@RequestMapping(value="/lessonWriteEnd.univ", method= {RequestMethod.POST})
	public ModelAndView subject_lessonWriteEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, LessonBoardVO lbvo, MultipartHttpServletRequest mrequest) {
		
		MultipartFile attach = lbvo.getAttach();
		
		
		if(!attach.isEmpty()) {
			// 파일이 있는 게시글
			
			String path = mrequest.getSession().getServletContext().getRealPath("/");
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	// 강의자료실 & 과제 및 평가  스마트에디터 다중사진첨부
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
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
			jsObj.put("parentSeq", lbcvo.getParentSeq());
			
			jsonArr.put(jsObj);
		}
		
		return jsonArr.toString();
		
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// 강의자료실 게시글 파일 다운로드
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
				
				else {
					out = response.getWriter();
					out.println("<script type='text/javascript'> alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일 다운로드가 불가합니다!!'); history.back(); </script>");
					return;
				}
			}
			
		} catch (Exception e) {
			
		}
		
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// 강의자료실 게시글 삭제 폼 페이지 요청
	@RequestMapping(value="/lessonBoardDelete.univ")
	public ModelAndView subject_lessonBoardDelete(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String seq = request.getParameter("seq");
		String code = (String) session.getAttribute("code");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq);
		paraMap.put("code", code);
		
		LessonBoardVO lbvo = service.getLessonBoardDetail(paraMap);
		
		if(loginuser != null && !lbvo.getFk_hakbun().equals(loginuser.getHakbun())) { // 삭제하려는 사람과 글쓴이가 다른 경우이다. 
			
			mav.addObject("message", "작성자 본인만 삭제가 가능합니다.");
			mav.addObject("loc", request.getContextPath()+"/lesson.univ");
			
			mav.setViewName("msg");
		}
		else { // 작성자와 로그인 유저가 같은 경우 비밀번호 확인 페이지로 보낸다.
			mav.addObject("seq", seq);
			mav.addObject("lbvo",lbvo);
			mav.setViewName("Sunghyun/lessonBoardDeleteEnd.tiles2");
		}
		
		return mav;
	}
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// 강의자료실 게시글 삭제 마무리 요청
	@RequestMapping(value="/lessonBoardDeleteEnd.univ")
	public ModelAndView subject_lessonBoardDeleteEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String seq = request.getParameter("seq");
		String pw = request.getParameter("pw");
		
		HttpSession session = request.getSession();
		String code = (String) session.getAttribute("code");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq);
		paraMap.put("code", code);
		
		LessonBoardVO lbvo = service.getLessonBoardDetail(paraMap);
		
		if( lbvo!= null && ! lbvo.getPw().equals(pw) ) {
			
			mav.addObject("message", "글암호가 올바르지 않습니다!!");
			mav.addObject("loc", request.getContextPath()+"/lesson.univ");
			mav.setViewName("msg");
		}
		
		else {
			int n = service.deleteLessonBoard(seq);
			
			if(n==1) {
				mav.addObject("message", "글삭제 성공");
				mav.addObject("loc", request.getContextPath()+"/lesson.univ");
				mav.setViewName("msg");
			}
			
			else {
				mav.addObject("message", "글삭제 성공");
				mav.addObject("loc", request.getContextPath()+"/lesson.univ");
				mav.setViewName("msg");
			}
		}
		
		return mav;
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// 강의자료실 게시글 수정 폼 페이지 요청
	@RequestMapping(value="/editLessonBoard.univ")
	public ModelAndView subject_editLessonBoard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String seq = request.getParameter("seq");
		String code = (String) request.getSession().getAttribute("code");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq);
		paraMap.put("code", code);
		
		LessonBoardVO lbvo = service.getLessonBoardDetail(paraMap);
		
		mav.addObject("lbvo", lbvo);
		mav.setViewName("Sunghyun/lessonEdit.tiles2");
		
		return mav;
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// 강의자료실 게시글 수정 완료 요청
	@RequestMapping(value="/editEndLessonBoard.univ", method= {RequestMethod.POST})
	public ModelAndView subject_editEndLessonBoard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, LessonBoardVO lbvo, MultipartHttpServletRequest mrequest) {
		
		
		HttpSession session = request.getSession();
		String code = (String) session.getAttribute("code");
		
		MultipartFile attach = lbvo.getAttach();
		
		String content = lbvo.getContent();
		
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
		
		int n = service.editLessonBoard(lbvo);
		
		if(n==1) {
			mav.addObject("message", "강의자료실 글 수정 성공!!");
			mav.addObject("loc", request.getContextPath()+"/lessonDetail.univ?code="+code+"&seq="+lbvo.getSeq());
			mav.setViewName("msg");
		}
		else {
			mav.addObject("message", "강의자료실 글 수정 실패..");
			mav.addObject("loc", "redirect:/lesson.univ");
			mav.setViewName("msg");
		}
		
		return mav;
		
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// 강의자료실 댓글삭제
	@ResponseBody
	@RequestMapping(value="/deleteLessonComment.univ", method= {RequestMethod.POST} , produces="text/plain;charset=UTF-8")
	public String subject_deleteLessonComment(HttpServletRequest request, HttpServletResponse response, LessonBoardVO lbvo) {
		
		String seq = request.getParameter("seq");
		String parentSeq = request.getParameter("parentSeq");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq);
		paraMap.put("parentSeq", parentSeq);
		
		int n = service.deleteLessonComment(paraMap);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
		
		return jsObj.toString();
	}
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 메신저
	@RequestMapping(value="/messenger.univ")
	public String requiredLogin_multichat(HttpServletRequest request, HttpServletResponse response) {
		return "Sunghyun/multichat";
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	
	// 과제 및 평가 게시판 글 목록
	@RequestMapping(value="/homework.univ")
	public ModelAndView subject_homework(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		String code = (String) session.getAttribute("code");
		
		List<HomeworkVO> homeworkList = service.getHomeworkList(code);
		
		mav.addObject("homeworkList", homeworkList);
		mav.setViewName("Sunghyun/homework.tiles2");
		return mav;
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 과제 및 평가 게시판 댓글가져오기
	@ResponseBody
	@RequestMapping(value="/getHomeworkComment.univ", produces="text/plain;charset=UTF-8")
	public String subject_getHomeworkComment(HttpServletRequest request, HttpServletResponse response) {
		
		String code = request.getParameter("code");
		
		
		List<HomeWorkCommentVO> homeworkCommentList = service.getHomeworkComment(code);
		
		
		JSONArray jsonArr = new JSONArray();
		
		for(HomeWorkCommentVO hwcvo : homeworkCommentList) {
			
			JSONObject jsObj = new JSONObject();
			jsObj.put("seq", hwcvo.getSeq());
			jsObj.put("parentSeq", hwcvo.getParentSeq());
			jsObj.put("fk_hakbun", hwcvo.getFk_hakbun());
			jsObj.put("name", hwcvo.getName());
			jsObj.put("regDate", hwcvo.getRegDate());
			jsObj.put("content", hwcvo.getContent());
			jsObj.put("fileName", hwcvo.getFileName());
			jsObj.put("orgFilename", hwcvo.getOrgFilename());
			jsObj.put("fileSize", hwcvo.getFileSize());
			jsObj.put("commentCount", hwcvo.getCommentCount());
			
			jsonArr.put(jsObj);
		}
		
		return jsonArr.toString();
	}
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// 과제 및 평가 게시판 댓글작성
	@ResponseBody
	@RequestMapping(value="/writeHomeworkComment.univ", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String writeHomeworkComment(MultipartHttpServletRequest mrequest, HttpServletResponse response, HomeWorkCommentVO hwcvo) {
		
		String content = hwcvo.getContent();
		
		content.replaceAll("<", "&lt;");
		content.replaceAll(">", "&gt;");
		
		hwcvo.setContent(content);
		
		MultipartFile attach = hwcvo.getAttach();
		
		if( !attach.isEmpty() ) {
			
			try {
			String path = mrequest.getSession().getServletContext().getRealPath("/");
			String root = path + "resources" + File.separator + "files"; 
			
			byte[] bytes = attach.getBytes(); // 실제 파일내용물
			
			String newFilename = "";
			String fileExt = attach.getOriginalFilename().substring(attach.getOriginalFilename().lastIndexOf(".")); 
			
			newFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
			newFilename += System.nanoTime();
			newFilename += fileExt;
			
			hwcvo.setFileName(newFilename); // WAS DISK에 저장될 파일명
			hwcvo.setOrgFilename(attach.getOriginalFilename()); 	// 실제 파일명
			hwcvo.setFileSize(String.valueOf(attach.getSize())); // 파일사이즈
			
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
		
		int n = service.writeHomeworkComment(hwcvo);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		
		return jsonObj.toString();
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// 과제 및 평가 게시판 글쓰기 폼 페이지 요청하기
	@RequestMapping(value="/homeworkWrite.univ")
	public ModelAndView subject_homeworkWrite(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String login_hakbun = loginuser.getHakbun();
		
		Map<String, String> subjectMap = (Map<String, String>) request.getAttribute("subjectMap");
		String subject_hakbun = subjectMap.get("fk_hakbun");
		
		if(login_hakbun != null && !subject_hakbun.equals(login_hakbun)) {
			
			mav.addObject("message", "해당과목의 교수님만 접근이 가능합니다!");
			mav.addObject("loc", request.getContextPath()+"/homework.univ");
			mav.setViewName("msg");
			return mav;
		}
		
		mav.setViewName("Sunghyun/homeworkWrite.tiles2");
		
		return mav;
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// 과제 및 평가 게시판 글쓰기 완료 요청하기
	@RequestMapping(value="/homeworkWriteEnd.univ", method= {RequestMethod.POST})
	public ModelAndView subject_homeworkWriteEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, HomeworkVO hwvo, MultipartHttpServletRequest mrequest) {
		
		
		MultipartFile attach = hwvo.getAttach();
		
		
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
				
				hwvo.setFileName(newFilename); // WAS DISK에 저장될 파일명
				hwvo.setOrgFilename(attach.getOriginalFilename()); 	// 실제 파일명
				hwvo.setFileSize(String.valueOf(attach.getSize())); // 파일사이즈
				
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
			hwvo.setFileName("");
		}
		
		int n = service.homeworkWriteEnd(hwvo);
		
		if(n==1) {
			String message = "과제 및 평가 게시판 글쓰기 성공";
			String loc = request.getContextPath()+"/homework.univ";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
			
		}
		else {
			String message = "과제 및 평가 게시판 글쓰기 실패";
			String loc = request.getContextPath()+"/homework.univ";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
		}
		
		return mav;
	}
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// 과제 및 평가 게시판 게시글 파일 다운로드 요청
	@RequestMapping(value="/homeworkFileDownload.univ")
	public void subject_homeworkFileDownload(HttpServletRequest request, HttpServletResponse response) {
		
		String seq = request.getParameter("seq");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null; 
		
		try {
			Integer.parseInt(seq);
			
			HomeworkVO hwvo = service.getHomeworkDetail(seq);
			
			if(hwvo == null || (hwvo != null && hwvo.getFileName() == null)) {
				out = response.getWriter();
				out.println("<script type='text/javascript'> alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일 다운로드가 불가합니다!!'); history.back(); </script>");
				return;
			}
			
			else {
				String fileName = hwvo.getFileName();
				String orgFilename = hwvo.getOrgFilename();
				
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
				
				else {
					out = response.getWriter();
					out.println("<script type='text/javascript'> alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일 다운로드가 불가합니다!!'); history.back(); </script>");
					return;
				}
			}
			
		} catch (Exception e) {
			
		}
		
	}
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// 과제 및 평가게시판 댓글 파일 다운로드
	@RequestMapping(value="/homeworkCommentFileDownload.univ")
	public void subject_homeworkCommentFileDownload(HttpServletRequest request, HttpServletResponse response) {
		
		String seq = request.getParameter("seq");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null; 
		
		try {
			Integer.parseInt(seq);
			
			HomeWorkCommentVO hwcvo = service.getHomeworkCommentDetail(seq);
			
			if(hwcvo == null || (hwcvo != null && hwcvo.getFileName() == null)) {
				out = response.getWriter();
				out.println("<script type='text/javascript'> alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일 다운로드가 불가합니다!!'); history.back(); </script>");
				return;
			}
			
			else {
				String fileName = hwcvo.getFileName();
				String orgFilename = hwcvo.getOrgFilename();
				
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
				
				else {
					out = response.getWriter();
					out.println("<script type='text/javascript'> alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일 다운로드가 불가합니다!!'); history.back(); </script>");
					return;
				}
			}
			
		} catch (Exception e) {
			
		}
		
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// 과제 및 평가 게시판 댓글 삭제 요청
	@ResponseBody
	@RequestMapping(value="/deleteHomeworkComment.univ", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String subject_deleteHomeworkComment(HttpServletRequest request, HttpServletResponse response) {
		
		String seq = request.getParameter("seq");
		String parentSeq = request.getParameter("parentSeq");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq);
		paraMap.put("parentSeq", parentSeq);
		
		int n = service.deleteHomeworkCommentDelete(paraMap);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
		
		
		return jsObj.toString();
	}
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// 과제 및 평가 게시판 게시글 삭제 요청
	@ResponseBody
	@RequestMapping(value="/deleteHomework.univ", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String subject_deleteHomework(HttpServletRequest request, HttpServletResponse response) {
		
		String seq = request.getParameter("seq");
		
		int n = service.deleteHomework(seq);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
		
		return jsObj.toString();
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// 과제 및 평가 게시판 게시글 수정 폼 페이지 요청
	@RequestMapping(value="/editHomework.univ")
	public ModelAndView subject_editHomework(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String seq = request.getParameter("seq");
		
		HomeworkVO hwvo = service.getHomeworkDetail(seq);
		
		if(hwvo != null) {
			
			mav.addObject("hwvo", hwvo);
			mav.setViewName("Sunghyun/homeworkEdit.tiles2");
		}
		else {
			mav.addObject("message", "해당 글번호의 게시글은 없습니다.");
			mav.addObject("loc", request.getContextPath()+"/homework.univ");
			
			mav.setViewName("msg");
		}
		
		return mav;
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// 과제 및 평가 게시판 게시글 수정 완료 요청
	@RequestMapping(value="/editEndHomework.univ", method= {RequestMethod.POST})
	public ModelAndView subject_editEndHomework(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, HomeworkVO hwvo, MultipartHttpServletRequest mrequest) {
		
		
		
		MultipartFile attach = hwvo.getAttach();
		
		if(!attach.isEmpty()) { // 파일을 첨부한 경우
			
			String path = mrequest.getSession().getServletContext().getRealPath("/");
			String root = path + "resources" + File.separator + "files"; 
			
			try {
				
				byte[] bytes = attach.getBytes(); // 실제 파일내용물
				
				String newFilename = "";
				String fileExt = attach.getOriginalFilename().substring(attach.getOriginalFilename().lastIndexOf(".")); 
				
				newFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
				newFilename += System.nanoTime();
				newFilename += fileExt;
				
				hwvo.setFileName(newFilename); // WAS DISK에 저장될 파일명
				hwvo.setOrgFilename(attach.getOriginalFilename()); 	// 실제 파일명
				hwvo.setFileSize(String.valueOf(attach.getSize())); // 파일사이즈
				
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
			
			hwvo.setFileName("");
		}
		
		int n = service.homeworkEditEnd(hwvo);
		
		String message = "";
		String loc = "";
		
		if(n==1) {
			message = "과제 및 평가 게시판 수정 성공";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
			
		}
		else {
			message = "과제 및 평가 게시판 수정 실패";
		}
		
		loc = mrequest.getContextPath()+"/homework.univ";
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		mav.setViewName("msg");
		
		return mav;
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	// 과제 및 평가 - 평가 페이지 요청
	@RequestMapping(value="/homeworkEvaluation.univ")
	public ModelAndView subject_homeworkEvaluation(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		String code = (String) session.getAttribute("code");
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser.getAuthority() != 1) {
			mav.addObject("message", "잘못된 접근입니다.");
			mav.addObject("loc", request.getContextPath()+"/dashboard.univ");
			mav.setViewName("msg");
		}
		
		else {
			// 해당과목의 평가목록을 요청한다.
			List<Map<String, String>> evalList = service.getEvaluation(code);
			
			// 과제 및 평가 댓글목록 가져오기
			List<HomeWorkCommentVO> homeworkCommentList = service.getHomeworkComment(code);
			
			mav.addObject("evalList", evalList);
			mav.addObject("homeworkCommentList", homeworkCommentList);
			mav.setViewName("Sunghyun/homeworkEvaluation.tiles2");
		}
		
		return mav;
	}
	
	
	// 과제 및 평가 - 평가 페이지 엑셀 다운로드 요청
	
	@RequestMapping(value="/downloadExcel.univ")
	public String downloadExcel(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		HttpSession session = request.getSession();
		String code = (String) session.getAttribute("code");
		
		// 엑셀용 데이터 조회
		List<Map<String, String>> evalExcelList = service.getEvaluationExcel(code);
		
		SXSSFWorkbook workbook = new SXSSFWorkbook();
		
		SXSSFSheet sheet = workbook.createSheet("수강학생 과제분석");
		
		sheet.setColumnWidth(0, 4000);
		sheet.setColumnWidth(1, 2000);
		sheet.setColumnWidth(2, 4000);
		sheet.setColumnWidth(3, 3000);
		sheet.setColumnWidth(4, 4000);
		sheet.setColumnWidth(5, 4000);
		sheet.setColumnWidth(6, 4000);
		sheet.setColumnWidth(7, 4000);
		
		int rowLocation = 0;
		
		CellStyle mergeRowStyle = workbook.createCellStyle();
	    mergeRowStyle.setAlignment(HorizontalAlignment.CENTER);
	    mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER);
	    
	    CellStyle headerStyle = workbook.createCellStyle();
	    headerStyle.setAlignment(HorizontalAlignment.CENTER);
	    headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
	    
	    mergeRowStyle.setFillForegroundColor(IndexedColors.GOLD.getIndex());
	    mergeRowStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
	    
	    Font mergeRowFont =  workbook.createFont(); 
	    mergeRowFont.setFontName("나눔고딕");
	    mergeRowFont.setFontHeight((short)500); 
	    mergeRowFont.setColor(IndexedColors.WHITE.getIndex());
	    mergeRowFont.setBold(true);
	    
	    mergeRowStyle.setFont(mergeRowFont);
	    
	    headerStyle.setBorderTop(BorderStyle.THICK);
	    headerStyle.setBorderBottom(BorderStyle.THICK);
	    headerStyle.setBorderLeft(BorderStyle.THIN);
	    headerStyle.setBorderRight(BorderStyle.THIN);
	    
	    SXSSFRow mergeRow = sheet.createRow(rowLocation);
	    
	    for(int i=0; i<8; i++) {
	    	
	    	Cell cell = mergeRow.createCell(i);
	    	cell.setCellStyle(mergeRowStyle);
	    	cell.setCellValue(evalExcelList.get(0).get("subject")+"_수강학생 과제분석");
	    }// end of for-----------------------
	    
	    sheet.addMergedRegion(new CellRangeAddress(rowLocation, rowLocation, 0, 7));
		
	    Row headerRow = sheet.createRow(++rowLocation);
	    
        Cell headerCell = headerRow.createCell(0); 
        headerCell.setCellValue("과목명");
        headerCell.setCellStyle(headerStyle);
        
        headerCell = headerRow.createCell(1); 
        headerCell.setCellValue("과목번호");
        headerCell.setCellStyle(headerStyle);
        
        headerCell = headerRow.createCell(2); 
        headerCell.setCellValue("학번");
        headerCell.setCellStyle(headerStyle);
        
        headerCell = headerRow.createCell(3); 
        headerCell.setCellValue("성명");
        headerCell.setCellStyle(headerStyle);
        
        headerCell = headerRow.createCell(4); 
        headerCell.setCellValue("소속학과");
        headerCell.setCellStyle(headerStyle);
        
        headerCell = headerRow.createCell(5); 
        headerCell.setCellValue("과제 제출건수");
        headerCell.setCellStyle(headerStyle);
        
        headerCell = headerRow.createCell(6); 
        headerCell.setCellValue("전체 과제수");
        headerCell.setCellStyle(headerStyle);
        
        headerCell = headerRow.createCell(7); 
        headerCell.setCellValue("과제 제출률");
        headerCell.setCellStyle(headerStyle);
        
        Row bodyRow = null;
        Cell bodyCell = null;
        
        for(int i=0; i<evalExcelList.size(); i++) {
        	
        	Map<String, String> map = evalExcelList.get(i);
        	
        	// 행생성
        	bodyRow = sheet.createRow(i + (rowLocation+1) ); 
        	
        	bodyCell = bodyRow.createCell(0);
        	bodyCell.setCellValue(map.get("subject"));
        	
        	bodyCell = bodyRow.createCell(1);
        	bodyCell.setCellValue(map.get("code"));
        	
        	bodyCell = bodyRow.createCell(2);
        	bodyCell.setCellValue(map.get("hakbun"));
        	
        	bodyCell = bodyRow.createCell(3);
        	bodyCell.setCellValue(map.get("name"));
        	
        	bodyCell = bodyRow.createCell(4);
        	bodyCell.setCellValue(map.get("deptname"));
        	
        	bodyCell = bodyRow.createCell(5);
        	bodyCell.setCellValue(Integer.parseInt(map.get("StudentCnt")));
        	
        	bodyCell = bodyRow.createCell(6);
        	bodyCell.setCellValue(Integer.parseInt(map.get("totalCnt")));
        	
        	bodyCell = bodyRow.createCell(7);
        	bodyCell.setCellValue(map.get("percentage"));
        	
        }// end of for--------------------------
        
        model.addAttribute("locale", Locale.KOREA); 
        model.addAttribute("workbook", workbook); 
        model.addAttribute("workbookName", evalExcelList.get(0).get("subject")+"_수강학생_과제분석");
        
        return "excelDownloadView";
		
	}
	
	@ResponseBody
	@RequestMapping(value="/academicCalendar.univ", produces="text/plain;charset=UTF-8")
	public String academicCalendar(HttpServletRequest request, HttpServletResponse response) {
		
		List<Map<String,String>> calendarList = service.getAcademicCalendar();
		
		JSONArray jsArr = new JSONArray();
		
		for(Map<String, String> map : calendarList) {
			
			JSONObject jsObj = new JSONObject();
			jsObj.put("title", map.get("title"));
			jsObj.put("start", map.get("startday"));
			
			if(map.get("endday") != null) {
				jsObj.put("end", map.get("endday"));
			}
			
			jsObj.put("allDay", true);
			
			jsArr.put(jsObj);
			
		}// end of for------------------------------
		
		return jsArr.toString();
	}
	
	
}
	
	
