<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<style type="text/css">

	div#container{
		width:1200px;
		height:700px;
		margin:50px 0px 0px 200px;
		border:solid 1px gray;
	}
	
	div#menu{
		width:1200px;
		height:40px;
	}
	
	table#student, table#teacher, table#subject{
		width:1100px;
		height:600px;
		margin:25px 0px 0px 50px;
		border:solid 1px #d7d7c1; 
	}

</style>

<script src= "<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" >

	$(document).ready(function(){
		


	});//end of $(document).ready(function(){-------------------------------------------
	
</script>

<div style="flex">
	<div id="container">
  		<%-- 상단 메뉴바 --%>
  		<nav>
		  	<div class="nav nav-tabs" id="nav-tab" role="tablist">
		    	<button class="nav-link active" id="student" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">학생정보</button>
		    	<button class="nav-link" id="teacher" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">교사정보</button>
		    	<button class="nav-link" id="subject" data-bs-toggle="tab" data-bs-target="#nav-contact" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">전공정보</button>
			</div>
		</nav>
		<%-- 하단 내용 --%>
		<div class="tab-content" id="nav-tabContent">
		  	<%-- 학생정보 --%>
		  	<div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
		  		<table id="student">
		  			<tr>
		  				<td>
		  					<select>
		  						<option>1</option>
		  						<option>2</option>
		  						<option>3</option>
		  					</select>
		  				</td>
		  			</tr>
		  			<tr>
		  				<td>
		  				
		  				</td>
		  			</tr>
		  		</table>
		  	</div>
		  	<%-- 교사정보 --%>
		  	<div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
		  		<table id="teacher">
		  			<tr>
		  				<td>
		  				2
		  				</td>
		  			</tr>
		  			<tr>
		  				<td>
		  				
		  				</td>
		  			</tr>
		  		</table>	  	
		  	</div>
		  	<%-- 전공정보 --%>
			<div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
				<table id="subject">
		  			<tr>
		  				<td>
		  				3
		  				</td>
		  			</tr>
		  			<tr>
		  				<td>
		  				
		  				</td>
		  			</tr>
		  		</table>
			</div>
		</div>
	</div>
</div>




