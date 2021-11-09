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

import com.spring.univ.common.MyUtil;
import com.spring.univ.model.DepartmentVO;
import com.spring.univ.model.FreeBoardVO;
import com.spring.univ.model.FreeCommentVO;
import com.spring.univ.model.MemberVO;
import com.spring.univ.model.SubjectVO;
import com.spring.univ.service.InterGillService;

@Controller
public class GillController {
	
	@Autowired
	private InterGillService service;
	
//=========================================================================	
	// 관리자 페이지 //
	@RequestMapping(value="/adminIndex.univ", method= {RequestMethod.POST})
	public ModelAndView adminIndex(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 관리자인지 우선 확인하기
		
		// 과목 및 과목번호 가져오기
		List<DepartmentVO> deptList = service.getDeptList();	
		mav.addObject("deptList", deptList);
		// 담당교수 가져오기
		List<SubjectVO> teacherList = service.getTeacherList();
		mav.addObject("teacherList", teacherList);
		
		mav.setViewName("admin/adminIndex");
		
		return mav;
	
	}//end of public ModelAndView requiredLogin_add(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
//=========================================================================
	// === 회원목록 조회해오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/memberList.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String memberList(HttpServletRequest request){

		// 멤버 리스트 뽑아오기		
		String status = request.getParameter("status");				// 상태
		String fk_deptCode = request.getParameter("fk_deptCode");	// 학
		String searchType = request.getParameter("searchType");		// 연락처,이름,학번
		String searchWord = request.getParameter("searchWord");		// 직접검색어입력
		String authority = request.getParameter("authority");		// 신분

		// 검색어를 입력 안했다면
		if(searchWord == "") {
			searchWord = "no";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("status", status);
		paraMap.put("fk_deptCode", fk_deptCode);
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("authority", authority);

		// 학생 리스트 가져오기
		List<MemberVO> studentList = service.getStudentList(paraMap);
		
		JSONArray jsonarr = new JSONArray();
		
		if(studentList != null) {
		
			for(MemberVO mbvo : studentList) {
		
				JSONObject jsonobj = new JSONObject();

				jsonobj.put("hakbun", mbvo.getHakbun());
				jsonobj.put("name", mbvo.getName());
				jsonobj.put("birth", mbvo.getBirth());
				jsonobj.put("fk_deptCode", mbvo.getFk_deptCode());
				jsonobj.put("email", mbvo.getEmail());
				jsonobj.put("address", mbvo.getAddress());		
				jsonobj.put("status", mbvo.getStatus());
				jsonobj.put("picture", mbvo.getPicture());
				jsonobj.put("phone", mbvo.getPhone());
				jsonobj.put("authority", mbvo.getAuthority());
	
				jsonarr.put(jsonobj);
			}
		}
		
		return jsonarr.toString();
				
	}//end of public String readComment(HttpServletRequest request){-------
//=========================================================================
	// === 과목목록 조회해오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/subjectList.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String subjectList(HttpServletRequest request){

		// 멤버 리스트 뽑아오기		
		String classDate = request.getParameter("classDate");		// 요일명
		String fk_deptCode = request.getParameter("fk_deptCode");	// 학
		String searchType = request.getParameter("searchType");		// 연락처,이름,학번
		String searchWord = request.getParameter("searchWord");		// 직접검색어입력

		// 검색어를 입력 안했다면
		if(searchWord == "") {
			searchWord = "no";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("classDate", classDate);
		paraMap.put("fk_deptCode", fk_deptCode);
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);

		// 학생 리스트 가져오기
		List<SubjectVO> subjectList = service.getSubjectList(paraMap);
		
		JSONArray jsonarr = new JSONArray();
		
		if(subjectList != null) {
		
			for(SubjectVO sbvo : subjectList) {
		
				JSONObject jsonobj = new JSONObject();

				jsonobj.put("subject", sbvo.getSubject());
				jsonobj.put("teacher", sbvo.getTeacher());
				jsonobj.put("fk_deptCode", sbvo.getFk_deptCode());
				jsonobj.put("hakjum", sbvo.getHakjum());
				jsonobj.put("classDate", sbvo.getClassDate());		
	
				jsonarr.put(jsonobj);
			}
		}
		
