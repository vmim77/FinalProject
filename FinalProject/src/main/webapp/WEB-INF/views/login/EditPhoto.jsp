<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
 
    
	<form name="addFrm"  enctype=multipart/form-data>
		<table style="width: 1024px" class="table table-bordered">
			
			<tr>
				<th style="width: 15%; background-color: #DDDDDD">파일첨부</th>
				<td>
					<input type="file" name="attach" /> 
				</td>
			</tr>
			
			
		</table>
		
		<div style="margin: 20px;">
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">완료</button>
			<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button> 
		</div>
	</form>