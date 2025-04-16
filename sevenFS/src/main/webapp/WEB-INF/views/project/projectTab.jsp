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
<!--           <div class="col-md-4">
            <div id="ganttProjectList" class="border rounded p-3" style="max-height: 700px; overflow-y: auto;">
              <h6 class="fw-bold mb-3">프로젝트 목록</h6>
              <div id="ganttProjectListContent">목록을 불러오는 중...</div>
            </div>
          </div> -->
          <div class="col">
            <div id="ganttChartArea">
              <div class="alert alert-info">좌측 프로젝트를 선택해주세요.</div>
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
  
  

	function loadGanttChart(prjctNo) {
	  fetch(`/project/gantt?prjctNo=\${prjctNo}`)
	    .then(res => res.text())
	    .then(html => {
	      document.getElementById("ganttChartArea").innerHTML = html;
	    })
	    .catch(err => {
	      document.getElementById("ganttChartArea").innerHTML = "<p class='text-danger'>간트차트 로드 실패</p>";
	    });
	}



</script>
</body>
</html>