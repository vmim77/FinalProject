package com.spring.univ.service;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.spring.univ.model.*;

@Service
public class GillService implements InterGillService {
//==============================================================================================
	@Autowired
	private InterGillDAO dao;
//==============================================================================================
	// 학생 리스트 가져오기
	@Override
	public List<MemberVO> getStudentList(Map<String, String> paraMap) {
		List<MemberVO> studentList = dao.getStudentList(paraMap);
		return studentList;
	}//end of public List<MemberVO> getStudentList(Map<String, String> paraMap) {---------------
//==============================================================================================
	// 과목 리스트 가져오기
	@Override
	public List<SubjectVO> getSubjectList(Map<String, String> paraMap) {
		List<SubjectVO> subjectList = dao.getSubjectList(paraMap);
		return subjectList;
	}//end of public List<SubjectVO> getSubjectList(Map<String, String> paraMap) {--------------
//==============================================================================================
	// 학과 및 학과번호 가져오기
	@Override
	public List<DepartmentVO> getDeptList() {
		List<DepartmentVO> deptList = dao.getDeptList();
		return deptList;
	}
//==============================================================================================
	// 새로운 회원 입력하기
	@Override
	public int UpdateMember(Map<String, String> paraMap) {
		int n = dao.UpdateMember(paraMap);
		return n;
	}//end of public int UpdateMember(Map<String, String> paraMap) {----------------------------
//==============================================================================================
	// 학번 중복여부 가져오기
	@Override
	public String getcheckHakbun(Map<String, String> paraMap) {
		String checkHakbun = dao.getcheckHakbun(paraMap);
		return checkHakbun;
	}//end of public String getcheckHakbun(Map<String, String> paraMap) {-----------------------
//==============================================================================================
	// 담당교수 가져오기
	@Override
	public List<MemberVO> getTeacherList(Map<String, String> paraMap) {
		List<MemberVO> teacherList = dao.getTeacherList(paraMap);
		return teacherList;
	}//end of public List<SubjectVO> getTeacherList() {-----------------------------------------
//==============================================================================================
	// 새로운 전공 입력하기
	@Override
	public int UpdateSubject(Map<String, String> paraMap) {
		int n = dao.UpdateSubject(paraMap);
		return n;
	}//end of public int UpdateSubject(Map<String, String> paraMap) {---------------------------
//==============================================================================================
	// 과목명 중복여부 가져오기
	@Override
	public String getcheckSubject(Map<String, String> paraMap) {
		String checkSubject = dao.getcheckSubject(paraMap);
		return checkSubject;
	}//end of public String getcheckSubject(Map<String, String> paraMap) {----------------------
//==============================================================================================
	// 학과코드 중복여부 가져오기
	@Override
	public String getcheckCode(Map<String, String> paraMap) {
		String checkCode = dao.getcheckCode(paraMap);
		return checkCode;
	}//end of public String getcheckCode(Map<String, String> paraMap) {-------------------------
//==============================================================================================
	// 상태 수정하기		
	@Override
	public int UpdateStatus(Map<String, String> paraMap) {
		int n = dao.UpdateStatus(paraMap);
		return n;
	}//end of public int UpdateStatus(Map<String, String> paraMap) {----------------------------
//==============================================================================================
	// 교수님 스케줄 조회해오기
	@Override
	public List<SubjectVO> getTeacherScheduleList(Map<String, String> paraMap) {
		List<SubjectVO> teacherScheduleList = dao.getTeacherScheduleList(paraMap);
		return teacherScheduleList;
	}//end of public List<SubjectVO> getTeacherScheduleList(Map<String, String> paraMap) {------
//==============================================================================================
	// 과 선택시 수강 미신청 인원 알아오기
	@Override
	public List<Map<String, String>> getsugangNoMemberList(Map<String, String> paraMap) {
		List<Map<String, String>> sugangNoMemberList = dao.getsugangNoMemberList(paraMap);
		return sugangNoMemberList;
	}//end of public List<SubjectVO> getsugangNoMemberList(Map<String, String> paraMap) {-------
//==============================================================================================
	// 과 선택시 수강 신청 인원 알아오기
	@Override
	public List<Map<String, String>> getsugangYesMemberList(Map<String, String> paraMap) {
		List<Map<String, String>> sugangYesMemberList = dao.getsugangYesMemberList(paraMap);
		return sugangYesMemberList;
	}//end of public List<Map<String, String>> getsugangYesMemberList(Map<String, String> paraMap) {
//==============================================================================================
	// 과 선택시 해당과 시간표 알아오기
	@Override
	public List<SubjectVO> getsugangSubjectList(Map<String, String> paraMap) {
		List<SubjectVO> subjectClassDateList = dao.getsugangSubjectList(paraMap);
		return subjectClassDateList;
	}//end of public List<SubjectVO> getsugangSubjectList(Map<String, String> paraMap) {
//==============================================================================================
	// 수업 선택시 해당 요일 알아오기
	@Override
	public String getsubjectClassDate(Map<String, String> paraMap) {
		String classDate = dao.getsubjectClassDate(paraMap);
		return classDate;
	}//end of public String getsubjectClassDate(Map<String, String> paraMap) {------------------
//==============================================================================================
	// 전공신청 안한 학생한명 알아오기
	@Override
	public List<MemberVO> getsearchNoMemberList(Map<String, String> paraMap) {
		List<MemberVO> searchNoMemberList = dao.getsearchNoMemberList(paraMap);
		return searchNoMemberList;
	}//end of public List<MemberVO> getsearchNoMemberList(Map<String, String> paraMap) {--------
//==============================================================================================
	// 수강신청 저장
	@Override
	public void SaveSugang(Map<String, String> paraMap) {
		dao.SaveSugang(paraMap);
	}//end of public void SaveSugang(Map<String, String> paraMap) {-----------------------------
//==============================================================================================
	// 전공신청 한 학생한명 알아오기
	@Override
	public List<Map<String, String>> getselectSugangMemberList(Map<String, String> paraMap) {
		List<Map<String, String>> selectSugangMemberList = dao.getselectSugangMemberList(paraMap);
		return selectSugangMemberList;
	}//end of public List<MemberVO> getselectSugangMemberList(Map<String, String> paraMap) {----
//==============================================================================================
	// 수강하지 않는 과목 가져와서 값 넣어주기
	@Override
	public List<Map<String, String>> getsugangNoSubjectList(Map<String, String> paraMap) {
		List<Map<String, String>> sugangNoSubjectList = dao.getsugangNoSubjectList(paraMap);
		return sugangNoSubjectList;
	}//end of public List<SubjectVO> getsugangNoSubjectList(Map<String, String> paraMap) {------
//==============================================================================================
	// 우선 해당 학번이 가지고 있는 수강목록 전부 지우기
	@Override
	public int DeleteSugang(String hakbun) {
		int m = dao.DeleteSugang(hakbun);
		return m;
	}//end of public int DeleteSugang(String hakbun) {------------------------------------------
//==============================================================================================
	// 전공 수정 전 먼저 지워주기
	@Override
	public void DeleteSubject(Map<String, String> paraMap) {
		dao.DeleteSubject(paraMap);	
	}//end of public void DeleteSubject(Map<String, String> paraMap) {--------------------------
//==============================================================================================
	// 각 문제 별 체크한 문항번호 가져오기
	@Override
	public String getCheckNum(Map<String, String> map) {
		String checkNum = dao.getCheckNum(map);
		return checkNum;
	}//end of public String getCheckNum(Map<String, String> map) {------------------------------
//==============================================================================================
	// 교수 담당수업 가져오기
	@Override
	public List<SubjectVO> getserveySubject(Map<String, String> paraMap) {
		List<SubjectVO> serveySubjectList = dao.getserveySubject(paraMap);
		return serveySubjectList;
	}//end of public List<SubjectVO> getserveySubject(Map<String, String> paraMap) {------------
//==============================================================================================
	// 평가문항 가져오기
	@Override
	public List<Map<String, String>> getPyungga(Map<String, String> paraMap) {
		List<Map<String, String>> pyunggaList = dao.getPyungga(paraMap);
		return pyunggaList;
	}//end of public List<Map<String, String>> getPyungga(Map<String, String> paraMap) {--------
//==============================================================================================
	// 설문 가져오기
	@Override
	public List<ServeyVO> getServeyList() {
		List<ServeyVO> serveyList = dao.getServeyList();
		return serveyList;
	}//end of public List<ServeyVO> getServeyList() {-------------------------------------------
//==============================================================================================
	// 설문 문항 가져오기
	@Override
	public List<ServeyDetailVO> getSulmoonMoonhangList(Map<String, String> paraMap) {
		List<ServeyDetailVO> sulmoonMoonhangList = dao.getSulmoonMoonhangList(paraMap);
		return sulmoonMoonhangList;
	}//end of public List<ServeyDetailVO> getSulmoonMoonhangList(Map<String, String> paraMap) {-
//==============================================================================================
	// 설문 분석대상 문항가져오기
	@Override
	public List<ServeyResultVO> getBoonsukList(Map<String, String> paraMap) {
		List<ServeyResultVO> boonsukList = dao.getBoonsukList(paraMap);
		return boonsukList;
	}//end of public List<ServeyResultVO> getBoonsukList(Map<String, String> paraMap) {---------
//==============================================================================================
	// 총 몇개인지 설문분석 결과값 가져오기
	@Override
	public String getResult(Map<String, String> map) {
		String boonsukChart = dao.getResult(map);
		return boonsukChart;
	}//end of public String getResult(Map<String, String> map) {--------------------------------
//==============================================================================================	
	// 쪽지 발신함 가져오기
	@Override
	public List<Map<String, String>> getSenderList(Map<String, String> map) {
		List<Map<String, String>> senderList = dao.getSenderList(map);
		return senderList;
	}//end of public List<JjokjiVO> getSenderList(Map<String, String> map) {--------------------
//==============================================================================================
	// 쪽지 수신함 가져오기
	@Override
	public List<Map<String, String>> getReceiveList(Map<String, String> map1) {
		List<Map<String, String>> receiveList = dao.getReceiveList(map1);
		return receiveList;
	}//end of public List<JjokjiVO> getReceiveList(Map<String, String> map) {-------------------
//==============================================================================================
	// 연락처 가져오기
	@Override
	public List<Map<String, String>> getContactList() {
		List<Map<String, String>> contactList = dao.getContactList();
		return contactList;
	}//end of public List<Map<String, String>> getContactList() {-------------------------------
//==============================================================================================
	// 발신함 삭제하기
	@Override
	public int jjokjiDel(Map<String, String[]> map) {
		int n = dao.jjokjiDel(map);
		return n;
	}//end of public int SenderDel(Map<String, String[]> map) {---------------------------------
//==============================================================================================
	// 즐겨찾기 목록 가져오기
	@Override
	public List<Map<String, String>> getStarList(Map<String, String> map2) {
		List<Map<String, String>> starList = dao.getStarList(map2);	
		return starList;
	}//end of public List<Map<String, String>> getStarList() {----------------------------------
//==============================================================================================
	// 즐겨찾기 등록하기
	@Override
	public int jjokjiStar(Map<String, String[]> map) {
		int n = dao.jjokjiStar(map);
		return n;
	}//end of public int jjokjiStar(Map<String, String[]> map) {--------------------------------
//==============================================================================================
	// 즐겨찾기 등록해제
	@Override
	public int jjokjiStarNo(Map<String, String[]> map) {
		int n = dao.jjokjiStarNo(map);
		return n;
	}//end of public int jjokjiStarNo(Map<String, String[]> map) {------------------------------
//==============================================================================================
	// 쪽지보내기 (첨부파일이 없는경우)
	@Override
	public int adminSendJjokji(Map<String, String> map) {
		int n = dao.adminSendJjokji(map);
		return n;
	}//end of public void adminSendJjokji(JjokjiVO jjokjivo) {----------------------------------
//==============================================================================================
	// 쪽지보내기 (첨부파일이 있는경우)
	@Override
	public int adminSendJjokji_withFile(JjokjiVO jjokjivo) {
		int n = dao.adminSendJjokji_withFile(jjokjivo);	
		return n;
	}//end of public void adminSendJjokji_withFile(JjokjiVO jjokjivo) {-------------------------
//==============================================================================================
	// 쪽지 첨부파일 다운로드 받기
	@Override
	public JjokjiVO getAdminJjokjiList(Map<String, String> paraMap) {
		JjokjiVO jjokjivo = dao.getAdminJjokjiList(paraMap);
		return jjokjivo;
	}//end of public JjokjiVO getAdminJjokjiList(Map<String, String> paraMap) {-----------------
//==============================================================================================
	// 파일 삭제를 위해 파일있는지 확인해오기
	@Override
	public String getDelFileSelect(String jseq) {
		String delFileSelect = dao.getDelFileSelect(jseq);
		return delFileSelect;
	}//end of public String getDelFileSelect(String jseq) {-------------------------------------
//==============================================================================================
}//end of public class BoardService implements InterBoardService {
