<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="row">
	<div class="col-md-8">
<div class="form-step">
  <div class="row">
    <div class="col-12">
      <div class="card border p-4">
        <h6 class="mb-3">최종 확인</h6>
        <p class="text-muted">입력하신 내용을 확인한 후 프로젝트를 생성하세요.</p>

        <h6 class="mt-4">1. 기본 정보</h6>
        <ul class="list-group mb-4">
          <li class="list-group-item"><strong>프로젝트명:&nbsp;</strong> <span id="confirmPrjctNm"></span></li>
          <li class="list-group-item"><strong>카테고리:&nbsp;</strong> <span id="confirmCtgry"></span></li>
          <li class="list-group-item"><strong>내용:&nbsp;</strong> <span id="confirmPrjctCn"></span></li>
          <li class="list-group-item"><strong>기간:&nbsp;</strong> <span id="confirmPeriod"></span></li>
          <li class="list-group-item"><strong>상태:&nbsp;</strong> <span id="confirmPrjctSttus"></span></li>
          <li class="list-group-item"><strong>등급:&nbsp;</strong> <span id="confirmPrjctGrad"></span></li>
        </ul>

        <h6 class="mt-4">2. 참여 인원</h6>
        <div id="confirmMemberList" class="mb-4 text-muted">등록된 인원이 없습니다.</div>

        <h6 class="mt-4">3. 등록된 업무</h6>
        <div id="confirmTaskList" class="mb-4 text-muted" >등록된 업무가 없습니다.</div>

        <h6 class="mt-4">4. 세부 정보</h6>
        <ul class="list-group">
          <li class="list-group-item"><strong>수주 금액:&nbsp;</strong> <span id="confirmAmount"></span></li>
          <li class="list-group-item"><strong>주소: &nbsp;</strong> <span id="confirmAdres"></span></li>
          <li class="list-group-item"><strong>URL: &nbsp; </strong> <span id="confirmUrl"></span></li>
        </ul>
      </div>
<!--       <div class="text-end mt-4">
        <button type="submit" class="btn btn-primary">
          <i class="fas fa-check me-1"></i> 프로젝트 생성
        </button>
      </div> -->
    </div>
  </div>
</div>
</div>
<div class="col-md-4">
  <div class="card p-3 bg-light">
    <h6 class="mb-3 text-primary"><i class="fas fa-clipboard-check me-2"></i>최종 확인 안내</h6>
    <ul class="text-muted small ps-3">
      <li>입력한 모든 정보를 다시 한 번 확인해주세요.</li>
      <li>잘못된 정보가 있다면 이전 단계로 돌아가 수정할 수 있습니다.</li>
      <li>업무 및 인원 정보는 프로젝트와 함께 저장됩니다.</li>
      <li>확인이 완료되면 '프로젝트 생성' 버튼을 눌러 제출하세요.</li>
    </ul>
  </div>
</div>

</div>
