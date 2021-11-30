package com.spring.univ.controller;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import com.google.gson.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.*;
import org.json.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import com.spring.univ.common.FileManager;
import com.spring.univ.model.*;
import com.spring.univ.service.InterGillService;

@Controller
public class GillController {
//=========================================================================
	@Autowired
	private InterGillService service;
	@Autowired
	private FileManager fileManager;
//=========================================================================	
	// 관리자 페이지 //
	@RequestMapping(value="/adminIndex.univ", method= {RequestMethod.GET})
	public ModelAndView adminIndex(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 관리자인지 우선 확인하기 
		HttpSession session = request.getSession(); 
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null && "0000001".equals(loginuser.getHakbun())) {
			
			// 학과 및 학과번호 가져오기
			List<DepartmentVO> deptList = service.getDeptList();	
			mav.addObject("deptList", deptList);
			mav.setViewName("admin/adminIndex");
			
		}
		else {
			
			mav.addObject("loc", request.getContextPath()+"/MemberLogin.univ");
			mav.addObject("message", "관리자 이외에 접근 불가합니다");
			mav.setViewName("msg");
			
		}
		
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
				
	}//end of public String memberList(HttpServletRequest request){----------------------------
//=============================================================================================	  
	// === 과목목록 조회해오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것 
	@RequestMapping(value="/subjectList.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String subjectList(HttpServletRequest request){

		// 멤버 리스트 뽑아오기       
		String classDate = request.getParameter("classDate");      // 요일명  
		String fk_deptCode = request.getParameter("fk_deptCode");  // 학    
		String searchType = request.getParameter("searchType");    // 연락처,이름,학번
		String searchWord = request.getParameter("searchWord");    // 직접검색어입력
    
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
				jsonobj.put("fk_hakbun", sbvo.getFk_hakbun());
				jsonobj.put("fk_deptCode", sbvo.getFk_deptCode());          
				jsonobj.put("hakjum", sbvo.getHakjum());
				jsonobj.put("code", sbvo.getCode());
				
				if("1".equals(sbvo.getClassDate())) {
					jsonobj.put("classDate", "월");
				}
				if("2".equals(sbvo.getClassDate())) {
					jsonobj.put("classDate", "화");
				}
				if("3".equals(sbvo.getClassDate())) {
					jsonobj.put("classDate", "수");
				}
				if("4".equals(sbvo.getClassDate())) {
					jsonobj.put("classDate", "목");
				}
				if("5".equals(sbvo.getClassDate())) {
					jsonobj.put("classDate", "금");
				}
			
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
		String name = request.getParameter("name");	
		String authority = request.getParameter("authority");
		String email = request.getParameter("email");
		String non = "필수입력";
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("hakbun", hakbun);
		paraMap.put("fk_deptCode", fk_deptCode);
		paraMap.put("name", name);
		paraMap.put("authority", authority);
		paraMap.put("email", email);
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

		int n = 0;
		
		// 상태
		String code = request.getParameter("code");
		String subject = request.getParameter("subject");	
		String fk_deptCode = request.getParameter("fk_deptCode");	
		String fk_hakbun = request.getParameter("fk_hakbun");		
		String hakjum = request.getParameter("hakjum");	
		String classDate = request.getParameter("classDate");
		
		// 단순 입력용인지 업데이트 용인지 확인
		String checkUpdate = request.getParameter("checkUpdate");

		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("code", code);
		paraMap.put("subject", subject);
		paraMap.put("fk_deptCode", fk_deptCode);
		paraMap.put("fk_hakbun", fk_hakbun);
		paraMap.put("hakjum", hakjum);
		paraMap.put("classDate", classDate);

		if("update".equals(checkUpdate)) {
			// 전공 수정 전 먼저 지워주기
			service.DeleteSubject(paraMap);
			
			n = 2;
		}
		
		// 새로운 전공 입력하기
		n = service.UpdateSubject(paraMap);
				
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
	// === 교수님목록 조회해오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/TeacherList.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String TeacherList(HttpServletRequest request){

		String deptCode = request.getParameter("deptCode");

		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("deptCode", deptCode);

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
//=========================================================================
	// === 회원목록 입력하기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/updateStatus.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String updateStatus(HttpServletRequest request){

		String hakbun = request.getParameter("hakbun");
		String status = request.getParameter("status");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("hakbun", hakbun);
		paraMap.put("status", status);

		// 상태 수정하기
		int n = service.UpdateStatus(paraMap);
				
		JSONObject jsonobj = new JSONObject();

		jsonobj.put("n", n);

		return jsonobj.toString();
				
	}//end of public String readComment(HttpServletRequest request){-------
//=========================================================================	
	// === 교수님 스케줄 조회해오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/TeacherScheduleList.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String TeacherScheduleList(HttpServletRequest request){

		String fk_hakbun = request.getParameter("fk_hakbun");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("fk_hakbun", fk_hakbun);

		// 교수님 스케줄 조회해오기
		List<SubjectVO> teacherScheduleList = service.getTeacherScheduleList(paraMap);
		
		JSONArray jsonarr = new JSONArray();
		
		if(teacherScheduleList != null) {
		
			for(SubjectVO svo : teacherScheduleList) {
		
				JSONObject jsonobj = new JSONObject();

				jsonobj.put("classDate", svo.getClassDate()); 
				jsonobj.put("subject", svo.getSubject()); 	
	
				jsonarr.put(jsonobj);
			}
		}
		
		return jsonarr.toString();
				
	}//end of public String TeacherList(HttpServletRequest request){------
