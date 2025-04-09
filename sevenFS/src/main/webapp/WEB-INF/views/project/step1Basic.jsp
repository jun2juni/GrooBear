<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row g-4">
  <!-- 왼쪽 8 영역: 기본 정보 입력 -->
  <div class="col-md-8">
    <div class="card border rounded-3 shadow-sm mb-4">
      <div class="card-body p-4">
        <h5 class="card-title fw-bold mb-4">
          <i class="fas fa-project-diagram text-primary me-2"></i>프로젝트 기본 정보
        </h5>
        <div class="row g-3">
          <!-- 프로젝트 명 -->
          <div class="col-md-6">
            <div class="mb-4">
              <label class="form-label fw-semibold">프로젝트 명 <span class="text-danger">*</span></label>
              <input type="text" name="prjctNm" placeholder="프로젝트 명을 입력하세요" class="form-control" required style="width: 90%;" />
            </div>
          </div>

          <!-- 사업 분류 -->
          <div class="col-md-6">
            <div class="mb-4">
              <label class="form-label fw-semibold">사업 분류 <span class="text-danger">*</span></label>
              <select name="ctgryNo" class="form-select" required style="width: 90%;">
                <option value="">사업 분류를 선택하세요</option>
                <option value="00">국가지원사업</option>
                <option value="01">법인자체사업</option>
                <option value="02">산학협력사업</option>
                <option value="03">민간수주사업</option>
                <option value="04">해외협력사업</option>
              </select>
            </div>
          </div>

          <!-- 프로젝트 내용 -->
          <div class="col-12">
            <div class="mb-4">
              <label class="form-label fw-semibold">프로젝트 내용 <span class="text-danger">*</span></label>
              <textarea name="prjctCn" placeholder="프로젝트의 목적, 범위, 기대효과 등을 자세히 기술해주세요" rows="5" class="form-control" required style="width: 95%;"></textarea>
            </div>
          </div>

          <!-- 날짜 및 상태 정보 -->
          <div class="col-md-3">
            <div class="mb-4">
              <label class="form-label fw-semibold">사업 시작일 <span class="text-danger">*</span></label>
              <input type="date" name="prjctBeginDate" class="form-control" required id="startDateInput" />
            </div>
          </div>

          <div class="col-md-3">
            <div class="mb-4">
              <label class="form-label fw-semibold">사업 종료일 <span class="text-danger">*</span></label>
              <input type="date" name="prjctEndDate" class="form-control" required />
            </div>
          </div>

          <div class="col-md-3">
            <div class="mb-4">
              <label class="form-label fw-semibold">프로젝트 상태 <span class="text-danger">*</span></label>
              <select name="prjctSttus" class="form-select" required>
                <option value="">선택하세요</option>
                <option value="00" selected>대기</option>
                <option value="01">진행중</option>
                <option value="02">완료</option>
                <option value="03">취소</option>
              </select>
            </div>
          </div>

          <div class="col-md-3">
            <div class="mb-4">
              <label class="form-label fw-semibold">프로젝트 등급 <span class="text-danger">*</span></label>
              <select name="prjctGrad" class="form-select" required>
                <option value="">선택하세요</option>
                <option value="A">A</option>
                <option value="B">B</option>
                <option value="C" selected>C</option>
                <option value="D">D</option>
                <option value="E">E</option>
              </select>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- 오른쪽 4 영역: 설명 영역 -->
  <div class="col-md-4">
    <div class="card border rounded-3 shadow-sm">
      <div class="card-body p-4">
        <h5 class="card-title fw-bold mb-4">
          <i class="fas fa-info-circle text-primary me-2"></i>기본 정보 입력 안내
        </h5>
        <ul class="mb-0 ps-3">
          <li class="mb-2">프로젝트 명은 간결하고 명확하게 작성해주세요.</li>
          <li class="mb-2">프로젝트 내용에는 목적, 기대효과 등을 포함해주세요.</li>
          <li class="mb-2">시작일과 종료일을 정확히 설정해주세요.</li>
          <li class="mb-2">상태는 현재 진행 상황에 맞게 선택해주세요.</li>
          <li class="mb-2">등급은 A(가장 중요) ~ E 중에서 선택해주세요.</li>
        </ul>
      </div>
    </div>
  </div>
</div>

<script>
// 페이지 로드 시 오늘 날짜를 사업 시작일에 설정
document.addEventListener('DOMContentLoaded', function() {
  // 오늘 날짜 구하기
  const today = new Date();
  
  // YYYY-MM-DD 형식으로 포맷팅
  const year = today.getFullYear();
  const month = String(today.getMonth() + 1).padStart(2, '0');
  const day = String(today.getDate()).padStart(2, '0');
  const formattedDate = `\${year}-\${month}-\${day}`;
  
  // 사업 시작일 입력 필드에 오늘 날짜 설정
  const startDateInput = document.getElementById('startDateInput');
  if (startDateInput) {
    startDateInput.value = formattedDate;
  }
});



</script>