<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="card-style chat-about h-100">
 <div class="row">
   <div class="col-4 chat-about-profile text-center d-flex align-items-center justify-content-center">
	 <div>
	   <div class="image mx-auto chat-about chat-about-profile image">
		 <img src="/upload/${empDetail.proflPhotoUrl}" alt="" style="border-radius: 50%; width:150px; height: 150px; ">
	   </div>
	   <h4><span class="text-dark mb-3 text-center">${empDetail.emplNm}</span></h4>
	   <div class="content text-center">
		 <span class="status-btn info-btn">${empDetail.posNm}</span>
		 <span class="status-btn success-btn">${empDetail.deptNm}</span>
	   </div>
	 </div>
    </div>
   
    <div class="col-8 activity-meta text-start" style="margin-top: 20px;">
      <ul>
        <li class="row">
          <span class="col-4 text-end" >입사일자</span>
          <c:set var="year" value="${empDetail.ecnyDate.substring(0,4)}"></c:set>
          <c:set var="month" value="${empDetail.ecnyDate.substring(4,6)}"></c:set>
          <c:set var="day" value="${empDetail.ecnyDate.substring(6,8)}"></c:set>
          <span class="col-8 text-medium text-dark">${year}.${month}.${day}</span>
        </li>
        <hr>
        <li class="row">
          <span class="col-4 text-end">이메일</span>
          <span class="col-8 text-medium text-dark">${empDetail.email}</span>
        </li>
        <hr>
        <li class="row">
          <span class="col-4 text-end">전화번호</span>
          <c:set var="telno1" value="${empDetail.telno.substring(0,3)}"></c:set>
          <c:set var="telno2" value="${empDetail.telno.substring(3,7)}"></c:set>
          <c:set var="telno3" value="${empDetail.telno.substring(7,11)}"></c:set>
          <span class="col-8 text-medium text-dark">${telno1}-${telno2}-${telno3}</span>
        </li>
        <hr>
        <li class="row">
          <span class="col-4 text-end">생년월일</span>
          <c:set var="year" value="${empDetail.brthdy.substring(0,4)}"></c:set>
          <c:set var="month" value="${empDetail.brthdy.substring(4,6)}"></c:set>
          <c:set var="day" value="${empDetail.brthdy.substring(6,8)}"></c:set>
          <span class="col-8 text-medium text-dark">${year}.${month}.${day}</span>
        </li>
        <hr>
        <li class="row">
          <span class="col-4 text-end">성별</span>
          <span class="col-8 text-medium text-dark">${empDetail.genderCodeNm}</span>
        </li>
        <hr>
        <li class="row">
          <span class="col-4 text-end">주소</span>
          <span class="col-8 text-medium text-dark">${empDetail.adres}<br/>
          	${empDetail.detailAdres}</span>
        </li>
      </ul>
    </div>
  </div>
  <div class="profile-info text-center">
     <sec:authorize access="hasRole('ROLE_ADMIN')">
     <ul>
       <li>
       <hr>
       <span class="status-btn dark-btn">특이사항</span>
       <c:choose>
		    <c:when test="${empDetail.partclrMatter != null}">
		         <div style="margin-top: 20px;" class="text-medium text-dark">${empDetail.partclrMatter}</div>
		    </c:when>
		    <c:otherwise>
		        <p style="margin-top: 20px;">특이사항이 없습니다.</p>
		    </c:otherwise>
		</c:choose>
       </li>
     </ul>
     </sec:authorize>
     
     <!-- 로그인한 계정과 사원번호가 일치할경우에만 보이게 -->
     <!-- emplNo가 관리자일 경우에만 보이게 -->
     <sec:authentication property="principal.empVO" var="emp" />
	     <div class="content text-center" style="margin-top: 40px;">
	     	<c:if test="${emp.emplNo == empDetail.emplNo || emp.emplNo == '20250000'}">
		    	 <a href="/emplUpdate?emplNo=${empDetail.emplNo}" class="main-btn active-btn-light btn-hover btn-sm">수정</a>
		     </c:if>
		     <c:if test="${emp.emplNo == empDetail.emplNo}">
		     	<a href="/auth/passWord" class="ml-5 main-btn success-btn-light btn-hover btn-sm">비밀번호 변경</a>
		     </c:if>
		     <c:if test="${emp.emplNo == '20250000'}">
		     	<button type="button" id="emplDeleteBtn" class="ml-5 main-btn danger-btn-light square-btn btn-hover btn-sm">삭제</button>
	     	 </c:if>
	     </div>
   </div>

</div>

