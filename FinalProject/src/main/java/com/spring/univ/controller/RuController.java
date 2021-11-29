package com.spring.univ.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
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
import com.spring.univ.common.MyUtil;
import com.spring.univ.model.DepartmentVO;
import com.spring.univ.model.FreeBoardVO;
import com.spring.univ.model.FreeCommentVO;
import com.spring.univ.model.JjokjiVO;
import com.spring.univ.model.MemberVO;
import com.spring.univ.service.InterRuService;

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
public class RuController {
	@Autowired
	private InterRuService service;

	// === 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection)
	@Autowired
	private FileManager fileManager; // FileManager클래스 생성하고 임포트함
	// Type에 따라 알아서 Bean 을 주입해준다. //그래서 fileManager는 null이 아니다

	/*
	 * @RequestMapping(value="/gill.univ") // /test1.action의 url은 아래의 메소드가 응답함!
	 * public String test1(HttpServletRequest request) {//
	 * 
	 * 
	 * List<String> deptList = service.showdepartment();
	 * 
	 * request.setAttribute("deptList", deptList);
	 * 
	 * 
	 * return "test5"; // /WEB-INF/views/test1.jsp 페이지를 만들어야 한다.
	 * 
	 * }//end of public String test1(HttpServletRequest request) {------------
	 */

//=========================================================================	
	// 게시판 글쓰기 폼페이지 띄우기 //
	@RequestMapping(value = "/add.univ")
	public ModelAndView requiredLogin_add(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		getCurrentURL(request);

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		String fk_hakbun = loginuser.getHakbun();
		String name = loginuser.getName();
		String fk_code = (String) session.getAttribute("code");// 추가

		session.setAttribute("fk_hakbun", fk_hakbun);
		session.setAttribute("name", name);
		session.setAttribute("fk_code", fk_code);

		mav.setViewName("board/add.tiles2");
		/// WEB-INF/views/tiles2/board/add.jsp 파일을 생성한다.

		return mav;

	}

//=========================================================================
	// 게시판 글쓰기 완료 요청 //
	@RequestMapping(value = "/addEnd.univ", method = { RequestMethod.POST })
	public ModelAndView addEnd(Map<String, String> paraMap, ModelAndView mav, FreeBoardVO freeboardvo) {

		// 파일첨부가 없는 글쓰기
		int n = service.add(freeboardvo);

		mav.setViewName("redirect:/list.univ");

		return mav;

	}// end of public ModelAndView addEnd(ModelAndView mav, BoardVO
		// boardvo)--------------------
//=========================================================================	
	// 글목록 보기 페이지 요청 //

	@RequestMapping(value = "/list.univ")
	public ModelAndView list(ModelAndView mav, HttpServletRequest request) {

		List<FreeBoardVO> freeboardList = null;

		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");

		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		// String fk_code = request.getParameter("code");//삭제
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

		int totalCount = 0; // 1. 총 게시물 건수
		int sizePerPage = 10; // 2. 한 페이지당 보여줄 게시물 건수
		int currentShowPageNo = 0; // 3. 현재 보여주는 페이지 번호로서, 초기치는 1페이지로 설정함
		int totalPage = 0; // 4. 총 페이지수(뤱브라우저상에서 보여줄 총 페이지 갯수)
		int startRno = 0; // 5. 시작 행번호
		int endRno = 0; // 6. 끝 행번호

		// 1. 총 게시물 건수
		totalCount = service.getTotalCount(paraMap);
		totalPage = (int) Math.ceil((double) totalCount / sizePerPage);

		if (str_currentShowPageNo == null) {

			currentShowPageNo = 1;
		} else {
			// get방식으로 들어올 때 번호를 치고 들어오는 것이 아닌 문자로 치고 들어올때 에러 방지
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

		paraMap.put("startRno", startRno + "");
		paraMap.put("endRno", endRno + "");

		// 페이징 처리한 글 목록 가져오기(검색의 유무와 상관 없이 모두 호환 가능하다)
		freeboardList = service.boardListSearchWithPaging(paraMap);

		// 아래는 검색대상 컬럼과 검색어를 유지시키기 위한 것
		if (!"".equals(searchType) && !"".equals(searchWord)) {
			mav.addObject(paraMap);
		}

		int blockSize = 10;

		// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
		int loop = 1;
		int pageNo = ((currentShowPageNo - 1) / blockSize) * blockSize + 1;

		String pageBar = "<ul style='list-style:none;'>";
		String url = "list.univ";

		////////////////////////////////////////////////////////////////////////////////////////////

		// === [맨처음][이전] 만들기 === // //페이징처리 url에 과목코드 추가 완료
		if (pageNo != 1) {

			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='" + url + "?code="
					+ fk_code + "&searchType=" + searchType + "&searchWord=" + searchWord
					+ "&currentShowPageNo=1'> « </a></li>";
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='" + url + "?code="
					+ fk_code + "&searchType=" + searchType + "&searchWord=" + searchWord + "&currentShowPageNo="
					+ (pageNo - 1) + "'> ‹ </a></li>";

		} // end of if(pageNo != 1) {----------------------------------------

		////////////////////////////////////////////////////////////////////////////////////////////

		while (!(loop > blockSize || pageNo > totalPage)) {

			// 내가 보고자 하는 페이지가 현제 페이지라면
			// ex) 현재 5페이지 인데 5페이지를 보고싶다면
			if (pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; color:red; padding:2px 4px;'>"
						+ pageNo + "</li>";
			} else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='" + url + "?code="
						+ fk_code + "&searchType=" + searchType + "&searchWord=" + searchWord + "&currentShowPageNo="
						+ pageNo + "'>" + pageNo + "</a></li>";

			}

			loop++;
			pageNo++;

		} // end of while(!(loop > blockSize || pageNo > totalPage)) {------

		////////////////////////////////////////////////////////////////////////////////////////////

		// === [다음][마지막] 만들기 === //
		if (pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='" + url + "?code="
					+ fk_code + "&searchType=" + searchType + "&searchWord=" + searchWord + "&currentShowPageNo="
					+ (pageNo + 1) + "'> › </a></li>";
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='" + url + "?code="
					+ fk_code + "&searchType=" + searchType + "&searchWord=" + searchWord + "&currentShowPageNo="
					+ totalPage + "'> » </a></li>";

		} // end of if(pageNo != 1) {----------------------------------------

		////////////////////////////////////////////////////////////////////////////////////////////

		pageBar += "</ul>";

		mav.addObject("pageBar", pageBar);

		String gobackURL = MyUtil.getCurrentURL(request);

		mav.addObject("gobackURL", gobackURL);
		mav.addObject("freeboardList", freeboardList);
		mav.setViewName("board/list.tiles2");

		return mav;
	}// end of public ModelAndView list(ModelAndView mav)-------------------
//=========================================================================	
	// 글 1개를 보여주는 페이지 요청 //

