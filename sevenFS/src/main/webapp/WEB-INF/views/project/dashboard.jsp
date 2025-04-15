<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Material Icons -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />

<style>
  .dashboard-card:hover { transform: translateY(-2px) scale(1.02); box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1); }
  .dashboard-card {transition: all 0.3s ease-in-out; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05); border-radius: 8px;}
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
    max-height: 600px;
    overflow-y: auto;
  }

  .table-scroll th {
    position: sticky;
    top: 0;
    background-color: #f8f9fa;
  }

  thead th {
    position: sticky;
    top: 0;
    z-index: 1;
    background-color: #f8f9fa;
  }

  .hover-highlight tbody tr:hover {
    background-color: rgba(0, 123, 255, 0.1);
    cursor: pointer;
  }

  .project-title-big {
    font-size: 1.5rem;
  }
  
th {
  cursor: pointer;
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
  
  transition: transform 0.3s ease;
}

/* 카드 hover 시 아이콘도 같이 반응하도록 */
  transform: translateY(-3px) rotate(-2deg) scale(1.1);
}
  
  
</style>




<div class="container-fluid">

  <!-- 프로젝트 상태 카드 -->
  <div class="row justify-content-center mb-4">
    <div class="col-md-4 mb-3">
      <div class="card dashboard-card shadow h-100 border-primary border-2 d-flex align-items-center justify-content-center">
        <div class="card-body d-flex align-items-center justify-content-center">
          <i class="material-icons text-primary me-3 fs-1">work</i>
          <h5 id="projectCountText" class="mb-0 fw-bold text-primary project-title-big">
            프로젝트 진행중
            <c:forEach var="status" items="${projectStatus}">
              <c:if test="${status.STATUS_NM eq '진행중'}">${status.CNT}</c:if>
            </c:forEach>건
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
                  </c:choose> 건
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
        <div class="card-header d-flex justify-content-between align-items-center">
          <span class="fw-bold">임박한 업무 (7일 이내)</span>
        </div>
        <div class="card-body scroll-table">
<table class="table table-bordered text-center hover-highlight" id="urgentTaskTable">
  <thead class="table-light">
    <tr>
      <th onclick="sortTableByColumn('urgentTaskTable', 0)">업무명</th>
      <th onclick="sortTableByColumn('urgentTaskTable', 1)">등급</th>
      <th onclick="sortTableByColumn('urgentTaskTable', 2)">중요도</th>
      <th onclick="sortTableByColumn('urgentTaskTable', 3, 'date')">종료일</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="t" items="${urgentTasks}">
      <tr data-taskGradCode="${t.taskGrad}" data-priortCode="${t.priort}" data-taskEndDt="${t.taskEndDt.time}">
        <td class="text-start ps-2">${t.taskNm}</td>
        <td><span class="badge grade-${t.taskGrad}">${t.taskGrad}</span></td>
        <td><span class="badge priort-${t.priort}">${commonCodes['PRIORT'][t.priort]}</span></td>
        <td><fmt:formatDate value="${t.taskEndDt}" pattern="yyyy-MM-dd"/></td>
      </tr>
    </c:forEach>
  </tbody>
