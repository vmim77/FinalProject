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
	/// 로그인 유무검사
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
	/// 로그인 유무검사 & 수강신청한 과목인지 검사
	@Pointcut("execution(public * com.spring..*Controller.subject_*(..))")
	public void subject() {}
	
	@Before("subject()")
	public void subjectCheck(JoinPoint joinPoint) {
		
		
		try {
			HttpServletRequest request = (HttpServletRequest) joinPoint.getArgs()[0]; 
			HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[1]; 
			
			HttpSession session = request.getSession();
			String sessionCode = (String) session.getAttribute("code");
			
			
			String servletPass = request.getServletPath();
			
			if(sessionCode == null || "".equals(sessionCode) || "/subject.univ".equals(servletPass)) { 
				sessionCode = request.getParameter("code"); // subject를 통해서 맨 처음 들어왔다면 sessionCode는 없다. 그러므로 subject.univ로 보내주는 sessionCode를 받아온다.
				session.setAttribute("code", request.getParameter("code"));
			}
			
			
			//////////////////////////////////////////////////////////////////
			// 1. 로그인 검사
			if(session.getAttribute("loginuser") == null) {
				String message = "길영대학교 학생만 이용할 수 있는 서비스입니다.";
				String loc = request.getContextPath() + "/MemberLogin.univ";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
				dispatcher.forward(request, response);
				return;
			}
			//////////////////////////////////////////////////////////////////
			
			//////////////////////////////////////////////////////////////////
			// 1-1. 과목코드가 정상적인지 확인한다.
			
			if(sessionCode == null || "".equals(sessionCode)) {
				sessionCode = "9999";
			}
			
			int result = service.checkCode(sessionCode);
			
			if(result==0) {
				String message = "요청하신 과목은 없는 과목입니다.";
				String loc = request.getContextPath() + "/dashboard.univ";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
				dispatcher.forward(request, response);
				
				return;
			}
			//////////////////////////////////////////////////////////////////
			
			
			/////////////////////////////////////////////////////////////////
			// 2. 수강여부 검사 - 학생
			
			
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			String hakbun = loginuser.getHakbun();
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("hakbun", hakbun);
			paraMap.put("code", sessionCode);
			
			if(loginuser.getAuthority()==0) {
				
				// 로그인한 학생이 듣는 수업인지 확인을 한다.
				int n = service.checkSugang(paraMap);
				
				if(n==0) {
					String message = "수강한 학생들만 접근할 수 있습니다.";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
					
					dispatcher.forward(request, response);
					return;
				}
				
			}
			
			////////////////////////////////////////////////////////////////
			// 2. 교수 본인이 담당하는 과목인지 검사한다.
			else if(loginuser.getAuthority()==1) {
				
				// 로그인한 교수가 접근하려는게 본인 수업인지 확인한다.
				int n = service.checkLesson(paraMap);
				
				if(n==0) {
					String message = loginuser.getName()+" 교수님의 담당과목이 아닙니다.";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
					
					dispatcher.forward(request, response);
					return;
				}
				
			}
			
			/////////////////////////////////////////////////////////////////
			// 3. 세션에 저장된 코드를 이용한 수강과목 정보조회해오기 -- 학생
			
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