	@RequestMapping(value = "/view.univ", method = { RequestMethod.GET })
	public ModelAndView view(ModelAndView mav, HttpServletRequest request) {

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
		paraMap.put("fk_code", fk_code);

		mav.addObject("searchType", searchType);
		mav.addObject("searchWord", searchWord);
		mav.addObject("fk_code", fk_code); 
		////////////////////////////////////////////////////////////////////////////////////////

		// === #125. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후 === //
		// 사용자가 목록보기 버튼을 클릭했을 떄 돌아갈 페이지를 알려주기위해
		// 현재 페이지 주소를 뷰단에 넘겨준다

		String gobackURL = request.getParameter("gobackURL");

		// 추가
		if (gobackURL != null && gobackURL.contains(" ")) {
			gobackURL = gobackURL.replaceAll(" ", "&");
			// 이전글제목, 다음글제목을 클릭했을때 돌아갈 페이지 주소를 올바르게 만들어주기 위해서 한 것임.
//			System.out.println("~~~~ 확인용 gobackURL =>" + gobackURL);
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

			FreeBoardVO freeboardvo = null;

			// 위의 글목록보기 #69. 에서 session.setAttribute("readCountPermission", "yes"); 해두었다.
			if ("yes".equals(session.getAttribute("readCountPermission"))) {
				// 글 목록보기를 클릭한 다음에 특정글을 조회해온 경우이다

				// 글 조회수 증가와 함께 글 1개를 조회 해주는 함수
				freeboardvo = service.getView(paraMap, login_hakbun);

				session.removeAttribute("readCountPermission");
				// 중요함!! session 에 저장된 readCountPermission 을 삭제한다.
			} else {
				// 웹브라우저에서 새로고침(F5)을 클릭한 경우이다
				freeboardvo = service.getWithNoAddCount(paraMap);
			}

			// view 페이지에 보여주기 위해 request 영역에 담음
			mav.addObject("freeboardvo", freeboardvo);

		} catch (NumberFormatException e) {
			e.printStackTrace();
		}

		mav.setViewName("board/view.tiles2");

		return mav;
	}// end of public ModelAndView view(ModelAndView mav, HttpServletRequest
		// request){
//=========================================================================	
	// 글수정 페이지 요청 //

