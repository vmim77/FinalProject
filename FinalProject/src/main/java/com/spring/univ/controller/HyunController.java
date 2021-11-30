package com.spring.univ.controller;

import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.*;

import javax.annotation.Resource;
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
import com.spring.univ.common.MyUtil;
import com.spring.univ.model.*;
import com.spring.univ.service.InterHyunService;

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
public class HyunController {

	@Autowired
	private InterHyunService service;

	@Autowired
	private FileManager fileManager;
	
	
// =========================================================================================================================
// =============== ********  QnA(문의게시판)  ******** =============== //
	// QnA(문의게시판) 글쓰기
	@RequestMapping(value="/QnAAdd.univ")
	public ModelAndView requiredLogin_QnAAdd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, QnAVO QnAvo) {

		getCurrentURL(request);

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		String fk_hakbun = loginuser.getHakbun();
		String name = loginuser.getName();
		String fk_code = (String) session.getAttribute("code");

		QnAvo.setFk_hakbun(fk_hakbun);
		QnAvo.setName(name);
		QnAvo.setFk_code(fk_code);

		session.setAttribute("fk_hakbun", fk_hakbun);
		session.setAttribute("name", name);
		session.setAttribute("fk_code", fk_code);

		// 답변글쓰기가 추가된 경우 시작 //
		String fk_seq = request.getParameter("fk_seq");
		String groupno = request.getParameter("groupno");
		String depthno = request.getParameter("depthno");
		String subject = request.getParameter("subject");
		
		QnAvo.setGroupno(groupno);

		if (fk_seq == null) {
			fk_seq = "";
		}

		mav.addObject("fk_seq", fk_seq);
		mav.addObject("groupno", groupno);
		mav.addObject("depthno", depthno);
		mav.addObject("subject", subject);

		// 답변글쓰기가 추가된 경우 끝 //

		mav.setViewName("QnA/QnAAdd.tiles2");
		// WEB-INF/views/tiles2/QnA/QnAAdd.jsp 파일 생성

		return mav;

	}
	
	
	// QnA(문의게시판) 글쓰기 완료
	@RequestMapping(value="/QnAAddEnd.univ", method={RequestMethod.POST})
	public ModelAndView QnAAddEnd(Map<String, String> paraMap, ModelAndView mav, QnAVO QnAvo) {
		
		// 파일첨부가 없는 글쓰기
		service.QnAAdd(QnAvo);
		
		mav.setViewName("redirect:/QnA.univ");
		
		return mav;
		
	}
	
	
	// 글 목록 보기
	@RequestMapping(value="/QnA.univ")
	public ModelAndView subject_QnA(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		List<QnAVO> QnAList = null;

		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");

		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		String fk_code = (String) session.getAttribute("code");// 추가

		if (searchType == null || (!"subject".equals(searchType) && !"name".equals(searchType))) {
			searchType = "";
		}
		if (searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty()) {
			searchWord = "";
		}

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("fk_code", fk_code); // 추가 완료 //**파라맵에 code넣고 글목록조회boardListSearchWithPaging 쿼리문에 where에 code넣기**

		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물건수(totalCount) 는 검색조건이 있을 때와 없을 떄로 나뉘어진다

		int totalCount = 0;			// 총 게시물 건수
		int sizePerPage = 10;		// 한 페이지당 보여줄 게시물 건수
		int currentShowPageNo = 0;	// 현재 보여주는 페이지 번호로서, 초기치는 1페이지로 설정함
		int totalPage = 0;			// 총 페이지수(뤱브라우저상에서 보여줄 총 페이지 갯수)
		
		int startRno = 0;			// 시작 행번호
		int endRno = 0;				// 끝 행번호

		// 총 게시물 건수 구하기
		totalCount = service.getQnATotalCount(paraMap);
		totalPage = (int) Math.ceil((double) totalCount / sizePerPage);

		if (str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		} else {
			// get 방식으로 들어올 때 번호를 치고 들어오는 것이 아닌 문자로 치고 들어올때 에러 방지
			try {

				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				// 보여지는 페이지가 0페이지 이거나 정해진 페이지 수 이상 입력해서 들어올 때
				if (currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}

			} catch (NumberFormatException e) {
				currentShowPageNo = 1;
			} // end of try----------------------------------------------------

		} // end of if(str_currentShowPageNo == null) {------------------------

		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1;

		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));

		// 페이징 처리한 글 목록 가져오기(검색의 유무와 상관 없이 모두 호환 가능하다)
		QnAList = service.QnASearchWithPaging(paraMap);

		// 아래는 검색대상 컬럼과 검색어를 유지시키기 위한 것
		if (!"".equals(searchType) && !"".equals(searchWord)) {
			mav.addObject(paraMap);
		}

		int blockSize = 10;

		// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
		int loop = 1;
		int pageNo = ((currentShowPageNo - 1) / blockSize) * blockSize + 1; // 페이지 번호 공식!

		String pageBar = "<ul style='list-style:none;'>";
		String url = "QnA.univ";

		////////////////////////////////////////////////////////////////////////////////////////////

		// === [맨처음][이전] 만들기 === // //페이징처리 url에 과목코드 추가 완료
		if (pageNo != 1) {

			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='" + url + "?code=" + fk_code + "&searchType=" + searchType + "&searchWord=" + searchWord + "&currentShowPageNo=1'> « </a></li>";
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='" + url + "?code=" + fk_code + "&searchType=" + searchType + "&searchWord=" + searchWord + "&currentShowPageNo=" + (pageNo-1) + "'> ‹ </a></li>";

		} // end of if(pageNo != 1) {----------------------------------------

		////////////////////////////////////////////////////////////////////////////////////////////

		while (!(loop > blockSize || pageNo > totalPage)) {

			// 내가 보고자 하는 페이지가 현제 페이지라면
			// ex) 현재 5페이지 인데 5페이지를 보고싶다면
			if (pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; color:red; padding:2px 4px;'>" + pageNo + "</li>";
			} else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='" + url + "?code=" + fk_code + "&searchType=" + searchType + "&searchWord=" + searchWord + "&currentShowPageNo=" + pageNo + "'>" + pageNo + "</a></li>";

			}

			loop++;
			pageNo++;

		} // end of while(!(loop > blockSize || pageNo > totalPage)) {------

		////////////////////////////////////////////////////////////////////////////////////////////

		// === [다음][마지막] 만들기 === //
		if (pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='" + url + "?code=" + fk_code + "&searchType=" + searchType + "&searchWord=" + searchWord + "&currentShowPageNo=" + pageNo + "'> › </a></li>";
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='" + url + "?code=" + fk_code + "&searchType=" + searchType + "&searchWord=" + searchWord + "&currentShowPageNo="+ totalPage + "'> » </a></li>";

		} // end of if(pageNo != 1) {----------------------------------------

		////////////////////////////////////////////////////////////////////////////////////////////

		pageBar += "</ul>";

		mav.addObject("pageBar", pageBar);

		String gobackURL = MyUtil.getCurrentURL(request);

		mav.addObject("gobackURL", gobackURL);
		mav.addObject("QnAList", QnAList);
		mav.setViewName("QnA/QnA.tiles2");
		// WEB-INF/views/tiles2/QnA/QnA.jsp 파일 생성

		return mav;
	}
	
	
	// 글 1개 조회
	@RequestMapping(value="/QnAView.univ", method={RequestMethod.GET})
	public ModelAndView subject_QnAView(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();// 추가
		String fk_code = (String) session.getAttribute("code");// 추가

		// 조회하고자 하는 글번호 받아오기
		String seq = request.getParameter("seq");

		// 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것이다.
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");

		if (searchType == null) {
			searchType = "";
		}

		if (searchWord == null) {
			searchWord = "";
		}

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq);
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("fk_code", fk_code); // 추가

		mav.addObject("searchType", searchType);
		mav.addObject("searchWord", searchWord);
		mav.addObject("fk_code", fk_code); // 추가
		////////////////////////////////////////////////////////////////////////////////////////

		// === #125. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후 === //
		// 사용자가 목록보기 버튼을 클릭했을 떄 돌아갈 페이지를 알려주기위해
		// 현재 페이지 주소를 뷰단에 넘겨준다

		String gobackURL = request.getParameter("gobackURL");

		// 추가
		if (gobackURL != null && gobackURL.contains(" ")) {
			gobackURL = gobackURL.replaceAll(" ", "&");
			// 이전글제목, 다음글제목을 클릭했을때 돌아갈 페이지 주소를 올바르게 만들어주기 위해서 한 것임.
//				System.out.println("~~~~ 확인용 gobackURL =>" + gobackURL);
			// ~~~~ 확인용 gobackURL
			// =>/list.action?searchType=subject&searchWord=%EC%9E%85%EB%8B%88%EB%8B%A4&currentShowPageNo=15
			// //입니다로 글제목 검색후 15페이지에 있는 55번 김유신 클릭 했을때 콘솔에 찍힘

		}

		mav.addObject("gobackURL", gobackURL);

		////////////////////////////////////////////////////////////////////////////////////////

		try {
			Integer.parseInt(seq); // 글번호 형 변환하기

			// 현재 로그인 되어 있는 사용자의 정보 가져오기 - 조회수를 위해서
			// 학번추가하면서 임시로 주석처리 HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

			String login_hakbun = null;

			// 로그인 되어져 있다면
			if (loginuser != null) {
				login_hakbun = loginuser.getHakbun();
			}

			QnAVO QnAvo = null;

			// 위의 글목록보기 #69. 에서 session.setAttribute("readCountPermission", "yes"); 해두었다.
			if ("yes".equals(session.getAttribute("readCountPermission"))) {
				// 글 목록보기를 클릭한 다음에 특정글을 조회해온 경우이다

				// 글 조회수 증가와 함께 글 1개를 조회 해주는 함수
				QnAvo = service.getQnAView(paraMap, login_hakbun);

				session.removeAttribute("readCountPermission");
				// 중요함!! session 에 저장된 readCountPermission 을 삭제한다.
			} else {
				// 웹브라우저에서 새로고침(F5)을 클릭한 경우이다
				QnAvo = service.getQnAWithNoAddCount(paraMap);
			}

			// view 페이지에 보여주기 위해 request 영역에 담음
			mav.addObject("QnAvo", QnAvo);

		} catch (NumberFormatException e) {
			e.printStackTrace();
		}

		mav.setViewName("QnA/QnAView.tiles2");
		// WEB-INF/views/tiles2/QnA/QnAView.jsp 파일 생성

		return mav;
	}
	

	// 글 수정하기
	@RequestMapping(value="/QnAEdit.univ", method={RequestMethod.GET})
	public ModelAndView requiredlogin_QnAEdit(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {

		// 글 수정해야 할 글번호 가져오기
		String seq = request.getParameter("seq");
		String fk_code = request.getParameter("fk_code");

		// 글 수정해야할 글1개 내용 가져오기
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq);
		paraMap.put("fk_code", fk_code); 

		paraMap.put("searchType", "");
		paraMap.put("searchWord", "");

		QnAVO QnAvo = service.getQnAWithNoAddCount(paraMap);

		try {
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

			// 글 작성자와 로그인한 유저와 같지 않으면
			if (!loginuser.getHakbun().equals(QnAvo.getFk_hakbun())) {

				String message = "다른 사용자의 글은 수정이 불가합니다.";
				String loc = "javascript:history.back()";

				mav.addObject("message", message);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
			}
			// 자신의 글을 수정할 경우
			else {
				mav.addObject("QnAvo", QnAvo);
				mav.setViewName("QnA/QnAEdit.tiles2");
				// WEB-INF/views/tiles2/QnA/QnAEdit.jsp 파일 생성
			}

		} catch (NullPointerException e) {
			String message = "로그인 후 이용가능한 서비스입니다.";
			String loc = request.getContextPath() + "/MemberLogin.univ";

			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
		}

		return mav;

	}
	
	
	// 글 수정 완료하기
	@RequestMapping(value="/QnAEditEnd.univ", method={RequestMethod.POST})
	public ModelAndView QnAEditEnd(ModelAndView mav, QnAVO QnAvo, HttpServletRequest request) {

		// 글 수정을 하려면 원본글에 입력했던 암호와 같아야 글 수정이 가능하도록 하게한다.
		int n = service.QnAEdit(QnAvo);
		// n이 1이라면 정상적으로 변경됨

		if (n == 1) {
			mav.addObject("message", "글 수정 성공!!");
		}

		mav.addObject("loc", request.getContextPath() + "/QnAView.univ?seq=" + QnAvo.getSeq());

		mav.setViewName("msg");

		return mav;

	}
	
	
	// 글 삭제하기
	@RequestMapping(value="/QnADel.univ")
	public ModelAndView QnADel(ModelAndView mav, HttpServletRequest request) {

		// 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성
		getCurrentURL(request);

		// 삭제해야 할 글번호 가져오기
		String seq = request.getParameter("seq");
		String fk_code = request.getParameter("fk_code");
		
		// 글 삭제해야할 글1개 내용 가져오기
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq);
		paraMap.put("fk_code", fk_code);// 추가

		paraMap.put("searchType", "");// 추가
		paraMap.put("searchWord", "");// 추가

		QnAVO QnAvo = service.getQnAWithNoAddCount(paraMap);

		try {
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

			// 글 작성자와 로그인한 유저와 같지 않으면
			if (!loginuser.getHakbun().equals(QnAvo.getFk_hakbun())) {

				String message = "다른 사용자의 삭제는 불가합니다.";
				String loc = "javascript:history.back()";

				mav.addObject("message", message);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
			}
			// 자신의 글을 삭제할 경우
			else {
				mav.addObject("QnAvo", QnAvo);
				mav.setViewName("QnA/QnADel.tiles2");
				// WEB-INF/views/tiles2/QnA/QnADel.jsp 파일 생성
			}

		} catch (NullPointerException e) {
			String message = "로그인 후 이용가능한 서비스입니다.";
			String loc = request.getContextPath() + "/MemberLogin.univ";

			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
		}

		return mav;

	}
	
	
	// 글 삭제 완료하기
	@RequestMapping(value="/QnADelEnd.univ", method={RequestMethod.POST})
	public ModelAndView QnADelEnd(ModelAndView mav, QnAVO QnAvo, HttpServletRequest request) {

		// 글 수정을 하려면 원본글에 입력했던 암호와 같아야 글 수정이 가능하도록 하게한다.
		int n = service.QnADel(QnAvo);
		// n이 1이라면 정상적으로 변경됨
		// n이 0이라면 글수정에 필요한 글암호가 틀린경우

		if (n == 0) {
			mav.addObject("message", "암호가 일치하지 않아 글 삭제가 불가합니다.");
		} else {
			mav.addObject("message", "글 삭제 성공!!");
		}

		mav.addObject("loc", request.getContextPath() + "/QnA.univ");

		mav.setViewName("msg");

		return mav;

	}
	
	
	// 검색어 입력시 자동글 완성하기
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/QnAWordSearchShow.univ", method={RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String QnAWordSearchShow(HttpServletRequest request) {

		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String fk_code = request.getParameter("fk_code");

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("fk_code", fk_code);

		List<String> wordList = service.QnAWordSearchShow(paraMap);

		JSONArray jsonarr = new JSONArray();

		if (wordList != null) {

			for (String word : wordList) {

				JSONObject jsonobj = new JSONObject();

				jsonobj.put("word", word);

				jsonarr.put(jsonobj);
			}
		}

		return jsonarr.toString();

	}
	
	
