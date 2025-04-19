<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="project-kanban-container" id="projectKanbanContent">
  <!-- 대기 상태 -->
  <div class="project-kanban-column" id="status-00">
    <div class="column-header bg-secondary bg-opacity-25">
      <h5><i class="fas fa-hourglass-start me-2"></i>대기</h5>
      <span class="badge bg-secondary rounded-pill ms-2">${fn:length(waitingProjects)}</span>
    </div>
    <div class="column-body" ondragover="allowDrop(event)" ondrop="drop(event, '00')">
      <c:forEach var="project" items="${waitingProjects}">
        <div class="project-card grade-${project.prjctGrad}" data-project-no="${project.prjctNo}" data-project-status="${project.prjctSttus}" draggable="true" ondragstart="drag(event)">
          <div class="card-header">
            <h6 class="project-title">${project.prjctNm}</h6>
            <span class="project-grade grade-badge-${project.prjctGrad}">${project.prjctGrad}</span>
          </div>
          <div class="card-body">
            <div class="project-info">
              <div class="info-row">
                <i class="fas fa-calendar-alt"></i>
                <span>${project.prjctBeginDate} ~ ${project.prjctEndDate}</span>
              </div>
              <c:if test="${not empty project.prjctRcvordAmount}">
                <div class="info-row">
                  <i class="fas fa-coins"></i>
                  <span class="amount"><fmt:formatNumber value="${project.prjctRcvordAmount}" type="number" pattern="#,#00"/></span>
                </div>
              </c:if>
              <div class="project-timeline">
                <div class="timeline-bar" data-begin="${project.prjctBeginDate}" data-end="${project.prjctEndDate}"></div>
              </div>
            </div>
          </div>
		<!-- 카드 푸터 수정 -->
<div class="card-footer">
  <span class="category-tag">${project.ctgryNm}</span>
  <a href="/project/projectDetail?prjctNo=${project.prjctNo}" class="detail-badge ms-auto">
    <i class="fas fa-info-circle me-1"></i>상세보기
  </a>
</div>
        </div>
      </c:forEach>
    </div>
  </div>

  <!-- 진행중 상태 -->
  <div class="project-kanban-column" id="status-01">
    <div class="column-header bg-primary bg-opacity-25">
      <h5><i class="fas fa-spinner me-2"></i>진행중</h5>
      <span class="badge bg-primary rounded-pill ms-2">${fn:length(inProgressProjects)}</span>
    </div>
    <div class="column-body" ondragover="allowDrop(event)" ondrop="drop(event, '01')">
      <c:forEach var="project" items="${inProgressProjects}">
        <%-- 동일한 구조 --%>
        <div class="project-card grade-${project.prjctGrad}" data-project-no="${project.prjctNo}" data-project-status="${project.prjctSttus}" draggable="true" ondragstart="drag(event)">
          <div class="card-header">
            <h6 class="project-title">${project.prjctNm}</h6>
            <span class="project-grade grade-badge-${project.prjctGrad}">${project.prjctGrad}</span>
          </div>
          <div class="card-body">
            <div class="project-info">
              <div class="info-row">
                <i class="fas fa-calendar-alt"></i>
                <span>${project.prjctBeginDate} ~ ${project.prjctEndDate}</span>
              </div>
              <c:if test="${not empty project.prjctRcvordAmount}">
                <div class="info-row">
                  <i class="fas fa-coins"></i>
                  <span class="amount"><fmt:formatNumber value="${project.prjctRcvordAmount}" type="number" pattern="#,#00"/></span>
                </div>
              </c:if>
              <div class="project-timeline">
                <div class="timeline-bar" data-begin="${project.prjctBeginDate}" data-end="${project.prjctEndDate}"></div>
              </div>
            </div>
          </div>
		<!-- 카드 푸터 수정 -->
<div class="card-footer">
  <span class="category-tag">${project.ctgryNm}</span>
  <a href="/project/projectDetail?prjctNo=${project.prjctNo}" class="detail-badge ms-auto">
    <i class="fas fa-info-circle me-1"></i>상세보기
  </a>