	@RequestMapping(value = "/edit.univ", method = { RequestMethod.GET })
	public ModelAndView requiredlogin_edit(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {

		// 글 수정해야 할 글번호 가져오기
		String seq = request.getParameter("seq");
		String fk_code = request.getParameter("fk_code");// 추가

		// 글 수정해야할 글1개 내용 가져오기
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq);
		paraMap.put("fk_code", fk_code); // 추가

		paraMap.put("searchType", "");// 추가
		paraMap.put("searchWord", "");// 추가

		FreeBoardVO freeboardvo = service.getWithNoAddCount(paraMap);

		try {
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

			// 글 작성자와 로그인한 유저와 같지 않으면
			if (!loginuser.getHakbun().equals(freeboardvo.getFk_hakbun())) {

				String message = "다른 사용자의 글은 수정이 불가합니다.";
				String loc = "javascript:history.back()";

				mav.addObject("message", message);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
			}
			// 자신의 글을 수정할 경우
			else {
				mav.addObject("freeboardvo", freeboardvo);
				mav.setViewName("board/edit.tiles2");
			}

		} catch (NullPointerException e) {
			String message = "로그인 후 이용가능한 서비스입니다.";
			String loc = request.getContextPath() + "/MemberLogin.univ";

			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
		}

		return mav;

	}// end of public public ModelAndView requiredlogin_edit(ModelAndView mav,
		// HttpServletRequest request, HttpServletResponse response) {
//=========================================================================	
	// === 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성 ===

	public void getCurrentURL(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));
	}

//=========================================================================	
	// 글수정 페이지 완료하기 //
	@RequestMapping(value = "/editEnd.univ", method = { RequestMethod.POST })
	public ModelAndView editEnd(ModelAndView mav, FreeBoardVO freeboardvo, HttpServletRequest request) {

		// 글 수정을 하려면 원본글에 입력했던 암호와 같아야 글 수정이 가능하도록 하게한다.
		int n = service.edit(freeboardvo);
		// n이 1이라면 정상적으로 변경됨
		// n이 0이라면 글수정에 필요한 글암호가 틀린경우

		if (n == 0) {
			mav.addObject("message", "암호가 일치하지 않아 글 수정이 불가합니다.");
		} else {
			mav.addObject("message", "글 수정 성공!!");
		}

		mav.addObject("loc", request.getContextPath() + "/view.univ?seq=" + freeboardvo.getSeq());

		mav.setViewName("msg");

		return mav;

	}// end of public ModelAndView editEnd(ModelAndView mav, BoardVO boardvo,
		// HttpServletRequest request) {
//=========================================================================		
	// 글삭제 페이지 띄우기 //

	@RequestMapping(value = "/del.univ")
	public ModelAndView del(ModelAndView mav, HttpServletRequest request) {

		// 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성
		getCurrentURL(request);

		// 삭제해야 할 글번호 가져오기
		String seq = request.getParameter("seq");
		String fk_code = request.getParameter("fk_code");// 추가

		// 글 삭제해야할 글1개 내용 가져오기
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq);
		paraMap.put("fk_code", fk_code);// 추가

		paraMap.put("searchType", "");// 추가
		paraMap.put("searchWord", "");// 추가

		FreeBoardVO freeboardvo = service.getWithNoAddCount(paraMap);

		try {
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

			// 글 작성자와 로그인한 유저와 같지 않으면
			if (!loginuser.getHakbun().equals(freeboardvo.getFk_hakbun())) {

				String message = "다른 사용자의 삭제는 불가합니다.";
				String loc = "javascript:history.back()";

				mav.addObject("message", message);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
			}
			// 자신의 글을 수정할 경우
			else {
				mav.addObject("freeboardvo", freeboardvo);
				mav.setViewName("board/del.tiles2");
			}

		} catch (NullPointerException e) {
			String message = "로그인 후 이용가능한 서비스입니다.";
			String loc = request.getContextPath() + "/MemberLogin.univ";

			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
		}

		return mav;

	}// end of public ModelAndView del(ModelAndView mav, BoardVO boardvo,
		// HttpServletRequest request) {
//=========================================================================
	// 글삭제 페이지 완료하기 //

	@RequestMapping(value = "/delEnd.univ", method = { RequestMethod.POST })
	public ModelAndView delEnd(ModelAndView mav, FreeBoardVO freeboardvo, HttpServletRequest request) {

		// 글 수정을 하려면 원본글에 입력했던 암호와 같아야 글 수정이 가능하도록 하게한다.
		int n = service.del(freeboardvo);
		// n이 1이라면 정상적으로 변경됨
		// n이 0이라면 글수정에 필요한 글암호가 틀린경우

		if (n == 0) {
			mav.addObject("message", "암호가 일치하지 않아 글 삭제가 불가합니다.");
		} else {
			mav.addObject("message", "글 삭제 성공!!");
		}

		mav.addObject("loc", request.getContextPath() + "/list.univ");

		mav.setViewName("msg");

		return mav;

	}// end of public ModelAndView delEnd(ModelAndView mav, BoardVO boardvo,
		// HttpServletRequest request) {
//=========================================================================	
	// 댓글쓰기(Ajax 로 처리) //

	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value = "/addComment.univ", method = { RequestMethod.POST }, produces = "text/plain;charset=UTF-8")
	public String addComment(FreeCommentVO freecommentvo) {

		// 댓글쓰기에 첨부파일이 없는 경우
		int n = 0;

		try {
			n = service.addComment(freecommentvo);
		} catch (Throwable e) {
			e.printStackTrace();
		}

		// 댓글쓰기(insert) 및 원게시물(tbl_board 테이블)에 댓글의 개수 증가(update 1씩 증가)하기
		JSONObject jsonobj = new JSONObject();
		jsonobj.put("n", n);
		jsonobj.put("name", freecommentvo.getName());

		return jsonobj.toString();

	}// end of public String addComment(CommentVO commentvo){