</table>

        </div>
      </div>
    </div>

    <!-- 오른쪽 통계: 진행률 + 등급 -->
    <div class="col-md-4 d-flex flex-column gap-3">
      <!-- 진행률 -->
      <div class="card shadow flex-fill">
        <div class="card-header fw-bold">업무 진행률 분포</div>
        <div class="card-body">
          <table class="table table-bordered text-center hover-highlight">
            <thead class="table-light"><tr><th>상태</th><th>건수</th></tr></thead>
            <tbody>
              <c:forEach var="p" items="${taskProgress}">
                <tr>
                  <td>
                    <span class="badge 
                      ${p.PROGRESS_GROUP eq '완료' ? 'bg-success' :
                         p.PROGRESS_GROUP eq '진행중' ? 'bg-warning text-dark' :
                         p.PROGRESS_GROUP eq '시작전' ? 'bg-secondary' : 'bg-light text-dark'}">
                      ${p.PROGRESS_GROUP}
                    </span>
                  </td>
                  <td>${p.CNT}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>

      <!-- 등급 통계 -->
      <div class="card shadow flex-fill">
        <div class="card-header fw-bold">업무 등급별 통계</div>
        <div class="card-body">
          <table class="table table-bordered text-center hover-highlight">
            <thead class="table-light"><tr><th>등급</th><th>건수</th></tr></thead>
            <tbody>
              <c:forEach var="g" items="${taskGrade}">
                <tr>
                  <td><span class="badge grade-${g.TASK_GRAD}">${g.TASK_GRAD}</span></td>
                  <td>${g.CNT}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
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
		      <th onclick="sortTableByColumn('myProjectTable', 1)">상태</th>
		      <th onclick="sortTableByColumn('myProjectTable', 2)">카테고리</th>
		      <th onclick="sortTableByColumn('myProjectTable', 3)">등급</th>
		      <th onclick="sortTableByColumn('myProjectTable', 4, 'date')">시작일</th>
		      <th onclick="sortTableByColumn('myProjectTable', 5, 'date')">종료일</th>
		    </tr>
		  </thead>
		  <tbody>
          <c:forEach var="project" items="${myProjects}">
            <tr data-status="${project.prjctSttus}" data-category="${project.ctgryNm}" data-grade="${project.prjctGrad}"
                data-start="${project.prjctBeginDateFormatted}" data-end="${project.prjctEndDateFormatted}">
              <td class="text-start ps-3">${project.prjctNm}</td>
              <td>
                <span class="badge 
                  ${project.prjctSttus eq '01' ? 'bg-primary' :
                    project.prjctSttus eq '02' ? 'bg-success' :
                    project.prjctSttus eq '03' ? 'bg-danger' : 'bg-secondary'}">
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
console.log("Compare:", aVal, bVal);
<script>
function sortTableByColumn(tableId, colIndex, type = 'string') {
    const table = document.getElementById(tableId);
    if (!table) {
        console.error(`Table with ID ${tableId} not found`);
        return;
    }

    const tbody = table.querySelector('tbody');
    if (!tbody) {
        console.error(`Table body not found in table ${tableId}`);
        return;
    }

    const rows = Array.from(tbody.querySelectorAll('tr'));
    if (rows.length === 0) {
        console.log(`No rows found in table ${tableId}`);
        return;
    }

    // Get the header element that was clicked
    const headers = table.querySelectorAll('th');
    if (colIndex >= headers.length) {
        console.error(`Column index ${colIndex} out of bounds`);
        return;
    }

    const th = headers[colIndex];
    
    // Toggle sort direction
    const isAsc = !th.classList.contains('asc');
    
    // Clear existing sort indicators
    headers.forEach(header => header.classList.remove('asc', 'desc'));
    
    // Add new sort indicator
    th.classList.add(isAsc ? 'asc' : 'desc');

    // Sort the rows
    rows.sort((a, b) => {
        // Get cell content
        let aCell = a.cells[colIndex];
        let bCell = b.cells[colIndex];
        
        if (!aCell || !bCell) {
            console.error(`Cell at index ${colIndex} not found in row`);
            return 0;
        }

        // Extract text from the cells (handling potential nested elements)
        let aVal = aCell.textContent.trim();
        let bVal = bCell.textContent.trim();

        // Format based on data type
        if (type === 'number') {
            aVal = parseFloat(aVal) || 0;
            bVal = parseFloat(bVal) || 0;
        } else if (type === 'date') {
            // Handle date formatting (YYYY-MM-DD)
            aVal = new Date(aVal.replace(/-/g, '/'));
            bVal = new Date(bVal.replace(/-/g, '/'));
            
            // Handle invalid dates
            if (isNaN(aVal.getTime())) aVal = new Date(0);
            if (isNaN(bVal.getTime())) bVal = new Date(0);
        } else {
            // String comparison (case insensitive)
            aVal = aVal.toLowerCase();
            bVal = bVal.toLowerCase();
        }

        // Compare the values based on sort direction
        if (aVal < bVal) return isAsc ? -1 : 1;
        if (aVal > bVal) return isAsc ? 1 : -1;
        return 0;
    });

    // Rebuild the table with sorted rows
    rows.forEach(row => tbody.appendChild(row));
}

// 페이지 로드 완료 후 실행
document.addEventListener('DOMContentLoaded', function() {
    // 정렬 가능한 테이블 목록
    const tables = ['urgentTaskTable', 'myProjectTable'];
    
    tables.forEach(tableId => {
        const table = document.getElementById(tableId);
        if (table) {
            const headers = table.querySelectorAll('th');
            
            // 각 테이블 헤더에 클릭 이벤트 추가
            headers.forEach((header, index) => {
                header.style.cursor = 'pointer'; // 커서 스타일 추가
                
                header.addEventListener('click', function() {
                    // 헤더 텍스트로 데이터 타입 추론
                    let type = 'string';
                    const headerText = this.textContent.toLowerCase();
                    
                    if (headerText.includes('일') || headerText.includes('date')) {
                        type = 'date';
                    } else if (headerText.includes('수') || headerText.includes('count')) {
                        type = 'number';
                    }
                    
                    sortTableByColumn(tableId, index, type);
                });
            });
            
            console.log(`Sort listeners added to table: ${tableId}`);
        } else {
            console.warn(`Table ${tableId} not found`);
        }
    });
});
</script>