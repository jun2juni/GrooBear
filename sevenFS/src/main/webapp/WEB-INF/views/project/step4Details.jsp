<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="form-step" id="step4" style="display: none;">
  <div class="row">
   <div class="col-6">
     <div class="input-style-1">
       <label>사업 수주 금액 &nbsp; 
         <span class="badge text-bg-success">(단위: &nbsp; 원)</span>
       </label>
       <div class="d-flex align-items-center">
         <!-- 왼쪽 입력 필드 -->
         <input type="text" name="prjct_rcvord_amount" id="amountInput" 
           placeholder="0" class="form-control text-end me-2"
           style="background-color: white; width: 50%;">
         
         <!-- 오른쪽 금액 표시 (input 대신 span) -->
         <span id="amountDisplay" class="form-control text-end bg-light px-3"
           style="width: 50%; border: 1px solid #ced4da; border-radius: .375rem;">
           0
         </span>
       </div>
     </div>

    <div class="col-md-12">
      <div class="input-style-1">
        <label>프로젝트 주소</label>
        <div class="input-group mb-2">
          <input type="text" id="postcode" class="bg-transparent" placeholder="우편번호" readonly />
          <button type="button" class="btn btn-outline-secondary" id="searchAddressBtn">
            <i class="fas fa-search me-1"></i> 주소 검색
          </button>
        </div>
        <input type="text" id="address" name="address" class="bg-transparent mb-2" placeholder="주소" readonly />
        <input type="text" id="detailAddress" name="detailAddress" class="bg-transparent" placeholder="상세주소" />
        <input type="hidden" name="prjctAdres" id="fullAddress" />
      </div>
    </div>
  </div>
</div>
