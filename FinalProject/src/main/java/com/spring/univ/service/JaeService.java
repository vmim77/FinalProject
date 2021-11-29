package com.spring.univ.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.univ.common.FileManager;
import com.spring.univ.model.ClassContentBoardVO;
import com.spring.univ.model.ClassContentCommentVO;
import com.spring.univ.model.InterJaeDAO;
import com.spring.univ.model.SubjectVO;
import com.spring.univ.model.WeekVO;

@Service
public class JaeService implements InterJaeService {

	@Autowired
	private InterJaeDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	//수업 리스트 가져오기
	@Override
	public List<Map<String, String>> getclassList(String code) {
		List<Map<String, String>> classList = dao.getclassList(code);
		return classList;
	}

	// 과목당 몇주차까지 있는지 알아오기
	@Override
	public List<WeekVO> getWeek(String code) {
		List<WeekVO> getWeek = dao.getWeek(code);
		return getWeek;
	}

	
	//주차별 차시 수업정보 가져오기
	@Override
	public List<Map<String, String>> classListbyWeek(Map<String, String> paraMap2) {
		List<Map<String, String>> classListbyWeek = dao.classListbyWeek(paraMap2);
		return classListbyWeek;
	}

	//하나의 수업 정보 가져오기
	@Override
	public Map<String, String> getOneClassView(Map<String, String> paraMap) {
		Map<String, String> getOneClassView = dao.getOneClassView(paraMap);
		
	
		
		return getOneClassView;
	}
	

	//첨부파일이 없는 교수님 강의콘텐츠 게시물 올리기
	@Override
	public int classContentAdd(ClassContentBoardVO ccbvo) {
		int n = dao.classContentAdd(ccbvo);
		return n;
	}

	//첨부파일이 있는  교수님 강의콘텐츠 게시물 올리기
	@Override
	public int classContentAdd_withFile(ClassContentBoardVO ccbvo) {
		int n = dao.classContentAdd_withFile(ccbvo);
		return n;
	}

	//교수가 올린 강의 게시물 가져오기
	@Override
	public List<ClassContentBoardVO> getclassContentList(String lessonseq) {
		List<ClassContentBoardVO> getclassContentList = dao.getclassContentList(lessonseq);
		return getclassContentList;
	}

	
	//교수가 올린 하나의 강의 게시물 가져오기(각 글의 첨부파일 정보를 얻어오기 위함)
	@Override
	public ClassContentBoardVO getClassOneContent(String classBoardSeq) {
		ClassContentBoardVO getClassOneContent = dao.getClassOneContent(classBoardSeq);
		return getClassOneContent;
	}

	
	//변경할 첨부파일이 없는 경우 게시물 수정하기
	@Override
	public int classContentEdit(ClassContentBoardVO ccbvo) {
		int n = dao.classContentEdit(ccbvo);
		return n;
	}

	
	//교수가 올린 강의 게시물 삭제하기
	@Override
	public int classContentDel(Map<String, String> paraMap) {
		
		 int n = dao.classContentDel(paraMap);
	      
	      // 첨부파일 존재 시 DB에서 삭제// 
	      if(n==1) {
	         String fileName = paraMap.get("fileName");
	         String path = paraMap.get("path");
	         
	         if( fileName != null && !"".equals(fileName) ) {
	            
	            try {
	               fileManager.doFileDelete(fileName, path);
	            } catch (Exception e) {
	               e.printStackTrace();
	            }
	         }
	      }
	      //////////////////////////////////////////////////////////////////////////////
	      
	      return n;
	}

	
	
	//변경할 첨부파일이 있는 경우 게시물 수정하기
	@Override
	public int classContentEdit_withFile(ClassContentBoardVO ccbvo, Map<String, String> paraMap) {
		
		 int n = dao.classContentEdit_withFile(ccbvo);
	      
	      // ===변경할 첨부파일이 있다면 먼저 업데이트를 해주고 그다음 원래 있던 첨부파일을 삭제한다. === // 
	      if(n==1) {
	         String fileName = paraMap.get("fileName");
	         String path = paraMap.get("path");
	         
	         if( fileName != null && !"".equals(fileName) ) {
	            
	            try {
	               fileManager.doFileDelete(fileName, path);
	            } catch (Exception e) {
	               e.printStackTrace();
	            }
	         }
	      }
	      //////////////////////////////////////////////////////////////////////////////
	      
	      return n;
	}

	
	//첨부파일 없는 댓글쓰기(Ajax)
	@Override
	public int classCommentWrite_noAttach(Map<String, String> paraMap) {
		int n = dao.classCommentWrite_noAttach(paraMap);
		return n;
	}
	
	
	// 첨부파일이 있는 댓글쓰기
	@Override
	public int classCommentWrite_withAttach(ClassContentCommentVO cccvo) {
		int n = dao.classCommentWrite_withAttach(cccvo);
		return n;
	}


	
	//게시물에 달린 댓글 페이징처리하여 알아오기(검색포함)
	@Override
	public List<ClassContentCommentVO> getCommentListPaging(Map<String, String> paraMap) {
		List<ClassContentCommentVO> getCommentListPaging = dao.getCommentListPaging(paraMap);
		return getCommentListPaging;
	}

	
	// 댓글 총 개수 알아오기 (검색포함)
	@Override
	public int getCommentTotalPageCount(Map<String, String> paraMap) {
		int getCommentTotalPageCount = dao.getCommentTotalPageCount(paraMap);
		return getCommentTotalPageCount;
	}

	
	//댓글 1개 조회해오기
	@Override
	public ClassContentCommentVO getClassContentCommentOne(String classCommentSeq) {
		ClassContentCommentVO getClassContentCommentOne = dao.getClassContentCommentOne(classCommentSeq);
		return getClassContentCommentOne;
	}

	
	//댓글 삭제하기
	@Override
	public int classCommentDel(Map<String, String> paraMap) {
		int n = dao.classCommentDel(paraMap);
		return n;
	}

	
	