//=========================================================================
	// === 과 선택시 수강 미신청 인원 알아오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/sugangNoMember.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String sugangNoMember(HttpServletRequest request){

		String fk_deptCode = request.getParameter("fk_deptCode");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("fk_deptCode", fk_deptCode);

		// 과 선택시 수강 미신청 인원 알아오기
		List<Map<String, String>> sugangNoMemberList = service.getsugangNoMemberList(paraMap);
		
		JSONArray jsonarr = new JSONArray();
		
		if(sugangNoMemberList != null) {
		
			for(Map<String, String> noSugangMap : sugangNoMemberList) {
		
				JSONObject jsonobj = new JSONObject();

				jsonobj.put("name", noSugangMap.get("name")); 
				jsonobj.put("hakbun", noSugangMap.get("hakbun")); 	
	
				jsonarr.put(jsonobj);
			}
		}
		
		return jsonarr.toString();
				
	}//end of public String TeacherList(HttpServletRequest request){------
//=========================================================================	
	// === 과 선택시 수강 신청 인원 알아오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/sugangYesMember.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String sugangYesMember(HttpServletRequest request){

		String fk_deptCode = request.getParameter("fk_deptCode");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("fk_deptCode", fk_deptCode);

		// 과 선택시 수강 신청 인원 알아오기
		List<Map<String, String>> sugangYesMemberList = service.getsugangYesMemberList(paraMap);
		
		JSONArray jsonarr = new JSONArray();
		
		if(sugangYesMemberList != null) {
		
			for(Map<String, String> yesSugangMap : sugangYesMemberList) {
		
				JSONObject jsonobj = new JSONObject();

				jsonobj.put("name", yesSugangMap.get("name")); 
				jsonobj.put("hakbun", yesSugangMap.get("hakbun")); 	
	
				jsonarr.put(jsonobj);
			}
		}
		
		return jsonarr.toString();
				
	}//end of public String TeacherList(HttpServletRequest request){------	
//=========================================================================	
	// === 과 선택시 해당과 시간표 알아오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/sugangSubject.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String sugangSubject(HttpServletRequest request){

		String fk_deptCode = request.getParameter("fk_deptCode");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("fk_deptCode", fk_deptCode);

		// 과 선택시 해당과 시간표 알아오기
		List<SubjectVO> sugangSubjectList = service.getsugangSubjectList(paraMap);
		
		JSONArray jsonarr = new JSONArray();
		
		if(sugangSubjectList != null) {
		
			for(SubjectVO svo : sugangSubjectList) {
		
				JSONObject jsonobj = new JSONObject();

				jsonobj.put("code", svo.getCode()); 
				jsonobj.put("subject", svo.getSubject());
				jsonobj.put("classDate", svo.getClassDate());
	
				jsonarr.put(jsonobj);
			}
		}
		
		return jsonarr.toString();
				
	}//end of public String TeacherList(HttpServletRequest request){------	
//=========================================================================
	// === 과목선택시 해당과목 수업요일 (Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/subjectClassDate.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String subjectClassDate(HttpServletRequest request){

		String code = request.getParameter("code");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("code", code);

		// 수업 선택시 해당 요일 알아오기
		String classDate = service.getsubjectClassDate(paraMap);

		JSONObject jsonobj = new JSONObject();

		jsonobj.put("classDate", classDate); 

		return jsonobj.toString();
				
	}//end of public String TeacherList(HttpServletRequest request){------	
//=========================================================================	
	// === 전공신청 안한 학생한명 알아오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/searchNoMember.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String searchNoMember(HttpServletRequest request){

		String hakbun = request.getParameter("hakbun");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("hakbun", hakbun);

		// 전공신청 안한 학생한명 알아오기
		List<MemberVO> searchNoMemberList = service.getsearchNoMemberList(paraMap);
		
		JSONArray jsonarr = new JSONArray();
		
		if(searchNoMemberList != null) {
		
			for(MemberVO mvo: searchNoMemberList) {
		
				JSONObject jsonobj = new JSONObject();

				jsonobj.put("hakbun", mvo.getHakbun()); 
				jsonobj.put("name", mvo.getName());

				jsonarr.put(jsonobj);
			}
		}
		
		return jsonarr.toString();
				
	}//end of public String TeacherList(HttpServletRequest request){------	
//=========================================================================
	// === 수강신청 저장(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/saveSugang.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String saveSugang(HttpServletRequest request){

		Map<String, String> paraMap = new HashMap<>();
		
		// 받아온 값
		String hakbun = request.getParameter("hakbun");
		String code = request.getParameter("code");

		// 자르기
		String[] hakbunArr = hakbun.split(",");
		String[] codeArr = code.split(",");
		
		// 배열의 길이
		int hakbunArrLength = hakbunArr.length;
		int codeArrLength = codeArr.length;
		
		// 학번당 과목 전부 업데이트 하기
		for(int i=0; i<hakbunArrLength; i++) {
			
			for(int j=0; j<codeArrLength; j++) {
				
				paraMap.put("hakbun", hakbunArr[i]);
				paraMap.put("code", codeArr[j]);	

				// 수강신청 저장
				service.SaveSugang(paraMap);
			}
			
		}
		
		JSONObject jsonobj = new JSONObject();

		jsonobj.put("n", hakbunArrLength);

		return jsonobj.toString();
				
	}//end of public String saveSugang(HttpServletRequest request){--------
