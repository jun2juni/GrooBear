<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="row g-4">
  <!-- 왼쪽 8 영역: 입력 영역 -->
  <div class="col-md-8">
    <div class="card border rounded-3 shadow-sm mb-4">
      <div class="card-body p-4">
        <h5 class="card-title fw-bold mb-4">
          <i class="fas fa-file-invoice text-primary me-2"></i>세부 정보 입력
        </h5>
        
        <!-- 수주 금액 -->
        <div class="mb-4">
          <label class="form-label fw-semibold">
            사업 수주 금액 <span class="badge bg-success ms-1">(단위: 원)</span>
          </label>
          <div class="d-flex align-items-center" style="width: 70%">
            <input type="text" name="prjctRcvordAmount" id="amountInput" 
                   class="form-control text-end me-2" placeholder="0"
                   style="width: 50%;" />
            <span id="amountDisplay" class="form-control text-end bg-light d-inline-block"
                  style="width: 50%; border: 1px solid #dee2e6; border-radius: 0.375rem;">
              0 원
            </span>
          </div>
          <small class="text-muted mt-1 d-block">숫자만 입력하세요. 자동으로 천 단위 구분 기호가 표시됩니다.</small>
        </div>

        <!-- 주소 입력 - 원래 형태로 복원 -->
        <div class="mb-4">
          <label class="form-label fw-semibold">프로젝트 주소</label>
          <div class="input-style-1 mb-3">
            <input type="text" name="restaurantAdd1" class="form-control address-select" id="restaurantAdd1" 
                   placeholder="주소를 입력하세요." value="" required="required" style="width: 70%; background-color: white;">
            <div class="invalid-feedback restaurantAdd1">식당 주소 찾기를 진행해주세요</div>
            <input type="text" name="restaurantAdd2" class="form-control mt-3" id="addressDetail" 
                   maxlength="30" placeholder="상세주소를 입력하세요." value="" required="required" style="width: 70%; background-color: white;">
            <div class="invalid-feedback">상세주소를 입력해주세요</div>
          </div>
        </div>

        <!-- URL - 원래 형태로 변경 -->
        <div class="input-style-1">
          <label class="form-label fw-semibold">프로젝트 URL</label>
          <div class="url-input-container" style="position: relative; width: 70%;">
            <input type="url" name="prjctUrl" id="urlInput" class="form-control bg-transparent"
                   placeholder="www.example.com" style="padding-left: 90px;" />
            <div class="url-prefix" style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #6c757d; pointer-events: none;">https://</div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- 오른쪽 4 영역: 안내 카드 -->
  <div class="col-md-4">
    <div class="card border rounded-3 shadow-sm">
      <div class="card-body p-4">
        <h5 class="card-title fw-bold mb-4">
          <i class="fas fa-file-invoice-dollar text-primary me-2"></i>세부 정보 안내
        </h5>
        <ul class="mb-0 ps-3">
          <li class="mb-2">수주 금액은 숫자만 입력하며 단위는 원입니다.</li>
          <li class="mb-2">주소 검색 버튼을 눌러 정확한 위치를 선택하세요.</li>
          <li class="mb-2">상세 주소에는 건물명, 호수 등을 입력해주세요.</li>
          <li class="mb-2">URL은 프로젝트와 관련된 웹사이트 주소입니다.</li>
        </ul>
      </div>
    </div>
  </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
  // 금액 입력 시 천 단위 구분 기호 표시 및 원화 표시
  const amountInput = document.getElementById('amountInput');
  const amountDisplay = document.getElementById('amountDisplay');
  
  amountInput.addEventListener('input', function(e) {
    // 숫자만 허용
    let value = e.target.value.replace(/[^0-9]/g, '');
    
    // 입력값 원본 유지
    e.target.value = value;
    
    // 천 단위 구분 기호와 원화 표시
    if (value) {
      const formattedValue = Number(value).toLocaleString('ko-KR');
      amountDisplay.textContent = formattedValue + ' 원';
    } else {
      amountDisplay.textContent = '0 원';
    }
  });
  
  // URL 입력 필드 처리
  const urlInput = document.getElementById('urlInput');
  
  // URL 입력 시 "https://" 접두사 관리
  urlInput.addEventListener('focus', function() {
    // 접두사가 표시된 상태에서 입력 필드 포커스를 받으면,
    // 실제 입력 영역의 시작 부분으로 커서 이동
    setTimeout(() => {
      const valueLength = this.value.length;
      this.setSelectionRange(valueLength, valueLength);
    }, 10);
  });
  
  // 폼 제출 시 URL 값 처리
  document.querySelector('form').addEventListener('submit', function(e) {
    const urlValue = urlInput.value.trim();
    
    // URL 값이 있고 https:// 접두사가 없는 경우, 접두사 추가
    if (urlValue && !urlValue.startsWith('https://') && !urlValue.startsWith('http://')) {
      // 숨겨진 필드에 전체 URL 저장 또는 기존 필드 값 수정
      // 방법 1: 기존 필드 값 수정
      urlInput.value = 'https://' + urlValue;
      
      // 방법 2: 숨겨진 필드 생성
      // const hiddenUrlField = document.createElement('input');
      // hiddenUrlField.type = 'hidden';
      // hiddenUrlField.name = 'prjctUrl';
      // hiddenUrlField.value = 'https://' + urlValue;
      // urlInput.name = 'prjctUrlDisplay'; // 원래 필드의 이름 변경
      // this.appendChild(hiddenUrlField);
    }
  });
  
  // 페이지 로드 시 초기화
  amountInput.dispatchEvent(new Event('input'));
});
</script>