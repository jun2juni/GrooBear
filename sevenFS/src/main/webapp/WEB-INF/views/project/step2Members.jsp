<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
.org-chart-btn.active,
.org-chart-btn:active,
.org-chart-btn:focus,
.org-chart-btn:focus-visible {
  background-color: #0d6efd !important;
  color: #fff !important;
  border-color: #0d6efd !important;
}

.org-chart-btn.active i,
.org-chart-btn:active i,
.org-chart-btn:focus i,
.org-chart-btn:focus-visible i {
  color: #fff !important;
}


</style>

<div class="row g-4">
  <div class="col-md-8">
    <div class="card border rounded-3 shadow-sm mb-4">
      <div class="card-body p-4">
        <h5 class="card-title fw-bold mb-4">
          <i class="fas fa-users text-primary me-2"></i>프로젝트 참여자
        </h5>
        
        <!-- 책임자 -->
        <div class="mb-4">
          <label class="form-label fw-semibold">책임자 <span class="text-danger">*</span></label>
          <div class="input-group">
            <input type="text" id="responsibleManager" class="form-control rounded-start" 
                   placeholder="책임자를 선택해주세요" readonly />
            <input type="hidden" id="responsibleManagerEmpno" name="responsibleManagerEmpno" />
			<button type="button"
			  class="btn btn-outline-primary org-chart-btn open-org-chart d-flex align-items-center gap-1 px-3 py-2"
			  data-target="responsibleManager">
			  <i class="fas fa-search"></i> <span class="btn-text">조직도</span>
			</button>

          </div>
          <small class="text-muted mt-1 d-block">프로젝트를 총괄할 책임자를 지정해주세요</small>
        </div>

        <!-- 참여자 -->
        <div class="mb-4">
          <label class="form-label fw-semibold">참여자 <span class="text-danger">*</span></label>
          <div class="input-group">
            <input type="text" id="participants" class="form-control rounded-start" 
                   placeholder="참여자를 선택해주세요" readonly />
            <input type="hidden" id="participantsEmpno" name="participantsEmpno" />
			<button type="button"
			  class="btn btn-outline-primary org-chart-btn open-org-chart d-flex align-items-center gap-1 px-3 py-2"
			  data-target="participants">
			  <i class="fas fa-search"></i> <span class="btn-text">조직도</span>
			</button>
          </div>
          <small class="text-muted mt-1 d-block">프로젝트에 참여할 구성원을 선택해주세요</small>
        </div>

        <!-- 참조자 -->
        <div class="mb-3">
          <label class="form-label fw-semibold">참조자</label>
          <div class="input-group">
            <input type="text" id="observers" class="form-control rounded-start" 
                   placeholder="참조자를 선택해주세요" readonly />
            <input type="hidden" id="observersEmpno" name="observersEmpno" />
			<button type="button"
			  class="btn btn-outline-primary org-chart-btn open-org-chart d-flex align-items-center gap-1 px-3 py-2"
			  data-target="observers">
			  <i class="fas fa-search"></i> <span class="btn-text">조직도</span>
			</button>
          </div>
          <small class="text-muted mt-1 d-block">프로젝트 내용을 참조할 구성원을 선택해주세요 (선택사항)</small>
        </div>
      </div>
    </div>

    <!-- 선택된 참여자 표 -->
    <div class="card border rounded-3 shadow-sm mb-5">
      <div class="card-body p-4">
        <h5 class="card-title fw-bold mb-4">
          <i class="fas fa-list-check text-primary me-2"></i>선택된 프로젝트 참여자
        </h5>
        <div class="table-responsive">
          <table class="table table-striped table-hover align-middle mb-0" id="selectedMembersTable">
            <thead class="table-light">
              <tr>
                <th class="text-center">역할</th>
                <th>이름</th>
                <th>부서명</th>
                <th>직급</th>
                <th>연락처</th>
                <th>이메일</th>
                <th class="text-center">관리</th>
              </tr>
            </thead>
            <tbody>
              <tr class="empty-row">
                <td colspan="7" class="text-center text-muted py-4">
                  <i class="fas fa-info-circle me-1"></i> 선택된 인원이 없습니다. 
                  조직도에서 프로젝트 참여자를 선택해주세요.
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <!-- 오른쪽 영역: 조직도 -->
  <div class="col-md-4">
    <div class="card border rounded-3 shadow-sm">
      <div class="card-body p-4">
        <h5 class="card-title fw-bold mb-4">
          <i class="fas fa-sitemap text-primary me-2"></i>조직도
        </h5>
        <!-- 조직도 컴포넌트 가져오기 -->
        <c:import url="../organization/orgList.jsp" />
      </div>
    </div>
  </div>
</div>

<script>
document.querySelectorAll('.open-org-chart').forEach(btn => {
	  btn.addEventListener('click', function () {
	    currentTarget = this.dataset.target;

	    // 👉 기존 버튼들 초기화
	    document.querySelectorAll('.open-org-chart').forEach(b => {
	      b.classList.remove('active', 'btn-primary');
	      b.classList.add('btn-outline-primary');
	    });

	    // 👉 클릭된 버튼에 스타일 적용
	    this.classList.remove('btn-outline-primary');
	    this.classList.add('btn-primary', 'active');
	  });
	});


</script>