//=========================================================================
// === 전공신청 한 학생한명 알아오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/SelectSugangMember.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String SelectSugangMember(HttpServletRequest request){

		String hakbun = request.getParameter("hakbun");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("hakbun", hakbun);

		// 전공신청 한 학생한명 알아오기
		List<Map<String, String>> selectSugangMemberList = service.getselectSugangMemberList(paraMap);
		
		JSONArray jsonarr = new JSONArray();
		
		if(selectSugangMemberList != null) {
		
			for(Map<String, String> SelectSugangMemberMap : selectSugangMemberList) {
		
				JSONObject jsonobj = new JSONObject();

				jsonobj.put("hakbun", SelectSugangMemberMap.get("fk_hakbun")); 
				jsonobj.put("name", SelectSugangMemberMap.get("name"));		
				jsonobj.put("code", SelectSugangMemberMap.get("code"));
				jsonobj.put("subject", SelectSugangMemberMap.get("subject"));
				jsonobj.put("classDate", SelectSugangMemberMap.get("classDate"));

				jsonarr.put(jsonobj);
			}
		}
		
		return jsonarr.toString();
				
	}//end of public String SelectSugangMember(HttpServletRequest request){
//=========================================================================
	// === 수강하지 않는 과목 가져와서 값 넣어주기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/sugangNoSubject.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String sugangNoSubject(HttpServletRequest request){

		String hakbun = request.getParameter("hakbun");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("hakbun", hakbun);

		// 수강하지 않는 과목 가져와서 값 넣어주기
		List<Map<String, String>> sugangNoSubjectList = service.getsugangNoSubjectList(paraMap);
		
		JSONArray jsonarr = new JSONArray();
		
		if(sugangNoSubjectList != null) {
		
			for(Map<String, String> sugangNoSubjectMap : sugangNoSubjectList) {
		
				JSONObject jsonobj = new JSONObject();

				jsonobj.put("code", sugangNoSubjectMap.get("code")); 
				jsonobj.put("subject", sugangNoSubjectMap.get("subject"));
				jsonobj.put("classDate", sugangNoSubjectMap.get("classDate"));
	
				jsonarr.put(jsonobj);
			}
		}
		
		return jsonarr.toString();
				
	}//end of public String TeacherList(HttpServletRequest request){------	
//=========================================================================
	// === 수강정보변경 저장(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/UpdateSugang.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String UpdateSugang(HttpServletRequest request){

		Map<String, String> paraMap = new HashMap<>();
		
		// 받아온 값
		String hakbun = request.getParameter("hakbun");
		String code = request.getParameter("code");

		// 자르기
		String[] codeArr = code.split(",");
		
		// 배열의 길이
		int codeArrLength = codeArr.length;

		int	n = service.DeleteSugang(hakbun);
		int m = 0; // 몇개의 과목이 입력되는지
		
		if(!"".equals(code)) {
		
			// 삭제된 내용이 있다면
			if(n > 0) {
					
				for(int i=0; i<codeArrLength; i++) {
					
					paraMap.put("hakbun", hakbun);
					paraMap.put("code", codeArr[i]);	
	
					// 수강신청 저장
					service.SaveSugang(paraMap);
					m++;
				
				}//end of for(int i=0; i<codeArrLength; i++) {-------------
				
			}//end of if(n > 0) {------------------------------------------
		
		}//end of if(!"".equals(code)) {-----------------------------------
		
		JSONObject jsonobj = new JSONObject();

		jsonobj.put("m", m);

		return jsonobj.toString();
				
	}//end of public String saveSugang(HttpServletRequest request){--------
//=========================================================================
	// 차트분석 페이지 //
	@RequestMapping(value="/adminChart.univ", method= {RequestMethod.POST})
	public ModelAndView adminChart(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession(); 
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null && "0000001".equals(loginuser.getHakbun())) {
		
			// 학과 및 학과번호 가져오기
			List<DepartmentVO> deptList = service.getDeptList();	
			mav.addObject("deptList", deptList);
			
			// 설문 가져오기
			List<ServeyVO> serveyList = service.getServeyList();
			mav.addObject("serveyList", serveyList);
		
			mav.setViewName("admin/adminChart");
			
		}
		else {
			
			mav.addObject("loc", request.getContextPath()+"/MemberLogin.univ");
			mav.addObject("message", "관리자 이외에 접근 불가합니다");
			mav.setViewName("msg");
			
		}
		
		return mav;
	
	}//end of public ModelAndView requiredLogin_add(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
