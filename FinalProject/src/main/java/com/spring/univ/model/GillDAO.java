package com.spring.univ.model;

import java.util.*;
import javax.annotation.Resource;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class GillDAO implements InterGillDAO {

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
	
	
	
	
	
	
}//end of public class BoardDAO implements InterBoardDAO {