// =============== ********  QnA(문의게시판) 끝  ******** =============== //
// =========================================================================================================================

	
	
	
	
	
	
	
// =========================================================================================================================
// =============== ********  Notice(공지사항)  ******** =============== //
	// 공지사항 글쓰기 (교수(authority = 1)만 작성할 수 있음)
	@RequestMapping(value="/noticeAdd.univ")
	public ModelAndView requiredLogin_noticeAdd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		getCurrentURL(request);
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String fk_hakbun = loginuser.getHakbun();
		String fk_code = (String) session.getAttribute("code");
		String name = loginuser.getName();
		
		session.setAttribute("fk_hakbun", fk_hakbun);
		session.setAttribute("fk_code", fk_code);
		session.setAttribute("name", name);

		mav.setViewName("notice/noticeAdd.tiles2");
		
		return mav;
	
	}
	
	// 게시판 글쓰기 완료 요청  //
	@RequestMapping(value="/noticeAddEnd.univ", method={RequestMethod.POST})			
	public ModelAndView noticeAddEnd(Map<String,String> paraMap, ModelAndView mav, NoticeVO noticevo) {	
		
		// 파일첨부가 없는 글쓰기
		service.noticeAdd(noticevo); 
		
		mav.setViewName("redirect:/notice.univ");

		return mav;
		
	}
	
	// 글 목록 보기
	@RequestMapping(value="/notice.univ")
	public ModelAndView subject_notice(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
			
		List<NoticeVO> noticeList = null;
		
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		String fk_code = (String) session.getAttribute("code");
		
		
		if(searchType == null || (!"subject".equals(searchType) && !"name".equals(searchType))) {
			searchType = "";
		}
		if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("fk_code", fk_code); //추가 완료 //**파라맵에 code넣고 글목록조회boardListSearchWithPaging 쿼리문에 where에 code넣기**
		
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물건수(totalCount) 는 검색조건이 있을 때와 없을 떄로 나뉘어진다
		
		int totalCount = 0;        // 1. 총 게시물 건수
		int sizePerPage = 10;      // 2. 한 페이지당 보여줄 게시물 건수
		int currentShowPageNo = 0; // 3. 현재 보여주는 페이지 번호로서, 초기치는 1페이지로 설정함
		int totalPage = 0;         // 4. 총 페이지수(뤱브라우저상에서 보여줄 총 페이지 갯수)
		int startRno = 0;          // 5. 시작 행번호
		int endRno = 0;            // 6. 끝 행번호
		
		
		// 1. 총 게시물 건수
	    totalCount = service.getNoticeTotalCount(paraMap);
		
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
		
		if(str_currentShowPageNo == null) {

			currentShowPageNo = 1;
		}
		else {
			// get방식으로 들어올 때 번호를 치고 들어오는 것이 아닌 문자로 치고 들어올때 에러 방지
			try {
				
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				// 보여지는 페이지가 0페이지 이거나 정해진 페이지 수 이상 입력해서 들어올 때
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
				
			} catch(NumberFormatException e) {
				currentShowPageNo = 1;
			}//end of try----------------------------------------------------
			
		}//end of if(str_currentShowPageNo == null) {------------------------
		
		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1;
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		// 페이징 처리한 글 목록 가져오기(검색의 유무와 상관 없이 모두 호환 가능하다)
		noticeList = service.noticeListSearchWithPaging(paraMap);

		
		// 아래는 검색대상 컬럼과 검색어를 유지시키기 위한 것
		if(!"".equals(searchType) && !"".equals(searchWord)) {
			mav.addObject(paraMap);
		}
		
		int blockSize = 10;
		
        // loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
		int loop = 1;
		int pageNo = ((currentShowPageNo - 1) / blockSize) * blockSize + 1;
		
		String pageBar = "<ul style='list-style:none;'>";
		String url = "notice.univ";
		
		////////////////////////////////////////////////////////////////////////////////////////////
		
		// === [맨처음][이전] 만들기 === // //페이징처리 url에 과목코드 추가 완료
		if(pageNo != 1) {
			
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?code="+fk_code+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'> « </a></li>";
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?code="+fk_code+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'> ‹ </a></li>";
			
		}//end of if(pageNo != 1) {----------------------------------------
		
		////////////////////////////////////////////////////////////////////////////////////////////
		
		while(!(loop > blockSize || pageNo > totalPage)) {
			
			// 내가 보고자 하는 페이지가 현제 페이지라면
			// ex) 현재 5페이지 인데 5페이지를 보고싶다면
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; color:red; padding:2px 4px;'>"+pageNo+"</li>";
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?code="+fk_code+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
				
			}
			
			loop++;
			pageNo++;
			
		}//end of while(!(loop > blockSize || pageNo > totalPage)) {------
		
		////////////////////////////////////////////////////////////////////////////////////////////
		
		// === [다음][마지막] 만들기 === //
		if(pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?code="+fk_code+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'> › </a></li>";
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?code="+fk_code+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'> » </a></li>";
			
		}//end of if(pageNo != 1) {----------------------------------------
		
		////////////////////////////////////////////////////////////////////////////////////////////
		
		
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);
		
	    String gobackURL = MyUtil.getCurrentURL(request);

	    mav.addObject("gobackURL", gobackURL);
		mav.addObject("noticeList", noticeList);
		mav.setViewName("notice/notice.tiles2");
		
		return mav;
	}
	
	// 글 1개 조회
	@RequestMapping(value="/noticeView.univ", method={RequestMethod.GET})
	public ModelAndView noticeView(ModelAndView mav, HttpServletRequest request) {

		HttpSession session = request.getSession();
		String fk_code = (String) session.getAttribute("code");
		
		// 조회하고자 하는 글번호 받아오기
		String seq = request.getParameter("seq");
		
		// 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것이다.  
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		if(searchType == null) {
			searchType = "";
		}
		
		if(searchWord == null) {
			searchWord = "";
		}
				
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq);
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("fk_code", fk_code); // 추가
		
		mav.addObject("searchType", searchType);
		mav.addObject("searchWord", searchWord);
		mav.addObject("fk_code", fk_code); // 추가
		////////////////////////////////////////////////////////////////////////////////////////
		
		// === #125. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후 === //
		//      사용자가 목록보기 버튼을 클릭했을 떄 돌아갈 페이지를 알려주기위해
		//			  현재 페이지 주소를 뷰단에 넘겨준다
		
		String gobackURL = request.getParameter("gobackURL");
		
		
		if(gobackURL != null && gobackURL.contains(" ") ) {
			gobackURL = gobackURL.replaceAll(" ", "&");
			// 이전글제목, 다음글제목을 클릭했을때 돌아갈 페이지 주소를 올바르게 만들어주기 위해서 한 것임.
//				System.out.println("~~~~ 확인용 gobackURL =>" + gobackURL);
			// ~~~~ 확인용 gobackURL =>/list.action?searchType=subject&searchWord=%EC%9E%85%EB%8B%88%EB%8B%A4&currentShowPageNo=15 //입니다로 글제목 검색후 15페이지에 있는 55번 김유신 클릭 했을때 콘솔에 찍힘

		}
		
		
		mav.addObject("gobackURL", gobackURL);
		
		////////////////////////////////////////////////////////////////////////////////////////
		
		try {
			Integer.parseInt(seq); // 글번호 형 변환하기
			
			// 현재 로그인 되어 있는 사용자의 정보 가져오기 - 조회수를 위해서
			// 학번추가하면서 임시로 주석처리 HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			String login_hakbun = null;
			
			// 로그인 되어져 있다면
			if(loginuser != null) { 
				login_hakbun = loginuser.getHakbun();
			}
			
			NoticeVO noticevo = null;
			
			// 위의 글목록보기 #69. 에서 session.setAttribute("readCountPermission", "yes"); 해두었다. 
			if("yes".equals(session.getAttribute("readCountPermission"))) {
				// 글 목록보기를 클릭한 다음에 특정글을 조회해온 경우이다
				
				// 글 조회수 증가와 함께 글 1개를 조회 해주는 함수
				noticevo = service.getNoticeView(paraMap, login_hakbun);
				
				session.removeAttribute("readCountPermission");
				// 중요함!! session 에 저장된 readCountPermission 을 삭제한다.
			}
			else {
				// 웹브라우저에서 새로고침(F5)을 클릭한 경우이다
				noticevo = service.getNoticeWithNoAddCount(paraMap);
			}
			
			// view 페이지에 보여주기 위해 request 영역에 담음
			mav.addObject("noticevo", noticevo);
			
		} catch(NumberFormatException e) {
			e.printStackTrace();
		}
		
		mav.setViewName("notice/noticeView.tiles2");
		
		return mav;
	}
	
	// 글 수정하기
	@RequestMapping(value="/noticeEdit.univ", method= {RequestMethod.GET})
	public ModelAndView requiredlogin_noticeEdit(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {

		// 글 수정해야 할 글번호 가져오기
		String seq = request.getParameter("seq");
		String fk_code = request.getParameter("fk_code");// 추가
		
		// 글 수정해야할 글1개 내용 가져오기
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq);
		paraMap.put("fk_code", fk_code); // 추가
		
		
		paraMap.put("searchType", "");// 추가
	    paraMap.put("searchWord", "");// 추가
		
	    NoticeVO noticevo = service.getNoticeWithNoAddCount(paraMap);
		
		try {
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			// 글 작성자와 로그인한 유저와 같지 않으면
			if(!loginuser.getHakbun().equals(noticevo.getFk_hakbun())) {
				
				String message = "다른 사용자의 글은 수정이 불가합니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
			}
			// 자신의 글을 수정할 경우
			else {
				mav.addObject("noticevo", noticevo);
				mav.setViewName("notice/noticeEdit.tiles2");
			}
			
		}catch(NullPointerException e) {
			String message = "로그인 후 이용가능한 서비스입니다.";
			String loc = request.getContextPath()+"/MemberLogin.univ";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
		}
		
		return mav;
		
	}
	
	// 글 수정 완료
	@RequestMapping(value="/noticeEditEnd.univ", method= {RequestMethod.POST})
	public ModelAndView noticeEditEnd(ModelAndView mav, NoticeVO noticevo, HttpServletRequest request) {
		
		// 글 수정을 하려면 원본글에 입력했던 암호와 같아야 글 수정이 가능하도록 하게한다.
		int n = service.noticeEdit(noticevo);
		// n이 1이라면 정상적으로 변경됨
		// n이 0이라면 글수정에 필요한 글암호가 틀린경우
		
		if(n==0) {
			mav.addObject("message", "암호가 일치하지 않아 글 수정이 불가합니다.");
		}
		else {
			mav.addObject("message", "글 수정 성공!!");
		}
		
		mav.addObject("loc", request.getContextPath()+"/noticeView.univ?seq="+noticevo.getSeq());
		
		mav.setViewName("msg");
		
		return mav;
		
	}
	
	// 글 삭제하기
	@RequestMapping(value="/noticeDel.univ")
	public ModelAndView noticeDel(ModelAndView mav, HttpServletRequest request) {
	
		// 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성
	    getCurrentURL(request);

		// 삭제해야 할 글번호 가져오기
		String seq = request.getParameter("seq");
		String fk_code = request.getParameter("fk_code");
		
		// 글 삭제해야할 글1개 내용 가져오기
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq);
		paraMap.put("fk_code", fk_code);// 추가
		
		paraMap.put("searchType", "");// 추가
	    paraMap.put("searchWord", "");// 추가
		
		NoticeVO noticevo = service.getNoticeWithNoAddCount(paraMap);
		
		try {
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			// 글 작성자와 로그인한 유저와 같지 않으면
			if(!loginuser.getHakbun().equals(noticevo.getFk_hakbun())) {
				
				String message = "다른 사용자의 삭제는 불가합니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
			}
			// 자신의 글을 수정할 경우
			else {
				mav.addObject("noticevo", noticevo);
				mav.setViewName("notice/noticeDel.tiles2");
			}
			
		}catch(NullPointerException e) {
			String message = "로그인 후 이용가능한 서비스입니다.";
			String loc = request.getContextPath()+"/MemberLogin.univ";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
		}
		
		return mav;
		
	}
	
	// 글 삭제 완료
	@RequestMapping(value="/noitceDelEnd.univ", method= {RequestMethod.POST})
	public ModelAndView noticeDelEnd(ModelAndView mav, NoticeVO noticevo, HttpServletRequest request) {
		
		// 글 수정을 하려면 원본글에 입력했던 암호와 같아야 글 수정이 가능하도록 하게한다.
		int n = service.noticeDel(noticevo);
		// n이 1이라면 정상적으로 삭제됨
		// n이 0이라면 글수정에 필요한 글암호가 틀린경우
		
		if(n==0) {
			mav.addObject("message", "암호가 일치하지 않아 글 삭제가 불가합니다.");
		}
		else {
			mav.addObject("message", "글 삭제 성공!!");
		}
		
		mav.addObject("loc", request.getContextPath() + "/notice.univ");
		
		mav.setViewName("msg");
		
		return mav;
		
	}
	
	
	// 검색어 입력시 자동글 완성하기
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/noticeWordSearchShow.univ", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String noticeWordSearchShow(HttpServletRequest request){
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		List<String> wordList = service.noticeWordSearchShow(paraMap);
		
		JSONArray jsonarr = new JSONArray();
		
		if(wordList != null) {
			
			for(String word : wordList) {
				
				JSONObject jsonobj = new JSONObject();
				
				jsonobj.put("word", word);
				
				jsonarr.put(jsonobj);
			}
		}
		
		return jsonarr.toString();
				
	}
	

	// 스마트에디터. 드래그앤드롭을 사용한 다중 사진 파일업로드 //
	@RequestMapping(value="/image/noticeMultiplePhotoUpload.univ", method= {RequestMethod.POST}) // attach_photos.js 참조. /board/image/multiplePhotoUpload.action 에서 /image/multiplePhotoUpload.action만 쓰면 됨
	public void NoticeMultiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) {
		
		/*
	      1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
	      >>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
	           우리는 WAS 의 webapp/resources/photo_upload 라는 폴더로 지정해준다.
	    */
	      
	      // WAS 의 webapp 의 절대경로를 알아와야 한다. 
	      HttpSession session = request.getSession();
	      String root = session.getServletContext().getRealPath("/"); 
	      String path = root + "resources"+File.separator+"photo_upload";
	      // path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다.  //이제 files폴더 안쓰고 photo_upload라는 폴더에 이미지넣기위해 생성하기 
	      // 스마트에디터 파일첨부이다. 스마트 에디터 파일첨부는 기존에 폼태그에 이미지를 담은것과 달리 글내용물에 담긴다
	         
	      // System.out.println(">>>> 확인용 path ==> " + path); 
	      // >>>> 확인용 path ==> C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\FinalProject\resources\photo_upload    
	         
	      File dir = new File(path);
	      if(!dir.exists())
	          dir.mkdirs();
	      //폴더가 없으면 만들라는 의미이다.
	      
	      String strURL = "";
	      
	      try {
		      String filename = request.getHeader("file-name"); // 파일명을 받는다 - 일반 원본파일명
	          // 네이버 스마트에디터를 사용한 파일업로드시 싱글파일업로드와는 다르게 멀티파일업로드는 파일명이 header 속에 담겨져 넘어오게 되어있다. 
		      
		      /*
	          [참고]
	          HttpServletRequest의 getHeader() 메소드를 통해 클라이언트 사용자의 정보를 알아올 수 있다. 
	
	          request.getHeader("referer");           // 접속 경로(이전 URL)
	          request.getHeader("user-agent");        // 클라이언트 사용자의 시스템 정보
	          request.getHeader("User-Agent");        // 클라이언트 브라우저 정보 
	          request.getHeader("X-Forwarded-For");   // 클라이언트 ip 주소 
	          request.getHeader("host");              // Host 네임  예: 로컬 환경일 경우 ==> localhost:9090    
		      
		      */
		      
		      InputStream is = request.getInputStream(); // is 는 네이버 스마트 에디터를 사용하여 사진첨부하기 된 이미지 파일임.
	          //java.io로 임포트하기
		      /*
	                    요청 헤더의 content-type이 application/json 이거나 multipart/form-data 형식일 때,
	           name(이름) 없이 값만 전달될 때 이 값은 요청 헤더가 아닌 바디를 통해 전달된다. //즉 본문속에 들어온다는 뜻
	                    이러한 형태의 값을 'payload body'라고 하는데 요청 바디에 직접 쓰여진다 하여 'request body post data'라고도 한다.
	
	                    서블릿에서 payload body 의 값을 읽어오려면 request.getParameter()를 사용하는 것이 아니라 
	           request.getInputStream() 또는 request.getReader()를 사용하여 body를 직접 읽는 방식으로 가져온다.    
	          */
		      
		     String newFilename = fileManager.doFileUpload(is, filename, path); // 이제 fileManager에서 doFileUpload 메소드를 만들어야 함 // 메소드는 newFilename를 리턴한다
		     
		     String ctxPath = request.getContextPath(); // board
             //bNewLine 과 sFileName 그리고 sFileURL 는 attach_photo.js에 있다
		     //올라가야 할 파일이름 경로에 넣어주고 다른것들도 넣어줘서 strURL를 만든다
             strURL += "&bNewLine=true&sFileName="+newFilename;  
             strURL += "&sWidth=";
             strURL += "&sFileURL="+ctxPath+"/resources/photo_upload/"+newFilename;
	     
             // === 웹브라우저상에 사진 이미지를 쓰기 === //
             PrintWriter out = response.getWriter();
             out.print(strURL); //웹브라우저에 strURL 값을 넣어주면 이제 파일이 올라간다
             
             
	      } catch(Exception e) {
	    	  e.printStackTrace();
	      }
	}
