<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<div class="table-responsive">
  <table class="table table-sm table-bordered">
    <thead class="table-light">
      <tr>
        <th style="text-align:center; width: 30%;">업무명</th>
        <th style="text-align:center; width: 15%;">담당자</th>
        <th style="text-align:center; width: 20%;">기간</th>
        <th style="text-align:center; width: 15%;">중요도</th>
        <th style="text-align:center; width: 15%;">등급</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="task" items="${project.taskList}" varStatus="status">
        <tr class="${not empty task.parentTaskNm ? 'table-light' : ''}" style="cursor:pointer" onclick="openTaskModal(${task.taskNo})">
          <td>
            <div style="margin-left:${(task.depth != null && task.depth > 0) ? task.depth * 20 : 15}px;" title="${task.taskNm}">
              <c:if test="${not empty task.upperTaskNo}">
                <i class="fas fa-level-up-alt fa-rotate-90 me-2 text-primary"></i>
              </c:if>
              <strong>${task.taskNm}</strong>
            </div>
          </td>
          <td class="text-center">
            <!-- 담당자 뱃지 색상 인라인 스타일로 강제 적용 -->
            <c:choose>
              <c:when test="${task.role == '00'}">
                <span class="badge" style="background-color: #dc3545 !important; color: white !important;">${task.chargerEmpNm}</span>
              </c:when>
              <c:when test="${task.role == '01'}">
                <span class="badge" style="background-color: #0d6efd !important; color: white !important;">${task.chargerEmpNm}</span>
              </c:when>
              <c:otherwise>
                <span class="badge" style="background-color: #6c757d !important; color: white !important;">${task.chargerEmpNm}</span>
              </c:otherwise>
            </c:choose>
          </td>
          <td class="text-center">
            <fmt:formatDate value="${task.taskBeginDt}" pattern="yyyy-MM-dd" /> ~
            <fmt:formatDate value="${task.taskEndDt}" pattern="yyyy-MM-dd" />
          </td>
          <td class="text-center">
            <c:choose>
              <c:when test="${task.priort == '00'}"><span class="badge bg-success">낮음</span></c:when>
              <c:when test="${task.priort == '01'}"><span class="badge bg-info">보통</span></c:when>
              <c:when test="${task.priort == '02'}"><span class="badge bg-warning">높음</span></c:when>
              <c:when test="${task.priort == '03'}"><span class="badge bg-danger">긴급</span></c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
          </td>
          <td class="text-center">${task.taskGrad}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>

<!-- 페이지네이션 추가 (컨트롤러에서 전달한 변수 사용) -->
<c:if test="${not empty project.taskList && totalPages > 1}">
  <div class="d-flex justify-content-center mt-3">
    <nav aria-label="Task pagination">
      <ul class="pagination pagination-sm">
        <!-- 이전 페이지 버튼 -->
        <c:choose>
          <c:when test="${currentPage <= 1}">
            <li class="page-item disabled">
              <a class="page-link" href="#" tabindex="-1" aria-disabled="true">&laquo;</a>
            </li>
          </c:when>
          <c:otherwise>
            <li class="page-item">
              <a class="page-link" href="javascript:void(0);" onclick="goToTaskPage(${currentPage - 1})">&laquo;</a>
            </li>
          </c:otherwise>
        </c:choose>
        
        <!-- 페이지 번호 -->
        <c:forEach begin="1" end="${totalPages}" var="pageNum">
          <li class="page-item ${currentPage == pageNum ? 'active' : ''}">
            <a class="page-link" href="javascript:void(0);" onclick="goToTaskPage(${pageNum})">${pageNum}</a>
          </li>
        </c:forEach>
        
        <!-- 다음 페이지 버튼 -->
        <c:choose>
          <c:when test="${currentPage >= totalPages}">
            <li class="page-item disabled">
              <a class="page-link" href="#" tabindex="-1" aria-disabled="true">&raquo;</a>
            </li>
          </c:when>
          <c:otherwise>
            <li class="page-item">
              <a class="page-link" href="javascript:void(0);" onclick="goToTaskPage(${currentPage + 1})">&raquo;</a>
            </li>
          </c:otherwise>
        </c:choose>
      </ul>
    </nav>
  </div>
</c:if>

<script>
// 페이지네이션 함수 정의 (이름 변경: goTaskPage -> goToTaskPage, 함수 없음 오류 해결)
function goToTaskPage(page) {
  const prjctNo = "${project.prjctNo}";
  
  fetch(`/projectTask/partialList?prjctNo=\${prjctNo}&page=\${page}`)
    .then(res => res.text())
    .then(html => {
      document.getElementById("taskListSection").innerHTML = html;
      
      // 스크롤을 테이블 맨 위로 이동
      document.getElementById("taskListSection").scrollIntoView({
        behavior: "smooth",
        block: "start"
      });
    })
    .catch(err => {
      console.error("업무 목록 페이지 로드 실패:", err);
      alert("업무 목록을 불러오는데 실패했습니다.");
    });
}

function refreshTaskList() {
  const prjctNo = "${project.prjctNo}";

  fetch(`/projectTask/partialList?prjctNo=\${prjctNo}`)
    .then(res => res.text())
    .then(html => {
      document.getElementById("taskListSection").innerHTML = html;

      // 포커싱 처리
      document.getElementById("taskListSection").scrollIntoView({
        behavior: "smooth",
        block: "start"
      });
    })
    .catch(err => {
      console.error("업무 목록 갱신 실패:", err);
      alert("업무 목록을 불러오는데 실패했습니다.");
    });
}
</script>