<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="col-lg-4">
  <div class="card-style mb-30 sticky-top" style="top: 80px;">
    <h6 class="mb-25">프로젝트 생성 가이드</h6>
    <div class="content-area" id="guideContent">
      <!-- 기본 정보 가이드 -->
      <div class="current-guide" id="guide-step1">
        <h5 class="mb-3"><i class="fas fa-info-circle me-2 text-primary"></i>기본 정보 입력 안내</h5>
        <ul class="guide-list">
          <li>프로젝트 명은 간결하고 명확하게 작성해주세요.</li>
          <li>프로젝트 내용에는 목적, 기대효과 등을 포함해주세요.</li>
          <li>프로젝트 시작일과 종료일을 정확히 설정해주세요.</li>
          <li>프로젝트 상태는 현재 진행 상황에 맞게 선택해주세요.</li>
          <li>프로젝트 등급은 중요도에 따라 A(가장 중요)~E 중에서 선택해주세요.</li>
        </ul>
      </div>
      
      <!-- 인원 등록 가이드 -->
      <div class="current-guide" id="guide-step2" style="display: none;">
        <h5 class="mb-3"><i class="fas fa-users me-2 text-primary"></i>인원 등록 안내</h5>
        <ul class="guide-list">
          <li>조직도 버튼을 클릭하여 프로젝트 참여자를 선택해주세요.</li>
          <li>책임자는 프로젝트의 전체 책임을 맡는 관리자입니다.</li>
          <li>참여자는 실제 프로젝트에 참여하여 업무를 수행하는 인원입니다.</li>
          <li>참조자는 프로젝트 정보를 참조할 수 있는 인원입니다.</li>
        </ul>
      </div>
      
      <!-- 업무 관리 가이드 -->
      <div class="current-guide" id="guide-step3" style="display: none;">
        <h5 class="mb-3"><i class="fas fa-tasks me-2 text-primary"></i>업무 관리 안내</h5>
        <ul class="guide-list">
          <li>주요 업무를 먼저 등록한 후 하위 업무를 추가해주세요.</li>
          <li>업무 제목은 구체적으로 작성하는 것이 좋습니다.</li>
          <li>담당자는 조직도에서 선택할 수 있습니다.</li>
          <li>업무 일정을 설정할 때는 프로젝트 기간 내에서 설정해주세요.</li>
          <li>중요도와 등급을 적절히 설정하여 업무 우선순위를 관리해주세요.</li>
          <li>파일 첨부는 필요한 경우에만 추가하세요.</li>
        </ul>
        
        <!-- 업무 목록 표시 영역 (오른쪽으로 이동) -->
        <div class="mt-4 task-list-area">
          <h5 class="mb-3"><i class="fas fa-clipboard-list me-2 text-primary"></i>등록된 업무 목록</h5>
          <div id="taskListContainer" class="p-2 border rounded bg-light" style="max-height: 300px; overflow-y: auto;">
            <ul class="task-tree list-unstyled mb-0">
              <!-- 업무 목록이 여기에 표시됩니다 -->
              <li class="text-center text-muted py-3">등록된 업무가 없습니다.</li>
            </ul>
          </div>
        </div>
      </div>
      
      <!-- 세부 정보 가이드 -->
      <div class="current-guide" id="guide-step4" style="display: none;">
        <h5 class="mb-3"><i class="fas fa-file-invoice-dollar me-2 text-primary"></i>세부 정보 안내</h5>
        <ul class="guide-list">
          <li>사업 수주 금액은 숫자만 입력하세요. 자동으로 천 단위 구분 기호가 표시됩니다.</li>
          <li>주소 검색 버튼을 통해 정확한 주소를 입력해주세요.</li>
          <li>상세 주소는 건물명, 동/호수 등을 포함하여 입력해주세요.</li>
        </ul>
      </div>
      
      <!-- 최종 확인 가이드 -->
      <div class="current-guide" id="guide-step5" style="display: none;">
        <h5 class="mb-3"><i class="fas fa-check-circle me-2 text-primary"></i>최종 확인 안내</h5>
        <ul class="guide-list">
          <li>입력한 모든 정보를 꼼꼼히 확인해주세요.</li>
          <li>필수 항목이 모두 입력되었는지 확인해주세요.</li>
          <li>정보에 오류가 있다면 이전 단계로 돌아가 수정할 수 있습니다.</li>
          <li>모든 정보가 정확하다면 '프로젝트 생성' 버튼을 클릭하여 완료해주세요.</li>
        </ul>
      </div>
      
      <!-- 조직도 영역 -->
      <div id="orgChartArea" style="display: none; max-height: 500px; overflow-y: auto; border: 1px solid #ddd; border-radius: 4px; padding: 15px; background-color: #fff;">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <h5 class="mb-0"><i class="fas fa-sitemap me-2 text-primary"></i>조직도</h5>
          <button id="closeOrgChart" class="btn btn-sm btn-outline-secondary">
            <i class="fas fa-times"></i> 닫기
          </button>
        </div>
        <c:import url="../organization/orgList.jsp" />
      </div>
    </div>
  </div>
</div>

<script>
  $(document).ready(function() {
    // 조직도 닫기 버튼 클릭 이벤트
    $("#closeOrgChart").click(function() {
      if (typeof window.hideOrgChart === "function") {
        window.hideOrgChart();
      } else {
        console.error("hideOrgChart 함수를 찾을 수 없습니다.");
        // 기본 동작 제공
        $('.current-guide').hide();
        $('#guide-step' + (window.currentStep || 1)).show();
        $('#orgChartArea').hide();
      }
    });
  });
  
  // 조직도 관련 전역 함수
  function clickEmp(data) {
    const member = {
      id: data.node.id,
      name: data.node.text,
      dept: data.node.parent,  // 여기서는 부모 노드 ID를 사용, 실제로는 부서명이 나오도록 해야 함
      position: "직위",  // 실제 데이터에서 가져와야 함
      tel: "연락처",     // 실제 데이터에서 가져와야 함
      email: "이메일"    // 실제 데이터에서 가져와야 함
    };
    
    // 현재 targetType에 따라 선택 처리
    if (window.currentOrgTarget) {
      if (typeof window.selectMember === "function") {
        window.selectMember(member, window.currentOrgTarget);
      } else if (typeof selectMember === "function") {
        selectMember(member, window.currentOrgTarget);
      } else {
        console.error("selectMember 함수를 찾을 수 없습니다.");
      }
    }
  }
  
  // 부서 클릭 시 처리 (필요한 경우)
  function clickDept(data) {
    console.log("부서 선택:", data.node.text);
  }
</script>