// =============== ********  Notice(공지사항) 끝  ******** =============== //
// =========================================================================================================================
	
	
	
	
	
	
// =========================================================================================================================
// =============== ********  Calendar  ******** =============== //
	@RequestMapping(value="/calendar.univ")
	public ModelAndView requiredLogin_calendar(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, CalendarVO calendarvo) {
		
		List<CalendarVO> calendarList = null;
		
		
			
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		String fk_hakbun = loginuser.getHakbun();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_hakbun", fk_hakbun);

		calendarList = service.getCalendar(paraMap);
		System.out.println(calendarList);
		
		
		if(calendarList.size() > 0) {
		
			String title = "";
			String startDate = "";
			String endDate = "";
			
			for(CalendarVO cvo : calendarList) {
				
				title += cvo.getTitle() + ",";
				startDate += cvo.getStartDate() + ",";
				endDate += cvo.getEndDate() + ",";
				
			}
			
			title = title.substring(0, title.lastIndexOf(","));
			startDate = startDate.substring(0, startDate.lastIndexOf(","));
			endDate = endDate.substring(0, endDate.lastIndexOf(","));
			System.out.println("title" + title);
			System.out.println("startDate" + startDate);
			System.out.println("endDate" + endDate);
			mav.addObject("title", title);
			mav.addObject("startDate", startDate);
			mav.addObject("endDate", endDate);
		}
		
		mav.setViewName("calendar/calendar.tiles1");
		
		return mav;
		
	}
	
	
	// 일정 추가
	@RequestMapping(value="/calendarAdd.univ")
	public ModelAndView requiredLogin_calendarAdd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, CalendarVO calendarvo) {
		
		
		mav.setViewName("calendar/calendarAdd.tiles1");
		// WEB-INF/views/tiles2/QnA/QnAAdd.jsp 파일 생성

		return mav;

	}
	
	
	// 일정 추가 완료
	@RequestMapping(value="/calendarAddEnd.univ", method={RequestMethod.POST})
	public ModelAndView calendarAddEnd(HttpServletRequest request, ModelAndView mav, CalendarVO calendarvo) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String fk_hakbun = loginuser.getHakbun();
		
		String title = request.getParameter("title");		// 일정제목
		String detail = request.getParameter("detail");		// 일정내용
		
		// 일정 시작일
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String time = request.getParameter("time");
		String minute = request.getParameter("minute");
		
		// 일정 마감일
		String year1 = request.getParameter("year1");
		String month1 = request.getParameter("month1");
		String day1 = request.getParameter("day1");
		String time1 = request.getParameter("time1");
		String minute1 = request.getParameter("minute1");
		
		String second = "00";
		
		System.out.println("학번 : " + fk_hakbun);
		
		calendarvo.setFk_hakbun(fk_hakbun);
		calendarvo.setTitle(title);
		calendarvo.setDetail(detail);
		calendarvo.setStartDate(year + "-" + month + "-" + day + " " + time + ":" + minute + ":" + second);
		calendarvo.setEndDate(year1 + "-" + month1 + "-" + day1 + " " + time1 + ":" + minute1 + ":" + second);
		
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_hakbun", fk_hakbun);
		paraMap.put("title", title);
		paraMap.put("detail", detail);
		paraMap.put("startDate", calendarvo.getStartDate());
		paraMap.put("endDate", calendarvo.getEndDate());
		
		
		
		service.calendarAdd(calendarvo);
		
		mav.setViewName("redirect:/calendar.univ");
		
		return mav;
		
	}
	
	
// =============== ********  Calendar 끝  ******** =============== //
// =========================================================================================================================

	
	
	
	
	
	
	
	

	// 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성
	public void getCurrentURL(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));
	}

}
