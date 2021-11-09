package com.spring.univ.common;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {

	public static String getCurrentURL(HttpServletRequest request) {
		
		// *** ? 다음의 데이터까지 포함한 현재 URL 주소를 알려주는 메소드를 생성 *** //
		String currentURL = request.getRequestURL().toString();
		// 현재 URL주소가 나온다.
		
		// System.out.println("currentURL => " + currentURL);
		// currentURL => http://localhost:9090/MyMVC/member/memberList.up
		
		String queryString = request.getQueryString();
		// System.out.println("queryString => " + queryString);
		// queryString => currentShowPageNo=5&sizePerPage=5&searchType=name&searchWord=%EC%9C%A0 (GET 방식일 경우)
		// queryString => null (POST 방식일 경우)
		
		if(queryString != null) {
			currentURL += "?" + queryString;
		}
		// POST 방식일 경우 어차피 queryString은 null이니 따로 처리해줄 필요가 없다.
		// 그냥 currentURL만 리턴시키면 된다.
		
		// System.out.println("확인용 currentURL => " + currentURL);
		// 확인용 currentURL => http://localhost:9090/MyMVC/member/memberList.up?currentShowPageNo=5&sizePerPage=5&searchType=name&searchWord=%EC%9C%A0
		
		
		// /MyMVC부터 앞에는 필요가 없으니 짤라준다.
		
		String ctxPath = request.getContextPath();
		// 	   /MyMVC
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length(); 
		// /MyMVC의 인덱스 번호를 가져온다.
		// 		27 	   = 			 21				 +		6
		
		currentURL = currentURL.substring(beginIndex);
		// IP주소 + 포트번호 + 컨텍스트패스명이 짤라진 URL이 다시 들어간다.
		// /member/memberList.up?currentShowPageNo=5&sizePerPage=5&searchType=name&searchWord=%EC%9C%A0
		
		return currentURL;
	}// end of public static String getCurrentURL(HttpServletRequest request)--------------------
	
	// **** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드) 작성하기 **** // 
	   public static String secureCode(String str) {
	      
	      str = str.replaceAll("<", "&lt;");
	      str = str.replaceAll(">", "&gt;");
	      
	      return str;
	   }
	
	
	
}
