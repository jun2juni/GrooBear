<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
 	<meta name="viewport"
		  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>${title}</title>
  <%@ include file="../layout/prestyle.jsp" %>
  
<style>
.form-label{
    font-size: 14px;
    font-weight: 500;
    color: #1A2142;
    display: block;
    margin-bottom: 10px;
}
</style>  
  
</head>
<body>
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../layout/header.jsp" %>
	<section class="section">
		<div class="container-fluid">
		<div class="card-style chat-about h-100" style="justify-content: center;">
			<input type="hidden" name="emplNo" value="${emplDetail.emplNo}">
				<form action="emplInsertPost" method="post" id="emplInsertForm" class="needs-validation" novalidate>
				  <div class=" form-group col-12" style="display: flex;">
				  	<div class="input-style-1 form-group col-2" style="margin-left: 15%">
			         	 <label for="clsfCode" class="form-label required">직급<span class="text-danger">*</span></label>
			     	     <select id="duration" class="form-select w-auto" name="clsfCode" required="required">
							<c:forEach var="posList" items="${cmmnList.posList}">
								<option value="${posList.cmmnCode}">${posList.cmmnCodeNm}</option>
							</c:forEach>
						 </select>
				 	 </div>
				  	<div class="input-style-1 form-group col-2">
		         	 <label for=upperDept class="form-label required">소속부서<span class="text-danger">*</span></label>
		     	     <select id="upperDept" class="form-select w-auto" required="required">
						<c:forEach var="upperDepList" items="${cmmnList.upperDepList}">
							<option value="${upperDepList.cmmnCode}">${upperDepList.cmmnCodeNm}</option>
						</c:forEach>
					 </select>
				  	</div>
				  	<%-- 부서 선택하면 소속팀 출력 --%>
					<div>
						<label class="form-label required">소속팀
								<span class="text-danger">*</span>
						</label> 
					    <div class="" id="lowerDepartment">
					    
					    </div>
					</div>
				  </div>
				 <div class="col-12 mt-4" style="display: flex;">
	   	          <div class="input-style-1 form-group" style="margin-left:15%;">
		            <label for="emplNm" class="form-label required maxlength="10">이름<span class="text-danger">*</span></label>
		            <input type="text" name="emplNm" class="form-control" id="emplNm" required>
		            <div class="invalid-feedback">이름을 작성하세요.</div>
		          </div>
				  <div class="form-group" style="margin-left:15%;">
				    <label for="genderCode" class="form-label" style="font-size: 14px; font-weight: 500; color: #1A2142;">
				        성별
				    </label>
				    <div class="form-check checkbox-style checkbox-warning">
				        <input class="form-check-input" type="radio" value="01" name="genderCode" id="radio-female">
				        <label class="form-check-label" for="radio-female">여성</label>
				    </div>
				    <div class="form-check checkbox-style checkbox-warning mb-20">
				        <input class="form-check-input" type="radio" value="00" name="genderCode" id="radio-male">
				        <label class="form-check-label" for="radio-male">남성</label>
				    </div>
				  </div>
	             </div>
	             <div class="input-style-1 form-group col-8" style="margin-left:15%;">
		             <label for="password" class="form-label required">비밀번호 <span class="text-danger">*초기 비밀번호는 java로 부여됩니다.</span></label>
		             <input type="text" name="password" class="form-control" id="password" value="java">
		             <div class="invalid-feedback"></div>
	  	          </div>
	  	          <div class="col-12" style="display: flex;">
		  	          <div class="input-style-1 form-group col-2" style="margin-left:15%;">
			            <label for="brthdy" class="form-label required">생년월일<span class="text-danger">*</span></label>
			            <input type="text" name="brthdy" class="form-control" id="cmmnCode" value="" 
			            		placeholder="ex) 20250507" required maxlength="8" minlength="8">
			            <div class="invalid-feedback"></div>
			          </div>
		   	          <div class="input-style-1 form-group col-3" style="margin-left:15%;">
			            <label for="telno" class="form-label required">휴대폰번호<span class="text-danger">*</span></label>
			            <input type="text" name="telno" class="form-control" id="telno" value="" 
			          		  placeholder="ex) 01012345678" required maxlength="11" minlength="11">
			            <div class="invalid-feedback"></div>
			          </div>
	  	          </div>
	  	          <div class="input-style-1 form-group col-8" style="margin-left:15%;">
		            <label for="email" class="form-label required">이메일<span class="text-danger">*</span></label>
		            <input type="text" name="email" class="form-control" id="email" value="" 
		            	placeholder="ex) 7FS@naver.com" required="required">
		            <div class="invalid-feedback"></div>
		          </div>
		          <div class="col-12" style="display: flex;">
	          		<div class="input-style-1 form-group col-2" style="margin-left:15%;">
		            <label for="ecnyDate" class="form-label required">입사일자 <span class="text-danger"> *</span></label>
		            <input type="text" name="ecnyDate" class="form-control" id="ecnyDate" value="${emp.ecnyDate}" required>
		            <div class="invalid-feedback"></div>
		          </div>
		          <div class="input-style-1 form-group col-4" style="margin-left:15%;">
		            <label for="retireDate" class="form-label">퇴사일자</label>
		             <c:choose>
		            	<c:when test="${emp.retireDate != null}">
		            		<input type="text" name="retireDate" class="form-control" id="retireDate" value="${emp.retireDate}">	
		            	</c:when>
		            	<c:otherwise>
		            		<span>퇴사하지 않은 사원입니다.</span>
		            	</c:otherwise>
		            </c:choose>
		            <div class="invalid-feedback"></div>
		          </div>
	          	</div>
	          	<div class="col-12" style="display: flex;">
	         		  <div class="input-style-1 form-group col-2" style="margin-left: 15%">
		            <label for="anslry" class="form-label required" style="margin-left: 10px;">급여<span class="text-danger"> *</span></label>
		            <input type="text" name="anslry" class="form-control" id="anslry" required>
		            <div class="invalid-feedback"></div>
		          </div>
	         		  <div class="input-style-1 form-group col-3" style="margin-left: 10px;">
		            <label for="acnutno" class="form-label required">계좌번호<span class="text-danger"> *</span></label>
		            <input type="text" name="acnutno" class="form-control" id="acnutno" required>
		            <div class="invalid-feedback"></div>
		          </div>
	         		  <div class="input-style-1 form-group col-2" style="margin-left: 10px;">
		            <label for="bankNm" class="form-label required">은행명<span class="text-danger"> *</span></label>
		            <input type="text" name="bankNm" class="form-control" id="bankNm" required>
		            <div class="invalid-feedback"></div>
		          </div>
	          	</div>
	     		    <div class="input-style-1 form-group col-6" style="margin-left:15%;">
		            <label for="partclrMatter" class="form-label">특이사항</label>
		            <textarea rows="4" name="partclrMatter" id="partclrMatter"></textarea>
		            <div class="invalid-feedback"></div>
	            </div>
	  	        <div class="input-style-1 form-group col-8" style="margin-left:15%;">
	            <label for="adres" class="form-label required">주소 <span class="text-danger">*</span></label>
		            <div class="row">
						<div class="col-8">
								<div class="mb-8">
									<input type="text" name="adres" class="form-control address-select" id="adres" placeholder="주소를 입력하세요." value="" required="required" >
									<div class="invalid-feedback restaurantAdd1"></div>
									<input type="text" name="detailAdres" class="form-control mt-3" id="detailAdres" maxlength="30" placeholder="상세주소를 입력하세요." value="" required="required" >
									<div class="invalid-feedback">상세주소를 입력해주세요</div>
								</div>
						</div>
					 </div>
					 </div>
            	<div class="invalid-feedback"></div>
			    <div class="content text-center">
			    <button type="submit" id="emplInsertBtn" class="main-btn primary-btn-light square-btn btn-hover btn-sm">확인</button>
		    	</div>
				</form>
            </div>
		</div>   
