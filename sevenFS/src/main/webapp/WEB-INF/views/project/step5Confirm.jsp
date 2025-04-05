<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="form-step" id="step5" style="display: none;">
  <div class="row">
    <div class="col-12">
      <div class="card border p-4">
        <h6 class="mb-3">최종 확인</h6>
        <p class="text-muted">입력하신 내용을 확인한 후 프로젝트를 생성하세요.</p>

        <h6 class="mt-4">1. 기본 정보</h6>
        <ul class="list-group mb-4">
          <li class="list-group-item"><strong>프로젝트명:</strong> <span id="confirmPrjctNm"></span></li>
          <li class="list-group-item"><strong>카테고리:</strong> <span id="confirmCtgry"></span></li>
          <li class="list-group-item"><strong>내용:</strong> <span id="confirmPrjctCn"></span></li>
          <li class="list-group-item"><strong>기간:</strong> <span id="confirmPeriod"></span></li>
          <li class="list-group-item"><strong>상태:</strong> <span id="confirmPrjctSttus"></span></li>
          <li class="list-group-item"><strong>등급:</strong> <span id="confirmPrjctGrad"></span></li>
        </ul>

        <h6 class="mt-4">2. 참여 인원</h6>
        <div id="confirmMemberList" class="mb-4 text-muted">등록된 인원이 없습니다.</div>

        <h6 class="mt-4">3. 등록된 업무</h6>
        <div id="confirmTaskList" class="mb-4 text-muted">등록된 업무가 없습니다.</div>

        <h6 class="mt-4">4. 세부 정보</h6>
        <ul class="list-group">
          <li class="list-group-item"><strong>수주 금액:</strong> <span id="confirmAmount"></span></li>
          <li class="list-group-item"><strong>주소:</strong> <span id="confirmAdres"></span></li>
          <li class="list-group-item"><strong>URL:</strong> <span id="confirmUrl"></span></li>
        </ul>
      </div>
      <div class="text-end mt-4">
        <button type="submit" class="btn btn-primary">
          <i class="fas fa-check me-1"></i> 프로젝트 생성
        </button>
      </div>
    </div>
  </div>
</div>