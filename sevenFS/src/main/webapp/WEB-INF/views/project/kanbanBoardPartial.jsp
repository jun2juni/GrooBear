
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!-- 숨겨진 프로젝트 번호 -->
<div id="projectKanbanBoard" data-prjct-no="${prjctNo}" style="display:none;"></div>

<!-- 칸반보드 3개 상태 컬럼 -->
<div class="d-flex gap-3 kanban-board-container w-100">
  <c:set var="columns">
    <c:out value="00:대기,01:진행중,02:완료" />
  </c:set>
  <c:forEach var="col" items="${fn:split(columns, ',')}">
    <c:set var="statusCode" value="${fn:split(col, ':')[0]}" />
    <c:set var="statusName" value="${fn:split(col, ':')[1]}" />
    <div class="kanban-col">
      <div class="kanban-header bg-light-${statusName eq '대기' ? 'gray' : statusName eq '진행중' ? 'yellow' : 'green'}">
        <h6 class="status-title">${statusName}</h6>
      </div>
      <div class="kanban-column" id="status-${statusCode}" ondragover="allowDrop(event)" ondrop="drop(event)">
        <c:forEach var="task" items="${statusCode eq '00' ? queuedCards : statusCode eq '01' ? servingCards : completedCards}">
          <div class="kanban-card"
               data-id="${task.taskNo}"
               data-status="${task.taskSttus}"
               data-end-date="${task.taskEndDt}"
               draggable="true"
               ondragstart="drag(event)"
               onclick="viewCardDetails(${task.taskNo})">
            ${task.taskNm}
          </div>
        </c:forEach>
      </div>
    </div>
  </c:forEach>
</div>

<!-- 업무 상세 정보 모달 -->
<div class="modal fade" id="taskDetailModal" tabindex="-1" aria-labelledby="taskDetailModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="taskDetailModalLabel">업무 상세 정보</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="taskDetailModalContent"></div>
    </div>
  </div>
</div>



<!-- 스타일 -->
<style>
/* 전체 컨테이너 높이 */
.row.h-100 {
  min-height: 85vh;
}

/* 프로젝트 목록 스타일 */
.project-list-scroll {
  max-height: 70vh;
  overflow-y: auto;
  border-radius: 0;
}

.project-item {
  transition: all 0.2s ease;
  cursor: pointer;
  border-left: 3px solid transparent;
  padding: 12px 15px;
}

.project-item:hover {
  background-color: #f8f9fa;
  border-left-color: #6c757d;
  transform: translateX(3px);
}

.project-item.active {
  background-color: #e9ecef;
  border-left-color: #0d6efd;
  font-weight: 600;
}