	//과목코드로 하나의 과목정보 알아오기
	@Override
	public SubjectVO getOneSubjectByCode(String code) {
		SubjectVO getOneSubjectByCode = dao.getOneSubjectByCode(code);
		return getOneSubjectByCode;
	}

	
	//몇 주차까지 등록되어있는지 알아오기
	@Override
	public int getWeekCount(String code) {
		int n = dao.getWeekCount(code);
		return n;
	}

	
	//수업 주차 등록하기
	@Override
	public int classWeekRegister(Map<String, String> paraMap) throws Exception{
		int n = dao.classWeekRegister(paraMap);
		return n;
	}

	
	//수업 차시 등록하기
	@Override
	public int classLessonRegister(Map<String, String> paraMap) {
		int n = dao.classLessonRegister(paraMap);
		return n;
	}

	
	//출석테이블에 인서트
	@Override
	public int goAttend(Map<String, String> paraMap)  throws Exception{
		int n = dao.goAttend(paraMap);
		return n;
	}

	
	//출석체크했는지 확인
	@Override
	public String attendCheck(Map<String, String> paraMap) {
		String n = dao.attendCheck(paraMap);
		return n;
	}

	
	//각 차시마다 출석했는지 알아오기
	@Override
	public String getAttendCheck(Map<String, String> paraMap) {
		String isCheck = dao.getAttendCheck(paraMap);
		return isCheck;
	}

	
	//과목의 각 주차당 몇개의 차시가 있는지 알아오기
	@Override
	public String getlessonCnt(Map<String, String> paraMap) {
		String lessonCnt = dao.getlessonCnt(paraMap);
		return lessonCnt;
	}

	
	//과목의 각 주차에 몇 개나 출석을 했는지 가져오기
	@Override
	public String getlessonAttendCnt(Map<String, String> paraMap) {
		String lessonAttendCnt = dao.getlessonAttendCnt(paraMap);
		return lessonAttendCnt;
	}

	
	//출석현황에서 어떤걸 출석했는지 알아오기
	@Override
	public String getlessonCheck(Map<String, String> paraMap2) {
		String lessonCheck = dao.getlessonCheck(paraMap2);
		return lessonCheck;
	}

	
	//출석현황에서 학습현황 보여주려고    각 수업 게시물에 댓글쓴걸 알아온다.
	@Override
	public String getlessonComment(Map<String, String> paraMap2) {
		String lessonComment = dao.getlessonComment(paraMap2);
		return lessonComment;
	}

	
	//지각 인정기간에 출석 안한 수업들 인서트하기
	@Override
	public int goLateAttend(Map<String, String> paraMap2) {
		int n = dao.goLateAttend(paraMap2);
		return n;
	}

	
	//count로 알아오는게 아닌 status로 알아온다.
	@Override
	public String getlessonCheck2(Map<String, String> paraMap2) {
		String lessonCheck2 = dao.getlessonCheck2(paraMap2);
		return lessonCheck2;
	}

	
	//출석테이블에 넣기전 지각인지 결석인지 알아오기 - 지각이나 결석이라면 이미 테이블에 status 2,3,4로 들어가 있기 때문에 insert하려고 하면 유니크 제약으로 오류 발생
	@Override
	public String getlessonCheckForAttendInsert(Map<String, String> paraMap) {
		String lessonCheckForAttendInsert = dao.getlessonCheckForAttendInsert(paraMap);
		return lessonCheckForAttendInsert;
	}

	
	// 출석테이블에 있다면 status가 뭔지 알아오고 1,2,3,4에 따라서 결과 정해주기
	@Override
	public String getAttendStatus(Map<String, String> paraMap) {
		String getAttendStatus = dao.getAttendStatus(paraMap);
		return getAttendStatus;
	}

	//지각 인정기간에 수업을 들어 status를 3으로 업데이트
	@Override
	public String lateUpdate(Map<String, String> paraMap) {
		String lateUpdate = dao.lateUpdate(paraMap);
		return lateUpdate;
	}

	
	//결석처리 업데이트
	@Override
	public int notAttendUpdate(Map<String, String> paraMap2) {
		int n = dao.notAttendUpdate(paraMap2);
		return n;
	}
	
	
	//총 수업 횟수
	@Override
	public int getTotalLessonCnt(Map<String, String> paraMap3) {
		int n = dao.getTotalLessonCnt(paraMap3);
		return n;
	}


	
	//총 출석 횟수
	@Override
	public int getTotalAttendCnt(Map<String, String> paraMap3) {
		int n = dao.getTotalAttendCnt(paraMap3);
		return n;
	}

	
	// 총 지각 횟수
	@Override
	public int getTotalLateCnt(Map<String, String> paraMap3) {
		int n = dao.getTotalLateCnt(paraMap3);
		return n;
	}

	
	// 총 지각 출석 횟수
	@Override
	public int getTotalLateAttendCnt(Map<String, String> paraMap3) {
		int n = dao.getTotalLateAttendCnt(paraMap3);
		return n;
	}

	
	// 총 결석 처리 횟수
	@Override
	public int getTotalNotAttendCnt(Map<String, String> paraMap3) {
		int n = dao.getTotalNotAttendCnt(paraMap3);
		return n;
	}


	

	 

	

	
	
	
	
	

}