		return jsonarr.toString();
				
	}//end of public String readComment(HttpServletRequest request){-------
//=========================================================================
	// === 회원목록 입력하기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/updateMember.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String updateMember(HttpServletRequest request){

		// 상태
		String hakbun = request.getParameter("hakbun");
		String fk_deptCode = request.getParameter("fk_deptCode");	
		String name = request.getParameter("name");	// 학번
		String authority = request.getParameter("authority");		
		String non = "필수입력";
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("hakbun", hakbun);
		paraMap.put("fk_deptCode", fk_deptCode);
		paraMap.put("name", name);
		paraMap.put("authority", authority);
		paraMap.put("non", non);

		// 새로운 회원 입력하기
		int n = service.UpdateMember(paraMap);
				
		JSONObject jsonobj = new JSONObject();

		jsonobj.put("n", n);

		return jsonobj.toString();
				
	}//end of public String readComment(HttpServletRequest request){-------
//=========================================================================	
	// === 학번 중복여부 조회해오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/selecthakbun.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String selecthakbun(HttpServletRequest request){

		// 멤버 리스트 뽑아오기		
		String hakbun = request.getParameter("hakbun");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("hakbun", hakbun);

		// 학번 중복여부 가져오기
		String checkHakbun = service.getcheckHakbun(paraMap);
		
		JSONObject jsonobj = new JSONObject();

		if(checkHakbun == null) {
			jsonobj.put("checkHakbun", "can");
		}
		else {
			jsonobj.put("checkHakbun", "cannot");
		}
	
		return jsonobj.toString();
				
	}//end of public String readComment(HttpServletRequest request){-------
//=========================================================================	
	// === 전공 입력하기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/updateSubject.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String updateSubject(HttpServletRequest request){

		// 상태
		String code = request.getParameter("code");
		String subject = request.getParameter("subject");	
		String fk_deptCode = request.getParameter("fk_deptCode");	
		String teacher = request.getParameter("teacher");		
		String hakjum = request.getParameter("hakjum");	
		String classDate = request.getParameter("classDate");	

		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("code", code);
		paraMap.put("subject", subject);
		paraMap.put("fk_deptCode", fk_deptCode);
		paraMap.put("teacher", teacher);
		paraMap.put("hakjum", hakjum);
		paraMap.put("classDate", classDate);

		// 새로운 전공 입력하기
		int n = service.UpdateSubject(paraMap);
				
		JSONObject jsonobj = new JSONObject();

		jsonobj.put("n", n);

		return jsonobj.toString();
				
	}//end of public String readComment(HttpServletRequest request){-------
//=========================================================================	
	// === 학과코드 중복여부 조회해오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/selectcode.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String selectcode(HttpServletRequest request){

		// 멤버 리스트 뽑아오기		
		String code = request.getParameter("code");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("code", code);

		// 학과코드 중복여부 가져오기
		String checkCode = service.getcheckCode(paraMap);
		
		JSONObject jsonobj = new JSONObject();

		if(checkCode == null) {
			jsonobj.put("checkCode", "can");
		}
		else {
			jsonobj.put("checkCode", "cannot");
		}
	
		return jsonobj.toString();
				
	}//end of public String readComment(HttpServletRequest request){-------
//=========================================================================	
	// === 학과명 중복여부 조회해오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/selectsubject.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String selectsubject(HttpServletRequest request){

		// 멤버 리스트 뽑아오기		
		String subject = request.getParameter("subject");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("subject", subject);

		// 과목명 중복여부 가져오기
		String checkSubject = service.getcheckSubject(paraMap);
		
		JSONObject jsonobj = new JSONObject();

		if(checkSubject == null) {
			jsonobj.put("checkSubject", "can");
		}
		else {
			jsonobj.put("checkSubject", "cannot");
		}
	
		return jsonobj.toString();
				
	}//end of public String readComment(HttpServletRequest request){-------
//=========================================================================
	
	
	
	
	
	
}	
