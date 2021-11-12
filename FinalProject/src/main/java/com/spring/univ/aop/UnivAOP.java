package com.spring.univ.aop;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.spring.univ.model.MemberVO;
import com.spring.univ.service.InterSungService;

@Aspect
@Component
public class UnivAOP {
	
	@Autowired
	InterSungService service;
	
	/////////////////////////////////////////////////////////////////////////////////////////////////
	// 1. 로그인 유무 검사하는 Advice
	@Pointcut("execution(public * com.spring..*Controller.requiredLogin_*(..))")
	public void requiredLogin() {}
	
	@Before("requiredLogin()")
	public void loginCheck(JoinPoint joinPoint) {
		
		HttpServletRequest  request  = (HttpServletRequest)  joinPoint.getArgs()[0];
		HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[1]; 
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginuser") == null) {
			String message = "길영대학교 학생만 이용할 수 있는 서비스입니다.";
			String loc = request.getContextPath() + "/MemberLogin.univ";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
			
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				
			}
			
		}
		
	}
	/////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////
	/// 2. 과목탭의 메뉴들을 위한 Advice
	/// 로그인유무 검사, 과목코드가 존재하는건지 검사, [학생] 수강신청한 과목에 접근하려는지 검사, [교수] 담당과목에 접근하려는지 검사, 과목메뉴들에 접근할때마다 그 과목에 맞는 정보들을 가져와준다. 
	@Pointcut("execution(public * com.spring..*Controller.subject_*(..))")
	
	// 이 Advice를 사용하기 위해서는 메소드명은 'subject_' 로 시작해야하며, 1번째 파라미터는 HttpServletRequest request, 2번째 파라미터는 HttpServletResponse response 이어야 합니다.
	public void subject() {}
	
	@Before("subject()")
	public void subjectCheck(JoinPoint joinPoint) {
		
		
		try {
			HttpServletRequest request = (HttpServletRequest) joinPoint.getArgs()[0]; 
			HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[1]; 
			
			HttpSession session = request.getSession();
			String sessionCode = (String) session.getAttribute("code"); // 현재 세션에 저장된 코드를 가져옵니다.
			
			
			String servletPass = request.getServletPath();
			// ServletPath 란?
			// localhost:9090/univ/dashboard.univ?code=0101
			/*
			 *  localhost: IP주소
			 *  9090: 포트번호
			 *  univ: 컨텍스트패스명
			 *  dashboard.univ: 서블릿패스
			 *  code=0101: 쿼리스트링 
			 */
			
			
			
			// 맨 처음에 과목메뉴로 이동했다면 세션에 code가 없습니다.
			// 또한 다른 과목(ex.금길영의 다이어트학)을 보다가 다른 과목(ex.장현걸의 보컬수업)으로 이동을 하면 세션의 code를 갱신해야하니 조건절에 넣었습니다.
			// 또한 과목으로 이동을 하면 무조건 "/subject.univ?code=과목번호"로 대쉬보드와 과목퀵메뉴에서 이동하게 설정을 해뒀습니다.
			if(sessionCode == null || "".equals(sessionCode) || "/subject.univ".equals(servletPass)) { 
				
				sessionCode = request.getParameter("code"); // 대쉬보드와 과목퀵메뉴에서 보내준 과목코드를 받아서,
				session.setAttribute("code", request.getParameter("code")); // 세션에 넣어줍니다.
			}
			
			
			//////////////////////////////////////////////////////////////////
			// 1단계. 로그인 유무 검사
			if(session.getAttribute("loginuser") == null) {
				String message = "길영대학교 학생만 이용할 수 있는 서비스입니다.";
				String loc = request.getContextPath() + "/MemberLogin.univ";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
				dispatcher.forward(request, response);
			}
			//////////////////////////////////////////////////////////////////
			
			
			
			
			//////////////////////////////////////////////////////////////////
			// 2단계. 과목코드가 우리 학교에 존재하는 과목인지 검사합니다.
			
			if(sessionCode == null || "".equals(sessionCode)) { // null이거나 ""이라면 비정상적이니 우리 학교에 존재할리 없는 9999를 임의로 줍니다.
				sessionCode = "9999";
			}
			
			
			int result = service.checkCode(sessionCode); 
			// 이 메소드는 DB에 접근하여 조건절에 code = #{code}를 하여 count(*)을 해옵니다.
			// 존재한다면 1 이상이고, 없다면 0입니다.
			
			
			// 없는 과목이라면 이 구절에 들어와서 더이상 Advice 아래로 내려가지 않고 내보냅니다.
			if(result==0) {
				String message = "요청하신 과목은 없는 과목입니다.";
				String loc = request.getContextPath() + "/dashboard.univ";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
				dispatcher.forward(request, response);
			}
			
			//////////////////////////////////////////////////////////////////
			
			
			// 학생은 authority가 0, 교수는 authority가 1인 점을 이용하여 구분을 해서 각각 검사를 해줍니다.
			
			/////////////////////////////////////////////////////////////////
			// 3-1단계. [학생] 자신이 수강신청한 과목에 접근하려는지 확인한다.
			
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser"); // 현재 로그인한 유저를 가져옵니다.
			String hakbun = loginuser.getHakbun(); // 걔의 학번을 가져옵니다.
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("hakbun", hakbun);
			paraMap.put("code", sessionCode);
			
			if(loginuser.getAuthority()==0) {
				
				int n = service.checkSugang(paraMap); 
				// 학번과 접근하려는 과목코드를 보내서 DB에 접근해 검사를 합니다.
				// 수강테이블에서 where fk_hakbun = #{hakbun} and fk_code = #{code} 로 검사를해서 count(*)를 가져옵니다.
				// 이 과목을 안듣는 학생이라면 0, 과목을 듣는다면 1 이상이 리턴됩니다.
				
				// 이 과목을 듣지않는데 URL등을 통하여 접근하려 한다면 쫓아냅니다.
				if(n==0) {
					String message = "수강한 학생들만 접근할 수 있습니다.";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
					
					dispatcher.forward(request, response);
				}
				
			}
			
			////////////////////////////////////////////////////////////////
			// 3-2단계. [교수] 자신이 담당하는 과목에 접근하려는지 확인합니다.
			
			else if(loginuser.getAuthority()==1) {
				
				// 로그인한 교수가 접근하려는게 본인 담당과목인지 확인을 한다.
				int n = service.checkLesson(paraMap);
				
				// 본인이 담당하지 않는 과목에 접근하려 한다면 마찬가지로 쫓아냅니다.
				if(n==0) {
					String message = loginuser.getName()+" 교수님의 담당과목이 아닙니다.";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
					
					dispatcher.forward(request, response);
				}
				
			}
			
			/////////////////////////////////////////////////////////////////
			// 4단계. 이제 접근하려는 과목의 정보들을 가져와줍니다. (HTML에 찍어주기 위해서 사용합니다.)
			// 과목, 부서, 멤버 테이블을 JOIN한 SQL문으로 조회를 합니다.
			// 과목 - 과목명, 수업요일, 배당학점 
			// 부서 - 강의실 위치
			// 멤버 - 교수 성명
			
			if(sessionCode != null && !"".equals(sessionCode)) {
				Map<String,String> subjectMap = service.getSubjectInfo(sessionCode);
				request.setAttribute("subjectMap", subjectMap);
			}

			/////////////////////////////////////////////////////////////////
			
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}	
	}
	////////////////////////////////////////////////////////////////////////////////////////////////////////
	

}
