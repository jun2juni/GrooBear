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
            <h5 class="fw-bold mb-3"><i class="fas fa-clipboard-check me-2 text-primary"></i>최종 확인</h5>
            <p class="text-muted mb-4">입력하신 내용을 확인한 후 프로젝트를 생성하세요.</p>

            <!-- 1. 기본 정보 -->
            <h6 class="mt-4 mb-2 fw-bold">1. 기본 정보</h6>
            <table class="table table-bordered table-sm mt-2">
              <tbody>
                <tr><th class="bg-light w-25 text-center">프로젝트명</th><td class="ps-3"><span id="confirmPrjctNm"></span></td></tr>
                <tr><th class="bg-light text-center">카테고리</th><td class="ps-3"><span id="confirmCtgry"></span></td></tr>
                <tr><th class="bg-light text-center">내용</th><td class="ps-3"><span id="confirmPrjctCn"></span></td></tr>
                <tr><th class="bg-light text-center">기간</th><td class="ps-3"><span id="confirmPeriod"></span></td></tr>
                <tr><th class="bg-light text-center">상태</th><td class="ps-3"><span id="confirmPrjctSttus" class="badge bg-info text-dark px-2 py-1"></span></td></tr>
                <tr><th class="bg-light text-center">등급</th><td class="ps-3"><span id="confirmPrjctGrad" class="badge bg-warning text-dark px-2 py-1"></span></td></tr>
              </tbody>
            </table>

            <!-- 2. 참여 인원 -->
            <h6 class="mt-5 mb-2 fw-bold">2. 참여 인원</h6>
            <div id="confirmMemberList" class="mb-4">
              <div class="row g-3">
                <div class="col-md-12">
                  <div class="border-top pt-3">
                    <span class="badge btn-danger mb-2 px-2 py-1">
                      <i class="fas fa-user-tie me-1"></i> 책임자
                    </span>
                    <div id="confirmResponsible" class="d-flex flex-wrap gap-2 small text-muted"></div>
                  </div>
                </div>
                <div class="col-md-12">
                  <div class="border-top pt-3">
                    <span class="badge btn-primary mb-2 px-2 py-1">
                      <i class="fas fa-user-check me-1"></i> 참여자
                    </span>
                    <div id="confirmParticipants" class="d-flex flex-wrap gap-2 small text-muted"></div>
                  </div>
                </div>
                <div class="col-md-12">
                  <div class="border-top pt-3">
                    <span class="badge btn-secondary mb-2 px-2 py-1">
                      <i class="fas fa-user-clock me-1"></i> 참조자
                    </span>
                    <div id="confirmObservers" class="d-flex flex-wrap gap-2 small text-muted"></div>
                  </div>
                </div>
              </div>
            </div>

            <!-- 3. 등록된 업무 -->
            <h6 class="mt-5 mb-2 fw-bold">3. 등록된 업무</h6>
            <div id="confirmTaskList" class="mb-4">
              <table class="table table-sm table-bordered">
                <thead class="table-light">
                  <tr>
                    <th style="text-align:center">업무명</th>
                    <th style="text-align:center">담당자</th>
                    <th style="text-align:center">기간</th>
                    <th style="text-align:center">중요도</th>
                    <th style="text-align:center">등급</th>
                  </tr>
                </thead>
                <tbody id="taskListBody">
                  <tr>
                    <td colspan="5" class="text-center text-muted">등록된 업무가 없습니다.</td>
                  </tr>
                </tbody>
              </table>
            </div>

            <!-- 4. 세부 정보 -->
            <h6 class="mt-5 mb-2 fw-bold">4. 세부 정보</h6>
            <table class="table table-bordered table-sm">
              <tbody>
                <tr><th class="bg-light w-25  text-center">수주 금액</th><td class="ps-3"><span id="confirmAmount"></span></td></tr>
                <tr><th class="bg-light  text-center">주소</th><td class="ps-3"><span id="confirmAdres"></span></td></tr>
                <tr><th class="bg-light  text-center">URL</th><td class="ps-3"><span id="confirmUrl"></span></td></tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- 오른쪽 안내 영역 -->
<!-- 오른쪽 안내 영역 -->
<div class="col-md-4">
  <div class="card border rounded-3 shadow-sm">  
    <div class="card-body p-4">
      <h5 class="card-title fw-bold mb-4 text-primary">
        <i class="fas fa-clipboard-check me-2"></i>최종 확인 안내
      </h5>
      <ul class="mb-0 ps-3">
        <li class="mb-2">입력한 모든 정보를 다시 한 번 확인해주세요.</li>
        <li class="mb-2">잘못된 정보가 있다면 이전 단계로 돌아가 수정할 수 있습니다.</li>
        <li class="mb-2">업무 및 인원 정보는 프로젝트와 함께 저장됩니다.</li>
        <li class="mb-2">확인이 완료되면 '프로젝트 생성' 버튼을 눌러 제출하세요.</li>
      </ul>
    </div>
  </div>
</div>

</div>
