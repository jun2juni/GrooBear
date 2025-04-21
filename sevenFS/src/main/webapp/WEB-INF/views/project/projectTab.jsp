<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="title" scope="application" value="프로젝트 관리" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>${title}</title>
  <%@ include file="../layout/prestyle.jsp" %>
  <style>
    .tab-grid {
      grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
    }
    .tab-btn {
      display: flex; align-items: center; justify-content: center;
      gap: 6px; padding: 10px 14px; font-weight: 600; font-size: 14px;
      border: 2px solid transparent; border-radius: 10px;
      background-color: white; transition: all 0.3s ease; cursor: pointer;
    }
    .tab-btn span { font-size: 18px; }
    .tab-btn:hover { transform: scale(1.03); }
    .tab-btn.active {
      color: white; background-color: var(--tab-color); border-color: var(--tab-color);
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }
    .tab-btn:not(.active) {
      background-color: white; color: var(--tab-color); border: 2px solid var(--tab-color);
    }
    .tab-blue { --tab-color: #5c6bc0; }
    .tab-green { --tab-color: #66bb6a; }
    .tab-orange { --tab-color: #ff7043; }
    .tab-purple { --tab-color: #ab47bc; }
    .tab-yellow { --tab-color: #fbc02d; }

    .tab-content-animated {
      border: 1px solid transparent;
      border-radius: 12px;
      padding: 20px;
      margin-top: 10px;
      animation: border-fill 1.2s ease forwards;
    }

    @keyframes border-fill {
      0% { border-color: transparent; background: white; box-shadow: none; }
      100% { box-shadow: 0 0 0 3px var(--tab-color); border-color: var(--tab-color); }
    }

    .project-sidebar-list .project-item:hover {
      background-color: #f5f5f5;
      font-weight: bold;
    }

    .project-list-scroll {
      max-height: 80vh;
      overflow-y: auto;
    }
  </style>
</head>
<body>
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
<%@ include file="../layout/header.jsp" %>

<section class="section">
  <div class="container-fluid">
    <!-- 탭 메뉴 -->
<div class="tab-grid d-grid gap-3 mb-4" id="custom-tab-buttons" role="tablist">
  <button class="tab-btn tab-blue active" data-bs-toggle="pill" data-bs-target="#tab1">
    <span class="material-icons-outlined">grid_view</span> 대시보드
  </button>
  <button class="tab-btn tab-green" data-bs-toggle="pill" data-bs-target="#tab2">
    <span class="material-icons-outlined">format_list_bulleted</span> 프로젝트 목록
  </button>
  <button class="tab-btn tab-orange" data-bs-toggle="pill" data-bs-target="#tab-gantt">
    <span class="material-icons-outlined">dvr</span> 간트차트
  </button>
  <button class="tab-btn tab-purple" data-bs-toggle="pill" data-bs-target="#projectKanban">
    <span class="material-icons-outlined">view_kanban</span> 프로젝트 칸반보드
  </button>
  <button class="tab-btn tab-yellow" data-bs-toggle="pill" data-bs-target="#taskKanban">
    <span class="material-icons-outlined">checklist</span> 업무 칸반보드
  </button>
</div>

<!-- 탭 콘텐츠 -->
<div class="tab-content" id="pills-tabContent">
  <div class="tab-pane fade show active" id="tab1" role="tabpanel">대시보드를 불러오는 중...</div>
  <div class="tab-pane fade" id="tab2" role="tabpanel">
    <div id="projectListContent">프로젝트 목록을 불러오는 중...</div>
  </div>
  
<div class="tab-pane fade" id="tab-gantt" role="tabpanel">
  <div class="card mb-3">
    <div class="card-header bg-light">
      <div class="row align-items-center">
        <div class="col-md-6">
          <h5 class="mb-0">간트 차트</h5>
        </div>
        <div class="col-md-6">
          <select id="ganttProjectSelect" class="form-select">
            <option value="">프로젝트 선택</option>
            <!-- 프로젝트 목록은 JavaScript로 채워집니다 -->
          </select>
        </div>
      </div>
    </div>
  </div>
  <div id="ganttChartArea" class="mt-3">
    <div class="alert alert-info text-center">
      <i class="material-icons-outlined mb-2" style="font-size: 2rem;">info</i>
      <p>상단에서 프로젝트를 선택하면 간트 차트가 표시됩니다.</p>
    </div>
  </div>
</div>
  
  
  
  <!-- 프로젝트 칸반보드 탭 -->
  <div class="tab-pane fade" id="projectKanban" role="tabpanel">
	  <div id="projectKanbanContent">
	    <div class="text-center py-5 text-muted">프로젝트 칸반보드를 불러오는 중...</div>
	  </div>
	</div>
      
  <!-- 업무 칸반보드 탭 -->
  <div class="tab-pane fade" id="taskKanban" role="tabpanel">
    <div class="row">
      <!-- 좌측: 프로젝트 목록 (30%) -->
      <div class="col-md-3 border-end pe-0" id="kanbanProjectListArea">
        <div class="project-header kanban-header bg" style="background-color: #e2d9f3;">
          <h6 class="status-title">프로젝트 목록</h6>
        </div>
        <ul class="list-group project-list-scroll">
          <c:forEach var="proj" items="${projectList}">
            <li class="list-group-item project-item" data-prjct-no="${proj.prjctNo}" style="cursor:pointer">
              ${proj.prjctNm}
            </li>
          </c:forEach>
        </ul>
      </div>
      
      <!-- 우측: 칸반 보드 (70%) -->
      <div class="col-md-9 ps-3" id="kanbanBoardContainer">
        <div class="text-muted text-center py-5">좌측 프로젝트를 선택해주세요.</div>
      </div>
    </div>
  </div>
</div>
  </div>
</section>

<%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>


<script>
//projectTab.jsp의 script 부분 수정 (첫 번째 파일)

document.addEventListener("DOMContentLoaded", function () {
  const urlParams = new URLSearchParams(window.location.search);
  const tab = urlParams.get("tab");
  const prjctNo = urlParams.get("prjctNo");

  // 탭 색상 처리
  document.querySelectorAll(".tab-btn").forEach(function(btn) {
    btn.addEventListener("click", function () {
      document.querySelectorAll(".tab-btn").forEach(function(b) { 
        b.classList.remove("active");
      });
      this.classList.add("active");
      const color = getComputedStyle(this).getPropertyValue('--tab-color');
      const content = document.querySelector(".tab-content");
      if (content) content.style.setProperty('--tab-color', color);
    });
  });

  // 탭에 따라 초기 로딩
  if (tab === "list") {
    new bootstrap.Tab(document.querySelector('[data-bs-target="#tab2"]')).show();
    loadProjectList();
  } else if (tab === "gantt") {
    new bootstrap.Tab(document.querySelector('[data-bs-target="#tab-gantt"]')).show();
    if (prjctNo) loadGanttChart(prjctNo);
  } else if (tab === "kanban") {
    new bootstrap.Tab(document.querySelector('[data-bs-target="#taskKanban"]')).show();
    if (prjctNo) loadKanbanBoard(prjctNo);
  } else if (tab === "projectKanban") {
    new bootstrap.Tab(document.querySelector('[data-bs-target="#projectKanban"]')).show();
    loadProjectKanbanBoard();
  } else {
    loadDashboard();
  }

  // 칸반 탭 클릭 시 기본 프로젝트 로딩
  const taskKanbanTab = document.querySelector('[data-bs-target="#taskKanban"]');
  if (taskKanbanTab) {
    taskKanbanTab.addEventListener("shown.bs.tab", function () {
      const defaultPrjctNo = document.querySelector(".project-item");
      if (defaultPrjctNo && defaultPrjctNo.dataset.prjctNo) {
        loadKanbanBoard(defaultPrjctNo.dataset.prjctNo);
      }
    });
  }
  
  // 프로젝트 칸반 클릭 시 로딩
  const projectKanbanTab = document.querySelector('[data-bs-target="#projectKanban"]');
  if (projectKanbanTab) {
    projectKanbanTab.addEventListener("shown.bs.tab", function () {
      loadProjectKanbanBoard();
    });
  }

  // 프로젝트 목록 탭 클릭 시 로딩
  const projectListTab = document.querySelector('[data-bs-target="#tab2"]');
  if (projectListTab) {
    projectListTab.addEventListener("shown.bs.tab", function () {
      loadProjectList(); // 탭 전환 시 프로젝트 목록 로드
    });
  }

  // 사이드바 프로젝트 클릭 시 AJAX로 업무 로드
  document.addEventListener("click", function (e) {
    if (e.target.classList.contains("project-item") || (e.target.closest && e.target.closest(".project-item"))) {
      // 클릭된 요소 또는 가장 가까운 부모 project-item 요소
      const item = e.target.classList.contains("project-item") ? e.target : e.target.closest(".project-item");
      const prjctNo = item.dataset.prjctNo;
      if (!prjctNo) return;
      const kanbanTab = document.querySelector('[data-bs-target="#taskKanban"]');
      if (kanbanTab) new bootstrap.Tab(kanbanTab).show();
      loadKanbanBoard(prjctNo);
    }
  });

  // 검색 폼 이벤트 핸들러 설정 - 메인 페이지에 있는 검색 폼
  const searchForm = document.getElementById('searchForm');
  if (searchForm) {
    searchForm.addEventListener('submit', function(e) {
      e.preventDefault();
      console.log("메인 검색 폼 제출!");
      // 프로젝트 탭으로 전환
      const projectTab = document.querySelector('[data-bs-target="#tab2"]');
      if (projectTab) new bootstrap.Tab(projectTab).show();
      // 검색 실행
      loadPage(1);
    });
  }
});

// 전역 이벤트 리스너 - 검색 폼이 동적으로 로드될 경우를 대비
document.addEventListener('click', function(e) {
  // 동적으로 추가된 검색 버튼 처리
  if (e.target.closest('.btn-primary') && e.target.closest('#searchForm')) {
    e.preventDefault();
    console.log("검색 버튼 클릭 감지!");
    // 프로젝트 탭으로 전환
    const projectTab = document.querySelector('[data-bs-target="#tab2"]');
    if (projectTab) new bootstrap.Tab(projectTab).show();
    // 검색 실행
    loadPage(1);
  }
});

// 동적으로 로드된 검색 폼에 이벤트 리스너 추가
// MutationObserver를 사용하여 DOM 변경 감지
const observer = new MutationObserver(function(mutations) {
  mutations.forEach(function(mutation) {
    if (mutation.type === 'childList' && mutation.addedNodes.length > 0) {
      // 추가된 노드 중에서 검색 폼 찾기
      mutation.addedNodes.forEach(function(node) {
        if (node.nodeType === 1) { // Element 노드인 경우만
          const searchForm = node.querySelector && node.querySelector('#searchForm');
          if (searchForm) {
            console.log("동적으로 로드된 검색 폼 발견!");
            searchForm.addEventListener('submit', function(e) {
              e.preventDefault();
              console.log("동적 검색 폼 제출!");
              // 프로젝트 탭으로 전환
              const projectTab = document.querySelector('[data-bs-target="#tab2"]');
              if (projectTab) new bootstrap.Tab(projectTab).show();
              // 검색 실행
              loadPage(1);
            });
          }
        }
      });
    }
  });
});

// 전체 document body 관찰 시작
observer.observe(document.body, { childList: true, subtree: true });

// ✅ 대시보드 로딩
function loadDashboard() {
  fetch("/dashboard")
    .then(function(res) { return res.text(); })
    .then(function(html) {
      document.getElementById("tab1").innerHTML = html;
    })
    .catch(function(err) { console.error("대시보드 로드 실패", err); });
}

// ✅ 프로젝트 리스트 로딩
function loadProjectList() {
  const currentPage = 1; // 초기 페이지
  const keywordInput = document.getElementById("keywordInput");
  const keyword = keywordInput ? keywordInput.value : ''; // 검색어
  const encodedKeyword = encodeURIComponent(keyword);
  
  fetch("/project/projectList?currentPage=" + currentPage + "&keyword=" + encodedKeyword)
    .then(function(res) { return res.text(); })
    .then(function(html) {
      document.getElementById("projectListContent").innerHTML = html;
      
      // 로드된 컨텐츠에서 검색 폼 이벤트 핸들러 등록
      const loadedSearchForm = document.querySelector("#projectListContent #searchForm");
      if (loadedSearchForm) {
        console.log("로드된 검색 폼에 이벤트 리스너 등록");
        loadedSearchForm.addEventListener('submit', function(e) {
          e.preventDefault();
          console.log("로드된 폼 제출!");
          // 프로젝트 탭으로 전환
          const projectTab = document.querySelector('[data-bs-target="#tab2"]');
          if (projectTab) new bootstrap.Tab(projectTab).show();
          // 검색 실행
          loadPage(1);
        });
      }
      
      safeExecuteInlineScripts("projectListContent");
    })
    .catch(function(err) { console.error("프로젝트 목록 로드 실패", err); });
}

// ✅ 페이지 로드 함수 - 전역으로 한 번만 정의
window.loadPage = function(page) {
  console.log("페이지 로드: " + page);
  window.currentPage = page;
  const keywordInput = document.getElementById("keywordInput");
  const keyword = keywordInput ? keywordInput.value : '';
  const encodedKeyword = encodeURIComponent(keyword);
  
  // 프로젝트 탭으로 전환 (이중 확인)
  const projectTab = document.querySelector('[data-bs-target="#tab2"]');
  if (projectTab) {
    try {
      new bootstrap.Tab(projectTab).show();
    } catch (e) {
      console.error("탭 전환 실패:", e);
    }
  }
  
  fetch("/project/projectList?currentPage=" + page + "&keyword=" + encodedKeyword)
    .then(function(res) { return res.text(); })
    .then(function(html) {
      const projectListContent = document.getElementById("projectListContent");
      if (projectListContent) {
        projectListContent.innerHTML = html;
        
        // 로드된 컨텐츠에서 검색 폼 이벤트 핸들러 등록
        const loadedSearchForm = document.querySelector("#projectListContent #searchForm");
        if (loadedSearchForm) {
          loadedSearchForm.addEventListener('submit', function(e) {
            e.preventDefault();
            console.log("페이지네이션 후 폼 제출!");
            loadPage(1);
          });
        }
        
        safeExecuteInlineScripts("projectListContent");
      }
    })
    .catch(function(err) {
      console.error("페이지 로드 실패:", err);
    });
};

// ✅ 프로젝트 삭제 확인 함수 - 전역 함수로 한 번만 정의
window.confirmDelete = function(event, prjctNo) {
  event.preventDefault();
  console.log("삭제 확인: " + prjctNo);
  
  if (typeof swal === 'undefined') {
    if(confirm("정말로 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.")) {
      window.deleteProject(prjctNo);
    }
  } else {
    swal({
      title: "정말로 삭제하시겠습니까?",
      text: "이 작업은 되돌릴 수 없습니다.",
      icon: "warning",
      buttons: ["취소", "삭제"],
      dangerMode: true,
    }).then(function(willDelete) {
      if (willDelete) {
        window.deleteProject(prjctNo);
      }
    });
  }
};

// ✅ 프로젝트 삭제 함수 - 전역 함수로 한 번만 정의
window.deleteProject = function(prjctNo) {
  console.log("삭제 실행: " + prjctNo);
  
  fetch("/project/delete/" + prjctNo, {
    method: 'DELETE',
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(function(res) {
    console.log("응답 상태: " + res.status);
    return res.json();
  })
  .then(function(data) {
    console.log("응답 데이터:", data);
    if (data.success) {
      // 성공 시 해당 행만 제거 (페이지 새로고침 없이)
      const row = document.getElementById("project-row-" + prjctNo);
      if (row) {
        row.style.transition = "opacity 0.5s";
        row.style.opacity = "0";
        setTimeout(function() {
          row.remove();
          
          // 목록이 비었는지 확인
          const tbody = row.closest("tbody");
          if (tbody && tbody.children.length === 0) {
            tbody.innerHTML = '<tr><td colspan="8" class="text-center py-4 text-muted">등록된 프로젝트가 없습니다.</td></tr>';
          }
        }, 500);
      }
      
      if (typeof swal !== 'undefined') {
        swal("삭제 완료", "프로젝트가 삭제되었습니다.", "success");
      } else {
        alert("프로젝트가 삭제되었습니다.");
      }
    } else {
      if (typeof swal !== 'undefined') {
        swal("삭제 실패", data.message || "프로젝트를 삭제할 수 없습니다.", "error");
      } else {
        alert("삭제 실패: " + (data.message || "프로젝트를 삭제할 수 없습니다."));
      }
    }
  })
  .catch(function(err) {
    console.error("삭제 요청 오류:", err);
    if (typeof swal !== 'undefined') {
      swal("삭제 실패", "서버 오류가 발생했습니다.", "error");
    } else {
      alert("삭제 실패: 서버 오류가 발생했습니다.");
    }
  });
};

// 간트 차트 로딩 함수 - 전역 함수로 한 번만 정의
// ✅ 개선된 간트 차트 로딩 함수
window.loadGanttChart = function(prjctNo) {
  console.log("간트차트 로드 시작: prjctNo =", prjctNo);
  if (!prjctNo) {
    console.error("프로젝트 번호가 제공되지 않았습니다.");
    return;
  }
  
  // 간트 탭으로 전환
  var ganttTabBtn = document.querySelector('[data-bs-target="#tab-gantt"]');
  if (ganttTabBtn) {
    try {
      new bootstrap.Tab(ganttTabBtn).show();
    } catch (e) {
      console.error("간트 탭 전환 실패:", e);
    }
  }
  
  // 로딩 표시
  var ganttArea = document.getElementById("ganttChartArea");
  if (ganttArea) {
    ganttArea.innerHTML = 
      '<div class="text-center py-5">' +
      '<div class="spinner-border" role="status"></div>' +
      '<p class="mt-3">간트차트를 불러오는 중...</p>' +
      '</div>';
    
    // 간트차트 로드 (캐시 방지를 위한 타임스탬프 추가)
    fetch("/project/gantt?prjctNo=" + prjctNo + "&t=" + Date.now(), {
      headers: { 
        "X-Requested-With": "XMLHttpRequest",
        "Cache-Control": "no-cache"
      }
    })
    .then(function(res) { 
      if (!res.ok) {
        throw new Error("서버 응답 오류: " + res.status);
      }
      return res.text(); 
    })
    .then(function(html) {
      if (!html || html.trim() === "") {
        throw new Error("빈 응답");
      }
      
      ganttArea.innerHTML = html;
      
      // 스크립트 실행
      safeExecuteInlineScripts("ganttChartArea");
    })
    .catch(function(err) {
      console.error("❌ 간트차트 로드 실패:", err);
      ganttArea.innerHTML = 
        '<div class="alert alert-danger">' +
        '<p><i class="material-icons-outlined">error</i> 간트차트를 불러오지 못했습니다.</p>' +
        '<p>오류 내용: ' + err.message + '</p>' +
        '<button class="btn btn-sm btn-outline-secondary mt-2" onclick="loadGanttChart(' + prjctNo + ')">다시 시도</button>' +
        '</div>';
    });
  } else {
    console.error("간트차트 영역(#ganttChartArea)을 찾을 수 없습니다.");
  }
};

// 아래 코드는 DOMContentLoaded 이벤트에 추가 (기존 이벤트 리스너를 대체하지 말고 추가)
// 간트차트 탭 클릭 이벤트 처리
document.addEventListener('DOMContentLoaded', function() {
  // 기존 DOMContentLoaded 이벤트 리스너가 있을 수 있으므로 추가만 합니다
  var ganttTabBtn = document.querySelector('[data-bs-target="#tab-gantt"]');
  if (ganttTabBtn) {
    ganttTabBtn.addEventListener('shown.bs.tab', function() {
      console.log("간트 탭이 표시됨");
      
      // 간트 영역이 비어있거나 안내 메시지만 있는 경우
      var ganttArea = document.getElementById("ganttChartArea");
      if (ganttArea && (!ganttArea.innerHTML || 
          ganttArea.innerHTML.trim() === "" || 
          ganttArea.innerHTML.includes("프로젝트를 선택해주세요") ||
          ganttArea.innerHTML.includes("alert"))) {
        
        // URL에서 프로젝트 번호 확인
        const urlParams = new URLSearchParams(window.location.search);
        const prjctNo = urlParams.get("prjctNo");
        
        if (prjctNo) {
          // URL에 프로젝트 번호가 있으면 해당 프로젝트 간트차트 로드
          console.log("URL 파라미터에서 프로젝트 번호 발견:", prjctNo);
          loadGanttChart(prjctNo);
        } else {
          // 없으면 기본 안내 메시지 표시
          ganttArea.innerHTML = '<div class="alert alert-info text-center p-4">' +
                              '<i class="material-icons-outlined fs-1 mb-2">info</i>' +
                              '<p>프로젝트를 선택하면 간트차트가 이곳에 표시됩니다.</p>' +
                              '<p class="text-muted small">프로젝트 목록에서 프로젝트를 선택하세요.</p>' +
                              '</div>';
        }
      }
    });
  }
});

// 간트차트로 이동 버튼에 대한 이벤트 위임 (별도로 추가)
document.addEventListener('click', function(e) {
  var target = e.target;
  
  // 간트차트 보기 링크 처리
  if (target.classList.contains('gantt-tab-link') || 
      (target.closest && target.closest('.gantt-tab-link'))) {
    e.preventDefault();
    
    var link = target.classList.contains('gantt-tab-link') ? target : target.closest('.gantt-tab-link');
    var prjctNo = link.getAttribute('data-project-id') || link.dataset.prjctNo;
    
    if (!prjctNo && link.getAttribute('onclick')) {
      // onclick 속성에서 프로젝트 번호 추출 시도
      var onclickText = link.getAttribute('onclick');
      var match = /loadGanttChart\((\d+)\)/.exec(onclickText);
      if (match && match[1]) {
        prjctNo = match[1];
      }
    }
    
    if (prjctNo) {
      console.log("간트차트 링크 클릭 감지, prjctNo =", prjctNo);
      loadGanttChart(prjctNo);
    } else {
      console.error("프로젝트 번호를 찾을 수 없음");
    }
  }
});

// 칸반보드 로딩
function loadKanbanBoard(prjctNo) {
  console.log("loadKanbanBoard 호출됨: prjctNo =", prjctNo);
  if (!prjctNo) return;

  const boardContainer = document.getElementById("kanbanBoardContainer");
  if (!boardContainer) return;

  boardContainer.innerHTML = 
    '<div class="text-center py-5">' +
    '<div class="spinner-border" role="status"></div>' +
    '<p class="mt-3">업무를 불러오는 중...</p>' +
    '</div>';

  fetch("/project/kanban/taskKanban?prjctNo=" + prjctNo + "&t=" + Date.now(), {
    headers: { "X-Requested-With": "XMLHttpRequest" }
  })
    .then(function(res) { return res.text(); })
    .then(function(html) {
      boardContainer.innerHTML = html;
      safeExecuteInlineScripts("kanbanBoardContainer");
    })
    .catch(function(err) {
      console.error("❌ 업무보드 로딩 실패:", err);
      boardContainer.innerHTML =
        '<div class="alert alert-danger">업무를 불러오지 못했습니다: ' + err.message + '</div>';
    });
}

// 프로젝트 칸반보드 ajax
function loadProjectKanbanBoard() {
  const container = document.getElementById("projectKanbanContent");
  if (!container) return;

  container.innerHTML = 
    '<div class="text-center py-5">' +
    '<div class="spinner-border" role="status"></div>' +
    '<p class="mt-3">프로젝트를 불러오는 중...</p>' +
    '</div>';

  fetch("/project/kanban", {
    headers: { "X-Requested-With": "XMLHttpRequest" }
  })
    .then(function(res) { return res.text(); })
    .then(function(html) {
      container.innerHTML = html;
      safeExecuteInlineScripts("projectKanbanContent");
    })
    .catch(function(err) {
      container.innerHTML = '<div class="alert alert-danger">불러오기 실패: ' + err.message + '</div>';
      console.error("❌ 프로젝트 칸반보드 로딩 실패:", err);
    });
}

// ✅ 삽입된 <script> 실행 함수 - 안전하게 수정
function safeExecuteInlineScripts(containerId) {
  const container = document.getElementById(containerId);
  if (!container) return;

  const scripts = container.querySelectorAll("script");
  console.log("📦 스크립트 재실행 시작");
  console.log("스크립트 개수:", scripts.length);
  
  scripts.forEach(function(oldScript) {
    try {
      const newScript = document.createElement("script");
      if (oldScript.src) {
        newScript.src = oldScript.src;
      } else {
        let scriptContent = oldScript.textContent || '';
        
        // 함수 중복 정의 방지 - 정규식 대신 단순 문자열 탐색 사용
        if (scriptContent.indexOf("function loadPage") !== -1) {
          scriptContent = "// loadPage 함수는 전역에 정의되어 있습니다.";
        }
        
        if (scriptContent.indexOf("function confirmDelete") !== -1) {
          scriptContent = "// confirmDelete 함수는 전역에 정의되어 있습니다.";
        }
        
        if (scriptContent.indexOf("function deleteProject") !== -1) {
          scriptContent = "// deleteProject 함수는 전역에 정의되어 있습니다.";
        }
        
        if (scriptContent.indexOf("let draggedCard") !== -1) {
          scriptContent = scriptContent.replace("let draggedCard", "draggedCard");
        }
        
        newScript.textContent = scriptContent;
      }
      
      document.body.appendChild(newScript);
    } catch (e) {
      console.error("스크립트 실행 오류:", e);
    }
  });
}

// 모든 검색 폼에 이벤트 리스너 적용 (초기 및 동적 로딩)
function setupAllSearchForms() {
  // 현재 페이지의 모든 검색 폼에 이벤트 리스너 등록
  document.querySelectorAll('#searchForm').forEach(function(form) {
    form.addEventListener('submit', function(e) {
      e.preventDefault();
      console.log("검색 폼 제출 감지!");
      
      // 프로젝트 탭으로 전환
      const projectTab = document.querySelector('[data-bs-target="#tab2"]');
      if (projectTab) new bootstrap.Tab(projectTab).show();
      
      // 검색 실행
      loadPage(1);
    });
  });
}

// 페이지 로드 후 모든 검색 폼 설정
document.addEventListener('DOMContentLoaded', setupAllSearchForms);

// 탭 변경 시 검색 폼 이벤트 리스너 등록
document.addEventListener('shown.bs.tab', function(e) {
  // 약간의 지연 후 검색 폼 설정 (DOM 업데이트 시간 허용)
  setTimeout(setupAllSearchForms, 300);
});













//프로젝트 목록 로드 및 셀렉트 박스 설정 함수
function loadProjectsForGantt() {
  console.log("간트 차트용 프로젝트 목록 로드 시작");
  fetch("/project/list/simple", {
    headers: { "X-Requested-With": "XMLHttpRequest" }
  })
  .then(function(res) { 
    if (!res.ok) throw new Error("프로젝트 목록 로드 실패");
    return res.json(); 
  })
  .then(function(projects) {
    console.log("프로젝트 목록 로드 완료:", projects.length, "개");
    
    // 셀렉트 박스 채우기
    var select = document.getElementById("ganttProjectSelect");
    if (!select) return;
    
    // 기존 옵션 초기화 (첫 번째 옵션은 유지)
    while (select.options.length > 1) {
      select.remove(1);
    }
    
    // 프로젝트 옵션 추가
    projects.forEach(function(project) {
      var option = document.createElement("option");
      option.value = project.prjctNo;
      option.textContent = project.prjctNm;
      
      // 현재 URL에 프로젝트 번호가 있으면 해당 프로젝트 선택
      const urlParams = new URLSearchParams(window.location.search);
      const currentPrjctNo = urlParams.get("prjctNo");
      if (currentPrjctNo && currentPrjctNo == project.prjctNo) {
        option.selected = true;
      }
      
      select.appendChild(option);
    });
    
    // 선택된 프로젝트가 있으면 간트 차트 로드
    if (select.value) {
      loadGanttChart(select.value);
    }
  })
  .catch(function(err) {
    console.error("프로젝트 목록 로드 실패:", err);
    var select = document.getElementById("ganttProjectSelect");
    if (select) {
      var option = document.createElement("option");
      option.value = "";
      option.textContent = "프로젝트 목록을 불러올 수 없습니다";
      select.appendChild(option);
    }
  });
}

// 간트 차트 탭 클릭 시 프로젝트 목록 로드
document.addEventListener('DOMContentLoaded', function() {
  var ganttTabBtn = document.querySelector('[data-bs-target="#tab-gantt"]');
  if (ganttTabBtn) {
    ganttTabBtn.addEventListener('shown.bs.tab', function() {
      console.log("간트 탭이 표시됨");
      
      // 프로젝트 목록 로드
      loadProjectsForGantt();
    });
  }
  
  // 셀렉트 박스 변경 이벤트
  var ganttProjectSelect = document.getElementById("ganttProjectSelect");
  if (ganttProjectSelect) {
    ganttProjectSelect.addEventListener('change', function() {
      var selectedProjectNo = this.value;
      if (selectedProjectNo) {
        loadGanttChart(selectedProjectNo);
      } else {
        // 선택된 프로젝트가 없으면 안내 메시지 표시
        var ganttArea = document.getElementById("ganttChartArea");
        if (ganttArea) {
          ganttArea.innerHTML = '<div class="alert alert-info text-center">' +
                                '<i class="material-icons-outlined mb-2" style="font-size: 2rem;">info</i>' +
                                '<p>프로젝트를 선택하면 간트 차트가 표시됩니다.</p>' +
                                '</div>';
        }
      }
    });
  }
});

// 3. 수정된 loadGanttChart 함수 (기존 함수 대체)
window.loadGanttChart = function(prjctNo) {
  console.log("간트차트 로드 시작: prjctNo =", prjctNo);
  if (!prjctNo) {
    console.error("프로젝트 번호가 제공되지 않았습니다.");
    return;
  }
  
  // 간트 탭으로 전환
  var ganttTabBtn = document.querySelector('[data-bs-target="#tab-gantt"]');
  if (ganttTabBtn) {
    try {
      new bootstrap.Tab(ganttTabBtn).show();
    } catch (e) {
      console.error("간트 탭 전환 실패:", e);
    }
  }
  
  // 셀렉트 박스에서 해당 프로젝트 선택
  var ganttProjectSelect = document.getElementById("ganttProjectSelect");
  if (ganttProjectSelect) {
    for (var i = 0; i < ganttProjectSelect.options.length; i++) {
      if (ganttProjectSelect.options[i].value == prjctNo) {
        ganttProjectSelect.selectedIndex = i;
        break;
      }
    }
  }
  
  // 로딩 표시
  var ganttArea = document.getElementById("ganttChartArea");
  if (ganttArea) {
    ganttArea.innerHTML = 
      '<div class="text-center py-5">' +
      '<div class="spinner-border" role="status"></div>' +
      '<p class="mt-3">간트차트를 불러오는 중...</p>' +
      '</div>';
    
    // 간트차트 로드 (캐시 방지를 위한 타임스탬프 추가)
    fetch("/project/gantt?prjctNo=" + prjctNo + "&t=" + Date.now(), {
      headers: { 
        "X-Requested-With": "XMLHttpRequest",
        "Cache-Control": "no-cache"
      }
    })
    .then(function(res) { 
      if (!res.ok) {
        throw new Error("서버 응답 오류: " + res.status);
      }
      return res.text(); 
    })
    .then(function(html) {
      if (!html || html.trim() === "") {
        throw new Error("빈 응답");
      }
      
      ganttArea.innerHTML = html;
      
      // 스크립트 실행
      safeExecuteInlineScripts("ganttChartArea");
    })
    .catch(function(err) {
      console.error("❌ 간트차트 로드 실패:", err);
      ganttArea.innerHTML = 
        '<div class="alert alert-danger">' +
        '<p><i class="material-icons-outlined">error</i> 간트차트를 불러오지 못했습니다.</p>' +
        '<p>오류 내용: ' + err.message + '</p>' +
        '<button class="btn btn-sm btn-outline-secondary mt-2" onclick="loadGanttChart(' + prjctNo + ')">다시 시도</button>' +
        '</div>';
    });
  } else {
    console.error("간트차트 영역(#ganttChartArea)을 찾을 수 없습니다.");
  }
};

</script>

</body>
</html>
