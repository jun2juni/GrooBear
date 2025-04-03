<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

	<div class="card-style chat-about h-100">
	   <h6 class="text-sm text-medium"></h6>
	   <div class="chat-about-profile">
	     <div class="content text-center" style="margin-bottom: 70px;">
	       <h5 class="text-bold mb-10"></h5>
	       <span class="status-btn info-btn">${deptDetail.cmmnCodeGroup}</span>
	     </div>
	   </div>
	   <div class="activity-meta text-start" style="margin-top: 20px;">
	     <ul style="margin-bottom: 40px;">
	       <li class="row">
	         <span class="col-4" >부서명</span>
	         <span class="col-8 text-medium text-dark">${deptDetail.cmmnCodeNm}</span>
	       </li>
	       	<hr/>
	       <li class="row">
	         <span class="col-4">부서설명</span>
	         <span class="col-8 text-medium text-dark">${deptDetail.cmmnCodeDc}</span>
	       </li>
	       <hr>
	       <li class="row">
	         <span class="col-4">부서코드</span>
	         <span class="col-8 text-medium text-dark">${deptDetail.cmmnCode}</span>
	       </li>
	     </ul>
	     <!-- 관리자면 전부 다 보이게,  -->
	     <sec:authorize access="hasRole('ROLE_ADMIN')">
	     <div class="content text-center">
		     <a href="/depUpdate?cmmnCode=${deptDetail.cmmnCode}" class="main-btn success-btn-light square-btn btn-hover btn-sm">수정</a>
		     <button id="deptDeleteBtn" type="button" class="main-btn danger-btn-light square-btn btn-hover btn-sm">삭제</button>
	     </div>
		</sec:authorize>
	   </div>
	</div> 
	

