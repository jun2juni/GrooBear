<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="title" scope="application" value="프로젝트 관리" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>${title}</title>
  <%@ include file="../layout/prestyle.jsp" %>
    <link rel="stylesheet" href="https://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.css">
  <script src="https://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.js"></script>
  <style>
    .tab-grid {
      grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
    }
    .tab-btn {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 6px;
      padding: 10px 14px;
      font-weight: 600;
      font-size: 14px;
      border: 2px solid transparent;
      border-radius: 10px;
      background-color: white;
      transition: all 0.3s ease;
      cursor: pointer;
    }
    .tab-btn span {
      font-size: 18px;
    }
    .tab-btn:hover {
      transform: scale(1.03);
    }
    .tab-btn.active {
      color: white;
      background-color: var(--tab-color);
      border-color: var(--tab-color);
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }
    .tab-btn:not(.active) {
      background-color: white;
      color: var(--tab-color);
      border: 2px solid var(--tab-color);
    }
    .tab-blue   { --tab-color: #5c6bc0; }
    .tab-green  { --tab-color: #66bb6a; }
    .tab-purple { --tab-color: #ba68c8; }
    .tab-yellow { --tab-color: #fbc02d; }
    .tab-orange { --tab-color: #ff8a65; }
    @media (max-width: 600px) {
      .tab-grid {
        grid-template-columns: repeat(auto-fit, minmax(130px, 1fr));
      }
    }
    .tab-content-animated {
      border: 1px solid transparent;
      border-radius: 12px;
      padding: 20px;
      margin-top: 10px;
      animation: border-fill 1.5s ease forwards;
    }
    @keyframes border-fill {
      0% {
        border-color: transparent;
        background: white;
        box-shadow: none;
      }
      100% {
        box-shadow: 0 0 0 3px var(--tab-color);
        border-color: var(--tab-color);
      }
    }
    
  /* 간트차트 우선순위 색상 */
  .task-priority-A .gantt_task_progress { background-color: #f44336; }
  .task-priority-B .gantt_task_progress { background-color: #ff9800; }
  .task-priority-C .gantt_task_progress { background-color: #ffeb3b; }
  .task-priority-D .gantt_task_progress { background-color: #4caf50; }
  .task-priority-E .gantt_task_progress { background-color: #2196f3; }
  
  /* 간트차트 컨테이너 스타일 */
  #ganttChartContainer {
    border: 1px solid #ddd;
    border-radius: 4px;
    overflow: hidden;
  }    
  </style>
</head>
<body>
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
<%@ include file="../layout/header.jsp" %>
<section class="section">
  <div class="container-fluid">
    <div class="tab-grid d-grid gap-3 mb-4" id="custom-tab-buttons" role="tablist">
      <button class="tab-btn tab-blue active" data-bs-toggle="pill" data-bs-target="#tab1" type="button">
        <span class="material-icons-outlined">grid_view</span> 대시보드
      </button>
      <button class="tab-btn tab-green" data-bs-toggle="pill" data-bs-target="#tab2" type="button">
        <span class="material-icons-outlined">format_list_bulleted</span> 프로젝트 목록
      </button>
      <button class="tab-btn tab-purple" data-bs-toggle="pill" data-bs-target="#projectKanban" type="button">
        <span class="material-icons-outlined">view_kanban</span> 칸반보드
      </button>
      <button class="tab-btn tab-yellow" data-bs-toggle="pill" data-bs-target="#taskKanban" type="button">
        <span class="material-icons-outlined">checklist</span> 업무보드
      </button>
      <button class="tab-btn tab-orange" data-bs-toggle="pill" data-bs-target="#tab-gantt" type="button">
        <span class="material-icons-outlined">dvr</span> 간트차트
      </button>
    </div>

    <div class="tab-content" id="pills-tabContent">
      <div class="tab-pane fade show active" id="tab1" role="tabpanel">대시보드 콘텐츠</div>
      <div class="tab-pane fade" id="tab2" role="tabpanel">
        <div id="projectListContent">프로젝트 목록을 불러오는 중...</div>
      </div>
      <div class="tab-pane fade" id="projectKanban" role="tabpanel">칸반보드 콘텐츠</div>
      <div class="tab-pane fade" id="taskKanban" role="tabpanel">업무보드 콘텐츠</div>
      
		<div class="tab-pane fade" id="tab-gantt" role="tabpanel">
		  <div class="row">
		    <div class="col">
		      <div id="ganttChartArea">
		        <div class="alert alert-info">프로젝트를 선택해주세요.</div>
		      </div>
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
console.log("gantt.jsp 로딩됨");

document.addEventListener("DOMContentLoaded", function () {
  const urlParams = new URLSearchParams(window.location.search);
  const tab = urlParams.get("tab");
  const prjctNo = urlParams.get("prjctNo");
  const highlightId = urlParams.get("highlight");

  // 탭 간트 누름
  if (tab === "gantt") {
	  const ganttTabButton = document.querySelector('[data-bs-target="#tab-gantt"]');
	  if (ganttTabButton) {
	    const tabInstance = new bootstrap.Tab(ganttTabButton);
	    tabInstance.show();

	    const prjctNo = urlParams.get("prjctNo");
	    const url = prjctNo ? `/project/gantt?prjctNo=\${prjctNo}` : "/project/gantt/latest";

	    fetch(url)
	      .then(res => res.text())
	      .then(html => {
	        const container = document.getElementById("ganttChartArea");
	        container.innerHTML = html;

	        // 새로 삽입된 <script> 실행
	        const scripts = container.querySelectorAll("script");
	        scripts.forEach(oldScript => {
	          const newScript = document.createElement("script");
	          if (oldScript.src) {
	            newScript.src = oldScript.src;
	          } else {
	            newScript.textContent = oldScript.textContent;
	          }
	          document.body.appendChild(newScript);
	        });
	      });
	  }
	}

  //간트차트 탭 클릭 이벤트
/* document.querySelector('[data-bs-target="#tab-gantt"]').addEventListener('shown.bs.tab', function() {
  console.log("간트차트 탭 선택됨");
  
  // 기존 URL에서 프로젝트 번호를 가져오거나, 없으면 최신 프로젝트 엔드포인트 사용
  const urlParams = new URLSearchParams(window.location.search);
  const prjctNo = urlParams.get("prjctNo");
  
  // prjctNo가 있으면 해당 프로젝트의 간트차트 로드, 없으면 최신 프로젝트
  const loadUrl = prjctNo ? `/project/gantt?prjctNo=\${prjctNo}` : "/project/gantt/latest";
  
  console.log("간트차트 로드 URL:", loadUrl);
  
  fetch(loadUrl)
    .then(res => res.text())
    .then(html => {
      document.getElementById("ganttChartArea").innerHTML = html;
      
      // 새로 삽입된 <script> 실행
      const scripts = document.getElementById("ganttChartArea").querySelectorAll("script");
      scripts.forEach(oldScript => {
        const newScript = document.createElement("script");
        if (oldScript.src) {
          newScript.src = oldScript.src;
        } else {
          newScript.textContent = oldScript.textContent;
        }
        document.body.appendChild(newScript);
      });
    })
    .catch(err => {
      console.error("간트차트 로드 실패:", err);
      document.getElementById("ganttChartArea").innerHTML = 
        `<div class='alert alert-danger'>간트차트를 불러오지 못했습니다: \${err.message}</div>`;
    });
}); */

  // 탭 목록 누름
  if (tab === "list") {
    const listTabButton = document.querySelector('[data-bs-target="#tab2"]');
    if (listTabButton) {
      const tabInstance = new bootstrap.Tab(listTabButton);
      tabInstance.show();
    }
    loadProjectList(highlightId);
  }

  document.querySelector('[data-bs-target="#tab2"]')?.addEventListener("shown.bs.tab", function () {
    loadProjectList();
  });

  function loadProjectList(highlightId) {
    fetch("/project/projectList")
      .then(res => res.text())
      .then(html => {
        const target = document.getElementById("projectListContent");
        if (target) {
          target.innerHTML = html;

          // 삭제 이벤트 바인딩
          document.querySelectorAll(".delete-project-btn").forEach(el => {
            el.addEventListener("click", function (e) {
              e.preventDefault();
              const prjctNo = this.dataset.projectId;
              swal({
                title: "정말로 삭제하시겠습니까?",
                text: "이 작업은 되돌릴 수 없습니다.",
                icon: "warning",
                buttons: ["취소", "삭제"],
                dangerMode: true,
              }).then((willDelete) => {
                if (willDelete) {
                  fetch(`/project/delete/\${prjctNo}`, {
                    method: 'DELETE'
                  })
                    .then(res => {
                      if (!res.ok) throw new Error("서버 오류");
                      return res.json();
                    })
                    .then(data => {
                      if (data.success) {
                        const row = document.getElementById(`project-row-\${prjctNo}`);
                        if (row) row.remove();
                        swal("삭제 완료", data.message || "프로젝트가 삭제되었습니다.", "success");
                      } else {
                        throw new Error(data.message || "삭제 실패");
                      }
                    })
                    .catch(err => {
                      console.error("삭제 실패:", err);
                      swal("삭제 실패", err.message || "하위 데이터로 인해 삭제할 수 없습니다.", "error");
                    });
                }
              });
            });
          });

          if (highlightId) {
            setTimeout(() => {
              const row = document.querySelector(`#project-row-\${highlightId}`);
              if (row) {
                row.classList.add("table-success");
                row.scrollIntoView({ behavior: "smooth" });
              }
            }, 200);
          }
        }
      })
      .catch(err => {
        console.error("프로젝트 목록 로드 실패:", err);
        document.getElementById("projectListContent").innerHTML = "<p class='text-danger'>프로젝트 목록을 불러오지 못했습니다.</p>";
      });
  }

  window.loadPage = function(page) {
    const keyword = document.getElementById("keywordInput")?.value || '';
    fetch(`/project/projectList?currentPage=\${page}&keyword=\${encodeURIComponent(keyword)}`)
      .then(res => res.text())
      .then(html => {
        document.getElementById("projectListContent").innerHTML = html;
      });
  };

  window.searchProjects = function(event) {
    event.preventDefault();
    loadPage(1);
  };

  loadDashboard();
});

function loadDashboard() {
  fetch("/dashboard")
    .then(res => res.text())
    .then(html => {
      document.querySelector("#tab1").innerHTML = html;
    })
    .catch(err => {
      console.error("대시보드 로드 실패:", err);
      document.querySelector("#tab1").innerHTML = "<p class='text-danger'>대시보드를 불러오지 못했습니다.</p>";
    });
}

function loadProjectList(highlightId) {
	  fetch("/project/projectList")
	    .then(res => res.text())
	    .then(html => {
	      const target = document.getElementById("projectListContent");
	      if (target) {
	        target.innerHTML = html;

	        // 삭제 버튼 바인딩
	        document.querySelectorAll(".delete-project-btn").forEach(el => {
	          el.addEventListener("click", function (e) {
	            e.preventDefault();
	            const prjctNo = this.dataset.projectId;

	            swal({
	              title: "정말로 삭제하시겠습니까?",
	              text: "이 작업은 되돌릴 수 없습니다.",
	              icon: "warning",
	              buttons: ["취소", "삭제"],
	              dangerMode: true,
	            }).then((willDelete) => {
	              if (willDelete) {
	                fetch(`/project/delete/\${prjctNo}`, {
	                  method: 'DELETE'
	                })
	                  .then(res => res.json())
	                  .then(data => {
	                    if (data.success) {
	                      swal("삭제 완료", "프로젝트가 삭제되었습니다.", "success")
	                        .then(() => loadPage(currentPage));
	                    } else {
	                      swal("삭제 실패", data.message || "삭제에 실패했습니다.", "error");
	                    }
	                  })
	                  .catch(err => {
	                    console.error("삭제 실패:", err);
	                    swal("삭제 실패", err.message || "서버 오류가 발생했습니다.", "error");
	                  });
	              }
	            });
	          });
	        });

	        // 하이라이트 처리
	        if (highlightId) {
	          setTimeout(() => {
	            const row = document.querySelector(`#project-row-\${highlightId}`);
	            if (row) {
	              row.classList.add("table-success");
	              row.scrollIntoView({ behavior: "smooth" });
	            }
	          }, 200);
	        }
	      }
	    });
	}

// 탭 클릭 시 색상에 따라 콘텐츠 스타일도 변경
document.querySelectorAll(".tab-btn").forEach(btn => {
    btn.addEventListener("click", function () {
      // 모든 버튼 active 해제
      document.querySelectorAll(".tab-btn").forEach(b => b.classList.remove("active"));
      this.classList.add("active");

      // 해당 탭의 색상 변수 가져오기
      const color = getComputedStyle(this).getPropertyValue('--tab-color');

      // 콘텐츠 영역 border 색상 적용
      const content = document.querySelector("#projectListContent");
      if (content) {
        content.style.setProperty('--tab-color', color);
        content.classList.remove("tab-content-animated");
        void content.offsetWidth; // reflow
        content.classList.add("tab-content-animated");
      }
    });
  });
  
  
	// 간트차트 불러옴
// 간트차트 로드 함수 - 스크립트 상단에 정의
function loadGanttChart(prjctNo) {
  console.log("간트차트 로드 시작 - 프로젝트 번호:", prjctNo);
  
  // 간트차트 영역에 HTML 구조 추가
  document.getElementById("ganttChartArea").innerHTML = `
    <div class="card">
      <div class="card-header">
        <h5 class="card-title">프로젝트 간트차트</h5>
        <span class="badge bg-primary">프로젝트 번호: \${prjctNo}</span>
      </div>
      <div class="card-body">
        <div id="ganttChartContainer" style="height: 600px; width: 100%;"></div>
      </div>
    </div>
  `;

  // dhtmlxGantt 라이브러리 로드 확인
  if (typeof gantt === 'undefined') {
    // 라이브러리가 없으면 동적 로드
    const cssLink = document.createElement('link');
    cssLink.rel = 'stylesheet';
    cssLink.href = 'https://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.css';
    document.head.appendChild(cssLink);

    const script = document.createElement('script');
    script.src = 'https://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.js';
    script.onload = function() {
      initGanttChart(prjctNo);
    };
    document.head.appendChild(script);
  } else {
    // 라이브러리가 이미 로드되어 있으면 바로 초기화
    initGanttChart(prjctNo);
  }
}

// 간트차트 초기화 함수
function initGanttChart(prjctNo) {
  console.log("간트차트 초기화 시작");
  
  // 간트차트 설정
  gantt.config.xml_date = "%Y-%m-%d %H:%i";
  gantt.config.date_format = "%Y-%m-%d %H:%i";
  
  // 작업 클래스 스타일링
  gantt.templates.task_class = function(start, end, task) {
    return "task-priority-" + (task.priority || "C");
  };
  
  // 칼럼 설정
  gantt.config.columns = [
    { name: "text", label: "업무명", tree: true, width: "*" },
    { name: "start_date", label: "시작일", align: "center", width: 80 },
    { name: "end_date", label: "종료일", align: "center", width: 80 },
    { name: "progress", label: "진행률", align: "center", width: 80, template: function(task) {
      return Math.round((task.progress || 0) * 100) + "%";
    }},
    { name: "owner", label: "담당자", align: "center", width: 80 },
    { name: "add", label: "", width: 44 }
  ];
  
  try {
    // 간트차트 초기화
    gantt.init("ganttChartContainer");
    console.log("간트차트 초기화 성공");
    
    // 실제 데이터 로드
    console.log("실제 간트차트 데이터 로드 시작 - URL:", "/project/gantt/data?prjctNo=" + prjctNo);
    gantt.load("/project/gantt/data?prjctNo=" + prjctNo, function() {
      console.log("실제 간트차트 데이터 로드 완료");
    });
    
    // 데이터프로세서 설정 (REST 방식)
    const dp = new gantt.dataProcessor("/project/gantt");
    dp.init(gantt);
    dp.setTransactionMode("REST");
    
    console.log("간트차트 초기화 완료");
  } catch (error) {
    console.error("간트차트 초기화 실패:", error);
    document.getElementById("ganttChartContainer").innerHTML = 
      `<div class="alert alert-danger">간트차트 초기화 실패: \${error.message}</div>`;
  }
}
	
	
	
// 간트차트 탭 클릭 이벤트 핸들러
document.querySelector('[data-bs-target="#tab-gantt"]').addEventListener('shown.bs.tab', function() {
  console.log("간트차트 탭 선택됨");
  
  // URL 파라미터에서 프로젝트 번호 가져오기
  const urlParams = new URLSearchParams(window.location.search);
  const prjctNo = urlParams.get("prjctNo") || '71'; // 기본값 71
  
  // 간트차트 로드
  loadGanttChart(prjctNo);
});

// 프로젝트 목록에서 간트차트 링크 클릭 이벤트 
$(document).on("click", ".gantt-tab-link", function(e) {
  e.preventDefault();
  const prjctNo = $(this).data("project-id");
  
  // 간트차트 탭으로 전환
  const ganttTabBtn = document.querySelector('[data-bs-target="#tab-gantt"]');
  if (ganttTabBtn) {
    new bootstrap.Tab(ganttTabBtn).show();
  }
  
  // 간트차트 로드
  loadGanttChart(prjctNo);
});
	
	
	

</script>
</body>
</html>