</div>
        </div>
      </c:forEach>
    </div>
  </div>

  <!-- 완료 상태 -->
  <div class="project-kanban-column" id="status-02">
    <div class="column-header bg-success bg-opacity-25">
      <h5><i class="fas fa-check-circle me-2"></i>완료</h5>
      <span class="badge bg-success rounded-pill ms-2">${fn:length(completedProjects)}</span>
    </div>
    <div class="column-body" ondragover="allowDrop(event)" ondrop="drop(event, '02')">
      <c:forEach var="project" items="${completedProjects}">
        <%-- 동일한 카드 구조 --%>
        <div class="project-card grade-${project.prjctGrad}" data-project-no="${project.prjctNo}" data-project-status="${project.prjctSttus}" draggable="true" ondragstart="drag(event)">
          <div class="card-header">
            <h6 class="project-title">${project.prjctNm}</h6>
            <span class="project-grade grade-badge-${project.prjctGrad}">${project.prjctGrad}</span>
          </div>
          <div class="card-body">
            <div class="project-info">
              <div class="info-row">
                <i class="fas fa-calendar-alt"></i>
                <span>${project.prjctBeginDate} ~ ${project.prjctEndDate}</span>
              </div>
              <c:if test="${not empty project.prjctRcvordAmount}">
                <div class="info-row">
                  <i class="fas fa-coins"></i>
                  <span class="amount"><fmt:formatNumber value="${project.prjctRcvordAmount}" type="number" pattern="#,#00"/></span>
                </div>
              </c:if>
              <div class="project-timeline">
                <div class="timeline-bar timeline-completed" style="width: 100%"></div>
              </div>
            </div>
          </div>
		<!-- 카드 푸터 수정 -->
<div class="card-footer">
  <span class="category-tag">${project.ctgryNm}</span>
  <a href="/project/projectDetail?prjctNo=${project.prjctNo}" class="detail-badge ms-auto">
    <i class="fas fa-info-circle me-1"></i>상세보기
  </a>
</div>
        </div>
      </c:forEach>
    </div>
  </div>

  <!-- 취소 상태 -->
  <div class="project-kanban-column" id="status-03">
    <div class="column-header bg-danger bg-opacity-25">
      <h5><i class="fas fa-ban me-2"></i>취소</h5>
      <span class="badge bg-danger rounded-pill ms-2">${fn:length(canceledProjects)}</span>
    </div>
    <div class="column-body" ondragover="allowDrop(event)" ondrop="drop(event, '03')">
      <c:forEach var="project" items="${canceledProjects}">
        <div class="project-card grade-${project.prjctGrad} canceled-project" data-project-no="${project.prjctNo}" data-project-status="${project.prjctSttus}" draggable="true" ondragstart="drag(event)">
          <div class="card-header">
            <h6 class="project-title">${project.prjctNm}</h6>
            <span class="project-grade grade-badge-${project.prjctGrad}">${project.prjctGrad}</span>
          </div>
          <div class="card-body">
            <div class="project-info">
              <div class="info-row">
                <i class="fas fa-calendar-alt"></i>
                <span>${project.prjctBeginDate} ~ ${project.prjctEndDate}</span>
              </div>
              <c:if test="${not empty project.prjctRcvordAmount}">
                <div class="info-row">
                  <i class="fas fa-coins"></i>
                  <span class="amount"><fmt:formatNumber value="${project.prjctRcvordAmount}" type="number" pattern="#,#00"/></span>
                </div>
              </c:if>
              <div class="project-timeline">
                <div class="timeline-bar timeline-canceled" data-begin="${project.prjctBeginDate}" data-end="${project.prjctEndDate}"></div>
              </div>
            </div>
          </div>
		<!-- 카드 푸터 수정 -->