//=========================================================================
	// 원게시물에 있는 댓글들을 조회해오기(Ajax 로 처리) //

	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value = "/readComment.univ", produces = "text/plain;charset=UTF-8")
	public String readComment(HttpServletRequest request) {

		String parentSeq = request.getParameter("parentSeq");

		List<FreeCommentVO> freecommentList = service.getCommentList(parentSeq);

		JSONArray jsonarr = new JSONArray();

		if (freecommentList != null) {

			for (FreeCommentVO frcmtvo : freecommentList) {

				JSONObject jsonobj = new JSONObject();

				jsonobj.put("content", frcmtvo.getContent());
				jsonobj.put("name", frcmtvo.getName());
				jsonobj.put("regDate", frcmtvo.getRegDate());

				jsonarr.put(jsonobj);
			}
		}

		return jsonarr.toString();

	}// end of public String readComment(HttpServletRequest request){-------
//=========================================================================
	// 검색어 입력시 자동글 완성하기 //

	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value = "/wordSearchShow.univ", method = {
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String wordSearchShow(HttpServletRequest request) {

		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);

		List<String> wordList = service.wordSearchShow(paraMap);

		JSONArray jsonarr = new JSONArray();

		if (wordList != null) {

			for (String word : wordList) {

				JSONObject jsonobj = new JSONObject();

				jsonobj.put("word", word);

				jsonarr.put(jsonobj);
			}
		}

		return jsonarr.toString();

	}// end of public String wordSearchShow(HttpServletRequest request){----
//=========================================================================
	// 원게시물에 있는 댓글들을 조회해오기(Ajax 로 처리) //

	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value = "/commentList.univ", produces = "text/plain;charset=UTF-8")
	public String commentList(HttpServletRequest request) {

		String parentSeq = request.getParameter("parentSeq");
		String currentShowPageNo = request.getParameter("currentShowPageNo");

		if (currentShowPageNo == null) {
			currentShowPageNo = "1";
		}

		int sizePerPage = 5;
		int startRno = ((Integer.parseInt(currentShowPageNo) - 1) * sizePerPage) + 1;
		int endRno = startRno + sizePerPage - 1;

		Map<String, String> paraMap = new HashMap<>();

		paraMap.put("parentSeq", parentSeq);
		paraMap.put("startRno", startRno + "");
		paraMap.put("endRno", endRno + "");

		List<FreeCommentVO> freecommentList = service.getCommentListPaging(paraMap);

		JSONArray jsonarr = new JSONArray();

		if (freecommentList != null) {

			for (FreeCommentVO frcmtvo : freecommentList) {

				JSONObject jsonobj = new JSONObject();

				jsonobj.put("content", frcmtvo.getContent());
				jsonobj.put("name", frcmtvo.getName());
				jsonobj.put("regDate", frcmtvo.getRegDate());

				jsonarr.put(jsonobj);
			}
		}

		return jsonarr.toString();

	}// end of public String commentList(HttpServletRequest request){-------
//=========================================================================
	// 댓글내용 페이지바 Ajax로 만들기 //

	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value = "/getCommentTotalPage.univ", produces = "text/plain;charset=UTF-8")
	public String getCommentTotalPage(HttpServletRequest request) {

		String parentSeq = request.getParameter("parentSeq");
		String sizePerPage = request.getParameter("sizePerPage");

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("parentSeq", parentSeq);

		// 원글 글번호(parentSeq)에 해당하는 댓글의 총갯수를 알아오기
		int totalCount = service.getCommentTotalCount(paraMap);

		// === 총페이지수(totalPage)구하기 ===
		// 만약에 총 게시물 건수(totalCount)가 12개 이라면
		// 총페이지수(totalPage)는 3개가 되어야 한다.
		int totalPage = (int) Math.ceil((double) totalCount / Integer.parseInt(sizePerPage));
		// (double)12/5 ==> 2.4 ==> Math.ceil(2.4) ==> 3.0 ==> (int)3.0 ==> 3

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("totalPage", totalPage); // {"totalPage":3}

		return jsonObj.toString();
	}// end of public String commentList(HttpServletRequest request){-------