.project-name {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* 칸반보드 컨테이너 */
.kanban-board-container {
  height: calc(85vh - 20px);
}

/* 칸반 컬럼 스타일 */
.kanban-col {
  min-width: 240px;
  flex: 1; 
  display: flex;
  flex-direction: column;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 5px rgba(0,0,0,0.05);
}

/* 칸반 헤더 스타일 */
.kanban-header {
  padding: 12px 16px;
  border-bottom: 1px solid rgba(0,0,0,0.1);
}

.status-title {
  margin: 0;
  font-weight: 600;
  text-align: center;
}

/* 칸반 컬럼 내부 스타일 */
.kanban-column {
  flex: 1;
  min-height: 65vh;
  padding: 12px;
  background-color: #f9f9f9;
  overflow-y: auto;
}

/* 칸반 카드 스타일 */
.kanban-card {
  background: #fff;
  border-left: 4px solid #5c6bc0;
  padding: 12px 16px;
  margin-bottom: 10px;
  border-radius: 6px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
  cursor: grab;
  transition: all 0.2s ease;
  word-break: break-word;
}

.kanban-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

/* 드래그 중인 카드 스타일 */
.kanban-card.dragging {
  opacity: 0.6;
  transform: scale(0.95);
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
.bg-light-blue { 
  background-color: #e3f2fd; 
}

/* 드래그 오버 효과 */
.kanban-column.drag-over {
  background-color: rgba(0,0,0,0.03);
  box-shadow: inset 0 0 0 2px rgba(0,0,0,0.1);
}

/* 빈 칸반 메시지 */
.empty-column-message {
  color: #9e9e9e;
  text-align: center;
  padding: 20px 0;
  font-style: italic;
}

/* 방금 이동된 카드 효과 */
.kanban-card.just-moved {
  animation: highlight-card 1s ease;
}

@keyframes highlight-card {
  0%, 100% { background-color: #fff; }
  50% { background-color: #e3f2fd; }
}

/* 프로젝트 목록 스타일 */
.project-header {
  background-color: #f5f5f5;
  padding: 0.75rem 1rem;
  margin-bottom: 0.5rem;
  border-bottom: 1px solid #dee2e6;
}

.project-item {
  transition: all 0.2s ease;
  cursor: pointer;
  border-left: 3px solid transparent;
  padding: 12px 15px;
}

.project-item:hover {
  background-color: #f8f9fa;
  border-left-color: #6c757d;
  transform: translateX(3px);
}

.project-item.active {
  background-color: #e9ecef;
  border-left-color: #0d6efd;
  font-weight: 600;
}

.project-name {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}


/* 프로젝트 목록 너비 조절 */
@media (min-width: 768px) {
  #kanbanProjectListArea {
    flex: 0 0 250px; /* 고정 너비로 변경 (기존 25% 대신) */
    max-width: 250px;
    transition: width 0.3s ease;
  }
  
  #kanbanBoardContainer {
    flex: 1; /* 남은 공간 모두 사용 */
    max-width: calc(100% - 250px);
  }
}

/* 프로젝트 목록 헤더 스타일 */
#kanbanProjectListArea .kanban-header {
  padding: 12px 16px;
  border-bottom: 1px solid rgba(0,0,0,0.1);
  margin-bottom: 10px;
}

/* 프로젝트 목록 스타일 개선 */
.project-list-scroll {
  max-height: calc(85vh - 60px); /* 헤더 높이 고려 */
  overflow-y: auto;
  border-radius: 0;
}

/* 프로젝트 목록 헤더 스타일 */
.kanban-header {
  padding: 12px 16px;
  border-bottom: 1px solid rgba(0,0,0,0.1);
}

.status-title {
  margin: 0;
  font-weight: 600;
  text-align: center;
}

/* 프로젝트 목록 너비 조절 */
@media (min-width: 768px) {
  #kanbanProjectListArea {
    flex: 0 0 250px;
    width: 250px;
    max-width: 250px;
    padding-right: 0;
  }
  
  #kanbanBoardContainer {
    flex: 1;
    max-width: calc(100% - 250px);
    margin-left: 0;
    padding-left: 15px;
  }
}

/* 프로젝트 목록 스타일 */
.project-list-scroll {
  max-height: calc(85vh - 60px);
  overflow-y: auto;
  border-radius: 0;
}

/* 칸반 컬럼들 고정 너비로 수정 */
.kanban-board-container {
  width: 100%;
  display: flex;
  justify-content: space-between;
}


.kanban-col:last-child {
  margin-right: 0;
}


/* 전체 컨테이너 스타일 */
.tab-content {
  width: 100%;
}

/* 칸반보드 레이아웃 조정 */
#taskKanban .row {
  margin: 0;
  width: 100%;
}

/* 프로젝트 목록 너비 조절 */
#kanbanProjectListArea {
  width: 250px;
  flex: 0 0 250px;
  max-width: 250px;
  padding-right: 0;
}

/* 칸반보드 컨테이너 조정 */
#kanbanBoardContainer {
  flex: 1;
  width: 100%;
  padding-left: 15px;
  padding-right: 15px;
}

/* 칸반 컬럼들 균등 분배 */
.kanban-board-container {
  width: 100%;
  display: flex;
  justify-content: space-between;
}

.kanban-col {
  flex: 1;
  min-width: 0;
  margin-right: 10px;
}

.kanban-col:last-child {
  margin-right: 0;
}


.kanban-card.has-comment {
  position: relative;
}
.kanban-card .comment-indicator {
  position: absolute;
  top: 6px;
  right: 8px;
  width: 10px;
  height: 10px;
  background-color: red;
  border-radius: 50%;
}
.kanban-card.deadline-soon {
  border-left-color: red !important;
}
</style>

<!-- 칸반 드래그 앤 드롭 스크립트 -->
<script>
// 전역 변수
var draggedCard = null;

// 페이지 로드 시 실행
document.addEventListener("DOMContentLoaded", function() {
  // 프로젝트 아이템 활성화
  const projectItems = document.querySelectorAll('.project-item');
  projectItems.forEach(item => {
    item.addEventListener('click', function() {
      projectItems.forEach(i => i.classList.remove('active'));
      this.classList.add('active');
    });
  });
  
  // 첫 번째 프로젝트가 있으면 활성화
  if(projectItems.length > 0 && document.getElementById('projectKanbanBoard')?.dataset.prjctNo) {
    const currentPrjctNo = document.getElementById('projectKanbanBoard').dataset.prjctNo;
    const activeProject = document.querySelector(`.project-item[data-prjct-no="${currentPrjctNo}"]`);
    if(activeProject) {
      activeProject.classList.add('active');
    }
  }
});

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
  event.dataTransfer.setData("text/plain", event.target.dataset.id);
  
  // 드래그 중인 카드 스타일 추가
  draggedCard.classList.add('dragging');
  
  // 드래그 오버 효과 제거 이벤트 추가
  document.querySelectorAll('.kanban-column').forEach(column => {
    column.addEventListener('dragleave', function(e) {
      e.currentTarget.classList.remove('drag-over');
    }, { once: true });
  });
}

