<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="card-style">

  <!-- 검색 폼 -->
  <div class="row mb-4">
    <div class="col-md-8 col-lg-6 mx-auto">
      <form onsubmit="searchProjects(event)" class="input-group">
        <input type="text" id="keywordInput" class="form-control" placeholder="프로젝트명, 카테고리, 담당자 검색" value="${param.keyword}">
        <button type="submit" class="btn btn-primary d-flex align-items-center">
          <span class="material-icons-outlined">search</span>
          <span class="ms-1">검색</span>
        </button>
      </form>
    </div>
  </div>

  <!-- 프로젝트 목록 테이블 -->
  <div class="card shadow-sm border-0">
    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
          <thead class="bg-light text-center">
            <tr>
              <th>순번</th>
              <th class="text-center">프로젝트명</th>
              <th>카테고리</th>
              <th>책임자</th>
              <th>상태</th>
              <th>등급</th>
              <th class="text-center">기간</th>
              <th>액션</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="project" items="${projectList}" varStatus="status">
              <tr class="align-middle" id="project-row-${project.prjctNo}">
                <td class="text-center">${startNumber - status.index}</td>
                <td class="text-start ps-4">
                  <a href="/project/projectDetail?prjctNo=${project.prjctNo}" class="text-decoration-none text-primary">
                    ${project.prjctNm}
                  </a>
                </td>
                <td><span class="badge bg-light text-dark">${project.ctgryNm}</span></td>
                <td>${project.prtcpntNm}</td>
                <td>
                  <c:choose>
                    <c:when test="${project.prjctSttusNm eq '진행중'}"><span class="badge bg-success">진행중</span></c:when>
                    <c:when test="${project.prjctSttusNm eq '대기중'}"><span class="badge bg-warning text-dark">대기중</span></c:when>
                    <c:when test="${project.prjctSttusNm eq '완료'}"><span class="badge bg-secondary">완료</span></c:when>
                    <c:when test="${project.prjctSttusNm eq '지연'}"><span class="badge bg-danger">지연</span></c:when>
                    <c:otherwise><span class="badge bg-info">${project.prjctSttusNm}</span></c:otherwise>
                  </c:choose>
                </td>
                <td class="text-center">${project.prjctGrad}</td>
                <td class="text-center">
                  <small class="text-muted">${project.prjctBeginDateFormatted} ~ ${project.prjctEndDateFormatted}</small>
                </td>
                <td class="text-center">
                  <div class="dropdown">
                    <button class="btn btn-light btn-sm" data-bs-toggle="dropdown">
                      <i class="material-icons-outlined">more_vert</i>
                    </button>
                    <ul class="dropdown-menu">
                      <li><a class="dropdown-item gantt-tab-link" href="#" data-project-id="${project.prjctNo}">간트차트 보기</a></li>
                      <li><a class="dropdown-item" href="/project/projectDetail?prjctNo=${project.prjctNo}">상세보기</a></li>
                      <li><a class="dropdown-item" href="/project/edit/${project.prjctNo}">수정</a></li>
                      <li><hr class="dropdown-divider"></li>
                      <li><a href="#" class="dropdown-item text-danger delete-project-btn" data-project-id="${project.prjctNo}" onclick="confirmDelete(event, this)">삭제</a></li>
                    </ul>
                  </div>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty projectList}">
              <tr><td colspan="8" class="text-center py-4 text-muted">등록된 프로젝트가 없습니다.</td></tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>

    <!-- 페이지네이션 -->
    <div class="d-flex justify-content-center align-items-center flex-wrap gap-3 m-4">
      <nav>
        <ul class="pagination pagination-sm mb-0">
          <c:if test="${articlePage.currentPage > 1}">
            <li class="page-item"><a class="page-link" href="#" onclick="loadPage(1)">&laquo;</a></li>
            <li class="page-item"><a class="page-link" href="#" onclick="loadPage(${articlePage.currentPage - 1})">&lsaquo;</a></li>
          </c:if>

          <c:forEach begin="${articlePage.startPage}" end="${articlePage.endPage}" var="i">
            <li class="page-item ${i == articlePage.currentPage ? 'active' : ''}">
              <a class="page-link" href="#" onclick="loadPage(${i})">${i}</a>
            </li>
          </c:forEach>

          <c:if test="${articlePage.currentPage < articlePage.totalPages}">
            <li class="page-item"><a class="page-link" href="#" onclick="loadPage(${articlePage.currentPage + 1})">&rsaquo;</a></li>
            <li class="page-item"><a class="page-link" href="#" onclick="loadPage(${articlePage.totalPages})">&raquo;</a></li>
          </c:if>
        </ul>
      </nav>
    </div>
  </div>
</div>

<!-- 스크립트 영역 -->
<script>
let currentPage = 1;

function searchProjects(e) {
  e.preventDefault();
  loadPage(1);
}

function loadPage(page) {
  currentPage = page;
  const keyword = document.getElementById("keywordInput")?.value || '';
  fetch(`/project/projectList?currentPage=\${page}&keyword=\${encodeURIComponent(keyword)}`)
    .then(res => res.text())
    .then(html => {
      document.getElementById("projectListContent").innerHTML = html;
    });
}

function confirmDelete(event, el) {
  event.preventDefault();
  const prjctNo = el.getAttribute("data-project-id");
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
            swal("삭제 완료", data.message || "프로젝트가 삭제되었습니다.", "success")
              .then(() => loadPage(currentPage));
          } else {
            swal("삭제 실패", data.message || "프로젝트를 삭제할 수 없습니다.", "error");
          }
        })
        .catch(err => {
          console.error("삭제 실패:", err);
          swal("삭제 실패", err.message || "서버 오류가 발생했습니다.", "error");
        });
    }
  });
}

// 간트차트 탭 전환 및 로드
// 간트차트 탭 전환 및 해당 프로젝트 로드
$(document).on("click", ".gantt-tab-link", function (e) {
  e.preventDefault();
  const prjctNo = $(this).data("project-id");

  const ganttTabBtn = document.querySelector('[data-bs-target="#tab-gantt"]');
  if (ganttTabBtn) {
    new bootstrap.Tab(ganttTabBtn).show(); // 탭 전환
  }

  // 실제 차트 로드
  const url = `/project/gantt?prjctNo=\${prjctNo}`;
  fetch(url)
    .then(res => res.text())
    .then(html => {
      document.getElementById("ganttChartArea").innerHTML = html;

      // 삽입된 <script> 수동 실행
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
      document.getElementById("ganttChartArea").innerHTML = "<p class='text-danger'>간트차트를 불러오지 못했습니다.</p>";
    });
});

</script>
