<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<style type="text/css">

#contents {
   /*  position: relative; */
    margin: auto;
    min-height: 1100px;
}
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:0.5px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:0.5px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-d1nvv{background-color:#ebebeb;border-color:#c0c0c0;font-weight:bold;text-align:center;vertical-align:middle}
.tg .tg-d1nv{background-color:#ebebeb;border-color:#c0c0c0;font-weight:bold;text-align:center;vertical-align:middle;width: 80px;}
.tg .tg-ve35{border-color:#c0c0c0;text-align:left;vertical-align:middle}
.tg .tg-m594{background-color:#fbe4e3;border-color:#c0c0c0;font-size:13.5px;text-align:left;vertical-align:top}
.tg .tg-fzdr{border-color:#c0c0c0;text-align:center;vertical-align:top}

button {
	width: 60px;
	height: 30px;
	float: right;
}

</style>


<script type="text/javascript">

   $(document).ready(function(){
      
   
   });

</script>



<div style="display: flex;">
<div  id="contents" style="margin: auto;">
		<div class="titleArea" style="margin-top: 80px;">
			<h2 style="font-size: 28pt; font-weight: bold; text-align: center;">2021학년도 2학기 쌍용대학교  강의평가</h2>
		</div>
		<br><br>
	<div class="typeWrite ">

<form name="evaluationFrm" action="Myinfo.univ">

<table class="tg" style="width: 970px;">
<thead>
  <tr>
    <th class="tg-m594" colspan="6"><br>이 강의평가 자료는 다음 학기의 강의에 참고하고자 하니,  본 교과목을 수강하면서 느낀 점을 객관적인 입장에서 솔직하고 성실하게 답변하여 주시기 바랍니다. <br><br>강의평가 결과에 대한 학생정보는 절대 비밀이 보장되며, 교수의 권한으로 학생의 정보를 알기는 불가능하오니 걱정하지 않으셔도 됩니다.<br><br></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-d1nvv">평가문항</td>
    <td class="tg-d1nv">매우그렇다</td>
    <td class="tg-d1nv">그렇다</td>
    <td class="tg-d1nv">보통</td>
    <td class="tg-d1nv">그렇지않다</td>
    <td class="tg-d1nv">매우그렇지않다</td>
  </tr>
  <tr>
    <td class="tg-ve35">나는 수업에 적극적으로 참여하였다.</td>
    <td class="tg-fzdr"><input type="radio" name="class" id="verysatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="class" id="satisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="class" id="normal" /></td>
    <td class="tg-fzdr"><input type="radio" name="class" id="dissatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="class" id="verydissatisfied" /></td>
  </tr>
  <tr>
    <td class="tg-ve35">강의는 수업 계획서대로 진행되었다.</td>
    <td class="tg-fzdr"><input type="radio" name="plan" id="verysatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="plan" id="satisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="plan" id="normal" /></td>
    <td class="tg-fzdr"><input type="radio" name="plan" id="dissatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="plan" id="verydissatisfied" /></td>
  </tr>
  <tr>
    <td class="tg-ve35">수업 계획서에는 강의에 관한 정보가 체계적이고 명확하게 제시되었다.</td>
    <td class="tg-fzdr"><input type="radio" name="exact" id="verysatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="exact" id="satisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="exact" id="normal" /></td>
    <td class="tg-fzdr"><input type="radio" name="exact" id="dissatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="exact" id="verydissatisfied" /></td>
  </tr>
  <tr>
    <td class="tg-ve35">교수는 수업준비(교재,학습자료 등)을 철저히 하였다.</td>
    <td class="tg-fzdr"><input type="radio" name="ready" id="verysatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="ready" id="satisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="ready" id="normal" /></td>
    <td class="tg-fzdr"><input type="radio" name="ready" id="dissatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="ready" id="verydissatisfied" /></td>
  </tr>
  <tr>
    <td class="tg-ve35">교수는 결강을 하지 않았으며, 휴강시에는 보강을 철저히 하였다.</td>
    <td class="tg-fzdr"><input type="radio" name="cancel" id="verysatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="cancel" id="satisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="cancel" id="normal" /></td>
    <td class="tg-fzdr"><input type="radio" name="cancel" id="dissatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="cancel" id="verydissatisfied" /></td>
  </tr>
  <tr>
    <td class="tg-ve35">교수는 학생들의 출결관리를 철저하게 하였다.</td>
    <td class="tg-fzdr"><input type="radio" name="attendance" id="verysatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="attendance" id="satisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="attendance" id="normal" /></td>
    <td class="tg-fzdr"><input type="radio" name="attendance" id="dissatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="attendance" id="verydissatisfied" /></td>
  </tr>
  <tr>
    <td class="tg-ve35">교수는 교과내용을 학생들이 이해할 수 있도록 명확하게 설명하였다.</td>
    <td class="tg-fzdr"><input type="radio" name="explain" id="verysatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="explain" id="satisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="explain" id="normal" /></td>
    <td class="tg-fzdr"><input type="radio" name="explain" id="dissatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="explain" id="verydissatisfied" /></td>
  </tr>
  <tr>
    <td class="tg-ve35">과제는 학습효과를 높이는데 도움이 되었다.</td>
    <td class="tg-fzdr"><input type="radio" name="homework" id="verysatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="homework" id="satisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="homework" id="normal" /></td>
    <td class="tg-fzdr"><input type="radio" name="homework" id="dissatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="homework" id="verydissatisfied" /></td>
  </tr>
  <tr>
    <td class="tg-ve35">평가 기준 및 방식은 객관적이고 합리적으로 제시되었다.</td>
    <td class="tg-fzdr"><input type="radio" name="objective" id="verysatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="objective" id="satisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="objective" id="normal" /></td>
    <td class="tg-fzdr"><input type="radio" name="objective" id="dissatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="objective" id="verydissatisfied" /></td>
  </tr>
  <tr>
    <td class="tg-ve35">이 강의에 대해 만족하여, 동기나 후배에게도 추천하고 싶다.</td>
    <td class="tg-fzdr"><input type="radio" name="recommend" id="verysatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="recommend" id="satisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="recommend" id="normal" /></td>
    <td class="tg-fzdr"><input type="radio" name="recommend" id="dissatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="recommend" id="verydissatisfied" /></td>
  </tr>
  <tr>
    <td class="tg-ve35">교수는 학생들의 질문을 적절히 수용하였고 성실히 응답하였다.</td>
    <td class="tg-fzdr"><input type="radio" name="qna" id="verysatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="qna" id="satisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="qna" id="normal" /></td>
    <td class="tg-fzdr"><input type="radio" name="qna" id="dissatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="qna" id="verydissatisfied" /></td>
  </tr>
  <tr>
    <td class="tg-ve35">교수는 열성적으로 강의하였다.</td>
    <td class="tg-fzdr"><input type="radio" name="passion" id="verysatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="passion" id="satisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="passion" id="normal" /></td>
    <td class="tg-fzdr"><input type="radio" name="passion" id="dissatisfied" /></td>
    <td class="tg-fzdr"><input type="radio" name="passion" id="verydissatisfied" /></td>
  </tr>
</tbody>
</table>

		<br><br>
		

		<button type="submit">제출</button>
 		<!--  input type="button" id="btnOK" value="제출" />-->

 
		</form>
		

</div>
</div>
</div>