//=========================================================================
	// === 교수 담당수업 가져오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/serveySubject.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String serveySubject(HttpServletRequest request){

		String fk_hakbun = request.getParameter("fk_hakbun");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("fk_hakbun", fk_hakbun);

		// 교수 담당수업 가져오기
		List<SubjectVO> serveySubjectList = service.getserveySubject(paraMap);
		
		JSONArray jsonarr = new JSONArray();
		
		if(serveySubjectList != null) {
		
			for(SubjectVO svo : serveySubjectList) {
		
				JSONObject jsonobj = new JSONObject();

				jsonobj.put("subject", svo.getSubject()); 
				jsonobj.put("code", svo.getCode());
	
				jsonarr.put(jsonobj);
			}
		}
		
		return jsonarr.toString();
				
	}//end of public String TeacherList(HttpServletRequest request){------	
//=========================================================================	
	// === 문항 별 차트분석(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/checkNum.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String checkNum(HttpServletRequest request){
		
		// 받아온 값
		String serveyNum = request.getParameter("serveyNum");
		String fk_serveyCode = request.getParameter("fk_serveyCode");
		// 자르기
		String[] serveyNumArr = serveyNum.split(",");
		// 배열의 길이
		int length = serveyNumArr.length;
		// 값 저장용
		String CheckNum = "";
		
		for(int i=1; i<=5; i++) {
			
			for(int j=0; j<length; j++) {
				
				Map<String, String> map = new HashMap<>();
				
				map.put("serveyNum", serveyNumArr[j]);
				map.put("CheckNum", i+"");
				map.put("fk_serveyCode", fk_serveyCode);
				
				// 각 문제 별 체크한 문항번호 가져오기
				CheckNum += service.getCheckNum(map) + ",";
				
			}//end of for(int j=0; j<length; j++) {------------------------
			
		}//end of for(int i=1; i<=5; i++) {--------------------------------
		
		// 선택번호
		String[] checkoneArr = CheckNum.substring(length*0,length*2).split(",");
		String[] checktwoArr = CheckNum.substring(length*2,length*4).split(",");
		String[] checkthreeArr = CheckNum.substring(length*4,length*6).split(",");
		String[] checkfourArr = CheckNum.substring(length*6,length*8).split(",");
		String[] checkfiveArr = CheckNum.substring(length*8,CheckNum.length()).split(",");
		
		int checkone = 0;
		int checktwo = 0;
		int checkthree = 0;
		int checkfour = 0;
		int checkfive = 0;
		
		// 번호당 총 갯수
		for(int i=0; i<length; i++) {
			checkone += Integer.parseInt(checkoneArr[i]);
			checktwo += Integer.parseInt(checktwoArr[i]);
			checkthree += Integer.parseInt(checkthreeArr[i]);
			checkfour += Integer.parseInt(checkfourArr[i]);
			checkfive += Integer.parseInt(checkfiveArr[i]);
		}
		
		int all = checkone + checktwo + checkthree + checkfour + checkfive;
		
		int result1 = Math.round(100*checkone/all);
		int result2 = Math.round(100*checktwo/all);
		int result3 = Math.round(100*checkthree/all);
		int result4 = Math.round(100*checkfour/all);
		int result5 = Math.round(100*checkfive/all);

		Gson gson = new Gson();
		
		JsonObject jsonObj = new JsonObject();

		jsonObj.addProperty("result1", result1);
		jsonObj.addProperty("result2", result2);
		jsonObj.addProperty("result3", result3);
		jsonObj.addProperty("result4", result4);
		jsonObj.addProperty("result5", result5);

		return gson.toJson(jsonObj);
				
	}//end of public String saveSugang(HttpServletRequest request){--------
//=========================================================================	
	// === 평가문항 가져오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/pyungga.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String pyungga(HttpServletRequest request){

		String fk_serveyCode = request.getParameter("fk_serveyCode");
		String serveyNum = request.getParameter("serveyNum");
		
		String[] serveyNumArr = serveyNum.split(",");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("fk_serveyCode", fk_serveyCode);

		// 평가문항 가져오기
		List<Map<String, String>> pyunggaList = service.getPyungga(paraMap);
		
		JSONArray jsonarr = new JSONArray();
		
		if(pyunggaList != null) {
		
			for(Map<String, String> map : pyunggaList) {
		
				for(int i=0; i<serveyNumArr.length; i++) {
				
					if(map.get("serveyNum").equals(serveyNumArr[i])) {
						
						JSONObject jsonobj = new JSONObject();
						
						jsonobj.put("subject", map.get("subject")); 
						jsonobj.put("name", map.get("name"));
						jsonobj.put("serveyContent", map.get("serveyContent"));
						jsonobj.put("serveyNum", serveyNumArr[i]);
						jsonobj.put("checkone", map.get("checkone"));
						jsonobj.put("checktwo", map.get("checktwo"));
						jsonobj.put("checkthree", map.get("checkthree"));
						jsonobj.put("checkfour", map.get("checkfour"));
						jsonobj.put("checkfive", map.get("checkfive"));
						
						jsonarr.put(jsonobj);
						
						break;
						
					}//end of if(map.get("serveyNum").equals(serveyNumArr[i])) {--------
					
				}//end of for(int i=0; i<serveyNumArr.length; i++) {--------------------
				
			}//end of for(Map<String, String> map : pyunggaList) {----------------------
			
		}//end of if(pyunggaList != null) {---------------------------------------------
		
		return jsonarr.toString();
				
	}//end of public String TeacherList(HttpServletRequest request){------	
