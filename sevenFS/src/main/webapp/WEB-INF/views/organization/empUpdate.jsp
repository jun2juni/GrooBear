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
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../layout/header.jsp" %>
	<section class="section">
		<div class="container-fluid">
			<form action="/emplUpdatePost" method="post" class="needs-validation" novalidate id="emplUpdateForm" enctype="multipart/form-data">
				<div class="card-style chat-about h-100" style="justify-content: center;">
				   <h6 class="text-sm text-medium"></h6>
				   <c:set var="emplDet" value="${emplDetail.emplDet}"></c:set>
				   <div class="chat-about-profile" style="justify-content: center;">
				       <h5 class="text-bold mb-10"></h5>
					     <div class="image" style="justify-content: center; margin-left: 15%">
					        <file-upload
				              label="프로필 이미지 수정"
				              name="uploadFile"
				              max-files="1"
				              contextPath="${pageContext.request.contextPath  }"
				              uploaded-file="${fileAttachList}"
				              atch-file-no="${emplDet.atchFileNo}"
				          ></file-upload>
					       <span class="text-medium text-dark"></span>
					     </div>
				   </div>
				   
				  <sec:authorize access="hasRole('ROLE_ADMIN')">
				  <div class="input-style-1 form-group col-12" style="display: flex;">
				  	<div class="input-style-1 form-group col-2" style="margin-left: 15%">
			         	 <label for="clsfCode" class="form-label required">직급<span class="text-danger">*</span></label>
			     	     <select id="duration" class="form-select w-auto" name="clsfCode">
							<c:forEach var="posList" items="${emplDetail.posList}">
								<option value="${posList.cmmnCode}">${posList.cmmnCodeNm}</option>
							</c:forEach>
						 </select>
				 	 </div>
				  	<div class="input-style-1 form-group col-6">
		         	 <label for="deptCode" class="form-label required">부서<span class="text-danger">*</span></label>
		     	     <select id="duration" class="form-select w-auto" name="deptCode">
						<c:forEach var="depList" items="${emplDetail.depList}">
							<option value="${depList.cmmnCode}">${depList.cmmnCodeNm}</option>
						</c:forEach>
					 </select>
				  	</div>
				  </div>
				  </sec:authorize>
				   <c:set var="emp" value="${emplDetail.emplDet}"></c:set>
				   <sec:authorize access="hasRole('ROLE_MEMBER')">
					   <input type="hidden" name="emplNm" value="${emp.emplNm}"/>
					   <input type="hidden" name="genderCode" value="${emp.genderCode}"/>
					   <input type="hidden" name="clsfCode" value="${emp.clsfCode}"/>
					   <input type="hidden" name="deptCode" value="${emp.deptCode}"/>
					   <input type="hidden" name="ecnyDate" value="${emp.ecnyDate}"/>
					   <input type="hidden" name="retireDate" value="${emp.retireDate}"/>
					   <input type="hidden" name="anslry" value="${emp.anslry}"/>
					   <input type="hidden" name="acnutno" value="${emp.acnutno}"/>
					   <input type="hidden" name="bankNm" value="${emp.bankNm}"/>
					   <input type="hidden" name="partclrMatter" value="${emp.partclrMatter}"/>
				   </sec:authorize>
				   <div class="activity-meta text-start" style="margin-top: 20px;">
			 			<input type="hidden" name="emplNo" value="${emp.emplNo}">
			   	          <div class="input-style-1 form-group col-8" style="margin-left:15%;">
				            <label for="password" class="form-label required">비밀번호<span class="text-danger">*</span></label>				            
				            <input type="text" name="password" class="form-control" value="${emp.password}">
				           <div class="invalid-feedback"></div>
			   	          </div>
	   	            	<sec:authorize access="hasRole('ROLE_ADMIN')">
		   	            <div class="col-12" style="display: flex;">
			   	          <div class="input-style-1 form-group" style="margin-left:15%;">
				            <label for="emplNm" class="form-label required">이름<span class="text-danger">*</span></label>
				            <input type="text" name="emplNm" class="form-control" id="emplNm" value="${emp.emplNm}" required>
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
		   	            
			           </sec:authorize>
		   	        	
			            <div class="input-style-1 form-group col-8" style="margin-left:15%;">
				            <label for="email" class="form-label required">이메일 <span class="text-danger">*</span></label>
				            <input type="text" name="email" class="form-control" id="email" value="${emp.email}" required>
				            <div class="invalid-feedback"></div>
				          </div>
			           <div class="col-12" style="display: flex;">
			           	<div class="input-style-1 form-group col-2" style="margin-left:15%;">
				            <label for="brthdy" class="form-label required" maxlength="8">생년월일 <span class="text-danger">*</span></label>
				            <input type="text" name="brthdy" class="form-control" id="brthdy" value="${emp.brthdy}" required>
				            <div class="invalid-feedback"></div>
			            </div>
			            <div class="input-style-1 form-group col-3" style="margin-left:15%;">
				            <label for="telno" class="form-label required" maxlength="11">휴대폰번호 <span class="text-danger">*</span></label>
				            <input type="text" name="telno" class="form-control" id="telno" value="${emp.telno}" required>
				            <div class="invalid-feedback"></div>
				          </div>
			           
			           </div>
			   	         
   				          <!-- 관리자일 경우에만 보이게하기 -->
				          <sec:authorize access="hasRole('ROLE_ADMIN')">
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
					            <input type="text" name="anslry" class="form-control" id="anslry" value="${emp.anslry}" required>
					            <div class="invalid-feedback"></div>
					          </div>
			          		  <div class="input-style-1 form-group col-3" style="margin-left: 10px;">
					            <label for="acnutno" class="form-label required">계좌번호<span class="text-danger"> *</span></label>
					            <input type="text" name="acnutno" class="form-control" id="acnutno" value="${emp.acnutno}" required>
					            <div class="invalid-feedback"></div>
					          </div>
			          		  <div class="input-style-1 form-group col-2" style="margin-left: 10px;">
					            <label for="bankNm" class="form-label required">은행명<span class="text-danger"> *</span></label>
					            <input type="text" name="bankNm" class="form-control" id="bankNm" value="${emp.bankNm}" required>
					            <div class="invalid-feedback"></div>
					          </div>
				          	</div>
			      		    <div class="input-style-1 form-group col-6" style="margin-left:15%;">
					            <label for="partclrMatter" class="form-label">특이사항</label>
					            <textarea rows="4" name="partclrMatter" id="partclrMatter" value="${emp.partclrMatter}">${emp.partclrMatter}</textarea>
					            <div class="invalid-feedback"></div>
				            </div>
				   	          
				          </sec:authorize>
			   	          <div class="input-style-1 form-group col-8" style="margin-left:15%;">
				            <label for="cmmnCode" class="form-label required">주소 <span class="text-danger"></span></label>
				            <div class="row">
								<div class="col-8">
										<div class="mb-4">
											<input type="text" name="adres" value="${emp.adres}" class="form-control address-select" id="adres" placeholder="주소를 입력하세요.">
											<div class="invalid-feedback restaurantAdd1"></div>
											<input type="text" name="detailAdres" value="${emp.detailAdres}" class="form-control mt-3" id="detailAdres" maxlength="30" placeholder="상세주소를 입력하세요.">
											<div class="invalid-feedback">상세주소를 입력해주세요</div>
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
