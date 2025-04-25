<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="project-kanban-container" id="projectKanbanContent">
  <!-- 대기 상태 -->
    <c:set var="statuses" value="00,01,02,03" />
    <c:forEach var="status" items="${fn:split(statuses, ',')}">
      <c:choose>
        <c:when test="${status eq '00'}">
          <c:set var="projects" value="${waitingProjects}" />
          <c:set var="title" value="대기" />
          <c:set var="color" value="secondary" />
          <c:set var="icon" value="fa-hourglass-start" />
        </c:when>
        <c:when test="${status eq '01'}">
          <c:set var="projects" value="${inProgressProjects}" />
          <c:set var="title" value="진행중" />
          <c:set var="color" value="primary" />
          <c:set var="icon" value="fa-spinner" />
        </c:when>
        <c:when test="${status eq '02'}">
          <c:set var="projects" value="${completedProjects}" />
          <c:set var="title" value="완료" />
          <c:set var="color" value="success" />
          <c:set var="icon" value="fa-check-circle" />
        </c:when>
        <c:when test="${status eq '03'}">
          <c:set var="projects" value="${canceledProjects}" />
          <c:set var="title" value="취소" />
          <c:set var="color" value="danger" />
          <c:set var="icon" value="fa-ban" />
        </c:when>
      </c:choose>

      <div class="project-kanban-column" id="status-${status}">
        <div class="column-header bg-${color} bg-opacity-25">
          <h5><i class="fas ${icon} me-2"></i>${title}</h5>
          <span class="badge bg-${color} rounded-pill ms-2" id="count-${status}">${fn:length(projects)}</span>
        </div>
        <div class="column-body" id="body-${status}" ondragover="allowDrop(event)" ondrop="drop(event, '${status}')">
          <c:forEach var="project" items="${projects}">
            <div class="project-card grade-${project.prjctGrad} ${status eq '03' ? 'canceled-project' : ''}"
                 data-project-no="${project.prjctNo}"
                 data-project-status="${project.prjctSttus}"
                 draggable="true" ondragstart="drag(event)">

              <div class="card-header">
                <h6 class="project-title">${project.prjctNm}</h6>
                <span class="project-grade grade-badge-${project.prjctGrad}">${project.prjctGrad}</span>
              </div>

              <div class="card-body">
                <div class="project-info">
                  <div class="info-row">
                    <i class="fas fa-calendar-alt"></i>
                    <!-- 날짜 표시 (JS 포맷팅 예정) -->
					<span class="project-dates" 
					      data-begin="${project.prjctBeginDate}" 
					      data-end="${project.prjctEndDate}">
					  ${project.prjctBeginDate} ~ ${project.prjctEndDate}
					</span>


                  </div>

                  <c:if test="${not empty project.prjctRcvordAmount}">
                    <div class="info-row">
                      <i class="fas fa-coins"></i>
                      <span class="amount">
                        <fmt:formatNumber value="${project.prjctRcvordAmount}" type="number" pattern="#,#00"/>
                      </span>
                    </div>
                  </c:if>

                  <div class="project-timeline">
                    <div class="timeline-bar ${status eq '02' ? 'timeline-completed' : status eq '03' ? 'timeline-canceled' : ''}"
                         data-begin="${project.prjctBeginDate}"
                         data-end="${project.prjctEndDate}"></div>
                  </div>
                </div>
              </div>

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
  flex: 1 1 320px;
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
let originalPosition = null;

// 날짜 포맷팅 함수
function formatDate(yyyymmdd) {
  if (!yyyymmdd || yyyymmdd.length !== 8) return yyyymmdd;
  return `\${yyyymmdd.slice(0, 4)}-\${yyyymmdd.slice(4, 6)}-\${yyyymmdd.slice(6, 8)}`;
}

// 드롭 허용
function allowDrop(event) {
  event.preventDefault();
  event.currentTarget.classList.add('drag-over');
}

// 드래그 시작
function drag(event) {
  draggedCard = event.target;
  draggedCard.dataset.originalColumn = draggedCard.closest('.column-body').id;
  originalPosition = {
    parent: draggedCard.parentElement,
    nextSibling: draggedCard.nextElementSibling
  };
  event.dataTransfer.setData("text/plain", draggedCard.dataset.projectNo);
  draggedCard.classList.add('dragging');
}

// 드롭 처리
function drop(event, newStatus) {
  event.preventDefault();
  event.currentTarget.classList.remove('drag-over');

  const projectNo = event.dataTransfer.getData("text/plain");
  const originalColumnId = draggedCard.dataset.originalColumn;
  const currentColumnId = event.currentTarget.id;

  draggedCard.classList.remove('dragging');

  if (originalColumnId === currentColumnId) {
    // 같은 컬럼이면 원래 위치 유지
    if (originalPosition && originalPosition.nextSibling) {
      event.currentTarget.insertBefore(draggedCard, originalPosition.nextSibling);
    }
    return;
  }

  event.currentTarget.appendChild(draggedCard);
  draggedCard.dataset.projectStatus = newStatus;

  if (newStatus === '03') {
    draggedCard.classList.add('canceled-project');
  } else {
    draggedCard.classList.remove('canceled-project');
  }

  draggedCard.classList.add('just-moved');
  setTimeout(() => draggedCard.classList.remove('just-moved'), 1000);

  updateStatusCounts();

  // 서버 업데이트
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
      alert("상태 변경 실패: " + data.message);
      const originalColumn = document.getElementById(originalColumnId);
      if (originalColumn) {
        if (originalPosition && originalPosition.nextSibling) {
          originalColumn.insertBefore(draggedCard, originalPosition.nextSibling);
        } else {
          originalColumn.appendChild(draggedCard);
        }
        updateStatusCounts();
      }
    }
  })
  .catch(error => {
    console.error("프로젝트 상태 업데이트 오류:", error);
    alert("상태 변경 중 오류가 발생했습니다.");
  });
}

// 상태별 카운터 업데이트
function updateStatusCounts() {
  ['00', '01', '02', '03'].forEach(status => {
    const count = document.querySelectorAll(`#status-\${status} .project-card`).length;
    const badge = document.querySelector(`#count-\${status}`);
    if (badge) badge.textContent = count;
  });
}

// 칸반보드 초기화
document.addEventListener("DOMContentLoaded", function() {
  document.querySelectorAll('.project-dates').forEach(span => {
    const begin = span.dataset.begin;
    const end = span.dataset.end;
    if (begin && end) {
      // 하이픈(-) 붙인 날짜로 textContent 교체
      span.textContent = `\${formatDate(begin)} ~ \${formatDate(end)}`;
    }
  });

  updateStatusCounts();
});

</script>