//=========================================================================

	// === #168. 스마트에디터. 드래그앤드롭을 사용한 다중 사진 파일업로드 === //
	@RequestMapping(value = "/image/multiplePhotoUpload.univ", method = { RequestMethod.POST }) // attach_photos.js 참조.
																								// /board/image/multiplePhotoUpload.action
																								// 에서
																								// /image/multiplePhotoUpload.action만
																								// 쓰면 됨
	public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) {

		/*
		 * 1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. >>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기 우리는
		 * WAS 의 webapp/resources/photo_upload 라는 폴더로 지정해준다.
		 */

		// WAS 의 webapp 의 절대경로를 알아와야 한다.
		HttpSession session = request.getSession();
		String root = session.getServletContext().getRealPath("/");
		String path = root + "resources" + File.separator + "photo_upload";
		// path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다. //이제 files폴더 안쓰고 photo_upload라는 폴더에
		// 이미지넣기위해 생성하기
		// 스마트에디터 파일첨부이다. 스마트 에디터 파일첨부는 기존에 폼태그에 이미지를 담은것과 달리 글내용물에 담긴다

		// System.out.println(">>>> 확인용 path ==> " + path);
		// >>>> 확인용 path ==>
		// C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\FinalProject\resources\photo_upload

		File dir = new File(path);
		if (!dir.exists())
			dir.mkdirs();
		// 폴더가 없으면 만들라는 의미이다.

		String strURL = "";

		try {
			String filename = request.getHeader("file-name"); // 파일명을 받는다 - 일반 원본파일명
			// 네이버 스마트에디터를 사용한 파일업로드시 싱글파일업로드와는 다르게 멀티파일업로드는 파일명이 header 속에 담겨져 넘어오게 되어있다.

			/*
			 * [참고] HttpServletRequest의 getHeader() 메소드를 통해 클라이언트 사용자의 정보를 알아올 수 있다.
			 * 
			 * request.getHeader("referer"); // 접속 경로(이전 URL)
			 * request.getHeader("user-agent"); // 클라이언트 사용자의 시스템 정보
			 * request.getHeader("User-Agent"); // 클라이언트 브라우저 정보
			 * request.getHeader("X-Forwarded-For"); // 클라이언트 ip 주소
			 * request.getHeader("host"); // Host 네임 예: 로컬 환경일 경우 ==> localhost:9090
			 * 
			 */

			InputStream is = request.getInputStream(); // is 는 네이버 스마트 에디터를 사용하여 사진첨부하기 된 이미지 파일임.
			// java.io로 임포트하기
			/*
			 * 요청 헤더의 content-type이 application/json 이거나 multipart/form-data 형식일 때, name(이름)
			 * 없이 값만 전달될 때 이 값은 요청 헤더가 아닌 바디를 통해 전달된다. //즉 본문속에 들어온다는 뜻 이러한 형태의 값을 'payload
			 * body'라고 하는데 요청 바디에 직접 쓰여진다 하여 'request body post data'라고도 한다.
			 * 
			 * 서블릿에서 payload body 의 값을 읽어오려면 request.getParameter()를 사용하는 것이 아니라
			 * request.getInputStream() 또는 request.getReader()를 사용하여 body를 직접 읽는 방식으로 가져온다.
			 */

			String newFilename = fileManager.doFileUpload(is, filename, path); // 이제 fileManager에서 doFileUpload 메소드를
																				// 만들어야 함 // 메소드는 newFilename를 리턴한다

			String ctxPath = request.getContextPath(); // board
			// bNewLine 과 sFileName 그리고 sFileURL 는 attach_photo.js에 있다
			// 올라가야 할 파일이름 경로에 넣어주고 다른것들도 넣어줘서 strURL를 만든다
			strURL += "&bNewLine=true&sFileName=" + newFilename;
			strURL += "&sWidth=";
			strURL += "&sFileURL=" + ctxPath + "/resources/photo_upload/" + newFilename;

			// === 웹브라우저상에 사진 이미지를 쓰기 === //
			PrintWriter out = response.getWriter();
			out.print(strURL); // 웹브라우저에 strURL 값을 넣어주면 이제 파일이 올라간다

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// =========================================================================

	// 쪽지 수신함 페이지 요청 //
	@RequestMapping(value = "/receiveList.univ")
	public ModelAndView requiredLogin_receiveList(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser.getAuthority() == 0) {//교수 또는 관리자 권한이 아닌 학생인 경우
			String message = "권한이 없습니다.";
			String loc = request.getContextPath()+"/MemberLogin.univ";
			// 원래는 위와같이 index.action 이 아니라 휴면인 계정을 풀어주는 페이지로 잡아주어야 한다.
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		}
		
		
		else {
		String fk_hakbun = loginuser.getHakbun();
		String name = loginuser.getName();

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_hakbun", fk_hakbun);

		///////////////////////////////////////////////////////

		String str_currentShowPageNo = request.getParameter("currentShowPageNo"); // 필요한지 모르겠다
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물건수(totalCount) 는 검색조건이 있을 때와 없을 떄로 나뉘어진다
		
		int totalCount = 0;        // 1. 총 게시물 건수
		int sizePerPage = 10;      // 2. 한 페이지당 보여줄 게시물 건수
		int currentShowPageNo = 0; // 3. 현재 보여주는 페이지 번호로서, 초기치는 1페이지로 설정함
		int totalPage = 0;         // 4. 총 페이지수(뤱브라우저상에서 보여줄 총 페이지 갯수)
		int startRno = 0;          // 5. 시작 행번호
		int endRno = 0;            // 6. 끝 행번호
		
		// 1. 총 게시물 건수
		totalCount = service.receiveTotalCount(paraMap);
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
		
		paraMap.put("startRno", startRno+"");
		paraMap.put("endRno", endRno+"");
		
		
		
		
		///////////////////////////////////////////////////////
		List<Map<String, String>> receiveList = service.receiveList(paraMap);
		///////////////////////////////////////////////////////
		
		
		int blockSize = 10;
		
		
		  // loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
				int loop = 1;
				int pageNo = ((currentShowPageNo - 1) / blockSize) * blockSize + 1;
				
				String pageBar = "<ul style='list-style:none;'>";
				String url = "receiveList.univ";
		
		// === [맨처음][이전] 만들기 === // //페이징처리 url에 과목코드 추가 완료
		if(pageNo != 1) {
			
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?currentShowPageNo=1'> « </a></li>";
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+(pageNo-1)+"'> ‹ </a></li>";
			
		}//end of if(pageNo != 1) {----------------------------------------
		
		while(!(loop > blockSize || pageNo > totalPage)) {
			
			// 내가 보고자 하는 페이지가 현제 페이지라면
			// ex) 현재 5페이지 인데 5페이지를 보고싶다면
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; color:red; padding:2px 4px;'>"+pageNo+"</li>";
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
				
			}
			
			loop++;
			pageNo++;
			
		}//end of while(!(loop > blockSize || pageNo > totalPage)) {------
		
		// === [다음][마지막] 만들기 === //
		if(pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"&currentShowPageNo="+(pageNo+1)+"'> › </a></li>";
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"&currentShowPageNo="+totalPage+"'> » </a></li>";
			
		}//end of if(pageNo != 1) {----------------------------------------

		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);

		///////////////////////////////////////////////////////
		session.setAttribute("fk_hakbun", fk_hakbun);
		session.setAttribute("name", name);

		mav.addObject("receiveList", receiveList);
		// mav.addObject("receiveList", receiveList);

		mav.setViewName("jjokji/receiveList.tiles2");

		
		
		
		
		
		
		
		
		//
		}
		return mav;

	}// end of public ModelAndView requiredLogin_receiveList(HttpServletRequest
		// request, HttpServletResponse response, ModelAndView mav)-------------------

	
	
	
	
	
	
	//////////////////////////////////////////////////////////////////////////

	// 쪽지 발신함 페이지 요청 //
	@RequestMapping(value = "/sendList.univ")
	public ModelAndView requiredLogin_sendList(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		if(loginuser.getAuthority() == 0) {
			String message = "권한이 없습니다.";
			String loc = request.getContextPath()+"/MemberLogin.univ";
			// 원래는 위와같이 index.action 이 아니라 휴면인 계정을 풀어주는 페이지로 잡아주어야 한다.
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		}
		
		else {
		
		
		
		String fk_hakbun = loginuser.getHakbun();
		String name = loginuser.getName();

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_hakbun", fk_hakbun);


		///////////////////////////////////////////////////////
		
		String str_currentShowPageNo = request.getParameter("currentShowPageNo"); // 필요한지 모르겠다
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물건수(totalCount) 는 검색조건이 있을 때와 없을 떄로 나뉘어진다
		
		int totalCount = 0;        // 1. 총 게시물 건수
		int sizePerPage = 10;      // 2. 한 페이지당 보여줄 게시물 건수
		int currentShowPageNo = 0; // 3. 현재 보여주는 페이지 번호로서, 초기치는 1페이지로 설정함
		int totalPage = 0;         // 4. 총 페이지수(뤱브라우저상에서 보여줄 총 페이지 갯수)
		int startRno = 0;          // 5. 시작 행번호
		int endRno = 0;            // 6. 끝 행번호
		
		// 1. 총 게시물 건수
		totalCount = service.sendTotalCount(paraMap);
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
		
		paraMap.put("startRno", startRno+"");
		paraMap.put("endRno", endRno+"");
		
		///////////////////////////////////////////////////////
		List<Map<String, String>> sendList = null;
		sendList = service.sendList(paraMap);
		///////////////////////////////////////////////////////

		
		int blockSize = 10;
		
		
		  // loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
				int loop = 1;
				int pageNo = ((currentShowPageNo - 1) / blockSize) * blockSize + 1;
				
				String pageBar = "<ul style='list-style:none;'>";
				String url = "sendList.univ";
		
		// === [맨처음][이전] 만들기 === // //페이징처리 url에 과목코드 추가 완료
		if(pageNo != 1) {
			
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?currentShowPageNo=1'> « </a></li>";
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+(pageNo-1)+"'> ‹ </a></li>";
			
		}//end of if(pageNo != 1) {----------------------------------------
		
		while(!(loop > blockSize || pageNo > totalPage)) {
			
			// 내가 보고자 하는 페이지가 현제 페이지라면
			// ex) 현재 5페이지 인데 5페이지를 보고싶다면
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; color:red; padding:2px 4px;'>"+pageNo+"</li>";
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
				
			}
			
			loop++;
			pageNo++;
			
		}//end of while(!(loop > blockSize || pageNo > totalPage)) {------
		
		// === [다음][마지막] 만들기 === //
		if(pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"&currentShowPageNo="+(pageNo+1)+"'> › </a></li>";
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"&currentShowPageNo="+totalPage+"'> » </a></li>";
			
		}//end of if(pageNo != 1) {----------------------------------------

		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);
		
		
		///////////////////////////////////////////////////////

		session.setAttribute("fk_hakbun", fk_hakbun);
		session.setAttribute("name", name);

		mav.addObject("sendList", sendList);
		// mav.addObject("sendList", sendList);

		mav.setViewName("jjokji/sendList.tiles2");

		
		
		}
		
		
		/////////////
		
		return mav;
	}// end of public ModelAndView requiredLogin_sendList(HttpServletRequest request,
		// HttpServletResponse response, ModelAndView mav)-------------------

	
	
	
	
	
	
	
	
	/////////////////////////////////////////////////////////////////////////////

	// 쪽지 보내기 페이지 요청 //
	@RequestMapping(value = "/sendjjokji.univ")
	public ModelAndView requiredLogin_sendjjokji(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		if(loginuser.getAuthority() == 0) {
			String message = "권한이 없습니다.";
			String loc = request.getContextPath()+"/MemberLogin.univ";
			// 원래는 위와같이 index.action 이 아니라 휴면인 계정을 풀어주는 페이지로 잡아주어야 한다.
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		}
		
		else {
		
		String fk_hakbun = loginuser.getHakbun();
		String name = loginuser.getName();

		List<DepartmentVO> deptList = service.getDeptList(); // 쪽지 보내기 과목 및 과목번호 가져오기
		
		/////////////// 확인용
		// deptCode  deptName
		
		/*
		for (int i=0; i<deptList.size(); i++) {
			String deptCode = deptList.get(i).getDeptCode();
			System.out.println(deptCode);
			
			
			String deptName = deptList.get(i).getDeptName();
			System.out.println(deptName);
			
		}
		
		 
		 */
		
		///////////////
	
		
		mav.addObject("deptList", deptList);
		//request.setAttribute("deptList", deptList);
		
		
		System.out.println("학번 " + fk_hakbun);
		System.out.println("이름 " + name);

		session.setAttribute("fk_hakbun", fk_hakbun);
		session.setAttribute("name", name);

		mav.setViewName("jjokji/sendjjokji.tiles2");
		
		}
		
		return mav;
	
	
	}// end of public ModelAndView requiredLogin_sendjjokji(HttpServletRequest
		// request, HttpServletResponse response, ModelAndView mav)-------------------

	
	
	
	
	
	//////////////////////////////////////////////////////////////////////////////////////

	// 쪽지 쓰기 완료 요청 //
	@RequestMapping(value = "/sendjjokjiEnd.univ", method = { RequestMethod.POST })
	public ModelAndView sendjjokjiEnd(ModelAndView mav, JjokjiVO jjokjivo, MultipartHttpServletRequest mrequest) {

		MultipartFile attach = jjokjivo.getAttach();
		
		if( !attach.isEmpty() ) {
			  
			
			  HttpSession session = mrequest.getSession();
			  String root = session.getServletContext().getRealPath("/");
			  
			 
		
			  String path = root + "resources" + File.separator + "files"; // path 가 첨부파일이
		
			  
			  String newFileName = ""; 
			  
			  byte[] bytes = null; 
			  
			  long fileSize = 0; 
			  
			 try { 
				 
			  bytes = attach.getBytes(); 
			  
			  newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(),path); 
			  
			  jjokjivo.setFileName(newFileName); 
			  
			  System.out.println("1 "+newFileName);
			  
			  jjokjivo.setOrgFilename(attach.getOriginalFilename()); 
			
			  System.out.println("2 "+attach.getOriginalFilename());
			  
			  fileSize = attach.getSize(); 
			  
			  jjokjivo.setFileSize(String.valueOf(fileSize));
			  
			  } catch (Exception e) { e.printStackTrace(); }
			  
			  } 
			  
		
			 
			  int n = 0;
			  
			  if( attach.isEmpty() ) { 
				  n = service.sendjjokji(jjokjivo); 
			  } 
			  
			  else {
				  n = service.sendjjokji_withFile(jjokjivo); 
			  }

		mav.setViewName("redirect:/sendList.univ"); 
		
		
		
		return mav;

	}
	
	
	//////////////////////////////////////////////////////////////////////////////////
	
	// === #163. 첨부파일 다운로드 받기 === //   
		@RequestMapping(value="/download.univ") 
		public void requiredLogin_download(HttpServletRequest request, HttpServletResponse response) { // 그냥 파일 다운받는 거니까 리턴 타입은 아무거나 상관없어서 void로 한다.
			
			String jseq = request.getParameter("jseq"); 
			
			Map<String, String> paraMap = new HashMap<>(); //매퍼보면 파라미터로 서치워드,서치타입,글번호를 맵으로 받아서 셀렉트한 값을 boardvo를 반환하도록 했다
			paraMap.put("jseq", jseq);
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = null; //웹브라우저에 직접 출력하기 위한 것
			
			
			try {
				Integer.parseInt(jseq);
				
				JjokjiVO jjokjivo = service.getjjokjiList(paraMap); //쪽지 vo전부 셀렉트해오는 쿼리문 필요하다
				
				
				if(jjokjivo == null || (jjokjivo != null && jjokjivo.getFileName() == null)) {
					
					out = response.getWriter();
					
					
					out.println("<script type='text/javascript'> alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일 다운로드가 불가합니다!!'); history.back(); </script>"); //주솽에 없는 숫자 입력했을때 나옴
					
					return; // 종료
				}
				
				else { //올바르게 들어왔을때 다운되도록 할 것
					 String fileName = jjokjivo.getFileName();
					
					 String orgFilename = jjokjivo.getOrgFilename();
					 
					 
			         HttpSession session = request.getSession(); 
			         String root = session.getServletContext().getRealPath("/");
			         
			         //   System.out.println("~~~~ 확인용 webapp 의 절대경로 => " + root);
			         // ~~~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\ 
			         
			         String path = root + "resources" + File.separator + "files";
			         
			         
			         // path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
			         //  System.out.println("~~~~ 확인용 path => " + path);
			         // ~~~~ 확인용 path => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files
			         
					 // **** file 다운로드 하기 **** //
			         boolean flag = fileManager.doFileDownload(fileName, orgFilename, path, response); //doFileDownload메소드에 값 넘김. 메소드의 리턴 타입은 boolean이다.
			         //flag 값이 true 로 받아오면 다운로드 성공을 말하고,
			         //flag 값이 flase 로 받아오면 다운로드 실패를 말한다.
					
			         if(flag == false) {
			        	 // 다운로드가 실패할 경우 메시지를 띄워준다.
			        	 out = response.getWriter();
						// 웹브라우저상에 메시지를 쓰기 위한 객체생성
							
						 out.println("<script type='text/javascript'> alert('파일 다운로드가 실패되었습니다!!'); history.back(); </script>"); 
						
			         }
			         
				}
			
			} catch (NumberFormatException e) {
				/*
				try {
					out = response.getWriter(); //IOE익셉션처리해줘야 함
					// 웹브라우저상에 메시지를 쓰기 위한 객체생성
					
					out.println("<script type='text/javascript'> alert('존재하지 않는 글번호 이므로 파일 다운로드가 불가합니다!!'); history.back(); </script>"); //문자 입력했을때 나옴
				} catch(IOException e1) {
					
				}
				*/
			} catch (IOException e2) {
				
			}
			
			
		}	
	
		
