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
			<form action="/depUpdatePost" method="post" id="depUpdateForm">
				<c:set var="deptDetail" value="${deptData.deptDetail}"></c:set>
				<input type="hidden" value="${deptDetail.cmmnCode}" name="cmmnCode" />
				<div class="card-style chat-about h-100" style="justify-content: center;">
				   <h6 class="text-sm text-medium"></h6>
				   <div class="chat-about-profile">
				     <div class="content text-center">
				       <h5 class="text-bold mb-10"></h5>
				       <span class="status-btn info-btn">${deptDetail.cmmnCodeGroup}</span>
				     </div>
				   </div>
				   <div class="activity-meta text-start" style="margin-top: 20px;">
		   	          	<div class="input-style-1 form-group col-8" style="margin-left:15%;">
			         	 <label for="upperCmmnCode" class="form-label required">소속 부서<span class="text-danger">*</span></label>
			     	     <select id="duration" class="form-select w-auto" name="upperCmmnCode">
								<option value="${deptDetail.upperCmmnCode}">변경없음</option>
							<c:forEach var="depList" items="${deptData.deptList}">
								<option value="${depList.cmmnCode}">${depList.cmmnCodeNm}</option>
							</c:forEach>
						 </select>
					  	</div>
			   	          
			   	          <div class="input-style-1 form-group col-8" style="margin-left:15%;">
				            <label for="cmmnCodeNm" class="form-label required">부서명 <span class="text-danger">*</span></label>
				            <input type="text" name="cmmnCodeNm" class="form-control" id="cmmnCodeNm" value="${deptDetail.cmmnCodeNm}" required>
				            <div class="invalid-feedback">부서명을 작성하세요.</div>
				          </div>
				          
			   	          <div class="input-style-1 form-group col-8" style="margin-left:15%;">
				            <label for="cmmnCodeDc" class="form-label required">부서설명 <span class="text-danger">*</span></label>
				            <input type="text" name="cmmnCodeDc" class="form-control" id="cmmnCodeDc" value="${deptDetail.cmmnCodeDc}" required>
				           <div class="invalid-feedback"></div>
			   	          </div>
			   	          
			   	          <%-- <div class="input-style-1 form-group col-8" style="margin-left:15%;">
				            <label for="cmmnCode" class="form-label required">부서코드 <span class="text-danger">*</span></label>
				            <input type="text" name="cmmnCode" class="form-control" id="cmmnCode" value="${deptDetail.cmmnCode}" required>
				            <div class="invalid-feedback"></div>
				          </div> --%>
				     <div class="content text-center">
				     <button type="button" id="updateBtn" class="main-btn success-btn-light square-btn btn-hover btn-sm">확인</button>
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
	$("#updateBtn").on("click", function(){
		Swal.fire({
			  title: "수정되었습니다.",
			  icon: "success",
			  draggable: true
			})
			.then((result) =>{
				if(result.isConfirmed){
				$("#depUpdateForm").submit();   
				}
			});
		});
	});

</script>
  
</main>


</body>
</html>
