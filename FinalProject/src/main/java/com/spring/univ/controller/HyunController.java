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

import com.spring.univ.model.FreeBoardVO;
import com.spring.univ.common.MyUtil;
import com.spring.univ.model.MemberVO;


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
	
	@RequestMapping(value="/notice.univ") // /Notice.univ의 url은 아래의 메소드가 응답함!
	public ModelAndView Notice(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("notice/notice.tiles1");
	//	/WEB-INF/views/tiles1/notice/notice.jsp 페이지를 만들어야 한다.
		
		return mav;
	
		
	}//public ModelAndView Notice(ModelAndView mav, HttpServletRequest request)--------	
	
//=========================================================================
	// === #51. 문의게시판(공지사항) 글쓰기 폼페이지 요청 === //
	@RequestMapping(value="/noticeAdd.univ")
	public ModelAndView Noticeadd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성
	//	MyUtil.getCurrentURL(request);
	
	/*	
		// === #142.답변글쓰기가 추가된 경우 시작 === //
		String fk_seq = request.getParameter("fk_seq");
		String groupno = request.getParameter("groupno");
		String depthno = request.getParameter("depthno");
		
		if(fk_seq == null) {
			fk_seq = "";
		}
		
		mav.addObject("fk_seq", fk_seq);
		mav.addObject("groupno", groupno);
		mav.addObject("depthno", depthno);
		
		// === #142.답변글쓰기가 추가된 경우 끝 === //
		
	*/	
		
		mav.setViewName("notice/noticeAdd.tiles1");
	//	/WEB-INF/views/tiles1/add.jsp 페이지를 만들어야 한다.
		
		return mav;
	
	}
//=========================================================================
	
	
	//=========================================================================
		// === #54. 문의게시판 글쓰기 완료 요청 === //
		@RequestMapping(value="/noticeAddEnd.univ", method= {RequestMethod.POST})
		public ModelAndView noticeAddEnd(Map<String, String> paraMap, ModelAndView mav, FreeBoardVO freeboardvo) { // <== After Advice 사용하기	
			
			/*
				form 태그의 name 명과  BoardVO 의 필드명이 같다라면 
				request.getParameter("form 태그의 name명"); 을 사용하지 않더라도
				자동적으로 BoardVO boardvo 에 set 되어진다.
			*/
		
		/*	
			System.out.println("~~~ 확인용 fk_userid : " + boardvo.getFk_userid());
			System.out.println("~~~ 확인용 name : " + boardvo.getName());
			System.out.println("~~~ 확인용 subject : " + boardvo.getSubject());
		*/
		//	int n = service.// <== 파일첨부가 없는 글쓰기
			
			mav.setViewName("redirect:/notice.univ");
			// list.action 페이지로 redirect(페이지이동)하라는 말이다.
			
			// === #96. After Advice를 사용하기 === //
			// == After Advice 를 사용하기 위해 파라미터를 생성하는 것임 ==
			//	  (글쓰기를 한 이후에 회원의 포인트를 100점 증가)
			paraMap.put("fk_hakbun", freeboardvo.getFk_hakbun());
			paraMap.put("point", "100"); // 글쓰기를 하면 포인트 100 증가시키기
			
			return mav;
		}//end of public ModelAndView noticeAddEnd(ModelAndView mav, FreeBoardVO freeboardvo)--------------------
	//=========================================================================	
	
}	