//=========================================================================	
	// >>> #191. Excel 파일로 다운받기 예제 <<< //
	@RequestMapping(value="/excel/downloadExcelFile.univ", method= {RequestMethod.POST})
	public String downloadExcelFile(HttpServletRequest request, Model model) {
														
		String fk_serveyCode = request.getParameter("fk_serveyCode");
		String serveyNum = request.getParameter("serveyNum");
		
		String[] serveyNumArr = serveyNum.split(",");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("fk_serveyCode", fk_serveyCode);

		// 평가문항 가져오기
		List<Map<String, String>> pyunggaList = service.getPyungga(paraMap);
      
		SXSSFWorkbook workbook = new SXSSFWorkbook();
      
		// 시트생성
		SXSSFSheet sheet = workbook.createSheet("강의평가 분석자료");
      
		// 시트 열 너비 설정
		sheet.setColumnWidth(0, 18000);
		sheet.setColumnWidth(1, 2500);
		sheet.setColumnWidth(2, 2500);
		sheet.setColumnWidth(3, 2500);
		sheet.setColumnWidth(4, 2500);
		sheet.setColumnWidth(5, 2500);
      
		// 행의 위치를 나타내는 변수
		int rowLocation = 0;

		CellStyle mergeRowStyle = workbook.createCellStyle();
		mergeRowStyle.setAlignment(HorizontalAlignment.CENTER);
		mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER);
                                      // import org.apache.poi.ss.usermodel.VerticalAlignment 으로 해야함.
		CellStyle headerStyle = workbook.createCellStyle();
		headerStyle.setAlignment(HorizontalAlignment.CENTER);
		headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);

		mergeRowStyle.setFillForegroundColor(IndexedColors.AQUA.getIndex());  
		mergeRowStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
      
		headerStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex()); 
		headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);   
      
		Font mergeRowFont = workbook.createFont(); 
		mergeRowFont.setFontName("나눔고딕");
		mergeRowFont.setFontHeight((short)500);
		mergeRowFont.setColor(IndexedColors.WHITE.getIndex());
		mergeRowFont.setBold(true);
      
		mergeRowStyle.setFont(mergeRowFont);

		headerStyle.setBorderTop(BorderStyle.THIN);
		headerStyle.setBorderBottom(BorderStyle.THIN);
		headerStyle.setBorderLeft(BorderStyle.THIN);
		headerStyle.setBorderRight(BorderStyle.THIN);
        
		// 병합할 행 만들기
		Row mergeRow = sheet.createRow(rowLocation); 
		
		for(int i=0; i<6; i++) {
			
			Cell cell = mergeRow.createCell(i);
			cell.setCellStyle(mergeRowStyle);
			cell.setCellValue("강의평가 결과");
			
		}//end of for(int i=0; i<8; i++) {------------------------------------------------------------
		
		// 셀 병합하기
		sheet.addMergedRegion(new CellRangeAddress(rowLocation, rowLocation, 0, 5));
		
        ////////////////////////////////////////////////////////////////////////////////////////////////
		
        // 헤더 행 생성
        Row headerRow = sheet.createRow(++rowLocation);
        
        // 해당 행의 1번쩨 열 셀 생성
        Cell headerCell = headerRow.createCell(0); // 엑셀에서 열의 시작은 0부터 시작한다. 
        headerCell.setCellValue("평가문항");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 2번쩨 열 셀 생성
        headerCell =headerRow.createCell(1);
        headerCell.setCellValue("매우만족");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 3번쩨 열 셀 생성
        headerCell =headerRow.createCell(2);
        headerCell.setCellValue("만족");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 4번쩨 열 셀 생성
        headerCell =headerRow.createCell(3);
        headerCell.setCellValue("보통");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 5번쩨 열 셀 생성
        headerCell =headerRow.createCell(4);
        headerCell.setCellValue("불만족");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 6번쩨 열 셀 생성
        headerCell =headerRow.createCell(5);
        headerCell.setCellValue("매우불만족");
        headerCell.setCellStyle(headerStyle);
        
        // === 내용에 해당하는 행 및 셀 생성하기 === //
        Row bodyRow = null;
        Cell bodyCell = null;
        
        int cnt = 0;
        
        for(Map<String, String> map : pyunggaList) {
    		
			for(int i=0; i<serveyNumArr.length; i++) {
			
				if(map.get("serveyNum").equals(serveyNumArr[i])) {
					
					// 행 생성
		        	bodyRow = sheet.createRow(cnt + (rowLocation+1));
		        	
		        	// 평가문항
		        	bodyCell = bodyRow.createCell(0);
		        	bodyCell.setCellValue(map.get("serveyContent"));
		        	
		        	// 매우만족
		        	bodyCell = bodyRow.createCell(1);
		        	bodyCell.setCellValue(map.get("checkone"));
		        	
		        	// 만족
		        	bodyCell = bodyRow.createCell(2);
		        	bodyCell.setCellValue(map.get("checktwo"));
		        	
		        	// 보통
		        	bodyCell = bodyRow.createCell(3);
		        	bodyCell.setCellValue(map.get("checkthree"));
		        	
		        	// 불만족
		        	bodyCell = bodyRow.createCell(4);
		        	bodyCell.setCellValue(map.get("checkfour"));
		        	
		        	// 매우불만족
		        	bodyCell = bodyRow.createCell(5);
		        	bodyCell.setCellValue(map.get("checkfive"));
					
					cnt++;
					
					break;
					
				}//end of if(map.get("serveyNum").equals(serveyNumArr[i])) {--------
				
			}//end of for(int i=0; i<serveyNumArr.length; i++) {--------------------
			
		}//end of for(Map<String, String> map : pyunggaList) {----------------------
        
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "강의평가 엑셀자료");
   
		return "excelDownloadView";
   
	}//end of public String downloadExcelFile(HttpServletRequest request) {---------------------------
