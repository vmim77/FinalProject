package com.spring.univ.model;

import java.util.*;
import javax.annotation.Resource;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class GillDAO implements InterGillDAO {
//================================================================================================
	@Resource
	private SqlSessionTemplate sqlsession2; // 원격DB에 연결
//================================================================================================
	@Override
	public List<MemberVO> getStudentList(Map<String, String> paraMap) {
		List<MemberVO> studentList = sqlsession2.selectList("Gill.getStudentList", paraMap);
		return studentList;
	}//end of public List<MemberVO> getStudentList(Map<String, String> paraMap) {-----------------
//================================================================================================
	// 과목 리스트 가져오기
	@Override
	public List<SubjectVO> getSubjectList(Map<String, String> paraMap) {
		List<SubjectVO> subjectList = sqlsession2.selectList("Gill.getSubjectList", paraMap);
		return subjectList;
	}//end of public List<SubjectVO> getSubjectList(Map<String, String> paraMap) {----------------
//================================================================================================
	// 학과 및 학과번호 가져오기
	@Override
	public List<DepartmentVO> getDeptList() {
		List<DepartmentVO> deptList = sqlsession2.selectList("Gill.getDeptList");
		return deptList;
	}
//================================================================================================
	// 새로운 회원 입력하기
	@Override
	public int UpdateMember(Map<String, String> paraMap) {
		int n = sqlsession2.insert("Gill.UpdateMember", paraMap);
		return n;
	}//end of public int UpdateMember(Map<String, String> paraMap) {------------------------------
//================================================================================================
	// 학번 중복여부 가져오기
	@Override
	public String getcheckHakbun(Map<String, String> paraMap) {
		String checkHakbun = sqlsession2.selectOne("Gill.getcheckHakbun", paraMap);
		return checkHakbun;
	}//end of public String getcheckHakbun(Map<String, String> paraMap) {-------------------------
//================================================================================================
	// 담당교수 가져오기
	@Override
	public List<MemberVO> getTeacherList(Map<String, String> paraMap) {
		List<MemberVO> teacherList = sqlsession2.selectList("Gill.getTeacherList", paraMap);
		return teacherList;
	}//end of public List<SubjectVO> getTeacherList() {-------------------------------------------
//================================================================================================
	// 새로운 전공 입력하기
	@Override
	public int UpdateSubject(Map<String, String> paraMap) {
		int n = sqlsession2.insert("Gill.UpdateSubject", paraMap);
		return n;
	}//end of public int UpdateSubject(Map<String, String> paraMap) {
//================================================================================================
	// 과목명 중복여부 가져오기
	@Override
	public String getcheckSubject(Map<String, String> paraMap) {
		String checkSubject = sqlsession2.selectOne("Gill.getcheckSubject", paraMap);
		return checkSubject;
	}//end of public String getcheckSubject(Map<String, String> paraMap) {------------------------
//================================================================================================
	// 학과코드 중복여부 가져오기
	@Override
	public String getcheckCode(Map<String, String> paraMap) {
		String checkCode = sqlsession2.selectOne("Gill.getcheckCode", paraMap);
		return checkCode;
	}//end of public String getcheckCode(Map<String, String> paraMap) {---------------------------
//================================================================================================
	// 상태 수정하기
	@Override
	public int UpdateStatus(Map<String, String> paraMap) {
		int n = sqlsession2.update("Gill.UpdateStatus", paraMap);
		return n;
	}//end of public int UpdateStatus(Map<String, String> paraMap) {------------------------------
//================================================================================================
	// 교수님 스케줄 조회해오기
	@Override
	public List<SubjectVO> getTeacherScheduleList(Map<String, String> paraMap) {
		List<SubjectVO> teacherScheduleList = sqlsession2.selectList("Gill.getTeacherScheduleList", paraMap);
		return teacherScheduleList;
	}//end of public List<SubjectVO> getTeacherScheduleList(Map<String, String> paraMap) {--------
//================================================================================================
	// 과 선택시 수강 미신청 인원 알아오기
	@Override
	public List<Map<String, String>> getsugangNoMemberList(Map<String, String> paraMap) {
		List<Map<String, String>> sugangNoMemberList = sqlsession2.selectList("Gill.getsugangNoMemberList", paraMap);
		return sugangNoMemberList;
	}//end of public List<SubjectVO> getsugangNoMemberList(Map<String, String> paraMap) {---------
//================================================================================================
	// 과 선택시 수강 신청 인원 알아오기
	@Override
	public List<Map<String, String>> getsugangYesMemberList(Map<String, String> paraMap) {
		List<Map<String, String>> sugangYesMemberList = sqlsession2.selectList("Gill.getsugangYesMemberList", paraMap);
		return sugangYesMemberList;
	}//end of public List<Map<String, String>> getsugangYesMemberList(Map<String, String> paraMap) {
//================================================================================================
	// 과 선택시 해당과 시간표 알아오기
	@Override
	public List<SubjectVO> getsugangSubjectList(Map<String, String> paraMap) {
		List<SubjectVO> sugangSubjectList = sqlsession2.selectList("Gill.getsugangSubjectList", paraMap);
		return sugangSubjectList;
	}//end of public List<SubjectVO> getsugangSubjectList(Map<String, String> paraMap) {
//================================================================================================
	// 수업 선택시 해당 요일 알아오기
	@Override
	public String getsubjectClassDate(Map<String, String> paraMap) {
		String classDate = sqlsession2.selectOne("Gill.getsubjectClassDate", paraMap);
		return classDate;
	}//end of public List<SubjectVO> getsubjectClassDate(Map<String, String> paraMap) {-----------
//================================================================================================
	// 전공신청 안한 학생한명 알아오기
	public List<MemberVO> getsearchNoMemberList(Map<String, String> paraMap) {
		List<MemberVO> searchNoMemberList = sqlsession2.selectList("Gill.getsearchNoMemberList", paraMap);
		return searchNoMemberList;
	}//end of public List<MemberVO> getsearchNoMemberList(Map<String, String> paraMap) {----------
//================================================================================================
	// 수강신청 저장
	@Override
	public void SaveSugang(Map<String, String> paraMap) {
		sqlsession2.insert("Gill.SaveSugang", paraMap);
	}//end of public void SaveSugang(Map<String, String> paraMap) {-------------------------------
//================================================================================================
	// 전공신청 한 학생한명 알아오기
	@Override
	public List<Map<String, String>> getselectSugangMemberList(Map<String, String> paraMap) {
		List<Map<String, String>> selectSugangMemberList = sqlsession2.selectList("Gill.getselectSugangMemberList", paraMap);
		return selectSugangMemberList;
	}//end of public List<MemberVO> getselectSugangMemberList(Map<String, String> paraMap) {------
//================================================================================================
	// 수강하지 않는 과목 가져와서 값 넣어주기
	@Override
	public List<Map<String, String>> getsugangNoSubjectList(Map<String, String> paraMap) {
		List<Map<String, String>> sugangNoSubjectList = sqlsession2.selectList("Gill.getsugangNoSubjectList", paraMap);
		return sugangNoSubjectList;
	}//end of public List<SubjectVO> getsugangNoSubjectList(Map<String, String> paraMap) {--------
//================================================================================================
	// 우선 해당 학번이 가지고 있는 수강목록 전부 지우기
	@Override
	public int DeleteSugang(String hakbun) {
		int m = sqlsession2.delete("Gill.DeleteSugang", hakbun);
		return m;
	}//end of public int DeleteSugang(String hakbun) {--------------------------------------------
//================================================================================================
	// 전공 수정 전 먼저 지워주기
	@Override
	public void DeleteSubject(Map<String, String> paraMap) {
		sqlsession2.delete("Gill.DeleteSubject", paraMap);
	}
//================================================================================================
	// 각 문제 별 체크한 문항번호 가져오기
	@Override
	public String getCheckNum(Map<String, String> map) {
		String checkNum = sqlsession2.selectOne("Gill.getCheckNum", map);
		return checkNum;
	}//end of public String getCheckNum(Map<String, String> map) {--------------------------------
//================================================================================================
	// 교수 담당수업 가져오기
	@Override
	public List<SubjectVO> getserveySubject(Map<String, String> paraMap) {
		List<SubjectVO> serveySubjectList = sqlsession2.selectList("Gill.getserveySubject", paraMap);
		return serveySubjectList;
	}//end of public List<SubjectVO> getserveySubject(Map<String, String> paraMap) {--------------
//================================================================================================
	// 평가문항 가져오기
	@Override
	public List<Map<String, String>> getPyungga(Map<String, String> paraMap) {
		List<Map<String, String>> pyunggaList = sqlsession2.selectList("Gill.getPyungga", paraMap);
		return pyunggaList;
	}//end of public List<Map<String, String>> getPyungga(Map<String, String> paraMap) {----------
//================================================================================================
	// 설문 가져오기
	@Override
	public List<ServeyVO> getServeyList() {
		List<ServeyVO> serveyList = sqlsession2.selectList("Gill.getServeyList");
		return serveyList;
	}//end of public List<ServeyVO> getServeyList() {---------------------------------------------
//================================================================================================
	// 설문 문항 가져오기
	@Override
	public List<ServeyDetailVO> getSulmoonMoonhangList(Map<String, String> paraMap) {
		List<ServeyDetailVO> sulmoonMoonhangList = sqlsession2.selectList("Gill.getSulmoonMoonhangList", paraMap);
		return sulmoonMoonhangList;
	}//end of public List<ServeyDetailVO> getSulmoonMoonhangList(Map<String, String> paraMap) {---
//================================================================================================
	// 설문 분석대상 문항가져오기
	@Override
	public List<ServeyResultVO> getBoonsukList(Map<String, String> paraMap) {
		List<ServeyResultVO> boonsukList = sqlsession2.selectList("Gill.getBoonsukList", paraMap);
		return boonsukList;
	}//end of public List<ServeyResultVO> getBoonsukList(Map<String, String> paraMap) {-----------
//================================================================================================	
	// 총 몇개인지 설문분석 결과값 가져오기
	@Override
	public String getResult(Map<String, String> map) {
		String boonsukChart = sqlsession2.selectOne("Gill.getResult", map);
		return boonsukChart;
	}//end of public String getResult(Map<String, String> map) {----------------------------------
//================================================================================================	
	// 쪽지 발신함 가져오기
	@Override
	public List<Map<String, String>> getSenderList(Map<String, String> map) {
		List<Map<String, String>> senderList = sqlsession2.selectList("Gill.getSenderList", map);
		return senderList;
	}//end of public List<JjokjiVO> getSenderList(Map<String, String> map) {----------------------
//================================================================================================
	// 쪽지 수신함 가져오기
	@Override
	public List<Map<String, String>> getReceiveList(Map<String, String> map1) {
		List<Map<String, String>> receiveList = sqlsession2.selectList("Gill.getReceiveList", map1);
		return receiveList;
	}//end of public List<JjokjiVO> getReceiveList(Map<String, String> map) {---------------------
//================================================================================================
	// 연락처 가져오기
	@Override
	public List<Map<String, String>> getContactList() {
		List<Map<String, String>> contactList = sqlsession2.selectList("Gill.getContactList");
		return contactList;
	}//end of public List<Map<String, String>> getContactList() {---------------------------------
//================================================================================================
	// 발신함 삭제하기
	@Override
	public int jjokjiDel(Map<String, String[]> map) {
		int n = sqlsession2.delete("Gill.jjokjiDel", map);
		return n;
	}//end of public int SenderDel(Map<String, String[]> map) {-----------------------------------
//================================================================================================
	// 즐겨찾기 목록 가져오기
	@Override
	public List<Map<String, String>> getStarList(Map<String, String> map2) {
		List<Map<String, String>> starList = sqlsession2.selectList("Gill.getStarList", map2);	
		return starList;
	}//end of public List<Map<String, String>> getStarList() {------------------------------------
//================================================================================================
	// 즐겨찾기 등록하기
	@Override
	public int jjokjiStar(Map<String, String[]> map) {
		int n = sqlsession2.update("Gill.jjokjiStar", map);
		return n;
	}//end of public int jjokjiStar(Map<String, String[]> map) {----------------------------------
//================================================================================================
	// 즐겨찾기 등록해제
	@Override
	public int jjokjiStarNo(Map<String, String[]> map) {
		int n = sqlsession2.update("Gill.jjokjiStarNo", map);
		return n;
	}//end of public int jjokjiStarNo(Map<String, String[]> map) {--------------------------------
//================================================================================================
	// 쪽지보내기 (첨부파일이 없는경우)
	@Override
	public int adminSendJjokji(Map<String, String> map) {
		int n = sqlsession2.insert("Gill.adminSendJjokji", map);
		return n;
	}//end of public void adminSendJjokji(JjokjiVO jjokjivo) {------------------------------------
//================================================================================================
	// 쪽지보내기 (첨부파일이 있는경우)
	@Override
	public int adminSendJjokji_withFile(JjokjiVO jjokjivo) {
		int n = sqlsession2.insert("Gill.adminSendJjokji_withFile", jjokjivo);
		return n;
	}//end of public void adminSendJjokji_withFile(JjokjiVO jjokjivo) {
//================================================================================================
	// 쪽지 첨부파일 다운로드 받기
	@Override
	public JjokjiVO getAdminJjokjiList(Map<String, String> paraMap) {
		JjokjiVO jjokjivo = sqlsession2.selectOne("Gill.getAdminJjokjiList", paraMap);
		return jjokjivo;
	}//end of public JjokjiVO getAdminJjokjiList(Map<String, String> paraMap) {-------------------
//================================================================================================
	// 파일 삭제를 위해 파일있는지 확인해오기
	@Override
	public String getDelFileSelect(String jseq) {
		String delFileSelect = sqlsession2.selectOne("Gill.getDelFileSelect", jseq);	
		return delFileSelect;
	}//end of public String getDelFileSelect(String jseq) {---------------------------------------
//================================================================================================
}//end of public class BoardDAO implements InterBoardDAO {