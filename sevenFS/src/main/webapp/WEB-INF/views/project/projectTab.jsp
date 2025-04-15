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
</head>
<body>
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
<%@ include file="../layout/header.jsp" %>

<section class="section">
  <div class="container-fluid">
    <!-- 탭 메뉴 -->
    <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
      <li class="nav-item" role="presentation">
        <button class="nav-link active" id="tab-dashboard" data-bs-toggle="pill" data-bs-target="#tab1" type="button" role="tab">대시보드</button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="tab-list" data-bs-toggle="pill" data-bs-target="#tab2" type="button" role="tab">프로젝트 목록</button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" data-bs-toggle="pill" data-bs-target="#projectKanban" type="button" role="tab">칸반보드(프로젝트)</button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" data-bs-toggle="pill" data-bs-target="#taskKanban" type="button" role="tab">칸반보드(업무)</button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" data-bs-toggle="pill" data-bs-target="#taskGantt" type="button" role="tab">간트차트</button>
      </li>
    </ul>

    <!-- 탭 내용 -->
    <div class="tab-content" id="pills-tabContent">
      <div class="tab-pane fade show active" id="tab1" role="tabpanel">대시보드 콘텐츠</div>
      <div class="tab-pane fade" id="tab2" role="tabpanel">
        <div id="projectListContent">프로젝트 목록을 불러오는 중...</div>
      </div>
      <div class="tab-pane fade" id="projectKanban" role="tabpanel">칸반보드 콘텐츠</div>
      <div class="tab-pane fade" id="taskKanban" role="tabpanel">업무보드 콘텐츠</div>
      <div class="tab-pane fade" id="taskGantt" role="tabpanel">간트차트 콘텐츠</div>
    </div>
  </div>
</section>

<%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>

<script>
document.addEventListener("DOMContentLoaded", function () {
  const urlParams = new URLSearchParams(window.location.search);
  const tab = urlParams.get("tab");
  const highlightId = urlParams.get("highlight");

  // 탭이 list일 경우 강제 탭 전환 및 AJAX 호출
  if (tab === "list") {
    const listTabButton = document.querySelector('[data-bs-target="#tab2"]');
    if (listTabButton) {
      const tabInstance = new bootstrap.Tab(listTabButton);
      tabInstance.show();
    }

    loadProjectList(highlightId);
  }

  // 수동으로 탭을 클릭했을 때도 목록 로딩
  document.querySelector('[data-bs-target="#tab2"]')?.addEventListener("shown.bs.tab", function () {
    loadProjectList();
  });

  // 프로젝트 목록 불러오기
  function loadProjectList(highlightId) {
    fetch("/project/projectList")
      .then(res => res.text())
      .then(html => {
        const target = document.getElementById("projectListContent");
        if (target) {
          target.innerHTML = html;

          // 하이라이트 표시
          if (highlightId) {
            setTimeout(() => {
              const row = document.querySelector(`\#project-row-\${highlightId}`);
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

  // 페이지네이션 이동
  window.loadPage = function(page) {
    const keyword = document.getElementById("keywordInput")?.value || '';
    fetch(`/project/projectList?currentPage=\${page}&keyword=\${encodeURIComponent(keyword)}`)
      .then(res => res.text())
      .then(html => {
        document.getElementById("projectListContent").innerHTML = html;
      });
  };

  // 검색 폼
  window.searchProjects = function(event) {
    event.preventDefault();
    loadPage(1);
  };

  // 삭제 관련 처리
  let projectToDelete = 0;

  const deleteModal = document.getElementById('deleteModal');
  if (deleteModal) {
	  deleteModal.addEventListener('shown.bs.modal', function (event) {
      const triggerBtn = event.relatedTarget;
      if (triggerBtn && triggerBtn.getAttribute('data-project-id')) {
        projectToDelete = triggerBtn.getAttribute('data-project-id');
        console.log("삭제할 프로젝트 번호:", projectToDelete);
      }
    });
  }

  const confirmBtn = document.getElementById('confirmDelete');
  if (confirmBtn) {
    confirmBtn.addEventListener('click', function () {
      if (!projectToDelete) {
        Swal.fire("오류", "삭제할 프로젝트가 선택되지 않았습니다.", "error");
        return;
      }

      fetch("/project/delete", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "prjctNo=" + encodeURIComponent(projectToDelete)
      })
        .then(res => {
          if (!res.ok) throw new Error("서버 오류");
          return res.text();
        })
        .then(() => {
          Swal.fire("삭제 완료", "프로젝트가 삭제되었습니다.", "success");
          loadPage(1); // 첫 페이지로 갱신
        })
        .catch(err => {
          console.error("삭제 실패:", err);
          Swal.fire("삭제 실패", "하위 데이터가 있어 삭제할 수 없습니다.", "error");
        });
    });
  }
});
</script>
</body>
</html>
