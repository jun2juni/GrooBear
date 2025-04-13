<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="card-style">

  <!-- 검색 폼 -->
  <div class="row mb-4">
    <div class="col-md-8 col-lg-6 mx-auto">
      <form method="get" action="/project/projectTab" class="input-group">
        <input type="text" name="keyword" class="form-control" placeholder="프로젝트명, 카테고리, 담당자 검색" value="${param.keyword}">
        <input type="hidden" name="tab" value="list" />
        <button type="submit" class="btn btn-primary">
          <span class="material-icons-outlined">search</span> 검색
        </button>
      </form>
    </div>
  </div>

  <!-- 프로젝트 목록 -->
  <div class="card shadow-sm border-0">
    <div class="card-header d-flex justify-content-between align-items-center">
      <h5 class="mb-0">프로젝트 목록</h5>
      <a href="/project/insert" class="btn btn-sm btn-success">
        <span class="material-icons-outlined" style="vertical-align: middle;">add</span> 신규 프로젝트
      </a>
    </div>

    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
			<thead class="bg-light text-center">
			  <tr>
			    <th scope="col" class="fw-semibold">#</th>
			    <th scope="col" class="fw-semibold text-center">프로젝트명</th>
			    <th scope="col" class="fw-semibold">카테고리</th>
			    <th scope="col" class="fw-semibold">책임자</th>
			    <th scope="col" class="fw-semibold">상태</th>
			    <th scope="col" class="fw-semibold">등급</th>
			    <th scope="col" class="fw-semibold text-center">기간</th>
			    <th scope="col" class="fw-semibold">액션</th>
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
                    <button class="btn btn-light btn-sm" data-bs-toggle="dropdown"><i class="material-icons-outlined">more_vert</i></button>
                    <ul class="dropdown-menu">
                      <li><a class="dropdown-item" href="/project/projectDetail?prjctNo=${project.prjctNo}">상세보기</a></li>
                      <li><a class="dropdown-item" href="/project/edit/${project.prjctNo}">수정</a></li>
                      <li><hr class="dropdown-divider"></li>
                      <li><a class="dropdown-item text-danger" href="#" data-bs-toggle="modal" data-bs-target="#deleteModal" data-project-id="${project.prjctNo}">삭제</a></li>
                    </ul>
                  </div>
                </td>
              </tr>
            </c:forEach>

            <!-- 데이터 없음 처리 -->
            <c:if test="${empty projectList}">
              <tr><td colspan="8" class="text-center py-4 text-muted">등록된 프로젝트가 없습니다.</td></tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>

    <!-- 페이징 -->
<div class="d-flex justify-content-center align-items-center mt-4">
  <div class="small text-muted me-3">총 ${totalProjectCount}개의 프로젝트</div>
  <nav>
    <ul class="pagination pagination-sm mb-0">
      <c:if test="${articlePage.currentPage > 1}">
        <li class="page-item">
          <a class="page-link" href="#" onclick="loadPage(1, $('#keywordInput').val())">&laquo;</a>
        </li>
        <li class="page-item">
          <a class="page-link" href="#" onclick="loadPage(${articlePage.currentPage - 1}, $('#keywordInput').val())">&lsaquo;</a>
        </li>
      </c:if>

      <c:forEach begin="${articlePage.startPage}" end="${articlePage.endPage}" var="i">
        <li class="page-item ${i == articlePage.currentPage ? 'active' : ''}">
          <a class="page-link" href="#" onclick="loadPage(${i}, $('#keywordInput').val())">${i}</a>
        </li>
      </c:forEach>

      <c:if test="${articlePage.currentPage < articlePage.totalPages}">
        <li class="page-item">
          <a class="page-link" href="#" onclick="loadPage(${articlePage.currentPage + 1}, $('#keywordInput').val())">&rsaquo;</a>
        </li>
        <li class="page-item">
          <a class="page-link" href="#" onclick="loadPage(${articlePage.totalPages}, $('#keywordInput').val())">&raquo;</a>
        </li>
      </c:if>
    </ul>
  </nav>
</div>

</div>

<!-- 삭제 확인 모달 -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header"><h5 class="modal-title">프로젝트 삭제</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body">
        정말로 이 프로젝트를 삭제하시겠습니까?<br><span class="text-danger small">이 작업은 되돌릴 수 없습니다.</span>
      </div>
      <div class="modal-footer">
        <button class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button class="btn btn-danger" id="confirmDelete">삭제</button>
      </div>
    </div>
  </div>
</div>

<script>
// 삭제 처리
let projectToDelete = 0;
document.getElementById('deleteModal')?.addEventListener('show.bs.modal', function (event) {
  projectToDelete = event.relatedTarget?.getAttribute('data-project-id');
});
document.getElementById('confirmDelete')?.addEventListener('click', function () {
  if (projectToDelete > 0) {
    fetch("/project/delete", {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: `prjctNo=\${projectToDelete}`
    }).then(() => location.reload());
  }
});

function loadPage(page, keyword) {
	  fetch(`/project/projectList?currentPage=\${page}&keyword=\${encodeURIComponent(keyword || '')}`)
	    .then(res => res.text())
	    .then(html => {
	      document.getElementById("projectListContent").innerHTML = html;
	    });
	}


</script>