//====================================================================================================	
	// === 설문결과 가져오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/sulmoonMoonhang.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String sulmoonMoonhang(HttpServletRequest request){

		String fk_serveyCode = request.getParameter("fk_serveyCode");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("fk_serveyCode", fk_serveyCode);

		// 설문 문항 가져오기
		List<ServeyDetailVO> sulmoonMoonhangList = service.getSulmoonMoonhangList(paraMap);
		
		JSONArray jsonarr = new JSONArray();
		
		// 아코디언 아이디용
		int cnt = 97;
		
		if(sulmoonMoonhangList != null) {
		
			for(ServeyDetailVO sdvo: sulmoonMoonhangList) {
		
				JSONObject jsonobj = new JSONObject();

				jsonobj.put("serveyContent", sdvo.getServeyContent()); 
				jsonobj.put("serveyNum", sdvo.getServeyNum());
				jsonobj.put("serveyCode", sdvo.getFk_serveyCode());

				jsonobj.put("firstID", (char)cnt);
				jsonobj.put("secondID", (char)cnt + "" + (char)cnt);
			
				cnt++;
				
				jsonarr.put(jsonobj);
			}
		}
		
		return jsonarr.toString();
		
	}//end of public String TeacherList(HttpServletRequest request){-------	
//=========================================================================	
	// === 설문분석대상 가져오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/boonsuk.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String boonsuk(HttpServletRequest request){

		// 설문 분석대상 문항
		String serveyNum = request.getParameter("serveyNum");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("serveyNum", serveyNum);
		paraMap.put("fk_serveycode", "0001");

		// 설문 분석대상 문항가져오기
		List<ServeyResultVO> boonsukList = service.getBoonsukList(paraMap);
		
		Gson gson = new Gson();

		JsonArray jsonArr = new JsonArray();
		
		if(boonsukList != null) {
		
			for(ServeyResultVO srvo: boonsukList) {
		
				JsonObject jsonObj = new JsonObject();

				jsonObj.addProperty("boonsuk", srvo.getServeyCheckNum());

				jsonArr.add(jsonObj);
			}
		}
		
		return gson.toJson(jsonArr);
		
	}//end of public String TeacherList(HttpServletRequest request){-------	
//=========================================================================	
	// === 설문분석결과 가져오기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/boonsukChart.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String boonsukChart(HttpServletRequest request){

		// 설문 분석대상 문항
		String serveyNum = request.getParameter("serveyNum");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("serveyNum", serveyNum);
		paraMap.put("fk_serveycode", "0001");

		// 설문 분석대상 문항가져오기
		List<ServeyResultVO> boonsukList = service.getBoonsukList(paraMap);
		
		////////////////////////////////////////////////////////////////////////////
		
		String boonsuk = "";
		
		// 담아주기
		for(ServeyResultVO srvo: boonsukList) {
			boonsuk += srvo.getServeyCheckNum() + ",";
		}

		// 설문 분석대상 문항
		String[] boonsukArr = boonsuk.substring(0, boonsuk.lastIndexOf(",")).split(",");
		
		// 설문 분석 기준
		String gijoon = request.getParameter("gijoon");
		String[] gijoonArr = gijoon.split(",");

		// 결과값
		String boonsukChart = "";
		
		for(int i=0; i<gijoonArr.length; i++) {
			
			for(int j=0; j<boonsukArr.length; j++) {
				
				Map<String, String> map = new HashMap<>();
				
				map.put("gijoon", gijoonArr[i]);
				map.put("boonsuk", boonsukArr[j]);
				
				// 총 몇개인지 설문분석 결과값 가져오기
				boonsukChart += service.getResult(map) + ",";
				
			}//end of for(int j=0; j<boonsukArr.length; j++) {-------------------
			
			boonsukChart += "/";
			
		}//end of for(int i=0; i<gijoonArr.length; i++) {------------------------

		// 총 결과값
		boonsukChart = boonsukChart.replaceAll(",/", "/");
		boonsukChart = boonsukChart.substring(0, boonsukChart.lastIndexOf("/"));

		String[] boonsukChartArr = boonsukChart.split("/");

		Gson gson = new Gson();

		JsonArray jsonArr = new JsonArray();
		
		// 총 결과값 넣어주기
		for(int i=0; i<boonsukChartArr.length; i++) {
			
			JsonObject jsonObj = new JsonObject();

			jsonObj.addProperty("gijoon", gijoonArr[i].trim());
			jsonObj.addProperty("boonsuk", boonsukChartArr[i].trim());
			
			jsonArr.add(jsonObj);
			
		}
		
		return gson.toJson(jsonArr);
		
	}//end of public String TeacherList(HttpServletRequest request){-------	