<div class="card-footer">
  <span class="category-tag">${project.ctgryNm}</span>
  <a href="/project/projectDetail?prjctNo=${project.prjctNo}" class="detail-badge ms-auto">
    <i class="fas fa-info-circle me-1"></i>상세보기
  </a>
</div>
        </div>
      </c:forEach>
    </div>
  </div>
</div>


<!-- 프로젝트 칸반보드 스타일 -->
<style>
/* 칸반보드 컨테이너 스타일 */
.project-kanban-container {
  display: flex;
  gap: 16px;
  padding: 16px;
  overflow-x: auto;
  min-height: calc(100vh - 200px);
  background-color: #f5f7f9;
}

/* 칸반 컬럼 스타일 */
.project-kanban-column {
  flex: 0 0 320px;
  display: flex;
  flex-direction: column;
  background-color: #f0f2f5;
  border-radius: 10px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
  overflow: hidden;
}

.column-header {
  padding: 16px;
  display: flex;
  align-items: center;
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
}

.column-header h5 {
  margin: 0;
  font-size: 16px;
  font-weight: 600;
}

.column-body {
  flex: 1;
  padding: 12px;
  overflow-y: auto;
  min-height: 100px;
}

/* 프로젝트 카드 스타일 */
.project-card {
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.07);
  margin-bottom: 12px;
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
  overflow: hidden;
  border-left: 5px solid #ccc;
}

.project-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
}

/* 등급별 테두리 색상 */
.project-card.grade-A {
  border-left-color: #ffd700; /* 금색 */
  border-left-width: 6px;
}

.project-card.grade-B {
  border-left-color: #c0c0c0; /* 은색 */
  border-left-width: 5px;
}

.project-card.grade-C {
  border-left-color: #2ecc71; /* 녹색 */
  border-left-width: 4px;
}

.project-card.grade-D {
  border-left-color: #3498db; /* 파란색 */
  border-left-width: 3px;
}

.project-card.grade-E {
  border-left-color: #bdc3c7; /* 회색 */
  border-left-width: 2px;
}

/* 취소된 프로젝트 스타일 */
.project-card.canceled-project {
  opacity: 0.8;
  background-color: #f9f9f9;
}

/* 카드 헤더 */
.card-header {
  padding: 12px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px solid #eee;
}

