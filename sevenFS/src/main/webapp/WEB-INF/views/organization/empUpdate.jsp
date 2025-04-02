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
</head>
<body>
<!-- 관리자만 보는 부서 수정페이지 -->
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../layout/header.jsp" %>
	<section class="section">
		<div class="container-fluid">
			<form action="/emplUpdatePost" method="post" id="emplUpdateForm">
				<input type="hidden" name="emplNo" value="${emplDetail.emplNo}">
				<div class="card-style chat-about h-100" style="justify-content: center;">
				   <h6 class="text-sm text-medium"></h6>
				   <div class="chat-about-profile">
				     <div class="content text-center">
				       <h5 class="text-bold mb-10"></h5>
				       <div class="chat-about-profile">
					     <div class="image mx-auto" style="text-align:center;">
						 <div>
					       <img src="/upload/{{fileStrePath}}" alt="이미지 넣어야됨"><br/>
						 </div>
					       <span class="text-medium text-dark"></span>
					     </div>
					     <div class="content text-center">
					       <h5 class="text-bold mb-10"></h5>
					       <span class="status-btn info-btn">${emplDetail.posNm}</span>
					       <span class="status-btn info-btn">${emplDetail.deptNm}</span>
					     </div>
					   </div>
				     </div>
				   </div>
				   
				   <div class="activity-meta text-start" style="margin-top: 20px;">
			   	        	<sec:authorize access="hasRole('ROLE_ADMIN')">
				   	          <div class="input-style-1 form-group col-8" style="margin-left:15%;">
					            <label for="emplNm" class="form-label required">이름<span class="text-danger">*</span></label>
					            <input type="text" name="emplNm" class="form-control" id="cmmnCodeNm" value="${emplDetail.emplNm}" required>
					            <div class="invalid-feedback">이름을 작성하세요.</div>
					          </div>
				           </sec:authorize>
			   	          <div class="input-style-1 form-group col-8" style="margin-left:15%;">
				            <label for="password" class="form-label required">비밀번호 <span class="text-danger">*</span></label>
				            <input type="text" name="password" class="form-control" id="cmmnCodeDc" value="${emplDetail.password}" required>
				           <div class="invalid-feedback"></div>
			   	          </div>
			   	          <div class="input-style-1 form-group col-8" style="margin-left:15%;">
				            <label for="brthdy" class="form-label required">생년월일 <span class="text-danger">*</span></label>
				            <input type="text" name="brthdy" class="form-control" id="cmmnCode" value="${emplDetail.brthdy}" required>
				            <div class="invalid-feedback"></div>
				          </div>
			   	          <div class="input-style-1 form-group col-8" style="margin-left:15%;">
				            <label for="telno" class="form-label required">휴대폰번호 <span class="text-danger">*</span></label>
				            <input type="text" name="telno" class="form-control" id="cmmnCode" value="${emplDetail.telno}" required>
				            <div class="invalid-feedback"></div>
				          </div>
			   	          <div class="input-style-1 form-group col-8" style="margin-left:15%;">
				            <label for="email" class="form-label required">이메일 <span class="text-danger">*</span></label>
				            <input type="text" name="email" class="form-control" id="cmmnCode" value="${emplDetail.email}" required>
				            <div class="invalid-feedback"></div>
				          </div>
   				          <!-- 관리자일 경우에만 보이게하기 -->
				          <sec:authorize access="hasRole('ROLE_ADMIN')">
				   	          <div class="input-style-1 form-group col-8" style="margin-left:15%;">
					            <label for="cmmnCode" class="form-label required">성별 <span class="text-danger">*</span></label>
					            <input type="text" name="cmmnCode" class="form-control" id="cmmnCode" value="${emplDetail.genderCode}" required>
					            <div class="invalid-feedback"></div>
				          	 </div>
				   	          <div class="input-style-1 form-group col-8" style="margin-left:15%;">
					            <label for="ecnyDate" class="form-label required">입사일자 <span class="text-danger"> *관리자만 변경 가능</span></label>
					            <input type="text" name="ecnyDate" class="form-control" id="cmmnCode" value="${emplDetail.ecnyDate}" required>
					            <div class="invalid-feedback"></div>
					          </div>
				   	          <div class="input-style-1 form-group col-8" style="margin-left:15%;">
					            <label for="retireDate" class="form-label required">퇴사일자 <span class="text-danger">*관리자만 변경 가능</span></label>
					            <c:choose>
					            	<c:when test="${emplDetail.retireDate != null}">
					            		<input type="text" name="retireDate" class="form-control" id="cmmnCode" value="${emplDetail.retireDate}" required>	
					            	</c:when>
					            	<c:otherwise>
					            		<span>퇴사하지 않은 사원입니다.</span>
					            	</c:otherwise>
					            </c:choose>
					            <div class="invalid-feedback"></div>
					          </div>
				          </sec:authorize>
			   	          <div class="input-style-1 form-group col-8" style="margin-left:15%;">
				            <label for="cmmnCode" class="form-label required">주소 <span class="text-danger">*</span></label>
				            <div class="row">
								<div class="col-6">
									<div class="card-style">
										<div class="mb-4">
											<label for="adres" class="form-label mb-3">주소찾기</label>
											<input type="text" name="adres" class="form-control address-select" id="adres" placeholder="주소를 입력하세요." value="" required="required" >
											<div class="invalid-feedback restaurantAdd1"></div>
											<input type="text" name="detailAdres" class="form-control mt-3" id="detailAdres" maxlength="30" placeholder="상세주소를 입력하세요." value="" required="required" >
											<div class="invalid-feedback">상세주소를 입력해주세요</div>
										</div>
									</div>
								</div>
							</div>
				            <div class="invalid-feedback"></div>
				          </div>
				     <div class="content text-center">
				     <button type="button" id="emplUpdateBtn" class="main-btn success-btn-light square-btn btn-hover btn-sm">확인</button>
				     </div>
				   </div>
				</div>   
			</form>    
		</div>
	</section>
  <%@ include file="../layout/footer.jsp" %>
  <%@ include file="../layout/prescript.jsp" %>
 <script type="text/javascript">
$(function(){
	$("#emplUpdateBtn").on("click", function(){
		Swal.fire({
			  title: "수정되었습니다.",
			  icon: "success",
			  draggable: true
			})
			.then((result) =>{
				if(result.isConfirmed){
				$("#emplUpdateForm").submit();
				}
			});
		});
	});

</script>
  
</main>


</body>
</html>