//=========================================================================		
	// 관리자 쪽지 페이지 //
	@RequestMapping(value="/adminJjokji.univ", method= {RequestMethod.POST})
	public ModelAndView adminJjokji(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 관리자인지 우선 확인하기 
		HttpSession session = request.getSession(); 
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null && "0000001".equals(loginuser.getHakbun())) {
		
			String receive_hakbun= request.getParameter("go_receive_hakbun");
	
			if(receive_hakbun == null) {
				receive_hakbun = "";
				
			}
			
			Map<String, String> map = new HashMap<>();
			map.put("hakbun", "0000001");
			map.put("receive_hakbun", receive_hakbun);
	
			// 쪽지 발신함 가져오기
			List<Map<String, String>> senderList = service.getSenderList(map);
			mav.addObject("senderList", senderList);
			
			////////////////////////////////////////////////////////////////////
			
			String sender_hakbun= request.getParameter("go_sender_hakbun");
	
			if(sender_hakbun == null) {
				sender_hakbun = "";
				
			}
			
			Map<String, String> map1 = new HashMap<>();
			map1.put("hakbun", "0000001");
			map1.put("sender_hakbun", sender_hakbun);
			
			// 쪽지 수신함 가져오기
			List<Map<String, String>> receiveList = service.getReceiveList(map1);
			mav.addObject("receiveList", receiveList);
			
			////////////////////////////////////////////////////////////////////
			
			// 연락처 가져오기
			List<Map<String, String>> contactList = service.getContactList();
			mav.addObject("contactList", contactList);
			
			// 학과 및 학과번호 가져오기
			List<DepartmentVO> deptList = service.getDeptList();	
			mav.addObject("deptList", deptList);
			
			////////////////////////////////////////////////////////////////////
			
			String star_hakbun= request.getParameter("go_star_hakbun");
	
			if(star_hakbun == null) {
				star_hakbun = "";
				
			}
			
			Map<String, String> map2 = new HashMap<>();
			map2.put("hakbun", "0000001");
			map2.put("star_hakbun", star_hakbun);
			
			// 즐겨찾기 목록 가져오기
			List<Map<String, String>> starList = service.getStarList(map2);	
			mav.addObject("starList", starList);
			
			mav.setViewName("admin/adminJjokji");
		
		}
		else {
			
			mav.addObject("loc", request.getContextPath()+"/MemberLogin.univ");
			mav.addObject("message", "관리자 이외에 접근 불가합니다");
			mav.setViewName("msg");
			
		}
		
		return mav;
	
	}//end of public ModelAndView requiredLogin_add(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
//=========================================================================
	// === 발신함 수신함 삭제하기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/jjokjiDel.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String jjokjiDel(HttpServletRequest request){

		String jseq = request.getParameter("jseq");
	
		String[] jseqArr1 = jseq.substring(0, jseq.lastIndexOf(",")).split(",");

		// 담아올 용도
		String delFileSelect = "";
		
		for(int i=0; i<jseqArr1.length; i++) {
			// 파일 삭제를 위해 파일있는지 확인해오기
			delFileSelect += service.getDelFileSelect(jseqArr1[i]) + ",";
		}
		
		String[] delFileArr = delFileSelect.substring(0, jseq.lastIndexOf(",")).split(",");
		
		Map<String, String[]> map = new HashMap<>();
		map.putIfAbsent("jseqArr1", jseqArr1);

		// 발신함 또는 수신함 삭제하기
		int n = service.jjokjiDel(map);
		
		if(n==1) {
			
			for(int i=0; i<delFileArr.length; i++) {
				
				if( delFileArr[i] != null || !"".equals(delFileArr[i]) ) {
					
					HttpSession session = request.getSession();
					String root = session.getServletContext().getRealPath("/"); 
					String path =  root + "resources" + File.separator + "files";

					try {
						fileManager.doFileDelete(delFileArr[i], path);
					} catch (Exception e) {
						e.printStackTrace();
					}//end of try {} catch (Exception e) {------------------------------

				}//end of if( delFileArr[i] != null || !"".equals(delFileArr[i]) ) {--------
				
			}//end of for(int i=0; i<delFileArr.length(); i++) {----------------------------
			
		}//end of if(n==1) {----------------------------------------------------------------
		
		JSONObject jsonobj = new JSONObject();

		jsonobj.put("n", n); 

		return jsonobj.toString();
		
	}//end of public String jjokjiDel(HttpServletRequest request){---------	
//=========================================================================	
	// === 즐겨찾기 등록하기(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/jjokjiStar.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String jjokjiStar(HttpServletRequest request){

		String jseq = request.getParameter("jseq");
	
		String[] jseqArr2 = jseq.substring(0, jseq.lastIndexOf(",")).split(",");
		
		Map<String, String[]> map = new HashMap<>();
		map.putIfAbsent("jseqArr2", jseqArr2);

		// 즐겨찾기 등록하기
		int n = service.jjokjiStar(map);

		JSONObject jsonobj = new JSONObject();

		jsonobj.put("n", n); 

		return jsonobj.toString();
		
	}//end of public String jjokjiDel(HttpServletRequest request){---------	