// 드롭 처리
function drop(event) {
  event.preventDefault();
  // 드래그 오버 효과 제거
  event.currentTarget.classList.remove('drag-over');
  
  const taskId = event.dataTransfer.getData("text/plain");
  const newStatus = event.currentTarget.id.replace("status-", "");
  
  // 서버에 상태 변경 요청 전에 UI 먼저 업데이트 (최적화된 사용자 경험)
  if (draggedCard) {
    // 드래그 스타일 제거
    draggedCard.classList.remove('dragging');
    
    // 카드를 새 컬럼으로 즉시 이동
    event.currentTarget.appendChild(draggedCard);
    
    // 수정 표시 효과
    draggedCard.classList.add('just-moved');
    setTimeout(() => {
      draggedCard.classList.remove('just-moved');
    }, 1000);
    
    // 상태 데이터 업데이트
    draggedCard.dataset.status = newStatus;
  }
  
  // 서버에 상태 변경 요청
  fetch("/project/kanban/update-status", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ cardId: taskId, status: newStatus })
  })
    .then(res => res.json())
    .then(data => {
      if (!data.success) {
        // 실패 시 사용자에게 알림
        alert("상태 변경 실패: " + data.message);
        
        // 실패했을 경우 원래 위치로 되돌리기
        const originalColumn = document.getElementById(draggedCard.dataset.originalColumn);
        if (originalColumn && draggedCard) {
          originalColumn.appendChild(draggedCard);
          // 원래 상태로 데이터 되돌리기
          const originalStatus = originalColumn.id.replace("status-", "");
          draggedCard.dataset.status = originalStatus;
        }
      }
    })
    .catch(error => {
      console.error("카드 상태 업데이트 오류:", error);
      alert("상태 변경 중 오류가 발생했습니다.");
      
      // 오류 시 원래 위치로 되돌리기
      const originalColumn = document.getElementById(draggedCard.dataset.originalColumn);
      if (originalColumn && draggedCard) {
        originalColumn.appendChild(draggedCard);
        // 원래 상태로 데이터 되돌리기
        const originalStatus = originalColumn.id.replace("status-", "");
        draggedCard.dataset.status = originalStatus;
      }
    });
}

// 업무 상세 정보 보기
function viewCardDetails(taskId) {
	openTaskModal(taskId);
  // 서버에서 업무 상세 정보를 가져와서 모달로 표시
  $.ajax({
    url: '/projectTask/detail',  // 기존 업무 상세 정보를 가져오는 엔드포인트
    type: 'GET',
    data: { taskNo: taskId },
    success: function(response) {
      // 모달 내용 업데이트
      $('#taskDetailModalContent').html(response);
      
      // 모달 표시
      $('#taskDetailModal').modal('show');
    },
    error: function(xhr, status, error) {
      console.error('업무 상세 정보를 불러오는 데 실패했습니다.', error);
      alert('업무 상세 정보를 불러오는 데 실패했습니다.');
    }
  });
}


document.addEventListener("DOMContentLoaded", function() {
	  // 프로젝트 목록 영역 찾기
	  const projectListArea = document.getElementById('kanbanProjectListArea');

	  // 이미 헤더가 있는지 확인하고 없으면 추가
	  if (projectListArea && !projectListArea.querySelector('.project-header')) {
	    // 헤더 요소 생성 - 칸반보드 헤더와 비슷한 스타일로 변경
	    const headerDiv = document.createElement('div');
	    headerDiv.className = 'kanban-header bg-light-gray'; // 칸반보드 헤더와 같은 클래스 사용
	    headerDiv.innerHTML = `
	      <h6 class="status-title">프로젝트 목록</h6>
	    `;

	    // 목록 컨테이너 앞에 헤더 삽입
	    projectListArea.insertBefore(headerDiv, projectListArea.firstChild);

	    // 목록 아이템에 스타일과 아이콘 추가
	    const listItems = projectListArea.querySelectorAll('.project-item');
	    listItems.forEach(item => {
	      // 아이콘이 없는 경우에만 추가
	      if (!item.querySelector('.material-icons-outlined')) {
	        const itemText = item.textContent.trim();
	        item.style.display = 'flex';
	        item.style.alignItems = 'center';
	        item.innerHTML = `
	          <span class="material-icons-outlined me-2 text-muted">assignment</span>
	          <span class="project-name">${itemText}</span>
	        `;
	      }
	    });
	  }
	});
	
	
	
	
