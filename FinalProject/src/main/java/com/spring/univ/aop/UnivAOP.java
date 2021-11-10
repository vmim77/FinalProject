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
	
	@Pointcut("execution(public * com.spring..*Controller.requiredLogin_*(..))")
	public void requiredLogin() {}
	
	@Before("requiredLogin()")
	public void loginCheck(JoinPoint joinPoint) {
		
		HttpServletRequest  request  = (HttpServletRequest)  joinPoint.getArgs()[0];
		HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[1]; 
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginuser") == null) {
			String message = "AMY대학교 학생만 이용할 수 있는 서비스입니다.";
			String loc = request.getContextPath() + "/MemberLogin.univ";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
			
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			
		}
		
	}
	/////////////////////////////////////////////////////////////////////////////////////////////////
	
	@Pointcut("execution(public * com.spring..*Controller.subject_*(..))")
	public void subject() {}
	
	@Before("subject()")
	public void subjectCheck(JoinPoint joinPoint) {
		
		HttpServletRequest  request  = (HttpServletRequest)  joinPoint.getArgs()[0];
		HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[1]; 
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginuser") == null) {
			String message = "AMY대학교 학생만 이용할 수 있는 서비스입니다.";
			String loc = request.getContextPath() + "/MemberLogin.univ";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
			
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			
		}
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String hakbun = loginuser.getHakbun();
		String code = request.getParameter("code");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("hakbun", hakbun);
		paraMap.put("code", code);
		
		// 로그인한 학생이 듣는 수업인지 확인을 한다.
		int n = service.checkSugang(paraMap);
		
		if(n!=1) {
			String message = "수강한 학생들만 접근할 수 있습니다.";
			String loc = request.getContextPath() + "/MemberLogin.univ";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
			
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}
			
	}
	////////////////////////////////////////////////////////////////////////////////////////////////////////
	

}
