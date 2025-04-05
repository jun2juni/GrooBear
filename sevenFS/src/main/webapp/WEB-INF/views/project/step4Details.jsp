<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="row">
  <!-- 8 : 입력 영역 -->
  <div class="col-md-8">
    <div class="card border p-4">
      <h6 class="mb-4">세부 정보 입력</h6>

      <!-- 수주 금액 -->
      <div class="input-style-1 mb-4">
        <label>사업 수주 금액 &nbsp; 
          <span class="badge text-bg-success">(단위: 원)</span>
        </label>
        <div class="d-flex align-items-center">
          <input type="text" name="prjctRcvordAmount" id="amountInput"
                 class="form-control text-end me-2" placeholder="0"
                 style="background-color: white; width: 50%;" />
          <span id="amountDisplay"
                class="form-control text-end bg-light"
                style="width: 50%; border: 1px solid #ced4da; border-radius: .375rem;">
            
          </span>
        </div>
      </div>

      <!-- 주소 입력 -->
      <div class="input-style-1 mb-4">
        <label>프로젝트 주소</label>
        <div class="input-group mb-2">
          <input type="text" id="postcode" class="form-control bg-transparent"
                 placeholder="우편번호" readonly />
          <button type="button" class="btn btn-outline-secondary"
                  id="searchAddressBtn">
            <i class="fas fa-search me-1"></i> 주소 검색
          </button>
        </div>
        <input type="text" id="address" name="address"
               class="form-control bg-transparent mb-2" placeholder="주소" readonly />
        <input type="text" id="detailAddress" name="detailAddress"
               class="form-control bg-transparent mb-2" placeholder="상세주소" />
        <input type="hidden" name="prjctAdres" id="fullAddress" />
      </div>

      <!-- URL -->
      <div class="input-style-1">
        <label>프로젝트 URL</label>
        <input type="url" name="prjctUrl" class="form-control bg-transparent"
               placeholder="https://example.com" />
      </div>
    </div>
  </div>

  <!-- 4 : 안내 카드 -->
  <div class="col-md-4">
    <div class="card border p-3 bg-light h-100">
      <h6 class="mb-3 text-primary">
        <i class="fas fa-file-invoice-dollar me-2"></i>세부 정보 안내
      </h6>
      <ul class="text-muted small ps-3">
        <li>수주 금액은 숫자만 입력하며 단위는 원입니다.</li>
        <li>주소 검색 버튼을 눌러 정확한 위치를 선택하세요.</li>
        <li>상세 주소에는 건물명, 호수 등을 입력해주세요.</li>
        <li>URL은 프로젝트와 관련된 웹사이트 주소입니다.</li>
      </ul>
    </div>
  </div>
</div>