//=========================================================================
// === 교수님목록 조회해오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/getTeacher.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.GET})
	public String getTeacher(HttpServletRequest request){

		String fk_deptCode = request.getParameter("fk_deptCode");
		System.out.println("~~~~ 확인용 fk_deptCode " + fk_deptCode); // 학과번호는 잘 받아옴

		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("fk_deptCode", fk_deptCode);

		// 담당교수 가져오기
		List<MemberVO> teacherList = service.getTeacherList(paraMap);
		
		JSONArray jsonarr = new JSONArray();
		
		if(teacherList != null) {
		
			for(MemberVO mvo : teacherList) {
		
				JSONObject jsonobj = new JSONObject();

				jsonobj.put("hakbun", mvo.getHakbun()); 
				jsonobj.put("name", mvo.getName()); 	
	
				jsonarr.put(jsonobj);
			}
		}
		
		return jsonarr.toString();
				
	}//end of public String TeacherList(HttpServletRequest request){------
	
	
	
	
	
	
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//=========================================================================
	// === 수신함,발신함 쪽지 삭제하기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/jjokjiListDel.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.GET})
	public String jjokjiListDel(HttpServletRequest request){
	
	String jseq = request.getParameter("jseq");
	
	String[] jseqArr1 = jseq.substring(0, jseq.lastIndexOf(",")).split(",");
	
	Map<String, String[]> map = new HashMap<>();
	map.putIfAbsent("jseqArr1", jseqArr1);
	
	// 발신함 삭제하기
	int n = service.jjokjiListDel(map);
	
	JSONObject jsonobj = new JSONObject();
	
	jsonobj.put("n", n); 
	
	return jsonobj.toString();
	
	}//end of public String jjokjiDel(HttpServletRequest request){---------   
	//=========================================================================   

	
	
	
	
	

}