</section>
<%@ include file="../layout/footer.jsp" %>
<%@ include file="../layout/prescript.jsp" %>
 <script type="text/javascript">
$(function(){
	
	
	/*$("#emplInsertBtn").on("click", function(){
		
 		$("#emplInsertForm").submit();
		
		 Swal.fire({
			  title: "등록되었습니다.",
			  icon: "success",
			  draggable: true
			})
			.then((result) =>{
				if(result.isConfirmed){
				$("#emplInsertForm").submit();
				}
			}); 
		}); */

	
$("#upperDept").on("change", function(){
	const upperCmmnCode = this.value;
	console.log("선택한 상위부서 : " , upperCmmnCode);
	
	// 상위코드 보내서 비동기로 보내기
	fetch("/getLowerdeptList?upperCmmnCode="+upperCmmnCode, {
		method : "get",
	    headers : {
	        "Content-Type": "application/json"
       }
	}) // end fetch
	.then(resp => resp.json())
	.then(res => {
		console.log("선택한 부서의 하위부서 리스트 : ", res);
		 // 여기서 $("#lowerDepartment") 내부 비우기
		  $("#lowerDepartment").html("");
		 res.map((lowerDep, idx) => {
				//console.log("lowerDep : " , lowerDep.cmmnCodeNm);
				const id = idx;
				//console.log("id" , id);
					
				 $("#lowerDepartment").append(
					`
					 <div>
					 <input type="radio" value="\${lowerDep.cmmnCode}" id="\${id}" name="deptCode">
		      		 <label for="\${id}">\${lowerDep.cmmnCodeNm}</label>
					</div>
					`
				); 
 			 }) // end map   
 			
	})// end result
}) // end click event
});	// end fn

//동적으로 만든 라디오 클릭시
$(document).on('change', "input:radio[name=deptCode]", function(e) {
    const val = e.target.value;
    console.log(val);
    
 });


</script>
  
</main>
</body>
</html>




