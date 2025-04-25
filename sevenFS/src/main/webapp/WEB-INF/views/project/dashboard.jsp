<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Material Icons -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />

<style>
  .tab-grid {
    margin-left: 0;
    margin-right: 0;
  }
  .dashboard-card:hover {
    transform: translateY(-2px) scale(1.02);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  }
  .dashboard-card {
    transition: all 0.3s ease-in-out;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    border-radius: 8px;
  }
  .badge-soft-yellow { background: #fff3cd; color: #856404; }
  .badge-soft-green { background: #d4edda; color: #155724; }
  .badge-soft-orange { background: #ffd8cc; color: #842029; }
  .badge-soft-blue  { background: #dbeeff; color: #004085; }
  .grade-A { background: #cce5ff; color: #004085; }
  .grade-B { background: #d4edda; color: #155724; }
  .grade-C { background: #fff3cd; color: #856404; }
  .grade-D { background: #ffe5b4; color: #8a6d3b; }
  .grade-E { background: #f0f0f0; color: #333333; }
  .priort-00 { background: #f0f0f0; color: #6c757d; }
  .priort-01 { background: #d1ecf1; color: #0c5460; }
  .priort-02 { background: #fff3cd; color: #856404; }
  .priort-03 { background: #f8d7da; color: #721c24; }
  .category-label {
    border: 1px solid #007bff;
    color: #007bff;
    background: #fff;
    padding: 2px 8px;
    border-radius: 12px;
    font-size: 0.85em;
  }
  .scroll-table {
    max-height: 750px;
    overflow-y: auto;
  }
  thead th {
    position: sticky;
    top: 0;
    z-index: 1;
    background-color: #f8f9fa;
  }
  .hover-highlight tbody tr:hover {
    background-color: rgba(0, 123, 255, 0.1);
  }
  .project-title-big {
    font-size: 1.5rem;
  }
  th.asc::after {
    content: ' ▲';
    font-size: 0.8em;
    color: #0d6efd;
  }
  th.desc::after {
    content: ' ▼';
    font-size: 0.8em;
    color: #0d6efd;
  }

  /* 임박한 업무: 업무명 40%, 좌측 정렬, 나머지 좁게 */
  #urgentTaskTable th:nth-child(1),
  #urgentTaskTable td:nth-child(1) {
    width: 40%;
    text-align: left;
    padding-left: 2%;
  }
  #urgentTaskTable th:nth-child(2),
  #urgentTaskTable th:nth-child(3),
  #urgentTaskTable th:nth-child(4),
  #urgentTaskTable th:nth-child(5) {
    width: 60px;
    white-space: nowrap;
  }

  /* 내가 참여한 프로젝트: 프로젝트명 30%, 나머지 자동 */
  #myProjectTable {
    width: 100%;
    overflow-x: auto;
  }
  #myProjectTable th:nth-child(1),
  #myProjectTable td:nth-child(1) {
    width: 40%;
    text-align: left;
    padding-left: 2%;
  }
  #myProjectTable th:nth-child(2),
  #myProjectTable td:nth-child(2),
  #myProjectTable th:nth-child(4),
  #myProjectTable td:nth-child(4) {
    width: 120px;
  }
  #myProjectTable th:nth-child(5),
  #myProjectTable th:nth-child(6) {
    cursor: pointer;
  }
/*     #myProjectTable thead th {
    font-weight: bold;
    font-size: 1.3em;
    color: #000;
  } */

  /* 테이블 제목 스타일 (섹션 제목) */
  .table-title {
    font-weight: bold;
    font-size: 1.3em;
    color: #000;
    text-align: center;
  }

  /* 진행중 건수 강조 */
  #projectCountText strong {
    font-size: 1.3em;
  }
    .card-header {
    text-align: center;
    color: #000;
    font-size: 1.3em;
    font-weight: bold;
  }

  .badge.bg-light {
    background-color: #e0e0e0;
    color: #000;
  }
</style>


<div class="container-fluid px-0">

  <!-- 프로젝트 상태 카드 -->
  <div class="row mb-4">
    <div class="col-md-4">
      <div class="card dashboard-card shadow h-100 border-white border-2 d-flex align-items-center justify-content-center bg-success p-2 text-white">
        <div class="card-body d-flex align-items-center justify-content-center">
<%--          <i class="material-icons text-warning me-3 fs-1">work</i>--%>
          <h5 id="projectCountText" class="mb-0 fw-bold text-white project-title-big text-center">
            프로젝트 진행중
            <br>
            <br>
            <c:forEach var="status" items="${projectStatus}">
              <c:if test="${status.STATUS_NM eq '진행중'}">
                <strong>${status.CNT}</strong>
              </c:if>
            </c:forEach>
             <span class="text-sm">건</span>
          </h5>
        </div>
      </div>
    </div>

    <!-- 업무 상태 카드 -->
    <div class="col-md-8">
      <div class="row g-3">
        <c:set var="labels" value="진행중인 업무,완료된 업무,업무 피드백 사항,피드백 반영한 업무"/>
        <c:set var="badgeClasses" value="badge-soft-yellow,badge-soft-green,badge-soft-orange,badge-soft-blue"/>
        <c:set var="statusIndex" value="0"/>
        <c:forEach var="label" items="${fn:split(labels, ',')}">
          <c:set var="badgeClass" value="${fn:split(badgeClasses, ',')[statusIndex]}"/>
          <div class="col-6 col-md-6">
            <div class="card h-100 text-center dashboard-card">
              <div class="card-body">
                <div class="fw-bold ${badgeClass} mb-2 py-1 rounded">${label}</div>
                <div class="fs-5 fw-bold">
                  <c:choose>
                    <c:when test="${taskMainStatus[statusIndex] != null}">${taskMainStatus[statusIndex].CNT}</c:when>
                    <c:otherwise>0</c:otherwise>
                  </c:choose>
                  <span class="text-sm">건</span>
                </div>
              </div>
            </div>
          </div>
          <c:set var="statusIndex" value="${statusIndex + 1}"/>
        </c:forEach>
      </div>
    </div>
  </div>

   <!-- 통계 구역 -->
  <div class="row mb-4">
    <!-- 임박한 업무 -->
    <div class="col-md-8">
      <div class="card shadow h-100">
        <div class="card-header d-flex justify-content-center align-items-center mb-3">
          <span class="fw-bold">임박한 업무 (7일 이내)</span>
        </div>
        <div class="card-body pt-0 scroll-table">
          <table class="table table-bordered text-center hover-highlight" id="urgentTaskTable">
            <thead class="table-light">
              <tr>
                <th>[프로젝트명] 업무명</th>
                <th>등급</th>
                <th>중요도</th>
                <th>진행률</th>
                <th>종료일</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="t" items="${urgentTasks}">
                <tr>
                  <td class="text-start ps-2">
                    <c:choose>
                      <c:when test="${not empty t.prjctNm}">
                        [${t.prjctNm}] ${t.taskNm}
                      </c:when>
                      <c:otherwise>${t.taskNm}</c:otherwise>
                    </c:choose>
                  </td>
                  <td><span class="badge grade-${t.taskGrad}">${t.taskGrad}</span></td>
                  <td><span class="badge priort-${t.priort}">${commonCodes['PRIORT'][t.priort] != null ? commonCodes['PRIORT'][t.priort] : '-'}</span></td>
                  <td>${t.progrsrt != null ? t.progrsrt : 0}%</td>
                  <td><fmt:formatDate value="${t.taskEndDt}" pattern="yyyy-MM-dd"/></td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- 오른쪽 통계: 프로젝트 상태 + 등급 통계 -->
    <div class="col-md-4">
      <div class="row g-3">
        <!-- 프로젝트 상태 분포 -->
        <div class="col-12">
          <div class="card shadow flex-fill">
            <div class="card-header fw-bold">프로젝트 상태 분포</div>
            <div class="card-body">
              <c:if test="${not empty projectStatus}">
                <table class="table table-bordered text-center hover-highlight">
                  <thead class="table-light">
                    <tr>
                      <th>상태</th>
                      <th>건수</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:set var="progressOrder" value="01,00,02,03"/>
					<c:forEach var="order" items="${fn:split(progressOrder, ',')}">
					  <c:forEach var="p" items="${projectStatus}">
					    <c:if test="${p.STATUS_CODE eq order}">
                          <tr>
                            <td>
                              <span class="badge 
                                ${p.STATUS_CODE eq '02' ? 'bg-success' :
                                  p.STATUS_CODE eq '01' ? 'bg-warning text-dark' :
                                  p.STATUS_CODE eq '00' ? 'bg-secondary' : 'bg-light text-dark'}">
                                ${p.STATUS_NM}
                              </span>
                            </td>
                            <td> <fmt:formatNumber value="${p.CNT}" /> <span class="text-sm">건</span></td>
                          </tr>
					    </c:if>
					  </c:forEach>
					</c:forEach>
                  </tbody>
                </table>
              </c:if>
            </div>
          </div>
        </div>

        <!-- 프로젝트 등급 통계 -->
        <div class="col-12">
          <div class="card shadow flex-fill">
            <div class="card-header fw-bold">프로젝트 등급별 통계</div>
            <div class="card-body">
              <c:if test="${not empty taskGrade}">
                <table class="table table-bordered text-center hover-highlight">
                  <thead class="table-light"><tr><th>등급</th><th>건수</th></tr></thead>
                  <tbody>
                    <c:forEach var="g" items="${taskGrade}">
                      <tr>
                        <td><span class="badge grade-${g.TASK_GRAD}">${g.TASK_GRAD}</span></td>
                        <td><fmt:formatNumber value="${g.CNT}" /> <span class="text-sm">건</span></td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </c:if>
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>
  


  <!-- 내가 참여한 프로젝트 -->
  <div class="card shadow">
    <div class="card-header text-center fw-bold d-flex justify-content-between align-items-center">
      <span class="mx-auto">내가 참여한 프로젝트</span>
    </div>
    <div class="card-body scroll-table">
      <table class="table table-bordered text-center hover-highlight" id="myProjectTable">
        <thead class="table-light">
          <tr>
            <th onclick="sortTableByColumn('myProjectTable', 0)">프로젝트명</th>
            <th>상태</th>
            <th>카테고리</th>
            <th>등급</th>
            <th onclick="sortTableByColumn('myProjectTable', 4, 'date')">시작일</th>
            <th onclick="sortTableByColumn('myProjectTable', 5, 'date')">종료일</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="project" items="${myProjects}">
            <tr>
              <td class="text-start ps-3">${project.prjctNm}</td>
              <td>
                <span class="badge 
                  ${project.prjctSttus eq '01' ? 'bg-warning text-dark' :
                    project.prjctSttus eq '02' ? 'bg-success' :
                    project.prjctSttus eq '00' ? 'bg-secondary' : 'bg-light'}">
                  ${project.prjctSttusNm}
                </span>
              </td>
              <td><span class="category-label">${project.ctgryNm}</span></td>
              <td><span class="badge grade-${project.prjctGrad}">${project.prjctGrad}</span></td>
              <td>${project.prjctBeginDateFormatted}</td>
              <td>${project.prjctEndDateFormatted}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>

<script>
function sortTableByColumn(tableId, colIndex, type = 'string') {
    const table = document.getElementById(tableId);
    if (!table) return;
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
    const headers = table.querySelectorAll('th');
    const th = headers[colIndex];

    const isAsc = !th.classList.contains('asc');
    headers.forEach(h => h.classList.remove('asc', 'desc'));
    th.classList.add(isAsc ? 'asc' : 'desc');

    rows.sort((a, b) => {
      const aVal = a.cells[colIndex].textContent.trim();
      const bVal = b.cells[colIndex].textContent.trim();
      let aSort = aVal, bSort = bVal;
      if (type === 'date') {
        aSort = new Date(aVal.replace(/-/g, '/'));
        bSort = new Date(bVal.replace(/-/g, '/'));
      } else {
        aSort = aVal.toLowerCase();
        bSort = bVal.toLowerCase();
      }
      return aSort < bSort ? (isAsc ? -1 : 1) : aSort > bSort ? (isAsc ? 1 : -1) : 0;
    });

    rows.forEach(row => tbody.appendChild(row));
  }
</script>