// 칸반보드 헤더
function addProjectListHeader() {
  const projectListArea = document.getElementById('kanbanProjectListArea');
  
  // 이미 헤더가 있는지 확인
  if (projectListArea && !projectListArea.querySelector('.project-header')) {
    // 헤더 요소 생성
    const headerDiv = document.createElement('div');
    headerDiv.className = 'project-header kanban-header bg-light-gray';
    headerDiv.innerHTML = `
      <h6 class="status-title">프로젝트 목록</h6>
    `;
    
    // 첫 번째 자식 요소 앞에 헤더 삽입
    projectListArea.insertBefore(headerDiv, projectListArea.firstChild);
    
    console.log("프로젝트 목록 헤더 추가 완료");
  }
}

// 칸반 탭이 표시될 때 헤더 추가
document.querySelector('[data-bs-target="#taskKanban"]')?.addEventListener("shown.bs.tab", function() {
  setTimeout(addProjectListHeader, 100);
});

// 페이지 로드 시 확인
document.addEventListener("DOMContentLoaded", function() {
  if (document.querySelector('#taskKanban.active')) {
    setTimeout(addProjectListHeader, 100);
  }
});

if (typeof originalLoadKanbanBoard === 'undefined') {
	  var originalLoadKanbanBoard = window.loadKanbanBoard;
	}
	
// 기존 loadKanbanBoard 함수 이후에도 실행
if (originalLoadKanbanBoard) {
  window.loadKanbanBoard = function(prjctNo) {
    originalLoadKanbanBoard(prjctNo);
    setTimeout(addProjectListHeader, 300);
  };
}


	


// 칸반보드 업무 클릭 이벤트 처리
$(document).ready(function() {
  // 칸반보드의 업무 카드 클릭 이벤트 처리
  $(document).on('click', '.kanban-item', function(e) {
    // 편집 버튼이나 다른 상호작용 요소 클릭 시 모달 열리지 않도록
    if ($(e.target).closest('.kanban-item-actions').length) {
      return;
    }
    
    const taskNo = $(this).data('task-no');
    openTaskDetailModal(taskNo);
  });
  
  // 모달 닫기 버튼 이벤트
  $(document).on('click', '.close-task-modal, .modal-backdrop', function() {
    $('#taskDetailModal').modal('hide');
  });
});

// 업무 상세 모달 열기 함수
function openTaskDetailModal(taskNo) {
  $.ajax({
    url: '/projectTask/detail',
    type: 'GET',
    data: { taskNo: taskNo },
    success: function(response) {
      // 모달 내용 업데이트
      $('#taskDetailModalContent').html(response);
      
      // 모달 표시
      $('#taskDetailModal').modal('show');
    },
    error: function(xhr, status, error) {
      console.error('업무 상세 정보를 불러오는 데 실패했습니다.', error);
      alert('업무 상세 정보를 불러오는 데 실패했습니다.');
    }
  });
}
	
	
	
function highlightDeadlineSoon() {
	  const cards = document.querySelectorAll('.kanban-card');
	  const today = new Date();
	  cards.forEach(card => {
	    const endDateStr = card.dataset.endDate;
	    if (!endDateStr) return;
	    const endDate = new Date(endDateStr);
	    if (isNaN(endDate)) return;
	    const diffTime = endDate - today;
	    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
	    if (diffDays <= 3) {
	      card.classList.add('deadline-soon');
	    }
	  });
	}

	function viewCardDetails(taskId) {
	  $.ajax({
	    url: '/projectTask/detail',
	    type: 'GET',
	    data: { taskNo: taskId },
	    success: function(response) {
	      $('#taskDetailModalContent').html(response);
	      $('#taskDetailModal').modal('show');
	      const card = document.querySelector(`.kanban-card[data-id='${taskId}']`);
	      if (card) {
	        card.classList.remove('has-comment');
	        const dot = card.querySelector('.comment-indicator');
	        if (dot) dot.remove();
	      }
	    },
	    error: function(xhr, status, error) {
	      alert('업무 상세 정보를 불러오는 데 실패했습니다.');
	    }
	  });
	}

	document.addEventListener('DOMContentLoaded', function() {
	  highlightDeadlineSoon();
	});
</script>