.project-title {
  margin: 0;
  font-size: 15px;
  font-weight: 600;
  line-height: 1.3;
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* 등급 배지 */
.project-grade {
  font-size: 12px;
  font-weight: bold;
  padding: 3px 6px;
  border-radius: 3px;
  margin-left: 8px;
}

.grade-badge-A {
  background-color: #fff8e1;
  color: #ff9800;
  border: 1px solid #ffe082;
}

.grade-badge-B {
  background-color: #f5f5f5;
  color: #757575;
  border: 1px solid #e0e0e0;
}

.grade-badge-C {
  background-color: #e8f5e9;
  color: #4caf50;
  border: 1px solid #c8e6c9;
}

.grade-badge-D {
  background-color: #e3f2fd;
  color: #2196f3;
  border: 1px solid #bbdefb;
}

.grade-badge-E {
  background-color: #f5f5f5;
  color: #9e9e9e;
  border: 1px solid #eeeeee;
}

/* 카드 본문 */
.card-body {
  padding: 12px;
}

.project-info {
  font-size: 13px;
}

.info-row {
  display: flex;
  align-items: center;
  margin-bottom: 8px;
}

.info-row i {
  width: 16px;
  margin-right: 8px;
  color: #666;
}

.amount {
  font-weight: 600;
}

/* 프로젝트 타임라인 */
.project-timeline {
  height: 6px;
  background-color: #eee;
  border-radius: 3px;
  overflow: hidden;
  margin-top: 10px;
}

.timeline-bar {
  height: 100%;
  background-color: #4299e1;
  border-radius: 3px;
}

.timeline-completed {
  background-color: #48bb78;
}

.timeline-canceled {
  background-color: #e53e3e;
  opacity: 0.7;
}

/* 카드 푸터 */
.card-footer {
  padding: 10px 12px;
  display: flex;
  align-items: center;
  border-top: 1px solid #eee;
  background-color: #fafafa;
}

.category-tag {
  font-size: 12px;
  background-color: #f0f2f5;
  color: #666;
  padding: 2px 6px;
  border-radius: 3px;
}

/* 드래그 중인 카드 스타일 */
.project-card.dragging {
  opacity: 0.6;
  transform: scale(0.98);
}

/* 드래그 오버 효과 */
.column-body.drag-over {
  background-color: #f0f7ff;
  box-shadow: inset 0 0 0 2px rgba(38, 128, 235, 0.2);
}

/* 방금 이동된 카드 효과 */
.project-card.just-moved {
  animation: highlight-card 1s ease;
}

@keyframes highlight-card {
  0%, 100% { background-color: #fff; }
  50% { background-color: #f0f7ff; }
}

/* 상태별 배경색 */
.bg-light-gray { 
  background-color: #f5f5f5; 
}
.bg-light-yellow { 
  background-color: #fff8e1; 
}
.bg-light-green { 
  background-color: #e8f5e9; 
}
.bg-light-red { 
  background-color: #ffebee; 
}

/* 상세보기 링크 스타일 */
.detail-link {
  color: #4a6fdc;
  font-size: 12px;
  font-weight: 500;
  cursor: pointer;
  transition: color 0.2s;
}

.detail-link:hover {
  color: #2c4ea3;
  text-decoration: underline;
}


/* 상세보기 뱃지 스타일 */
.detail-badge {
  display: inline-flex;
  align-items: center;
  background-color: #e3f2fd;
  color: #0d6efd;
  font-size: 11px;
  font-weight: 600;
  padding: 4px 8px;
  border-radius: 4px;
  text-decoration: none;
  transition: all 0.2s ease;
  border: 1px solid #bbd9fa;
}

.detail-badge:hover {
  background-color: #0d6efd;
  color: #ffffff;
  text-decoration: none;
}

/* 아이콘 버튼 스타일 */
.btn-detail {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 28px;
  height: 28px;
  border-radius: 50%;
  background-color: #e3f2fd;
  color: #0d6efd;
  transition: all 0.2s ease;
  border: 1px solid #bbd9fa;
}

.btn-detail:hover {
  background-color: #0d6efd;
  color: #ffffff;
  transform: scale(1.1);
}

/* 푸터 레이아웃 조정 */
.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 12px;
}



</style>

<!-- 프로젝트 칸반보드 스크립트 -->
<script>
// 전역 변수
let draggedCard = null;

// 드롭 허용
function allowDrop(event) {
  event.preventDefault();
  // 드래그 오버 시 시각적 효과
  event.currentTarget.classList.add('drag-over');
}

// 드래그 시작
function drag(event) {
  draggedCard = event.target;
  // 원래 상태 저장 (실패 시 되돌리기 위해)
  draggedCard.dataset.originalColumn = draggedCard.parentElement.id;
  event.dataTransfer.setData("text/plain", event.target.dataset.projectNo);
  
  // 드래그 중인 카드 스타일 추가
  draggedCard.classList.add('dragging');
  
  // 드래그 오버 효과 제거 이벤트 추가
  document.querySelectorAll('.column-body').forEach(column => {
    column.addEventListener('dragleave', function(e) {
      e.currentTarget.classList.remove('drag-over');
    }, { once: true });
  });
}

// 드롭 처리
function drop(event, newStatus) {
  event.preventDefault();
  // 드래그 오버 효과 제거
  event.currentTarget.classList.remove('drag-over');
  
  const projectNo = event.dataTransfer.getData("text/plain");
  
  // UI 먼저 업데이트
  if (draggedCard) {
    // 드래그 스타일 제거
    draggedCard.classList.remove('dragging');
    
    // 카드를 새 컬럼으로 즉시 이동
    event.currentTarget.appendChild(draggedCard);
    
    // 이동 효과 추가
    draggedCard.classList.add('just-moved');
    setTimeout(() => {
      draggedCard.classList.remove('just-moved');
    }, 1000);
    
    // 상태 데이터 업데이트
    draggedCard.dataset.projectStatus = newStatus;
    
    // 취소 상태인 경우 시각적 변경
    if (newStatus === '03') {
      draggedCard.classList.add('canceled-project');
    } else {
      draggedCard.classList.remove('canceled-project');
    }
  }
  
  // 서버에 상태 변경 요청
  fetch("/project/kanban/update-project-status", {
    method: "POST",
    headers: { 
      "Content-Type": "application/json",
      "X-CSRF-TOKEN": document.querySelector("meta[name='_csrf']")?.getAttribute("content") 
    },
    body: JSON.stringify({ projectNo: projectNo, status: newStatus })
  })
  .then(res => res.json())
  .then(data => {
    if (!data.success) {
      // 실패 시 사용자에게 알림
      alert("상태 변경 실패: " + data.message);
      
      // 원래 위치로 되돌리기
      const originalColumn = document.getElementById(draggedCard.dataset.originalColumn);
      if (originalColumn && draggedCard) {
        originalColumn.appendChild(draggedCard);
        // 원래 상태로 데이터 되돌리기
        const originalStatus = draggedCard.dataset.projectStatus;
        draggedCard.dataset.projectStatus = originalStatus;
      }
    }
  })
  .catch(error => {
    console.error("프로젝트 상태 업데이트 오류:", error);
    alert("상태 변경 중 오류가 발생했습니다.");
  });
}

// 프로젝트 상세 정보 모달 열기
function openProjectDetailModal(projectNo) {
  // AJAX로 프로젝트 상세 정보 가져오기
  fetch(`/project/detail?projectNo=${projectNo}`)
    .then(response => response.text())
    .then(html => {
      document.getElementById('projectDetailModalContent').innerHTML = html;
      
      // 수정 버튼에 이벤트 추가
      document.getElementById('editProjectBtn').addEventListener('click', function() {
        location.href = `/project/edit?projectNo=${projectNo}`;
      });
      
      // 모달 표시
      const modal = new bootstrap.Modal(document.getElementById('projectDetailModal'));
      modal.show();
    })
    .catch(error => {
      console.error('프로젝트 상세 정보를 불러오는 데 실패했습니다:', error);
      alert('프로젝트 상세 정보를 불러오는 데 실패했습니다.');
    });
}

// 프로젝트 기간 기반 진행률 계산 함수
function calculateProgress(beginDate, endDate) {
  if (!beginDate || !endDate) return 0;
  
  const today = new Date();
  const begin = new Date(
    beginDate.substring(0, 4), 
    beginDate.substring(4, 6) - 1, 
    beginDate.substring(6, 8)
  );
  const end = new Date(
    endDate.substring(0, 4), 
    endDate.substring(4, 6) - 1, 
    endDate.substring(6, 8)
  );
  
  // 프로젝트 아직 시작 안 함
  if (today < begin) return 0;
  
  // 프로젝트 이미 종료
  if (today > end) return 100;
  
  // 진행 중인 프로젝트 진행률 계산
  const totalDuration = end - begin;
  const elapsedDuration = today - begin;
  return Math.round((elapsedDuration / totalDuration) * 100);
}

// 프로젝트 칸반보드 초기화 (페이지 로드/탭 클릭 시 호출)
document.addEventListener("DOMContentLoaded", function() {
  // 프로젝트 칸반보드 탭이 표시될 때 초기화
  document.querySelector('[data-bs-target="#projectKanban"]')?.addEventListener("shown.bs.tab", function() {
    // 프로젝트 카드 클릭 이벤트
    document.querySelectorAll('#projectKanban .project-card').forEach(card => {
      card.addEventListener('click', function(e) {
        if (!e.target.closest('.card-action-btn')) {
          const projectNo = this.dataset.projectNo;
          openProjectDetailModal(projectNo);
        }
      });
    });
  });
});
</script>