//=========================================================================	
	// === 즐겨찾기 등록해제(Ajax 로 처리) === //
	@ResponseBody // 제이손 뷰페이지에서 그대로 보여주기 위해서 적어주는 것
	@RequestMapping(value="/jjokjiStarNo.univ", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String jjokjiStarNo(HttpServletRequest request){

		String jseq = request.getParameter("jseq");
	
		String[] jseqArr3 = jseq.substring(0, jseq.lastIndexOf(",")).split(",");
		
		Map<String, String[]> map = new HashMap<>();
		map.putIfAbsent("jseqArr3", jseqArr3);

		// 즐겨찾기 등록해제
		int n = service.jjokjiStarNo(map);

		JSONObject jsonobj = new JSONObject();

		jsonobj.put("n", n); 

		return jsonobj.toString();
		
	}//end of public String jjokjiDel(HttpServletRequest request){---------	
//=========================================================================	
	// === 파일이 있는 쪽지 쓰기 완료 요청(Ajax 로 처리) === //
	@ResponseBody
	@RequestMapping(value="/adminSendJjokjiFile.univ", method = { RequestMethod.POST }, produces="text/plain;charset=UTF-8")   
	public String adminSendJjokjiFile(JjokjiVO jjokjivo, MultipartHttpServletRequest mrequest, HttpServletResponse response) {

		MultipartFile attach = jjokjivo.getAttach();
	 
		HttpSession session = mrequest.getSession();
       
		String root = session.getServletContext().getRealPath("/");
		String path = root + "resources" + File.separator + "files"; 
		String newFileName = ""; 
       
		byte[] bytes = null; 
       
		long fileSize = 0; 
           
    	try { 
         
    		bytes = attach.getBytes(); 
       
    		newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
       
    		jjokjivo.setFileName(newFileName); 
    		jjokjivo.setOrgFilename(attach.getOriginalFilename()); 
    		
    		fileSize = attach.getSize(); 
    		
    		jjokjivo.setFileSize(String.valueOf(fileSize));
       
    	} catch (Exception e) { 
    		e.printStackTrace(); 
    	}//end of try { } catch (Exception e) { ---------------------------------------------

        // 쪽지보내기 (첨부파일이 있는경우)
		int n = service.adminSendJjokji_withFile(jjokjivo); 
    
		JSONObject jsonObj = new JSONObject();
  		jsonObj.put("n", n);
  		
  		return jsonObj.toString();
	
	}//end of public ModelAndView sendjjokjiEnd(ModelAndView mav, JjokjiVO jjokjivo, MultipartHttpServletRequest mrequest) {
//=========================================================================
	// === 파일이 없는 쪽지 쓰기 완료 요청(Ajax 로 처리) === //
	@ResponseBody
	@RequestMapping(value="/adminSendJjokjiNoFile.univ", method = { RequestMethod.POST }, produces="text/plain;charset=UTF-8")   
	public String adminSendJjokjiNoFile(HttpServletRequest request, HttpServletResponse response) {

		String receive_hakbun = request.getParameter("receive_hakbun");
		String jjokjiContent = request.getParameter("jjokjiContent");
		
		Map<String, String> map = new HashMap<>();
		
		map.put("receive_hakbun", receive_hakbun);
		map.put("sender_hakbun", "0000001");
		map.put("jjokjiContent", jjokjiContent);
		
		// 쪽지보내기 (첨부파일이 없는경우)
		int n = service.adminSendJjokji(map); 		

		JSONObject jsonObj = new JSONObject();
  		jsonObj.put("n", n);
  		
  		return jsonObj.toString();
	
	}//end of public String adminSendJjokjiNoFile(HttpServletRequest request, HttpServletResponse response) {
//=========================================================================	
	// === 첨부파일 다운로드 받기 === //   		
	@RequestMapping(value="/FileDownload.univ") 
	public void FileDownload(HttpServletRequest request, HttpServletResponse response) { 
				
		String jseq = request.getParameter("jseq"); 
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("jseq", jseq);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null; 
		
		try {
			
			// 쪽지 첨부파일 다운로드 받기
			JjokjiVO jjokjivo = service.getAdminJjokjiList(paraMap);

			if(jjokjivo == null || (jjokjivo != null && jjokjivo.getFileName() == null)) {
				
				out = response.getWriter();
				out.println("<script type='text/javascript'> alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일 다운로드가 불가합니다!!'); history.back(); </script>"); //주솽에 없는 숫자 입력했을때 나옴
				
				return; 
			}
			else { //올바르게 들어왔을때 다운되도록 할 것

				String fileName = jjokjivo.getFileName();
				String orgFilename = jjokjivo.getOrgFilename();

		        HttpSession session = request.getSession(); 
		         
		        String root = session.getServletContext().getRealPath("/");
		        String path = root + "resources" + File.separator + "files";
		         
		        boolean flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
				
		        if(flag == false) {
		        	out = response.getWriter();
		        	out.println("<script type='text/javascript'> alert('파일 다운로드가 실패되었습니다!!'); history.back(); </script>"); 
		        }//end of if(flag == false) {--------------------------------------------
     
			}//end of if(jjokjivo == null || (jjokjivo != null && jjokjivo.getFileName() == null)) {
		
		} catch (NumberFormatException e) {

		} catch (IOException e2) {
			
		}//end of try{ } catch (IOException e2) {-----------------------------------------

	}//end of public void requiredLogin_download(HttpServletRequest request, HttpServletResponse response) {
//=========================================================================
}//end of public class GillController {------------------------------------	